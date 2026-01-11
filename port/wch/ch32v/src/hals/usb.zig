//! USB device implementation
//!
//!

const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const chip = microzig.hal.compatibility.chip;
const usb = microzig.core.usb;

const PHY = enum {
    device,
    host_device,
};

pub const HardwareConfig = struct {
    max_endpoints_count: comptime_int = 3, // datasheet text says 16 but only has 8 registers?
    max_interfaces_count: comptime_int = 2, // not sure on this
    num_can_active: u2 = 0, // 0, 1 or 2, changes amount of shared SRAM
    phy: PHY = .device,
    buffer_size: u32 = 64,
};

const BufferDescription = packed struct {
    const Count = packed struct {
        val: u10,
        res: u6,
        res2: u16,
    };
    address: u32,
    count: Count,
};

const SHARED_SRAM_SIZE: comptime_int = 512; // bytes
const SHARED_SRAM_ADDR: comptime_int = 0x40006000;
pub fn Polled(
    controller_config: usb.Config,
    config: HardwareConfig,
) type {
    const buffer_desc_size = 2 * config.max_endpoints_count * @sizeOf(BufferDescription);
    // seems like we must have 2 buffers per endpoint
    // they're either double buffered or tx/rx?
    const buffer_size = 2 * config.max_endpoints_count * config.buffer_size;
    const used_sram = buffer_desc_size + buffer_size;
    comptime {
        // Do hardware config validity checks here
        const can_sram_size: u32 = 128 * @as(u32, @intCast(config.num_can_active));
        const available_sram = SHARED_SRAM_SIZE - can_sram_size;

        if (used_sram > available_sram) {
            @compileLog("USB Buffer configuration overflows available sram");
        }
    }
    _ = controller_config;
    // _ = config;
    const USB = peripherals.USB;
    const EXT = peripherals.EXTEND;

    // always putting the buffer descriptor table at the start of shared sram
    const buffer_descriptor_table: *align(2) [2 * config.max_endpoints_count]BufferDescription = @ptrFromInt(SHARED_SRAM_ADDR);
    const ep_buffers: *align(2) [2 * config.max_endpoints_count][config.buffer_size]u8 = @ptrFromInt(SHARED_SRAM_ADDR + buffer_desc_size);

    return struct {
        const vtable: usb.DeviceInterface.VTable = .{
            .ep_writev = start_tx,
            .ep_readv = start_rx,
            .set_address = set_address,
            .ep_open = ep_open,
        };

        pub fn poll() void {
            // do the recurring work here
        }
        pub fn init() @This() {
            // setup hardware here
            // first check for 48MHz clock then enable the USB Clock in RCC_CFGR0
            const RCC = peripherals.RCC;
            // RCC.CFGR0 // USBPRE
            RCC.AHBPCENR.modify(.{ .USBHS_EN = 1 });
            RCC.APB1PCENR.modify(.{ .USBDEN = 1 });
            USB.CNTR.modify(.{ .FRES = 1 }); // reset the peripheral if it's not already

            init_shared_sram();
            // endpoint config

            //packet buffer description table

            USB.DADDR.modify(.{ .ADD = 0, .EF = 1 });
            EXT.EXTEND_CTR.modify(.{ .USBDPU = 1 }); // enable pull up
            USB.CNTR.modify(.{ .FRES = 0 }); // bring device out of reset
            USB.ISTR.raw = 0; // reset all interrupt bits
            // enable interrupts here if needed
            USB.CNTR.modify(.{ .ESOFM = 0, .SOFM = 0, .RESETM = 0, .SUSPM = 0, .WKUPM = 0, .ERRM = 0, .PMAOVRM = 0, .CTRM = 0 });

            return .{};
        }

        fn init_shared_sram() void {
            // put table at start of sram
            USB.BTABLE.modify(.{ .BTABLE = 0 });
            for (buffer_descriptor_table, ep_buffers) |*desc, *buf| {
                desc.*.address = @intFromPtr(buf);
                desc.*.count.val = 64; // is EP0 64 bytes?
            }
        }

        pub fn start_tx(self: *usb.DeviceInterface, ep_num: usb.types.Endpoint.Num, buffer: []const u8) void {
            _ = self;
            _ = ep_num;
            _ = buffer;
        }
        pub fn start_rx(self: *usb.DeviceInterface, ep_num: usb.types.Endpoint.Num, len: usize) void {
            _ = self;
            _ = ep_num;
            _ = len;
        }
        pub fn ep_open(self: *@This(), desc: *const usb.descriptor.Endpoint) void {
            _ = self;
            // how to tell if IN or OUT endpoint?

            const epr = get_epr_reg(desc.endpoint.num);
            epr.modify(.{
                .EP_TYPE = switch (desc.attributes.transfer_type) {
                    .Bulk => 0b00,
                    .Control => 0b01,
                    .Isochronous => 0b10,
                    .Interrupt => 0b11,
                },
                .EP_KIND = 0, // no double buffering for now

            });
        }
        pub fn set_address(self: *usb.DeviceInterface, addr: u7) void {
            _ = self;
            _ = addr;
        }
        fn get_epr_reg(ep_num: usb.types.Endpoint.Num) @TypeOf(USB.EPR0) {
            return switch (ep_num) {
                .ep0 => USB.EPR0,
                .ep1 => USB.EPR1,
                .ep2 => USB.EPR2,
                .ep3 => USB.EPR3,
                .ep4 => USB.EPR4,
                .ep5 => USB.EPR5,
                .ep6 => USB.EPR6,
                .ep7 => USB.EPR7,
                else => @compileError("Unsupported endpoint number"),
            };
        }
    };
}
