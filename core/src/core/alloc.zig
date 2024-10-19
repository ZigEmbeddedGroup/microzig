//
//  ############################################################
//
//   File:     alloc.zig
//
//
//   Purpose:  General purpose memory allocator
//             to be used in bare metal applications
//             which do not have a backing operating
//             system nor a memory management unit.
//
//
//   Remarks:  - Operates on a finite byte field
//               (u8 array) within the .data segment.
//
//
//   Author:   P. Leibundgut
//             <https://github.com/leibupro>
//
//
//   Date:     09/2024
//
//  ############################################################
//

const std = @import( "std" );
const ArrayBitSet = std.bit_set.ArrayBitSet;

const assert = std.debug.assert;
const print = std.debug.print;
const alignPointerOffset = std.mem.alignPointerOffset;

const Allocator = std.mem.Allocator;


const FreeCellAuditResult = struct
{
    suitable: bool,
    adjusted_len: usize,
    adjusted_offset: usize,
    perfect_fit: bool,
};

const AllocatorStats = struct
{
    num_cells: usize,
    num_alloc_calls: usize,
    num_free_calls: usize,
    bytes_allocated: usize,
    overhead_bytes: usize,
};


pub fn BareMetalAllocator( comptime memory_area: []u8 ) type
{
    assert( memory_area.len > 0 );
    return struct
    {
        const Self = @This();
        const MemoryCell = struct
        {
            memory: []u8,
            next: ?*MemoryCell,
        };
        const BitMap = ArrayBitSet( u128, memory_area.len );

        //
        // Every defrag_inteval'th call of free()
        // defragmentation of the free memory cells
        // is initiated.
        //
        // If defrag_interval is set to 0, defragment()
        // is never called.
        //
        defrag_interval: usize = 10,

        memory_vault: []u8 = memory_area,
        metadata_space: [ memory_area.len ]MemoryCell = undefined,
        free_list_head: ?*MemoryCell,
        stats: AllocatorStats,
        bit_map: BitMap,

        pub fn init() Self
        {
            return Self
            {
                .free_list_head = null,
                .stats =
                    .{
                        .num_cells = 0,
                        .num_alloc_calls = 0,
                        .num_free_calls = 0,
                        .bytes_allocated = 0,
                        .overhead_bytes = 0,
                    },
                .bit_map = undefined,
            };
        }

        pub fn set_defrag_interval(
                self: *Self,
                interval: usize ) void
        {
            self.*.defrag_interval = interval;
        }

        pub fn prepare( self: *Self ) void
        {
            self.*.metadata_space[ 0 ] =
                .{
                    .memory = self.*.memory_vault[ 0 .. ],
                    .next = null,
                };
            self.*.free_list_head =
                &( self.*.metadata_space[ 0 ] );
            self.*.bit_map = BitMap.initFull();
            self.*.bit_map.unset( 0 );
            self.*.stats.num_cells = 1;
            self.*.stats.num_alloc_calls = 0;
            self.*.stats.num_free_calls = 0;
            self.*.stats.bytes_allocated = 0;
            self.*.stats.overhead_bytes = 0;
        }

        pub fn reset( self: *Self ) void
        {
            self.*.prepare();
        }

        pub fn allocator( self: *Self ) Allocator
        {
            return .{
                .ptr = self,
                .vtable = &.{
                    .alloc = alloc,
                    .resize = resize,
                    .free = free,
                },
            };
        }

        fn mem_cell_lt( self: *Self,
                        a: *MemoryCell,
                        b: *MemoryCell ) bool
        {
            _ = self;
            //
            // Return true if a < b.
            //
            const a_last: usize = @intFromPtr(
                &( a.*.memory[ ( a.*.memory.len - 1 ) ] )
            );
            const b_first: usize = @intFromPtr(
                &( b.*.memory[ 0 ] )
            );
            const ret_val: bool = ( a_last < b_first );
            return ret_val;
        }

        //
        // Time complexity, worst case: O( n ).
        //
        fn alloc( ctx: *anyopaque,
                  len: usize,
                  log2_ptr_align: u8,
                  ret_addr: usize ) ?[*]u8
        {
            const self: *Self = @ptrCast( @alignCast( ctx ) );
            _ = ret_addr;
            self.*.stats.num_alloc_calls = @addWithOverflow(
                self.*.stats.num_alloc_calls,
                1
            )[ 0 ];
            const ptr_align: usize = (
                @as( usize, 1 ) <<
                @as( Allocator.Log2Align, @intCast( log2_ptr_align ) )
            );
            const ret_val: ?[*]u8 =
                self.*.grab_mem_cell( ptr_align, len );
            return ret_val;
        }

        fn grab_mem_cell( self: *Self,
                          ptr_align: usize,
                          len: usize ) ?[*]u8
        {
            var ret_val: ?[*]u8 = null;

            if( self.*.free_list_head ) | head |
            {
                //
                // Handle the list head case ...
                //
                const audit_result_head: FreeCellAuditResult =
                    self.*.examine_free_cell(
                        head,
                        ptr_align,
                        len
                );
                if( audit_result_head.suitable )
                {
                    if( audit_result_head.perfect_fit )
                    {
                        //
                        // No cell division necessary, current
                        // cell can be used as is. Since in this
                        // case the current cell is the head, we
                        // have to replace the free list head.
                        //
                        self.*.free_list_head = head.*.next;
                        head.*.next = null;
                        ret_val =
                            ( head.*.memory.ptr +
                              audit_result_head.adjusted_offset );
                    }
                    else
                    {
                        //
                        // Cell division required. New divided/split
                        // cell to be returned. Other cell remains
                        // free.
                        //
                        ret_val = self.*.cell_division(
                            audit_result_head,
                            head
                        );
                    }
                    self.*.update_stats_alloc( &audit_result_head );
                    return ret_val;
                }
                //
                // Start walking the list and handle the
                // further list nodes if and only if
                // the head wasn't a suitable memory cell.
                //
                var mem_cell: *MemoryCell = head;
                while( mem_cell.next )
                    | nxt_mem_cell | :
                    ( mem_cell = nxt_mem_cell )
                {
                    const audit_result_body: FreeCellAuditResult =
                        self.*.examine_free_cell(
                            nxt_mem_cell,
                            ptr_align,
                            len
                    );
                    if( audit_result_body.suitable )
                    {
                        if( audit_result_body.perfect_fit )
                        {
                            //
                            // No cell division necessary, current
                            // cell can be used as is. But we have to
                            // remove the memory cell from the free
                            // list here.
                            //
                            mem_cell.*.next = nxt_mem_cell.*.next;
                            nxt_mem_cell.*.next = null;
                            ret_val =
                                ( nxt_mem_cell.*.memory.ptr +
                                  audit_result_body.adjusted_offset );
                        }
                        else
                        {
                            //
                            // Cell division required. New divided/split
                            // cell to be returned. Other cell remains
                            // free.
                            //
                            ret_val = self.*.cell_division(
                                audit_result_body,
                                nxt_mem_cell
                            );
                        }
                        self.*.update_stats_alloc( &audit_result_body );
                        break;
                    }
                }
            }
            return ret_val;
        }

        fn cell_division( self: *Self,
                          audit_result: FreeCellAuditResult,
                          mem_cell: *MemoryCell ) ?[*]u8
        {
            const idx: usize =
                self.*.bit_map.findFirstSet()
                orelse return null;
            self.*.bit_map.unset( idx );
            const new_cell: *MemoryCell =
                &( self.*.metadata_space[ idx ] );
            new_cell.*.memory =
                mem_cell.*.memory[ 0 .. audit_result.adjusted_len ];
            new_cell.*.next = null;
            mem_cell.*.memory =
                mem_cell.*.memory[ audit_result.adjusted_len .. ];
            const ret_val: [*]u8 =
                ( new_cell.*.memory.ptr +
                  audit_result.adjusted_offset );
            return ret_val;
        }

        fn examine_free_cell( self: *Self,
                              mem_cell: *MemoryCell,
                              ptr_align: usize,
                              len: usize ) FreeCellAuditResult
        {
            _ = self;
            var result: FreeCellAuditResult =
                .{
                    .suitable = undefined,
                    .adjusted_len = undefined,
                    .adjusted_offset = undefined,
                    .perfect_fit = undefined,
                };
            result.suitable = false;
            result.perfect_fit = false;
            if( len <= mem_cell.*.memory.len )
            {
                const adjust_off: ?usize =
                    alignPointerOffset(
                        mem_cell.*.memory.ptr, ptr_align
                );
                if( adjust_off ) | adjustment_value |
                {
                    const ovfl = @addWithOverflow(
                        len, adjustment_value
                    );
                    if( ovfl[ 1 ] == 0 )
                    {
                        result.adjusted_offset = adjustment_value;
                        result.adjusted_len = ovfl[ 0 ];

                        if( result.adjusted_len <
                            mem_cell.*.memory.len )
                        {
                            result.suitable = true;
                            result.perfect_fit = false;
                        }
                        else if( result.adjusted_len ==
                                 mem_cell.*.memory.len )
                        {
                            result.suitable = true;
                            result.perfect_fit = true;
                        }
                    }
                }
            }
            return result;
        }

        fn update_stats_alloc(
                self: *Self,
                ar: *const FreeCellAuditResult ) void
        {
            if( ar.*.suitable )
            {
                if( !ar.*.perfect_fit )
                {
                    self.*.stats.num_cells += 1;
                }
                self.*.stats.bytes_allocated += ar.*.adjusted_len;
                self.*.stats.overhead_bytes += ar.*.adjusted_offset;
            }
        }

        fn update_stats_free(
                self: *Self,
                buf: []u8,
                mem_cell: *MemoryCell
        ) void
        {
            self.*.stats.bytes_allocated -= mem_cell.*.memory.len;
            const overhead: usize =
                ( mem_cell.*.memory.len - buf.len );
            self.*.stats.overhead_bytes -= overhead;
        }

        fn resize( ctx: *anyopaque,
                   buf: []u8,
                   log2_buf_align: u8,
                   new_size: usize,
                   return_address: usize ) bool
        {
            //
            // The bare metal allocator is intentionally designed
            // not to be resized. The array of memory lies within
            // the .data segment and its dimension is known at
            // compile time.
            //
            const self: *Self = @ptrCast( @alignCast( ctx ) );
            _ = self;
            _ = buf;
            _ = log2_buf_align;
            _ = new_size;
            _ = return_address;
            return false;
        }

        //
        // Time complexity, worst case: O( n^2 ).
        // The n^2 is because of the double free check.
        //
        fn free( ctx: *anyopaque,
                 buf: []u8,
                 log2_buf_align: u8,
                 return_address: usize ) void
        {
            const self: *Self = @ptrCast( @alignCast( ctx ) );
            self.*.stats.num_free_calls = @addWithOverflow(
                self.*.stats.num_free_calls,
                1
            )[ 0 ];
            if( self.*.defrag_interval > 0 )
            {
                const defrag_chk: usize = @rem(
                    self.*.stats.num_free_calls,
                    self.*.defrag_interval
                );
                if( defrag_chk == 0 )
                {
                    self.*.defragment();
                }
            }
            _ = log2_buf_align;
            _ = return_address;
            self.*.release_mem_cell( buf );
        }

        fn release_mem_cell( self: *Self, buf: []u8 ) void
        {
            //
            // Memory cell which has to be worked into
            // the free list of the allocator ...
            //
            // Memory cell is inserted into the free list
            // in ascending order of the memory vault
            // addresses. This massively facilitates the
            // defragmentation of memory cells.
            //
            const mem_cell: *MemoryCell =
                self.*.search_mem_cell( buf );
            if( self.*.free_list_head ) | head |
            {
                //
                // Prepend case ...
                //
                if( self.*.mem_cell_lt( mem_cell, head ) )
                {
                    mem_cell.*.next = head;
                    self.*.free_list_head = mem_cell;
                }
                else
                {
                    var it: *MemoryCell = head;
                    var inserted: bool = false;
                    while( it.*.next )
                        | nxt_mem_cell | :
                        ( it = nxt_mem_cell )
                    {
                        //
                        // Insert case ...
                        //
                        if( self.*.mem_cell_lt( mem_cell, nxt_mem_cell ) )
                        {
                            mem_cell.*.next = nxt_mem_cell;
                            it.*.next = mem_cell;
                            inserted = true;
                            break;
                        }
                    }
                    if( !inserted )
                    {
                        //
                        // Append case ...
                        //
                        mem_cell.*.next = null;
                        it.*.next = mem_cell;
                    }
                }
            }
            else
            {
                self.*.free_list_head = mem_cell;
            }
            self.*.update_stats_free( buf, mem_cell );
        }

        fn search_mem_cell( self: *Self, buf: []u8 ) *MemoryCell
        {
            var cell_candidate: ?*MemoryCell = null;
            for( 0 .. self.*.bit_map.capacity() ) | bit_idx |
            {
                //
                // Memory cell is a candidate when the free
                // bit is not set, respectively the memory cell
                // is in use, was allocated earlier ...
                //
                if( !self.*.bit_map.isSet( bit_idx ) )
                {
                    const candidate: *MemoryCell =
                        &( self.*.metadata_space[ bit_idx ] );
                    const chk_result: bool = self.*.free_addr_chk(
                        buf,
                        candidate
                    );
                    if( chk_result )
                    {
                        cell_candidate = candidate;
                        break;
                    }
                    else
                    {
                        cell_candidate = null;
                    }
                }
            }
            //
            // No memory cell exists which contains the requested
            // address range. Currenty we fall into an unreachable
            // trap here. E.g. in case of a double free() ...
            //
            const mem_cell: *MemoryCell = cell_candidate
                                          orelse unreachable;
            return mem_cell;
        }

        fn free_addr_chk( self: *Self,
                          buf: []u8,
                          candidate: *MemoryCell ) bool
        {
            var ret_val: bool = false;

            const first: usize = @intFromPtr( &( buf[ 0 ] ) );
            const last: usize =
                @intFromPtr( &( buf[ ( buf.len - 1 ) ] ) );

            const cell_first: usize =
                @intFromPtr( &( candidate.*.memory[ 0 ] ) );
            const cell_last: usize = @intFromPtr(
                &( candidate.*.memory[ ( candidate.*.memory.len - 1 ) ] )
            );

            if( ( cell_first <= first ) and ( cell_last == last ) )
            {
                ret_val = true;
            }

            if( ret_val )
            {
                //
                // Memory cell candidate not already
                // in the free list?
                //
                var it: ?*MemoryCell = self.*.free_list_head;
                while( it ) | mem_cell | : ( it = mem_cell.*.next )
                {
                    if( mem_cell == candidate )
                    {
                        ret_val = false;
                        break;
                    }
                }
            }

            return ret_val;
        }

        //
        // Time complexity, worst case: O( n ).
        //
        fn defragment( self: *Self ) void
        {
            //
            // To see if cells are adjacent, there must be
            // at least two memory cells present.
            //
            if( self.*.free_list_head ) | head |
            {
                var current: *MemoryCell = head;
                var next: ?*MemoryCell = current.*.next;

                const current_holder: **MemoryCell = &current;
                const next_holder: *?*MemoryCell = &next;

                while( true )
                {
                    //
                    // Adjacency check does not modify
                    // the content of the next_holder ...
                    //
                    while( self.*.cells_adjacent(
                               current_holder.*,
                               next_holder
                           )
                    )
                    {
                        //
                        // Cell union procedure might
                        // modify the content of the next_holder ...
                        //
                        self.*.cell_union(
                            current_holder.*,
                            next_holder
                        );
                    }
                    if( next_holder.* ) | nxt |
                    {
                        ( current_holder.* ) = nxt;
                        ( next_holder.* ) = nxt.*.next;
                    }
                    else
                    {
                        break;
                    }
                }
            }
        }

        fn cell_union( self: *Self,
                       a: *MemoryCell,
                       b_holder: *?*MemoryCell ) void
        {
            const b: *MemoryCell = ( b_holder.* ) orelse return;
            //
            // Cell a is enlarged by the size of cell b.
            // Cell b vanishes ...
            //
            var ovfl = @subWithOverflow(
                @intFromPtr( &( a.*.memory[ 0 ] ) ),
                @intFromPtr( &( self.*.memory_vault[ 0 ] ) )
            );
            assert( ovfl[ 1 ] == 0 );
            const start_idx: usize = ovfl[ 0 ];

            ovfl = @subWithOverflow(
                @intFromPtr( &( b.*.memory[ ( b.*.memory.len - 1 ) ] ) ),
                @intFromPtr( &( self.*.memory_vault[ 0 ] ) )
            );
            assert( ovfl[ 1 ] == 0 );
            const end_idx: usize = ovfl[ 0 ];

            assert( end_idx >= start_idx );

            const new_slice: []u8 =
                self.*.memory_vault[ start_idx .. ( end_idx + 1 ) ];

            a.*.memory = new_slice;
            a.*.next = b.*.next;
            b_holder.* = a.*.next;
            b.*.next = null;

            const cell_idx: usize =
                ( b - &( self.*.metadata_space[ 0 ] ) );
            self.*.bit_map.set( cell_idx );
            self.*.stats.num_cells -= 1;
        }

        fn cells_adjacent( self: *Self,
                           a: *MemoryCell,
                           b_holder: *?*MemoryCell ) bool
        {
            //
            // The memory cells in the free list are sorted
            // ascending by the address range that a single
            // memory cell carries.
            //
            // The function is commutative.
            //
            _ = self;
            var ret_val: bool = false;
            const b: *MemoryCell = ( b_holder.* ) orelse return false;

            const a_last: usize = @intFromPtr(
                &( a.*.memory[ ( a.*.memory.len - 1 ) ] )
            );
            const b_first: usize = @intFromPtr( &( b.*.memory[ 0 ] ) );

            const b_last: usize = @intFromPtr(
                &( b.*.memory[ ( b.*.memory.len - 1 ) ] )
            );
            const a_first: usize = @intFromPtr( &( a.*.memory[ 0 ] ) );

            const ovfl_ba = @subWithOverflow( b_first, a_last );
            const ovfl_ab = @subWithOverflow( a_first, b_last );

            if( ( ovfl_ba[ 1 ] == 0 ) and ( ovfl_ab[ 1 ] == 1 ) )
            {
                if( ovfl_ba[ 0 ] == 1 )
                {
                    ret_val = true;
                }
            }

            if( ( ovfl_ba[ 1 ] == 1 ) and ( ovfl_ab[ 1 ] == 0 ) )
            {
                if( ovfl_ab[ 0 ] == 1 )
                {
                    ret_val = true;
                }
            }

            return ret_val;
        }
    };
}


