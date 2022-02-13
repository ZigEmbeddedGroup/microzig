#!/usr/bin/env python3
import sys
import subprocess
import re

from cmsis_svd.parser import SVDParser


def cleanup_description(description):
    if description is None:
        return ''

    return ' '.join(description.replace('\n', ' ').split())


# register names in some SVDs are using foo[n] for registers names
# and also for some reaons there are string formatters like %s in the reigster names
NAME_REGEX = re.compile(r"\[([^\]]+)]")
def cleanup_name(name):
    return NAME_REGEX.sub(r"_\1", name).replace("%", "_")


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
            name: enum(u<size>){ // bit offset: 0 desc: foo description
              name = value, // desc: ...
              name = value, // desc:
              _, // non-exhustive
            },

        '''
        field.description = cleanup_description(field.description)
        self.write_line(f"{field.name}:enum(u{field.bit_width}){{// bit offset: {field.bit_offset} desc: {field.description}")

        total_fields_with_values = 0
        for e in field.enumerated_values:
            e.description = cleanup_description(e.description)
            if e.value is None or e.name == "RESERVED":
                # reserved fields doesn't have a value so we have to comment them out
                self.write_line(f"// @\"{e.name}\", // desc: {e.description}")
            else:
                total_fields_with_values = total_fields_with_values + 1
                self.write_line(f"@\"{e.name}\" = {e.value}, // desc: {e.description}")

        # if the fields doesn't use all possible values make the enum non-exhaustive
        if total_fields_with_values < 2**field.bit_width:
            self.write_line("_, // non-exhaustive")

        self.write_line("},")
        return field.bit_offset + field.bit_width

    def generate_register_field(self, field):
        '''
        returns something like:
            name: u<size>, // bit offset: 0 desc: foo description
        '''
        field.description = cleanup_description(field.description)
        self.write_line(f"{field.name}:u{field.bit_width},// bit offset: {field.bit_offset} desc: {field.description}")
        return field.bit_offset + field.bit_width

    def generate_register_declaration(self, register):
        '''

        '''
        register.description = cleanup_description(register.description)
        self.write_line(f"// byte offset: {register.address_offset} {register.description}")
        register.name = cleanup_name(register.name)

        size = register.size
        if size == None:
            size = 32 # hack for now...

        self.write_line(f" pub const {register.name} = mmio(Address + 0x{register.address_offset:08x}, {size}, packed struct{{")
        last_offset = 0
        reserved_index = 0
        for field in sorted(register.fields, key=lambda f: f.bit_offset):
            # workaround for NXP SVD which has overleaping reserved fields
            if field.name == "RESERVED":
                self.write_line(f"// RESERVED: u{field.bit_width}, // bit offset: {field.bit_offset} desc: {field.description}")
                continue

            if last_offset != field.bit_offset:
                reserved_size = field.bit_offset - last_offset
                self.generate_padding(reserved_size, "reserved", reserved_index)
                reserved_index = reserved_index + reserved_size

            if field.is_enumerated_type:
                last_offset = self.generate_enumerated_field(field)
            else:
                last_offset = self.generate_register_field(field)

        if size is not None:
            if len(register.fields) == 0:
                self.write_line(f"raw: u{size}, // placeholder field")
            else:
                self.generate_padding(size - last_offset, "padding", 0)

        self.write_line("});")

    def generate_peripherial_declaration(self, peripherial):
        # TODO: write peripherial description
        self.write_line(f"pub const {peripherial.name} = extern struct {{")
        self.write_line(f"pub const Address: u32 = 0x{peripherial.base_address:08x};")

        for register in sorted(peripherial.registers, key=lambda f: f.address_offset):
            self.generate_register_declaration(register)

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
                self.write_line(f"\n    /// {interrupt.description}")
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

        self.write_line("const mmio = @import(\"microzig-mmio\").mmio;")
        self.write_line(f"const Name = \"{device.name}\";")
        interrupts = {}
        for peripheral in device.peripherals:
            self.generate_peripherial_declaration(peripheral)
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

    zig_fmt = subprocess.Popen(('zig', 'fmt', '--stdin'), stdin=subprocess.PIPE,
                               stdout=subprocess.PIPE, encoding='utf8')

    generator = MMIOFileGenerator(zig_fmt.stdin)
    generator.generate_file(device)

    zig_fmt.stdin.flush()
    zig_fmt.stdin.close()
    print(zig_fmt.stdout.read())


if __name__ == "__main__":
    main()
