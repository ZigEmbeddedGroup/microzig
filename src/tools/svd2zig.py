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
        for x in range(offset, offset+count):
            self.write_line(f"{name}{x}: u1 = 0,")

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
                self.write_line(f"// .@\"{e.name}\", // desc: {e.description}")
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

    def generate_file(self, device):
        self.write_line("// generated using svd2zig.py\n// DO NOT EDIT")
        self.write_line(f"// based on {device.name} version {device.version}")

        self.write_line("const mmio = @import(\"microzig-mmio\").mmio;")
        self.write_line(f"const Name = \"{device.name}\";")
        for peripherial in device.peripherals:
            self.generate_peripherial_declaration(peripherial)

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