//
// *******************************************************************
// Allocator test code starts here ...
// *******************************************************************
//

//
// Caution when dimensioning the memory area.
//
// Currently the total amount of the allocator including
// the effective memory area that the allocator manages
// (memory_vault_size) takes the byte size of approximately:
//
//           memory_vault_size
//         + ( memory_vault_size * ( 3 * pointer_size ) ).
//
// pointer_size varies depending on the target platform.
//
// The tests are typically launched on the development host
// which is currently x86_64 (pointer_size = 8),
// just to keep in mind.
//
const amount_of_memory: usize = ( 2 * 1024 );
var memory_vault: [ amount_of_memory ]u8
    align( @sizeOf( usize ) ) = undefined;
var bma = BareMetalAllocator( &memory_vault ).init();


const testing = std.testing;
const expectEqual = testing.expectEqual;

fn print_allocator_stats() void
{
    print( ( "\n\n" ++
             " Number of alloc() calls: {d:5}\n" ++
             " Number of free() calls:  {d:5}\n" ++
             " Number of memory cells:  {d:5}\n" ++
             " Total bytes allocated:   {d:5}\n" ++
             " Total overhead bytes:    {d:5}\n" ),
           .{ bma.stats.num_alloc_calls,
              bma.stats.num_free_calls,
              bma.stats.num_cells,
              bma.stats.bytes_allocated,
              bma.stats.overhead_bytes } );
}

