#!/usr/bin/env python3
import sys
import subprocess
import re
import textwrap

from cmsis_svd.parser import SVDParser
import cmsis_svd.model as model


def cleanup_description(description):
    if description is None:
        return ''

    return ' '.join(description.replace('\n', ' ').split())

def comment_description(description):
    if description is None:
        return None

    description = ' '.join(description.replace('\n', ' ').split())
    return textwrap.fill(description, width=80, initial_indent='/// ', subsequent_indent='/// ')


def escape_field(field):
    if not field[0].isdigit() and re.match(r'^[A-Za-z0-9_]+$', field):
        return field
    else:
        return f"@\"{field}\""


class MMIOFileGenerator:
    def __init__(self, f):
        self.f = f

    def generate_padding(self, count, name, offset):
        while count > 0:
            self.write_line(f"{name}{offset + count}: u1 = 0,")
            count = count - 1

    def generate_enumerated_field(self, field):
        '''
        returns something like:
            name: enum(u<size>){ // foo description
              name = value, // desc: ...
              name = value, // desc:
              _, // non-exhustive
            },

        '''
        description = comment_description(field.description)
        self.write_line(description)
        self.write_line(f"{field.name}: u{field.bit_width} = 0,")

        # TODO: turn enums back on later
        #self.write_line(f"{field.name}:enum(u{field.bit_width}){{")

        #total_fields_with_values = 0
        #for e in field.enumerated_values:
        #    e.description = cleanup_description(e.description)
        #    if e.value is None or e.name == "RESERVED":
        #        # reserved fields doesn't have a value so we have to comment them out
        #        escaped_field_name = escape_field(e.name)
        #        self.write_line(f"// {escaped_field_name}, // {e.description}")
        #    else:
        #        total_fields_with_values = total_fields_with_values + 1
        #        escaped_field_name = escape_field(e.name)
        #        if e.name != e.description:
        #            self.write_line(f"/// {e.description}")
        #        self.write_line(f"{escaped_field_name} = {e.value},")

        ## if the fields doesn't use all possible values make the enum non-exhaustive
        #if total_fields_with_values < 2**field.bit_width:
        #    self.write_line("_, // non-exhaustive")

        #self.write_line("},")
        return field.bit_offset + field.bit_width

    def generate_register_field(self, field):
        '''
        returns something like:
            name: u<size>, // foo description
        '''
        description = comment_description(field.description)
        if field.name != field.description:
            self.write_line(description)
            self.write_line(f"{field.name}:u{field.bit_width} = 0,")

        return field.bit_offset + field.bit_width

    def generate_fields(self, fields, size):
            last_offset = 0
            reserved_index = 0
            for field in sorted(fields, key=lambda f: f.bit_offset):
                # workaround for NXP SVD which has overleaping reserved fields
                if field.name == "RESERVED":
                    self.write_line(f"// RESERVED: u{field.bit_width}, // {field.description}")
                    continue

                if last_offset != field.bit_offset:
                    reserved_size = field.bit_offset - last_offset
                    self.generate_padding(reserved_size, "reserved", reserved_index)
                    reserved_index += reserved_size

                if field.is_enumerated_type:
                    last_offset = self.generate_enumerated_field(field)
                else:
                    last_offset = self.generate_register_field(field)

            if size is not None and size != last_offset:
                self.generate_padding(size - last_offset, "padding", 0)

    def generate_register_declaration_manual(self, name, description, address_offset, fields, size):
        num_fields = len(fields)
        description = comment_description(description)

        self.write_line("")
        self.write_line(description)
        if num_fields == 0 or (num_fields == 1 and fields[0].bit_width == 32 and name == fields[0].name):
            # TODO: hardcoded 32 bit here
            self.write_line(f"pub const {name} = @intToPtr(*volatile u{size}, Address + 0x{address_offset:08x});")
        else:
            self.write_line(f"pub const {name} = mmio(Address + 0x{address_offset:08x}, {size}, packed struct{{")
            self.generate_fields(fields, size)
            self.write_line("});")

    def generate_register_declaration(self, register):
        size = register.size
        if size == None:
            size = 32 # hack for now...

        num_fields = len(register.fields)
        description = comment_description(register.description)

        self.write_line("")
        self.write_line(description)
        if num_fields == 0 or (num_fields == 1 and register.fields[0].bit_width == 32 and register.name == register.fields[0].name):
            # TODO: hardcoded 32 bit here
            self.write_line(f"pub const {register.name} = @intToPtr(*volatile u{size}, Address + 0x{register.address_offset:08x});")
        else:
            self.write_line(f"pub const {register.name} = mmio(Address + 0x{register.address_offset:08x}, {size}, packed struct{{")
            self.generate_fields(register.fields, size)
            self.write_line("});")
            
    def generate_register_cluster(self, cluster):
        if cluster.derived_from is not None:
            raise Exception("TODO: derived_from")

        self.write_line("")
        self.write_line(f"pub const {cluster.name} = struct {{")
        for register in cluster._register:
            if isinstance(register, model.SVDRegisterArray):
                self.generate_register_array(register)
            elif isinstance(register, model.SVDRegister):
                self.generate_register_declaration(register)


        self.write_line("};")

    def generate_register_cluster_array(self, cluster):
        max_fields = int(cluster.dim_increment / 4)
        if len(cluster._register) > max_fields:
            raise Exception("not enough room for fields")

        name = cluster.name.replace("[%s]", "")
        self.write_line(f"pub const {name} = @intToPtr(*volatile [{cluster.dim}]packed struct {{")
        for register in cluster._register:

            size = register.size
            if size == None:
                size = 32 # hack for now...
            last_offset = 0
            reserved_index = 0

            if size != 32:
                raise Exception("TODO: handle registers that are not 32-bit")

            description = comment_description(register.description)

            self.write_line("")
            self.write_line(description)
            if len(register.fields) == 0 or (len(register.fields) == 1 and register.fields[0].bit_width == size and register.name == register.fields[0].name):
                self.write_line(f"{register.name}: u{size},")
            else:
                self.write_line(register.name + f": MMIO({size}, packed struct {{")
                self.generate_fields(register.fields, size)
                self.write_line("}),")


        for i in range(0, max_fields - len(cluster._register)):
            self.write_line(f"  padding{i}: u32,")
        
        # TODO: this would be cleaner, but we'll probably run into packed struct bugs
        #num_bits = size * (max_fields - len(cluster._register))
        #self.write_line(f"_: u{num_bits},")

        self.write_line(f" }}, Address + 0x{cluster.address_offset:08x});")


    # TODO: calculate size in here, fine since everything we're working with rn is 32 bit
    def generate_register_array(self, register_array):
        description = comment_description(register_array.description)

        if register_array.dim_indices.start != 0 or ("%s" in register_array.name and not "[%s]" in register_array.name):
            for i in register_array.dim_indices:
                fmt = register_array.name.replace("%s", "{}")
                name = fmt.format(i)
                self.generate_register_declaration_manual(name,
                        register_array.description,
                        register_array.address_offset + (i * register_array.dim_increment),
                        register_array._fields,
                        32)
            return

        if register_array.dim_increment != 4:
            raise Exception("TODO register " + register_array.name + " dim_increment != 4" + ", it is " + str(register_array.dim_increment))

        name = register_array.name.replace("%s", "").replace("[]", "")
        self.write_line(description)
        num_fields = len(register_array._fields)

        # TODO: hardcoded 32 bit here
        if num_fields == 0 or (num_fields == 1 and register_array._fields[0].bit_width == 32 and name == register_array._fields[0].name):

            # TODO: hardcoded 32 bit here
            self.write_line(f"pub const {name} = @intToPtr(*volatile [{register_array.dim}]u32, Address + 0x{register_array.address_offset:08x});")
        else:
            self.write_line(f"pub const {name} = @intToPtr(*volatile [{register_array.dim}]MMIO(32, packed struct {{")
            self.generate_fields(register_array._fields, 32)

            self.write_line(f"}}), Address + 0x{register_array.address_offset:08x});")
            
    def generate_peripheral_declaration(self, peripheral):
        description = comment_description(peripheral.description)
        self.write_line("")
        self.write_line(description)
        self.write_line(f"pub const {peripheral.name} = extern struct {{")
        self.write_line(f"pub const Address: u32 = 0x{peripheral.base_address:08x};")

        for register in sorted(peripheral._lookup_possibly_derived_attribute('registers'), key=lambda f: f.address_offset):
            self.generate_register_declaration(register)

        for register_array in sorted(peripheral._lookup_possibly_derived_attribute('register_arrays'), key=lambda f: f.address_offset):
            self.generate_register_array(register_array)

        for cluster in sorted(peripheral._lookup_possibly_derived_attribute('clusters'), key=lambda f: f.address_offset):
            if isinstance(cluster, model.SVDRegisterCluster):
                self.generate_register_cluster(cluster)
            elif isinstance(cluster, model.SVDRegisterClusterArray):
                #self.generate_register_cluster_array(cluster)
                pass
            else:
                raise Exception("unhandled cluster type")

        self.write_line("};")

    # TODO: descriptions on system interrupts/exceptions, turn on system interrupts/exceptions
    def generate_startup_and_interrupts(self, interrupts):
        self.write_line("")
        self.write_line(
        """
const std = @import(\"std\");
const root = @import(\"root\");
const cpu = @import(\"cpu\");
const config = @import(\"microzig-config\");
const InterruptVector = extern union {
    C: fn () callconv(.C) void,
    Naked: fn () callconv(.Naked) void,
    // Interrupt is not supported on arm
};

fn makeUnhandledHandler(comptime str: []const u8) InterruptVector {
    return InterruptVector{
        .C = struct {
            fn unhandledInterrupt() callconv(.C) noreturn {
                @panic(\"unhandled interrupt: \" ++ str);
            }
        }.unhandledInterrupt,
    };
}

pub const VectorTable = extern struct {
    initial_stack_pointer: u32 = config.end_of_stack,
    Reset: InterruptVector = InterruptVector{ .C = cpu.startup_logic._start },
    NMI: InterruptVector = makeUnhandledHandler(\"NMI\"),
    HardFault: InterruptVector = makeUnhandledHandler(\"HardFault\"),
    MemManage: InterruptVector = makeUnhandledHandler(\"MemManage\"),
    BusFault: InterruptVector = makeUnhandledHandler(\"BusFault\"),
    UsageFault: InterruptVector = makeUnhandledHandler(\"UsageFault\"),

    reserved: [4]u32 = .{ 0, 0, 0, 0 },
    SVCall: InterruptVector = makeUnhandledHandler(\"SVCall\"),
    DebugMonitor: InterruptVector = makeUnhandledHandler(\"DebugMonitor\"),
    reserved1: u32 = 0,

    PendSV: InterruptVector = makeUnhandledHandler(\"PendSV\"),
    SysTick: InterruptVector = makeUnhandledHandler(\"SysTick\"),\n
""")

        reserved_count = 2
        expected_next_value = 0
        for interrupt in interrupts:
            if expected_next_value > interrupt.value:
                raise Exception("out of order interrupt list")

            while expected_next_value < interrupt.value:
                self.write_line(f"    reserved{reserved_count}: u32 = 0,")
                expected_next_value += 1
                reserved_count += 1

            if interrupt.description is not None:
                description = comment_description(interrupt.description)
                self.write_line(description)
            self.write_line(f"    {interrupt.name}: InterruptVector = makeUnhandledHandler(\"{interrupt.name}\"),")
            expected_next_value += 1
        self.write_line("};")

        self.write_line(
        """
fn isValidField(field_name: []const u8) bool {
    return !std.mem.startsWith(u8, field_name, "reserved") and
        !std.mem.eql(u8, field_name, "initial_stack_pointer") and
        !std.mem.eql(u8, field_name, "reset");
}

export const vectors: VectorTable linksection(\"microzig_flash_start\") = blk: {
    var temp: VectorTable = .{};
    if (@hasDecl(root, \"vector_table\")) {
        const vector_table = root.vector_table;
        if (@typeInfo(vector_table) != .Struct)
            @compileLog(\"root.vector_table must be a struct\");

        inline for (@typeInfo(vector_table).Struct.decls) |decl| {
            const calling_convention = @typeInfo(@TypeOf(@field(vector_table, decl.name))).Fn.calling_convention;
            const handler = @field(vector_table, decl.name);

            if (!@hasField(VectorTable, decl.name)) {
                var msg: []const u8 = \"There is no such interrupt as '\" ++ decl.name ++ \"', declarations in 'root.vector_table' must be one of:\\n\";
                inline for (std.meta.fields(VectorTable)) |field| {
                    if (isValidField(field.name)) {
                        msg = msg ++ \"    \" ++ field.name ++ \"\\n\";
                    }
                }

                @compileError(msg);
            }

            if (!isValidField(decl.name))
                @compileError(\"You are not allowed to specify \'\" ++ decl.name ++ \"\' in the vector table, for your sins you must now pay a $5 fine to the ZSF: https://github.com/sponsors/ziglang\");

            @field(temp, decl.name) = switch (calling_convention) {
                .C => .{ .C = handler },
                .Naked => .{ .Naked = handler },
                // for unspecified calling convention we are going to generate small wrapper
                .Unspecified => .{
                    .C = struct {
                        fn wrapper() callconv(.C) void {
                            if (calling_convention == .Unspecified) // TODO: workaround for some weird stage1 bug
                                @call(.{ .modifier = .always_inline }, handler, .{});
                        }
                    }.wrapper,
                },

                else => @compileError(\"unsupported calling convention for function \" ++ decl.name),
            };
        }
    }
    break :blk temp;
};
""")

    def generate_file(self, device):
        self.write_line("// generated using svd2zig.py\n// DO NOT EDIT")
        self.write_line(f"// based on {device.name} version {device.version}")


        self.write_line("const microzig_mmio = @import(\"microzig-mmio\");")
        self.write_line("const mmio = microzig_mmio.mmio;")
        self.write_line("const MMIO = microzig_mmio.MMIO;")
        self.write_line(f"const Name = \"{device.name}\";")
        interrupts = {}
        for peripheral in device.peripherals:
            self.generate_peripheral_declaration(peripheral)
            if peripheral.interrupts != None:
                for interrupt in peripheral.interrupts:
                    if interrupt.value in interrupts and interrupts[interrupt.value].description != interrupt.description:
                        interrupts[interrupt.value].description += "; " + interrupt.description
                    else:
                        interrupts[interrupt.value] = interrupt

        interrupts = list(map(lambda i: i[1], sorted(interrupts.items())))
        for interrupt in interrupts:
            if interrupt.description is not None:
                interrupt.description = ' '.join(interrupt.description.split())

        self.generate_startup_and_interrupts(interrupts)

    def write_line(self, line):
        self.f.write(line + "\n")


def main():
    parser = SVDParser.for_packaged_svd(sys.argv[1], sys.argv[2] + '.svd')
    device = parser.get_device()

    generator = MMIOFileGenerator(sys.stdout)
    generator.generate_file(device)

if __name__ == "__main__":
    main()