fn print_free_mem_cells() void
{
    print( "\n\nFree memory cells:\n", .{} );
    var it = bma.free_list_head;
    while( it ) | mem_cell | : ( it = mem_cell.next )
    {
        print( " Memory cell byte size: {d:5}\n",
               .{ mem_cell.*.memory.len } );
    }
    print( "\n\n", .{} );
}

test "Bare metal allocator initialisation"
{
    const mem_vault_size: usize = @sizeOf( @TypeOf( memory_vault ) );
    const allocator_size: usize = @sizeOf( @TypeOf( bma ) );
    const mem_vault_slice_size: usize =
        @sizeOf( @TypeOf( bma.memory_vault ) );
    const free_list_space_size: usize =
        @sizeOf( @TypeOf( bma.metadata_space ) );
    const pointer_size: usize = @sizeOf( *u32 );

    bma.prepare();

    std.debug.print(
        "Byte size of the memory vault: {}\n",
        .{ mem_vault_size }
    );
    std.debug.print(
        "Byte size of the bare metal allocator: {}\n",
        .{ allocator_size }
    );
    std.debug.print(
        "Byte size of the memory vault slice: {}\n",
        .{ mem_vault_slice_size }
    );
    std.debug.print(
        "Byte size of the free list space: {}\n",
        .{ free_list_space_size }
    );

    // _ = allocator_size;
    // _ = mem_vault_slice_size;
    // _ = free_list_space_size;
    // _ = mem_vault_size;

    assert( amount_of_memory == mem_vault_size );
    _ = pointer_size;
    // assert(
    //     allocator_size ==
    //     ( ( 2 * pointer_size ) +
    //       ( mem_vault_size * 2 * pointer_size ) )
    // );
    //

    try testing.expectEqual( bma.bit_map.capacity(),
                             memory_vault.len );
    try testing.expectEqual( bma.bit_map.count(),
                             ( memory_vault.len - 1 ) );
    try testing.expectEqual( bma.bit_map.findFirstSet(), 1 );

    const base = &bma.metadata_space[ 0 ];
    const p1 = &bma.metadata_space[ 42 ];

    // const ptr_info = @typeInfo( @TypeOf( base ) );
    // print( "{}\n", .{ ptr_info } );
    const idx: usize = ( p1 - base );
    try testing.expectEqual( idx, 42 );

    print_allocator_stats();
}


test "Allocate one and then four bytes twice"
{
    bma.reset();
    print_allocator_stats();
    const allocator: Allocator = bma.allocator();

    const ptr_a: *u8 = try allocator.create( u8 );
    try expectEqual( @mod( @intFromPtr( ptr_a ), @sizeOf( u8 ) ), 0 );
    try expectEqual( ptr_a, &bma.memory_vault[ 0 ] );
    print( "{*}\n", .{ ptr_a } );
    print_allocator_stats();

    const ptr_b: *u32 = try allocator.create( u32 );
    try expectEqual( @mod( @intFromPtr( ptr_b ), @sizeOf( u32 ) ), 0 );
    try expectEqual( @as( *u8, @ptrCast( ptr_b ) ), &bma.memory_vault[ 4 ] );
    print( "{*}\n", .{ ptr_b } );
    print_allocator_stats();

    const ptr_c: *u32 = try allocator.create( u32 );
    try expectEqual( @mod( @intFromPtr( ptr_c ), @sizeOf( u32 ) ), 0 );
    try expectEqual( @as( *u8, @ptrCast( ptr_c ) ), &bma.memory_vault[ 8 ] );
    print( "{*}\n", .{ ptr_c } );

    try expectEqual( bma.stats.num_alloc_calls, 3 );
    try expectEqual( bma.stats.bytes_allocated, 12 );
    try expectEqual( bma.stats.overhead_bytes, 3 );

    print_allocator_stats();
    print_free_mem_cells();
}


test "Bytewise allocate all"
{
    bma.reset();
    print_allocator_stats();
    const allocator: Allocator = bma.allocator();

    for( 0 .. bma.memory_vault.len ) | i |
    {
        const ptr: *u8 = try allocator.create( u8 );
        try expectEqual( ptr, &( memory_vault[ i ] ) );
    }

    try expectEqual( bma.free_list_head, null );
    try expectEqual( bma.stats.num_cells, bma.memory_vault.len );

    const BitMap = ArrayBitSet( u128, memory_vault.len );
    try expectEqual( bma.bit_map.eql( BitMap.initEmpty() ), true );

    try expectEqual( bma.stats.num_alloc_calls, bma.memory_vault.len );
    try expectEqual( bma.stats.bytes_allocated, bma.memory_vault.len );
    try expectEqual( bma.stats.overhead_bytes, 0 );

    print_allocator_stats();
    print_free_mem_cells();

    //
    // Provoke out of memory error ...
    //
    const ptr_2: *u8 = allocator.create( u8 ) catch | err |
        switch( err )
        {
            error.OutOfMemory =>
            {
                print( " Got expected OutOfMemory error.\n\n", .{} );
                return;
            },
        };
    _ = ptr_2;
}


test "Allocate and free basic / free list prepend case."
{
    bma.reset();
    const allocator: Allocator = bma.allocator();

    print( "******************************************************\n",
           .{}
    );

    var flh = bma.free_list_head orelse @panic( "oh, no" );

    const ptr_a: *u8 = try allocator.create( u8 );
    try expectEqual( flh.*.memory.len, 2047 );
    print_allocator_stats();
    print_free_mem_cells();
    const ptr_b: *u32 = try allocator.create( u32 );
    flh = bma.free_list_head orelse @panic( "oh, no" );
    try expectEqual( flh.*.memory.len, 2040 );
    print_allocator_stats();
    print_free_mem_cells();

    allocator.destroy( ptr_b );
    flh = bma.free_list_head orelse @panic( "oh, no" );
    try expectEqual( flh.*.memory.len, 7 );
    print_allocator_stats();
    print_free_mem_cells();
    allocator.destroy( ptr_a );
    flh = bma.free_list_head orelse @panic( "oh, no" );
    try expectEqual( flh.*.memory.len, 1 );
    print_allocator_stats();
    print_free_mem_cells();


    const exp_lengths: [ 3 ]usize = .{ 1, 7, 2040 };
    var it = bma.free_list_head;
    var idx: usize = 0;
    while( it ) | fl_node | : ( it = fl_node.*.next )
    {
        try expectEqual( fl_node.*.memory.len, exp_lengths[ idx ] );
        idx += 1;
    }

    print( "******************************************************\n",
           .{}
    );
}


test "Free list insert case."
{
    bma.reset();
    const allocator: Allocator = bma.allocator();

    print( "******************************************************\n",
           .{}
    );

    const ptr_a: *u8 = try allocator.create( u8 );
    const ptr_b: *u32 = try allocator.create( u32 );
    const ptr_c: *u16 = try allocator.create( u16 );
    const ptr_d: *u32 = try allocator.create( u32 );
    const ptr_e: *u32 = try allocator.create( u32 );
    const ptr_f: *u16 = try allocator.create( u16 );

    print_allocator_stats();
    print_free_mem_cells();

    allocator.destroy( ptr_a );
    allocator.destroy( ptr_b );
    allocator.destroy( ptr_f );
    allocator.destroy( ptr_c );
    allocator.destroy( ptr_d );
    allocator.destroy( ptr_e );

    print_allocator_stats();
    print_free_mem_cells();

    const exp_lengths: [ 7 ]usize = .{ 1, 7, 2, 6, 4, 2, 2026 };
    var it = bma.free_list_head;
    var idx: usize = 0;
    while( it ) | fl_node | : ( it = fl_node.*.next )
    {
        try expectEqual( fl_node.*.memory.len, exp_lengths[ idx ] );
        idx += 1;
    }

    const ptr_g: *u16 = try allocator.create( u16 );
    print_allocator_stats();
    print_free_mem_cells();
    allocator.destroy( ptr_g );
    print_allocator_stats();
    print_free_mem_cells();

    const exp_lengths_2: [ 8 ]usize = .{ 1, 3, 4, 2, 6, 4, 2, 2026 };
    it = bma.free_list_head;
    idx = 0;
    while( it ) | fl_node | : ( it = fl_node.*.next )
    {
        try expectEqual( fl_node.*.memory.len, exp_lengths_2[ idx ] );
        idx += 1;
    }

    print( "******************************************************\n",
           .{}
    );
}


test "Free list append case"
{
    bma.reset();
    print_allocator_stats();
    const allocator: Allocator = bma.allocator();

    print( "******************************************************\n",
           .{}
    );

    const memory = try allocator.alloc(
        u32,
        ( ( bma.memory_vault.len / @sizeOf( u32 ) ) - 3 )
    );

    const ptr_a: *u4 = try allocator.create( u4 );
    const ptr_b: *u32 = try allocator.create( u32 );
    const ptr_c: *u8 = try allocator.create( u8 );
    const ptr_d: *u16 = try allocator.create( u16 );

    try expectEqual( bma.free_list_head, null );

    print_allocator_stats();

    //
    // Create head and append to free list ...
    //
    allocator.destroy( ptr_a );
    allocator.destroy( ptr_b );
    allocator.destroy( ptr_c );
    allocator.destroy( ptr_d );

    print_free_mem_cells();

    //
    // Prepend to free list because the range in memory is < the
    // ranges in ptr_a, ptr_b, ptr_c, ptr_d ...
    //
    allocator.free( memory );

    print_free_mem_cells();
    print_allocator_stats();

    const exp_lengths: [ 5 ]usize = .{ 2036, 1, 7, 1, 3 };
    var it = bma.free_list_head;
    var idx: usize = 0;
    while( it ) | fl_node | : ( it = fl_node.*.next )
    {
        try expectEqual( fl_node.*.memory.len, exp_lengths[ idx ] );
        idx += 1;
    }

    print( "******************************************************\n",
           .{}
    );
}


fn print_occupied_meta_data_idx() void
{
    //
    // Considering only the first 10 entries ...
    //
    print( "\nOccupied memory cells (indexes): \n", .{} );
    for( 0 .. bma.bit_map.capacity() ) | idx |
    {
        if( !bma.bit_map.isSet( idx ) )
        {
            print( " {d:4}\n", .{ idx } );
        }
    }
}

test "Simple defragment test"
{
    bma.reset();
    const allocator: Allocator = bma.allocator();

    print( "******************************************************\n",
           .{}
    );
    const ptr_a: *u4 = try allocator.create( u4 );
    const ptr_b: *u32 = try allocator.create( u32 );
    const ptr_c: *u8 = try allocator.create( u8 );

    allocator.destroy( ptr_a );
    allocator.destroy( ptr_b );
    allocator.destroy( ptr_c );

    print_free_mem_cells();
    print_allocator_stats();
    print_occupied_meta_data_idx();

    bma.defragment();
    print_free_mem_cells();
    print_allocator_stats();
    print_occupied_meta_data_idx();

    const exp_lengths: [ 1 ]usize = .{ 2048 };
    var it = bma.free_list_head;
    var idx: usize = 0;
    while( it ) | fl_node | : ( it = fl_node.*.next )
    {
        try expectEqual( fl_node.*.memory.len, exp_lengths[ idx ] );
        idx += 1;
    }

    //
    // Expected occupied (not free) memory cell metadata after
    // the defragment() call.
    //
    const BitMap = ArrayBitSet( u128, memory_vault.len );
    var exp_bitmap = BitMap.initFull();
    exp_bitmap.unset( 1 );

    try expectEqual( bma.bit_map.eql( exp_bitmap ), true );

    print( "******************************************************\n",
           .{}
    );
}


test "Simple defragment test 2"
{
    bma.reset();
    const allocator: Allocator = bma.allocator();

    print( "******************************************************\n",
           .{}
    );
    const ptr_a: *u4 = try allocator.create( u4 );
    const ptr_b: *u32 = try allocator.create( u32 );
    const ptr_c: *u8 = try allocator.create( u8 );

    ptr_b.* = 0xdeadbeef;

    allocator.destroy( ptr_a );
    allocator.destroy( ptr_c );

    print_free_mem_cells();
    print_allocator_stats();
    print_occupied_meta_data_idx();

    bma.defragment();
    print_free_mem_cells();
    print_allocator_stats();
    print_occupied_meta_data_idx();

    const exp_lengths: [ 2 ]usize = .{ 1, 2040 };
    var it = bma.free_list_head;
    var idx: usize = 0;
    while( it ) | fl_node | : ( it = fl_node.*.next )
    {
        try expectEqual( fl_node.*.memory.len, exp_lengths[ idx ] );
        idx += 1;
    }

    //
    // Expected occupied (not free) memory cell metadata after
    // the defragment() call.
    //
    const BitMap = ArrayBitSet( u128, memory_vault.len );
    var exp_bitmap = BitMap.initFull();
    exp_bitmap.unset( 1 );
    exp_bitmap.unset( 2 );
    exp_bitmap.unset( 3 );

    try expectEqual( bma.bit_map.eql( exp_bitmap ), true );

    try expectEqual( ptr_b.*, 0xdeadbeef );

    print( "******************************************************\n",
           .{}
    );
}


test "Simple defragment test 3"
{
    bma.reset();
    const allocator: Allocator = bma.allocator();

    print( "******************************************************\n",
           .{}
    );
    const ptr_a: *u4 = try allocator.create( u4 );
    const ptr_b: *u32 = try allocator.create( u32 );
    const ptr_c: *u8 = try allocator.create( u8 );

    allocator.destroy( ptr_a );
    allocator.destroy( ptr_b );
    _ = ptr_c;

    print_free_mem_cells();
    print_allocator_stats();
    print_occupied_meta_data_idx();

    bma.defragment();
    print_free_mem_cells();
    print_allocator_stats();
    print_occupied_meta_data_idx();

    const exp_lengths: [ 2 ]usize = .{ 8, 2039 };
    var it = bma.free_list_head;
    var idx: usize = 0;
    while( it ) | fl_node | : ( it = fl_node.*.next )
    {
        try expectEqual( fl_node.*.memory.len, exp_lengths[ idx ] );
        idx += 1;
    }

    //
    // Expected occupied (not free) memory cell metadata after
    // the defragment() call.
    //
    const BitMap = ArrayBitSet( u128, memory_vault.len );
    var exp_bitmap = BitMap.initFull();
    exp_bitmap.unset( 1 );
    exp_bitmap.unset( 3 );
    exp_bitmap.unset( 0 );

    try expectEqual( bma.bit_map.eql( exp_bitmap ), true );

    print( "******************************************************\n",
           .{}
    );
}


test "Defragment memory area with 1 single byte left allocated in the middle"
{
    //
    // Since we call defragment() manually within the tests
    // we set the automatic defragmentation interval to a high
    // value so that it is not called automatically.
    //
    bma.set_defrag_interval( 100_000 );

    bma.reset();

    const allocator: Allocator = bma.allocator();
    const BitMap = ArrayBitSet( u128, memory_vault.len );

    print( "******************************************************\n",
           .{}
    );

    var ptrs: [ memory_vault.len ]*u8 = undefined;
    for( &ptrs ) | *ptr |
    {
        ptr.* = try allocator.create( u8 );
    }
    ptrs[ ( memory_vault.len / 2 ) ].* = 0x55;

    const exp_bitmap_before_defrag = BitMap.initEmpty();
    try expectEqual( bma.bit_map.eql( exp_bitmap_before_defrag ),
                     true
    );

    for( 0 .. ( memory_vault.len / 2 ) ) | idx |
    {
        allocator.destroy( ptrs[ idx ] );
    }
    for( ( ( memory_vault.len / 2 ) + 1 ) ..
         memory_vault.len )
       | idx |
    {
        allocator.destroy( ptrs[ idx ] );
    }
    try expectEqual( bma.bit_map.eql( exp_bitmap_before_defrag ),
                     true
    );

    // print_free_mem_cells();
    print_allocator_stats();
    // print_occupied_meta_data_idx();

    bma.defragment();
    print_free_mem_cells();
    print_allocator_stats();
    print_occupied_meta_data_idx();

    const exp_lengths: [ 2 ]usize = .{ 1024, 1023 };
    var it = bma.free_list_head;
    var idx: usize = 0;
    while( it ) | fl_node | : ( it = fl_node.*.next )
    {
        try expectEqual( fl_node.*.memory.len, exp_lengths[ idx ] );
        idx += 1;
    }

    //
    // Expected occupied (not free) memory cell metadata after
    // the defragment() call.
    //
    var exp_bitmap_after_defrag = BitMap.initFull();
    // Accumulated free cell at the beginning.
    exp_bitmap_after_defrag.unset(    1 );
    // Cell for spike in the middle.
    exp_bitmap_after_defrag.unset( 1025 );
    // Accumulated free cell after spike.
    exp_bitmap_after_defrag.unset( 1026 );

    try expectEqual( bma.bit_map.eql( exp_bitmap_after_defrag ),
                     true
    );

    try expectEqual( ptrs[ ( memory_vault.len / 2 ) ].*, 0x55 );

    print( "******************************************************\n",
           .{}
    );
}


test "Defragment and re-alloc"
{
    bma.reset();
    const allocator: Allocator = bma.allocator();

    print( "******************************************************\n",
           .{}
    );
    const ptr_a: *u4 = try allocator.create( u4 );
    const ptr_b: *u32 = try allocator.create( u32 );
    const ptr_c: *u8 = try allocator.create( u8 );

    allocator.destroy( ptr_a );
    allocator.destroy( ptr_b );
    ptr_c.* = 0x55;

    print_free_mem_cells();
    print_allocator_stats();
    print_occupied_meta_data_idx();

    bma.defragment();
    print_free_mem_cells();
    print_allocator_stats();
    print_occupied_meta_data_idx();

    const exp_lengths: [ 2 ]usize = .{ 8, 2039 };
    var it = bma.free_list_head;
    var idx: usize = 0;
    while( it ) | fl_node | : ( it = fl_node.*.next )
    {
        try expectEqual( fl_node.*.memory.len, exp_lengths[ idx ] );
        idx += 1;
    }

    //
    // Expected occupied (not free) memory cell metadata after
    // the defragment() call.
    //
    const BitMap = ArrayBitSet( u128, memory_vault.len );
    var exp_bitmap = BitMap.initFull();
    exp_bitmap.unset( 1 );
    exp_bitmap.unset( 3 );
    exp_bitmap.unset( 0 );

    try expectEqual( bma.bit_map.eql( exp_bitmap ), true );

    const ptr_d: *u128 = try allocator.create( u128 );
    const ptr_e: *u64 = try allocator.create( u64 );

    //
    // The + 15 is because of the 16 byte alignment of the u128 value.
    //
    try expectEqual( @as( *u8, @ptrCast( ptr_d ) ),
                     &bma.memory_vault[ 9 + 15 ] );
    //
    // Perfect fit at the start of the memory area,
    // 8 byte cell for the u64 value.
    //
    try expectEqual( @as( *u8, @ptrCast( ptr_e ) ),
                     &bma.memory_vault[ 0 ] );


    allocator.destroy( ptr_d );
    allocator.destroy( ptr_e );
    exp_bitmap.unset( 2 );
    try expectEqual( bma.bit_map.eql( exp_bitmap ), true );

    print_free_mem_cells();
    print_allocator_stats();
    print_occupied_meta_data_idx();

    try expectEqual( ptr_c.*, 0x55 );

    print( "******************************************************\n",
           .{}
    );
}

