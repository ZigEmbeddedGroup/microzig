const micro = @import("microzig");
const mmio = micro.mmio;

pub const devices = struct {
    ///  nRF52832 reference description for radio MCU with ARM 32-bit Cortex-M4 Microcontroller
    pub const nrf52 = struct {
        pub const properties = struct {
            pub const @"cpu.nvic_prio_bits" = "3";
            pub const @"cpu.mpu" = "1";
            pub const @"cpu.fpu" = "1";
            pub const @"cpu.revision" = "r0p1";
            pub const @"cpu.vendor_systick_config" = "0";
            pub const license =
                \\
                \\Copyright (c) 2010 - 2021, Nordic Semiconductor ASA All rights reserved.\n
                \\\n
                \\Redistribution and use in source and binary forms, with or without\n
                \\modification, are permitted provided that the following conditions are met:\n
                \\\n
                \\1. Redistributions of source code must retain the above copyright notice, this\n
                \\   list of conditions and the following disclaimer.\n
                \\\n
                \\2. Redistributions in binary form must reproduce the above copyright\n
                \\   notice, this list of conditions and the following disclaimer in the\n
                \\   documentation and/or other materials provided with the distribution.\n
                \\\n
                \\3. Neither the name of Nordic Semiconductor ASA nor the names of its\n
                \\   contributors may be used to endorse or promote products derived from this\n
                \\   software without specific prior written permission.\n
                \\\n
                \\THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"\n
                \\AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE\n
                \\IMPLIED WARRANTIES OF MERCHANTABILITY, AND FITNESS FOR A PARTICULAR PURPOSE\n
                \\ARE DISCLAIMED. IN NO EVENT SHALL NORDIC SEMICONDUCTOR ASA OR CONTRIBUTORS BE\n
                \\LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR\n
                \\CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF\n
                \\SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS\n
                \\INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN\n
                \\CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)\n
                \\ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE\n
                \\POSSIBILITY OF SUCH DAMAGE.\n
                \\        
            ;
            pub const @"cpu.name" = "CM4";
            pub const @"cpu.endian" = "little";
        };

        pub const VectorTable = extern struct {
            const Handler = micro.interrupt.Handler;
            const unhandled = micro.interrupt.unhandled;

            initial_stack_pointer: u32,
            Reset: Handler = unhandled,
            NMI: Handler = unhandled,
            HardFault: Handler = unhandled,
            MemManageFault: Handler = unhandled,
            BusFault: Handler = unhandled,
            UsageFault: Handler = unhandled,
            reserved5: [4]u32 = undefined,
            SVCall: Handler = unhandled,
            DebugMonitor: Handler = unhandled,
            reserved11: [1]u32 = undefined,
            PendSV: Handler = unhandled,
            SysTick: Handler = unhandled,
            POWER_CLOCK: Handler = unhandled,
            RADIO: Handler = unhandled,
            UARTE0_UART0: Handler = unhandled,
            SPIM0_SPIS0_TWIM0_TWIS0_SPI0_TWI0: Handler = unhandled,
            SPIM1_SPIS1_TWIM1_TWIS1_SPI1_TWI1: Handler = unhandled,
            NFCT: Handler = unhandled,
            GPIOTE: Handler = unhandled,
            SAADC: Handler = unhandled,
            TIMER0: Handler = unhandled,
            TIMER1: Handler = unhandled,
            TIMER2: Handler = unhandled,
            RTC0: Handler = unhandled,
            TEMP: Handler = unhandled,
            RNG: Handler = unhandled,
            ECB: Handler = unhandled,
            CCM_AAR: Handler = unhandled,
            WDT: Handler = unhandled,
            RTC1: Handler = unhandled,
            QDEC: Handler = unhandled,
            COMP_LPCOMP: Handler = unhandled,
            SWI0_EGU0: Handler = unhandled,
            SWI1_EGU1: Handler = unhandled,
            SWI2_EGU2: Handler = unhandled,
            SWI3_EGU3: Handler = unhandled,
            SWI4_EGU4: Handler = unhandled,
            SWI5_EGU5: Handler = unhandled,
            TIMER3: Handler = unhandled,
            TIMER4: Handler = unhandled,
            PWM0: Handler = unhandled,
            PDM: Handler = unhandled,
            reserved44: [2]u32 = undefined,
            MWU: Handler = unhandled,
            PWM1: Handler = unhandled,
            PWM2: Handler = unhandled,
            SPIM2_SPIS2_SPI2: Handler = unhandled,
            RTC2: Handler = unhandled,
            I2S: Handler = unhandled,
            FPU: Handler = unhandled,
        };

        pub const peripherals = struct {
            ///  Factory Information Configuration Registers
            pub const FICR = @intToPtr(*volatile types.peripherals.FICR, 0x10000000);
            ///  User Information Configuration Registers
            pub const UICR = @intToPtr(*volatile types.peripherals.UICR, 0x10001000);
            ///  Block Protect
            pub const BPROT = @intToPtr(*volatile types.peripherals.BPROT, 0x40000000);
            ///  Power control
            pub const POWER = @intToPtr(*volatile types.peripherals.POWER, 0x40000000);
            ///  Clock control
            pub const CLOCK = @intToPtr(*volatile types.peripherals.CLOCK, 0x40000000);
            ///  2.4 GHz Radio
            pub const RADIO = @intToPtr(*volatile types.peripherals.RADIO, 0x40001000);
            ///  UART with EasyDMA
            pub const UARTE0 = @intToPtr(*volatile types.peripherals.UARTE0, 0x40002000);
            ///  Universal Asynchronous Receiver/Transmitter
            pub const UART0 = @intToPtr(*volatile types.peripherals.UART0, 0x40002000);
            ///  Serial Peripheral Interface Master with EasyDMA 0
            pub const SPIM0 = @intToPtr(*volatile types.peripherals.SPIM0, 0x40003000);
            ///  SPI Slave 0
            pub const SPIS0 = @intToPtr(*volatile types.peripherals.SPIS0, 0x40003000);
            ///  I2C compatible Two-Wire Master Interface with EasyDMA 0
            pub const TWIM0 = @intToPtr(*volatile types.peripherals.TWIM0, 0x40003000);
            ///  I2C compatible Two-Wire Slave Interface with EasyDMA 0
            pub const TWIS0 = @intToPtr(*volatile types.peripherals.TWIS0, 0x40003000);
            ///  Serial Peripheral Interface 0
            pub const SPI0 = @intToPtr(*volatile types.peripherals.SPI0, 0x40003000);
            ///  I2C compatible Two-Wire Interface 0
            pub const TWI0 = @intToPtr(*volatile types.peripherals.TWI0, 0x40003000);
            ///  Serial Peripheral Interface Master with EasyDMA 1
            pub const SPIM1 = @intToPtr(*volatile types.peripherals.SPIM0, 0x40004000);
            ///  SPI Slave 1
            pub const SPIS1 = @intToPtr(*volatile types.peripherals.SPIS0, 0x40004000);
            ///  I2C compatible Two-Wire Master Interface with EasyDMA 1
            pub const TWIM1 = @intToPtr(*volatile types.peripherals.TWIM0, 0x40004000);
            ///  I2C compatible Two-Wire Slave Interface with EasyDMA 1
            pub const TWIS1 = @intToPtr(*volatile types.peripherals.TWIS0, 0x40004000);
            ///  Serial Peripheral Interface 1
            pub const SPI1 = @intToPtr(*volatile types.peripherals.SPI0, 0x40004000);
            ///  I2C compatible Two-Wire Interface 1
            pub const TWI1 = @intToPtr(*volatile types.peripherals.TWI0, 0x40004000);
            ///  NFC-A compatible radio
            pub const NFCT = @intToPtr(*volatile types.peripherals.NFCT, 0x40005000);
            ///  GPIO Tasks and Events
            pub const GPIOTE = @intToPtr(*volatile types.peripherals.GPIOTE, 0x40006000);
            ///  Analog to Digital Converter
            pub const SAADC = @intToPtr(*volatile types.peripherals.SAADC, 0x40007000);
            ///  Timer/Counter 0
            pub const TIMER0 = @intToPtr(*volatile types.peripherals.TIMER0, 0x40008000);
            ///  Timer/Counter 1
            pub const TIMER1 = @intToPtr(*volatile types.peripherals.TIMER0, 0x40009000);
            ///  Timer/Counter 2
            pub const TIMER2 = @intToPtr(*volatile types.peripherals.TIMER0, 0x4000a000);
            ///  Real time counter 0
            pub const RTC0 = @intToPtr(*volatile types.peripherals.RTC0, 0x4000b000);
            ///  Temperature Sensor
            pub const TEMP = @intToPtr(*volatile types.peripherals.TEMP, 0x4000c000);
            ///  Random Number Generator
            pub const RNG = @intToPtr(*volatile types.peripherals.RNG, 0x4000d000);
            ///  AES ECB Mode Encryption
            pub const ECB = @intToPtr(*volatile types.peripherals.ECB, 0x4000e000);
            ///  AES CCM Mode Encryption
            pub const CCM = @intToPtr(*volatile types.peripherals.CCM, 0x4000f000);
            ///  Accelerated Address Resolver
            pub const AAR = @intToPtr(*volatile types.peripherals.AAR, 0x4000f000);
            ///  Watchdog Timer
            pub const WDT = @intToPtr(*volatile types.peripherals.WDT, 0x40010000);
            ///  Real time counter 1
            pub const RTC1 = @intToPtr(*volatile types.peripherals.RTC0, 0x40011000);
            ///  Quadrature Decoder
            pub const QDEC = @intToPtr(*volatile types.peripherals.QDEC, 0x40012000);
            ///  Comparator
            pub const COMP = @intToPtr(*volatile types.peripherals.COMP, 0x40013000);
            ///  Low Power Comparator
            pub const LPCOMP = @intToPtr(*volatile types.peripherals.LPCOMP, 0x40013000);
            ///  Software interrupt 0
            pub const SWI0 = @intToPtr(*volatile types.peripherals.SWI0, 0x40014000);
            ///  Event Generator Unit 0
            pub const EGU0 = @intToPtr(*volatile types.peripherals.EGU0, 0x40014000);
            ///  Software interrupt 1
            pub const SWI1 = @intToPtr(*volatile types.peripherals.SWI0, 0x40015000);
            ///  Event Generator Unit 1
            pub const EGU1 = @intToPtr(*volatile types.peripherals.EGU0, 0x40015000);
            ///  Software interrupt 2
            pub const SWI2 = @intToPtr(*volatile types.peripherals.SWI0, 0x40016000);
            ///  Event Generator Unit 2
            pub const EGU2 = @intToPtr(*volatile types.peripherals.EGU0, 0x40016000);
            ///  Software interrupt 3
            pub const SWI3 = @intToPtr(*volatile types.peripherals.SWI0, 0x40017000);
            ///  Event Generator Unit 3
            pub const EGU3 = @intToPtr(*volatile types.peripherals.EGU0, 0x40017000);
            ///  Software interrupt 4
            pub const SWI4 = @intToPtr(*volatile types.peripherals.SWI0, 0x40018000);
            ///  Event Generator Unit 4
            pub const EGU4 = @intToPtr(*volatile types.peripherals.EGU0, 0x40018000);
            ///  Software interrupt 5
            pub const SWI5 = @intToPtr(*volatile types.peripherals.SWI0, 0x40019000);
            ///  Event Generator Unit 5
            pub const EGU5 = @intToPtr(*volatile types.peripherals.EGU0, 0x40019000);
            ///  Timer/Counter 3
            pub const TIMER3 = @intToPtr(*volatile types.peripherals.TIMER0, 0x4001a000);
            ///  Timer/Counter 4
            pub const TIMER4 = @intToPtr(*volatile types.peripherals.TIMER0, 0x4001b000);
            ///  Pulse Width Modulation Unit 0
            pub const PWM0 = @intToPtr(*volatile types.peripherals.PWM0, 0x4001c000);
            ///  Pulse Density Modulation (Digital Microphone) Interface
            pub const PDM = @intToPtr(*volatile types.peripherals.PDM, 0x4001d000);
            ///  Non Volatile Memory Controller
            pub const NVMC = @intToPtr(*volatile types.peripherals.NVMC, 0x4001e000);
            ///  Programmable Peripheral Interconnect
            pub const PPI = @intToPtr(*volatile types.peripherals.PPI, 0x4001f000);
            ///  Memory Watch Unit
            pub const MWU = @intToPtr(*volatile types.peripherals.MWU, 0x40020000);
            ///  Pulse Width Modulation Unit 1
            pub const PWM1 = @intToPtr(*volatile types.peripherals.PWM0, 0x40021000);
            ///  Pulse Width Modulation Unit 2
            pub const PWM2 = @intToPtr(*volatile types.peripherals.PWM0, 0x40022000);
            ///  Serial Peripheral Interface Master with EasyDMA 2
            pub const SPIM2 = @intToPtr(*volatile types.peripherals.SPIM0, 0x40023000);
            ///  SPI Slave 2
            pub const SPIS2 = @intToPtr(*volatile types.peripherals.SPIS0, 0x40023000);
            ///  Serial Peripheral Interface 2
            pub const SPI2 = @intToPtr(*volatile types.peripherals.SPI0, 0x40023000);
            ///  Real time counter 2
            pub const RTC2 = @intToPtr(*volatile types.peripherals.RTC0, 0x40024000);
            ///  Inter-IC Sound
            pub const I2S = @intToPtr(*volatile types.peripherals.I2S, 0x40025000);
            ///  FPU
            pub const FPU = @intToPtr(*volatile types.peripherals.FPU, 0x40026000);
            ///  GPIO Port 1
            pub const P0 = @intToPtr(*volatile types.peripherals.P0, 0x50000000);
            ///  System Tick Timer
            pub const SysTick = @intToPtr(*volatile types.peripherals.SCS.SysTick, 0xe000e010);
        };
    };
};

pub const types = struct {
    pub const peripherals = struct {
        ///  System Control Space
        pub const SCS = struct {
            ///  System Tick Timer
            pub const SysTick = extern struct {
                ///  SysTick Control and Status Register
                CTRL: mmio.Mmio(packed struct(u32) {
                    ENABLE: u1,
                    TICKINT: u1,
                    CLKSOURCE: u1,
                    reserved16: u13,
                    COUNTFLAG: u1,
                    padding: u15,
                }),
                ///  SysTick Reload Value Register
                LOAD: mmio.Mmio(packed struct(u32) {
                    RELOAD: u24,
                    padding: u8,
                }),
                ///  SysTick Current Value Register
                VAL: mmio.Mmio(packed struct(u32) {
                    CURRENT: u24,
                    padding: u8,
                }),
                ///  SysTick Calibration Register
                CALIB: mmio.Mmio(packed struct(u32) {
                    TENMS: u24,
                    reserved30: u6,
                    SKEW: u1,
                    NOREF: u1,
                }),
            };
        };

        ///  Factory Information Configuration Registers
        pub const FICR = extern struct {
            reserved16: [16]u8,
            ///  Code memory page size
            CODEPAGESIZE: mmio.Mmio(packed struct(u32) {
                ///  Code memory page size
                CODEPAGESIZE: u32,
            }),
            ///  Code memory size
            CODESIZE: mmio.Mmio(packed struct(u32) {
                ///  Code memory size in number of pages
                CODESIZE: u32,
            }),
            reserved96: [72]u8,
            ///  Description collection[0]: Device identifier
            DEVICEID: [2]mmio.Mmio(packed struct(u32) {
                ///  64 bit unique device identifier
                DEVICEID: u32,
            }),
            reserved128: [24]u8,
            ///  Description collection[0]: Encryption Root, word 0
            ER: [4]mmio.Mmio(packed struct(u32) {
                ///  Encryption Root, word n
                ER: u32,
            }),
            ///  Description collection[0]: Identity Root, word 0
            IR: [4]mmio.Mmio(packed struct(u32) {
                ///  Identity Root, word n
                IR: u32,
            }),
            ///  Device address type
            DEVICEADDRTYPE: mmio.Mmio(packed struct(u32) {
                ///  Device address type
                DEVICEADDRTYPE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Public address
                        Public = 0x0,
                        ///  Random address
                        Random = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Description collection[0]: Device address 0
            DEVICEADDR: [2]mmio.Mmio(packed struct(u32) {
                ///  48 bit device address
                DEVICEADDR: u32,
            }),
        };

        ///  User Information Configuration Registers
        pub const UICR = extern struct {
            ///  Unspecified
            UNUSED0: u32,
            ///  Unspecified
            UNUSED1: u32,
            ///  Unspecified
            UNUSED2: u32,
            reserved16: [4]u8,
            ///  Unspecified
            UNUSED3: u32,
            ///  Description collection[0]: Reserved for Nordic firmware design
            NRFFW: [15]mmio.Mmio(packed struct(u32) {
                ///  Reserved for Nordic firmware design
                NRFFW: u32,
            }),
            ///  Description collection[0]: Reserved for Nordic hardware design
            NRFHW: [12]mmio.Mmio(packed struct(u32) {
                ///  Reserved for Nordic hardware design
                NRFHW: u32,
            }),
            ///  Description collection[0]: Reserved for customer
            CUSTOMER: [32]mmio.Mmio(packed struct(u32) {
                ///  Reserved for customer
                CUSTOMER: u32,
            }),
            reserved512: [256]u8,
            ///  Description collection[0]: Mapping of the nRESET function (see POWER chapter for details)
            PSELRESET: [2]mmio.Mmio(packed struct(u32) {
                ///  GPIO number P0.n onto which Reset is exposed
                PIN: u6,
                reserved31: u25,
                ///  Connection
                CONNECT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disconnect
                        Disconnected = 0x1,
                        ///  Connect
                        Connected = 0x0,
                    },
                },
            }),
            ///  Access Port protection
            APPROTECT: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable Access Port protection. Any other value than 0xFF being written to this field will enable protection.
                PALL: packed union {
                    raw: u8,
                    value: enum(u8) {
                        ///  Disable
                        Disabled = 0xff,
                        ///  Enable
                        Enabled = 0x0,
                        _,
                    },
                },
                padding: u24,
            }),
            ///  Setting of pins dedicated to NFC functionality: NFC antenna or GPIO
            NFCPINS: mmio.Mmio(packed struct(u32) {
                ///  Setting of pins dedicated to NFC functionality
                PROTECT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Operation as GPIO pins. Same protection as normal GPIO pins
                        Disabled = 0x0,
                        ///  Operation as NFC antenna pins. Configures the protection for NFC operation
                        NFC = 0x1,
                    },
                },
                padding: u31,
            }),
        };

        ///  Block Protect
        pub const BPROT = extern struct {
            reserved1536: [1536]u8,
            ///  Block protect configuration register 0
            CONFIG0: mmio.Mmio(packed struct(u32) {
                ///  Enable protection for region 0. Write '0' has no effect.
                REGION0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 1. Write '0' has no effect.
                REGION1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 2. Write '0' has no effect.
                REGION2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 3. Write '0' has no effect.
                REGION3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 4. Write '0' has no effect.
                REGION4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 5. Write '0' has no effect.
                REGION5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 6. Write '0' has no effect.
                REGION6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 7. Write '0' has no effect.
                REGION7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 8. Write '0' has no effect.
                REGION8: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 9. Write '0' has no effect.
                REGION9: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 10. Write '0' has no effect.
                REGION10: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 11. Write '0' has no effect.
                REGION11: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 12. Write '0' has no effect.
                REGION12: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 13. Write '0' has no effect.
                REGION13: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 14. Write '0' has no effect.
                REGION14: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 15. Write '0' has no effect.
                REGION15: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 16. Write '0' has no effect.
                REGION16: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 17. Write '0' has no effect.
                REGION17: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 18. Write '0' has no effect.
                REGION18: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 19. Write '0' has no effect.
                REGION19: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 20. Write '0' has no effect.
                REGION20: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 21. Write '0' has no effect.
                REGION21: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 22. Write '0' has no effect.
                REGION22: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 23. Write '0' has no effect.
                REGION23: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 24. Write '0' has no effect.
                REGION24: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 25. Write '0' has no effect.
                REGION25: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 26. Write '0' has no effect.
                REGION26: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 27. Write '0' has no effect.
                REGION27: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 28. Write '0' has no effect.
                REGION28: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 29. Write '0' has no effect.
                REGION29: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 30. Write '0' has no effect.
                REGION30: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 31. Write '0' has no effect.
                REGION31: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enable
                        Enabled = 0x1,
                    },
                },
            }),
            ///  Block protect configuration register 1
            CONFIG1: mmio.Mmio(packed struct(u32) {
                ///  Enable protection for region 32. Write '0' has no effect.
                REGION32: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 33. Write '0' has no effect.
                REGION33: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 34. Write '0' has no effect.
                REGION34: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 35. Write '0' has no effect.
                REGION35: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 36. Write '0' has no effect.
                REGION36: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 37. Write '0' has no effect.
                REGION37: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 38. Write '0' has no effect.
                REGION38: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 39. Write '0' has no effect.
                REGION39: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 40. Write '0' has no effect.
                REGION40: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 41. Write '0' has no effect.
                REGION41: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 42. Write '0' has no effect.
                REGION42: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 43. Write '0' has no effect.
                REGION43: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 44. Write '0' has no effect.
                REGION44: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 45. Write '0' has no effect.
                REGION45: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 46. Write '0' has no effect.
                REGION46: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 47. Write '0' has no effect.
                REGION47: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 48. Write '0' has no effect.
                REGION48: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 49. Write '0' has no effect.
                REGION49: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 50. Write '0' has no effect.
                REGION50: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 51. Write '0' has no effect.
                REGION51: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 52. Write '0' has no effect.
                REGION52: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 53. Write '0' has no effect.
                REGION53: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 54. Write '0' has no effect.
                REGION54: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 55. Write '0' has no effect.
                REGION55: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 56. Write '0' has no effect.
                REGION56: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 57. Write '0' has no effect.
                REGION57: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 58. Write '0' has no effect.
                REGION58: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 59. Write '0' has no effect.
                REGION59: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 60. Write '0' has no effect.
                REGION60: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 61. Write '0' has no effect.
                REGION61: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 62. Write '0' has no effect.
                REGION62: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 63. Write '0' has no effect.
                REGION63: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
            }),
            ///  Disable protection mechanism in debug interface mode
            DISABLEINDEBUG: mmio.Mmio(packed struct(u32) {
                ///  Disable the protection mechanism for NVM regions while in debug interface mode. This register will only disable the protection mechanism if the device is in debug interface mode.
                DISABLEINDEBUG: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable in debug
                        Disabled = 0x1,
                        ///  Enable in debug
                        Enabled = 0x0,
                    },
                },
                padding: u31,
            }),
            ///  Unspecified
            UNUSED0: u32,
            ///  Block protect configuration register 2
            CONFIG2: mmio.Mmio(packed struct(u32) {
                ///  Enable protection for region 64. Write '0' has no effect.
                REGION64: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 65. Write '0' has no effect.
                REGION65: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 66. Write '0' has no effect.
                REGION66: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 67. Write '0' has no effect.
                REGION67: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 68. Write '0' has no effect.
                REGION68: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 69. Write '0' has no effect.
                REGION69: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 70. Write '0' has no effect.
                REGION70: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 71. Write '0' has no effect.
                REGION71: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 72. Write '0' has no effect.
                REGION72: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 73. Write '0' has no effect.
                REGION73: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 74. Write '0' has no effect.
                REGION74: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 75. Write '0' has no effect.
                REGION75: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 76. Write '0' has no effect.
                REGION76: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 77. Write '0' has no effect.
                REGION77: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 78. Write '0' has no effect.
                REGION78: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 79. Write '0' has no effect.
                REGION79: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 80. Write '0' has no effect.
                REGION80: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 81. Write '0' has no effect.
                REGION81: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 82. Write '0' has no effect.
                REGION82: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 83. Write '0' has no effect.
                REGION83: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 84. Write '0' has no effect.
                REGION84: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 85. Write '0' has no effect.
                REGION85: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 86. Write '0' has no effect.
                REGION86: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 87. Write '0' has no effect.
                REGION87: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 88. Write '0' has no effect.
                REGION88: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 89. Write '0' has no effect.
                REGION89: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 90. Write '0' has no effect.
                REGION90: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 91. Write '0' has no effect.
                REGION91: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 92. Write '0' has no effect.
                REGION92: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 93. Write '0' has no effect.
                REGION93: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 94. Write '0' has no effect.
                REGION94: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 95. Write '0' has no effect.
                REGION95: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
            }),
            ///  Block protect configuration register 3
            CONFIG3: mmio.Mmio(packed struct(u32) {
                ///  Enable protection for region 96. Write '0' has no effect.
                REGION96: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 97. Write '0' has no effect.
                REGION97: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 98. Write '0' has no effect.
                REGION98: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 99. Write '0' has no effect.
                REGION99: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 100. Write '0' has no effect.
                REGION100: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 101. Write '0' has no effect.
                REGION101: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 102. Write '0' has no effect.
                REGION102: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 103. Write '0' has no effect.
                REGION103: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 104. Write '0' has no effect.
                REGION104: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 105. Write '0' has no effect.
                REGION105: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 106. Write '0' has no effect.
                REGION106: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 107. Write '0' has no effect.
                REGION107: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 108. Write '0' has no effect.
                REGION108: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 109. Write '0' has no effect.
                REGION109: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 110. Write '0' has no effect.
                REGION110: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 111. Write '0' has no effect.
                REGION111: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 112. Write '0' has no effect.
                REGION112: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 113. Write '0' has no effect.
                REGION113: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 114. Write '0' has no effect.
                REGION114: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 115. Write '0' has no effect.
                REGION115: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 116. Write '0' has no effect.
                REGION116: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 117. Write '0' has no effect.
                REGION117: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 118. Write '0' has no effect.
                REGION118: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 119. Write '0' has no effect.
                REGION119: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 120. Write '0' has no effect.
                REGION120: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 121. Write '0' has no effect.
                REGION121: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 122. Write '0' has no effect.
                REGION122: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 123. Write '0' has no effect.
                REGION123: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 124. Write '0' has no effect.
                REGION124: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 125. Write '0' has no effect.
                REGION125: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 126. Write '0' has no effect.
                REGION126: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable protection for region 127. Write '0' has no effect.
                REGION127: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Protection disabled
                        Disabled = 0x0,
                        ///  Protection enabled
                        Enabled = 0x1,
                    },
                },
            }),
        };

        ///  Power control
        pub const POWER = extern struct {
            reserved120: [120]u8,
            ///  Enable constant latency mode
            TASKS_CONSTLAT: u32,
            ///  Enable low power mode (variable latency)
            TASKS_LOWPWR: u32,
            reserved264: [136]u8,
            ///  Power failure warning
            EVENTS_POFWARN: u32,
            reserved276: [8]u8,
            ///  CPU entered WFI/WFE sleep
            EVENTS_SLEEPENTER: u32,
            ///  CPU exited WFI/WFE sleep
            EVENTS_SLEEPEXIT: u32,
            reserved772: [488]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  Write '1' to Enable interrupt for POFWARN event
                POFWARN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved5: u2,
                ///  Write '1' to Enable interrupt for SLEEPENTER event
                SLEEPENTER: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for SLEEPEXIT event
                SLEEPEXIT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u25,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  Write '1' to Disable interrupt for POFWARN event
                POFWARN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved5: u2,
                ///  Write '1' to Disable interrupt for SLEEPENTER event
                SLEEPENTER: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for SLEEPEXIT event
                SLEEPEXIT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u25,
            }),
            reserved1024: [244]u8,
            ///  Reset reason
            RESETREAS: mmio.Mmio(packed struct(u32) {
                ///  Reset from pin-reset detected
                RESETPIN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Not detected
                        NotDetected = 0x0,
                        ///  Detected
                        Detected = 0x1,
                    },
                },
                ///  Reset from watchdog detected
                DOG: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Not detected
                        NotDetected = 0x0,
                        ///  Detected
                        Detected = 0x1,
                    },
                },
                ///  Reset from soft reset detected
                SREQ: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Not detected
                        NotDetected = 0x0,
                        ///  Detected
                        Detected = 0x1,
                    },
                },
                ///  Reset from CPU lock-up detected
                LOCKUP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Not detected
                        NotDetected = 0x0,
                        ///  Detected
                        Detected = 0x1,
                    },
                },
                reserved16: u12,
                ///  Reset due to wake up from System OFF mode when wakeup is triggered from DETECT signal from GPIO
                OFF: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Not detected
                        NotDetected = 0x0,
                        ///  Detected
                        Detected = 0x1,
                    },
                },
                ///  Reset due to wake up from System OFF mode when wakeup is triggered from ANADETECT signal from LPCOMP
                LPCOMP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Not detected
                        NotDetected = 0x0,
                        ///  Detected
                        Detected = 0x1,
                    },
                },
                ///  Reset due to wake up from System OFF mode when wakeup is triggered from entering into debug interface mode
                DIF: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Not detected
                        NotDetected = 0x0,
                        ///  Detected
                        Detected = 0x1,
                    },
                },
                ///  Reset due to wake up from System OFF mode by NFC field detect
                NFC: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Not detected
                        NotDetected = 0x0,
                        ///  Detected
                        Detected = 0x1,
                    },
                },
                padding: u12,
            }),
            reserved1064: [36]u8,
            ///  Deprecated register - RAM status register
            RAMSTATUS: mmio.Mmio(packed struct(u32) {
                ///  RAM block 0 is on or off/powering up
                RAMBLOCK0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Off
                        Off = 0x0,
                        ///  On
                        On = 0x1,
                    },
                },
                ///  RAM block 1 is on or off/powering up
                RAMBLOCK1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Off
                        Off = 0x0,
                        ///  On
                        On = 0x1,
                    },
                },
                ///  RAM block 2 is on or off/powering up
                RAMBLOCK2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Off
                        Off = 0x0,
                        ///  On
                        On = 0x1,
                    },
                },
                ///  RAM block 3 is on or off/powering up
                RAMBLOCK3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Off
                        Off = 0x0,
                        ///  On
                        On = 0x1,
                    },
                },
                padding: u28,
            }),
            reserved1280: [212]u8,
            ///  System OFF register
            SYSTEMOFF: mmio.Mmio(packed struct(u32) {
                ///  Enable System OFF mode
                SYSTEMOFF: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Enable System OFF mode
                        Enter = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved1296: [12]u8,
            ///  Power failure comparator configuration
            POFCON: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable power failure comparator
                POF: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Power failure comparator threshold setting
                THRESHOLD: packed union {
                    raw: u4,
                    value: enum(u4) {
                        ///  Set threshold to 1.7 V
                        V17 = 0x4,
                        ///  Set threshold to 1.8 V
                        V18 = 0x5,
                        ///  Set threshold to 1.9 V
                        V19 = 0x6,
                        ///  Set threshold to 2.0 V
                        V20 = 0x7,
                        ///  Set threshold to 2.1 V
                        V21 = 0x8,
                        ///  Set threshold to 2.2 V
                        V22 = 0x9,
                        ///  Set threshold to 2.3 V
                        V23 = 0xa,
                        ///  Set threshold to 2.4 V
                        V24 = 0xb,
                        ///  Set threshold to 2.5 V
                        V25 = 0xc,
                        ///  Set threshold to 2.6 V
                        V26 = 0xd,
                        ///  Set threshold to 2.7 V
                        V27 = 0xe,
                        ///  Set threshold to 2.8 V
                        V28 = 0xf,
                        _,
                    },
                },
                padding: u27,
            }),
            reserved1308: [8]u8,
            ///  General purpose retention register
            GPREGRET: mmio.Mmio(packed struct(u32) {
                ///  General purpose retention register
                GPREGRET: u8,
                padding: u24,
            }),
            ///  General purpose retention register
            GPREGRET2: mmio.Mmio(packed struct(u32) {
                ///  General purpose retention register
                GPREGRET: u8,
                padding: u24,
            }),
            ///  Deprecated register - RAM on/off register (this register is retained)
            RAMON: mmio.Mmio(packed struct(u32) {
                ///  Keep RAM block 0 on or off in system ON Mode
                ONRAM0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Off
                        RAM0Off = 0x0,
                        ///  On
                        RAM0On = 0x1,
                    },
                },
                ///  Keep RAM block 1 on or off in system ON Mode
                ONRAM1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Off
                        RAM1Off = 0x0,
                        ///  On
                        RAM1On = 0x1,
                    },
                },
                reserved16: u14,
                ///  Keep retention on RAM block 0 when RAM block is switched off
                OFFRAM0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Off
                        RAM0Off = 0x0,
                        ///  On
                        RAM0On = 0x1,
                    },
                },
                ///  Keep retention on RAM block 1 when RAM block is switched off
                OFFRAM1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Off
                        RAM1Off = 0x0,
                        ///  On
                        RAM1On = 0x1,
                    },
                },
                padding: u14,
            }),
            reserved1364: [44]u8,
            ///  Deprecated register - RAM on/off register (this register is retained)
            RAMONB: mmio.Mmio(packed struct(u32) {
                ///  Keep RAM block 2 on or off in system ON Mode
                ONRAM2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Off
                        RAM2Off = 0x0,
                        ///  On
                        RAM2On = 0x1,
                    },
                },
                ///  Keep RAM block 3 on or off in system ON Mode
                ONRAM3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Off
                        RAM3Off = 0x0,
                        ///  On
                        RAM3On = 0x1,
                    },
                },
                reserved16: u14,
                ///  Keep retention on RAM block 2 when RAM block is switched off
                OFFRAM2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Off
                        RAM2Off = 0x0,
                        ///  On
                        RAM2On = 0x1,
                    },
                },
                ///  Keep retention on RAM block 3 when RAM block is switched off
                OFFRAM3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Off
                        RAM3Off = 0x0,
                        ///  On
                        RAM3On = 0x1,
                    },
                },
                padding: u14,
            }),
            reserved1400: [32]u8,
            ///  DC/DC enable register
            DCDCEN: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable DC/DC converter
                DCDCEN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                padding: u31,
            }),
        };

        ///  Clock control
        pub const CLOCK = extern struct {
            ///  Start HFCLK crystal oscillator
            TASKS_HFCLKSTART: u32,
            ///  Stop HFCLK crystal oscillator
            TASKS_HFCLKSTOP: u32,
            ///  Start LFCLK source
            TASKS_LFCLKSTART: u32,
            ///  Stop LFCLK source
            TASKS_LFCLKSTOP: u32,
            ///  Start calibration of LFRC oscillator
            TASKS_CAL: u32,
            ///  Start calibration timer
            TASKS_CTSTART: u32,
            ///  Stop calibration timer
            TASKS_CTSTOP: u32,
            reserved256: [228]u8,
            ///  HFCLK oscillator started
            EVENTS_HFCLKSTARTED: u32,
            ///  LFCLK started
            EVENTS_LFCLKSTARTED: u32,
            reserved268: [4]u8,
            ///  Calibration of LFCLK RC oscillator complete event
            EVENTS_DONE: u32,
            ///  Calibration timer timeout
            EVENTS_CTTO: u32,
            reserved772: [496]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Enable interrupt for HFCLKSTARTED event
                HFCLKSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for LFCLKSTARTED event
                LFCLKSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved3: u1,
                ///  Write '1' to Enable interrupt for DONE event
                DONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for CTTO event
                CTTO: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u27,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Disable interrupt for HFCLKSTARTED event
                HFCLKSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for LFCLKSTARTED event
                LFCLKSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved3: u1,
                ///  Write '1' to Disable interrupt for DONE event
                DONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for CTTO event
                CTTO: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u27,
            }),
            reserved1032: [252]u8,
            ///  Status indicating that HFCLKSTART task has been triggered
            HFCLKRUN: mmio.Mmio(packed struct(u32) {
                ///  HFCLKSTART task triggered or not
                STATUS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Task not triggered
                        NotTriggered = 0x0,
                        ///  Task triggered
                        Triggered = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  HFCLK status
            HFCLKSTAT: mmio.Mmio(packed struct(u32) {
                ///  Source of HFCLK
                SRC: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  64 MHz internal oscillator (HFINT)
                        RC = 0x0,
                        ///  64 MHz crystal oscillator (HFXO)
                        Xtal = 0x1,
                    },
                },
                reserved16: u15,
                ///  HFCLK state
                STATE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  HFCLK not running
                        NotRunning = 0x0,
                        ///  HFCLK running
                        Running = 0x1,
                    },
                },
                padding: u15,
            }),
            reserved1044: [4]u8,
            ///  Status indicating that LFCLKSTART task has been triggered
            LFCLKRUN: mmio.Mmio(packed struct(u32) {
                ///  LFCLKSTART task triggered or not
                STATUS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Task not triggered
                        NotTriggered = 0x0,
                        ///  Task triggered
                        Triggered = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  LFCLK status
            LFCLKSTAT: mmio.Mmio(packed struct(u32) {
                ///  Source of LFCLK
                SRC: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  32.768 kHz RC oscillator
                        RC = 0x0,
                        ///  32.768 kHz crystal oscillator
                        Xtal = 0x1,
                        ///  32.768 kHz synthesized from HFCLK
                        Synth = 0x2,
                        _,
                    },
                },
                reserved16: u14,
                ///  LFCLK state
                STATE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  LFCLK not running
                        NotRunning = 0x0,
                        ///  LFCLK running
                        Running = 0x1,
                    },
                },
                padding: u15,
            }),
            ///  Copy of LFCLKSRC register, set when LFCLKSTART task was triggered
            LFCLKSRCCOPY: mmio.Mmio(packed struct(u32) {
                ///  Clock source
                SRC: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  32.768 kHz RC oscillator
                        RC = 0x0,
                        ///  32.768 kHz crystal oscillator
                        Xtal = 0x1,
                        ///  32.768 kHz synthesized from HFCLK
                        Synth = 0x2,
                        _,
                    },
                },
                padding: u30,
            }),
            reserved1304: [248]u8,
            ///  Clock source for the LFCLK
            LFCLKSRC: mmio.Mmio(packed struct(u32) {
                ///  Clock source
                SRC: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  32.768 kHz RC oscillator
                        RC = 0x0,
                        ///  32.768 kHz crystal oscillator
                        Xtal = 0x1,
                        ///  32.768 kHz synthesized from HFCLK
                        Synth = 0x2,
                        _,
                    },
                },
                reserved16: u14,
                ///  Enable or disable bypass of LFCLK crystal oscillator with external clock source
                BYPASS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable (use with Xtal or low-swing external source)
                        Disabled = 0x0,
                        ///  Enable (use with rail-to-rail external source)
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable external source for LFCLK
                EXTERNAL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable external source (use with Xtal)
                        Disabled = 0x0,
                        ///  Enable use of external source instead of Xtal (SRC needs to be set to Xtal)
                        Enabled = 0x1,
                    },
                },
                padding: u14,
            }),
            reserved1336: [28]u8,
            ///  Calibration timer interval
            CTIV: mmio.Mmio(packed struct(u32) {
                ///  Calibration timer interval in multiple of 0.25 seconds. Range: 0.25 seconds to 31.75 seconds.
                CTIV: u7,
                padding: u25,
            }),
            reserved1372: [32]u8,
            ///  Clocking options for the Trace Port debug interface
            TRACECONFIG: mmio.Mmio(packed struct(u32) {
                ///  Speed of Trace Port clock. Note that the TRACECLK pin will output this clock divided by two.
                TRACEPORTSPEED: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  32 MHz Trace Port clock (TRACECLK = 16 MHz)
                        @"32MHz" = 0x0,
                        ///  16 MHz Trace Port clock (TRACECLK = 8 MHz)
                        @"16MHz" = 0x1,
                        ///  8 MHz Trace Port clock (TRACECLK = 4 MHz)
                        @"8MHz" = 0x2,
                        ///  4 MHz Trace Port clock (TRACECLK = 2 MHz)
                        @"4MHz" = 0x3,
                    },
                },
                reserved16: u14,
                ///  Pin multiplexing of trace signals.
                TRACEMUX: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  GPIOs multiplexed onto all trace-pins
                        GPIO = 0x0,
                        ///  SWO multiplexed onto P0.18, GPIO multiplexed onto other trace pins
                        Serial = 0x1,
                        ///  TRACECLK and TRACEDATA multiplexed onto P0.20, P0.18, P0.16, P0.15 and P0.14.
                        Parallel = 0x2,
                        _,
                    },
                },
                padding: u14,
            }),
        };

        ///  2.4 GHz Radio
        pub const RADIO = extern struct {
            ///  Enable RADIO in TX mode
            TASKS_TXEN: u32,
            ///  Enable RADIO in RX mode
            TASKS_RXEN: u32,
            ///  Start RADIO
            TASKS_START: u32,
            ///  Stop RADIO
            TASKS_STOP: u32,
            ///  Disable RADIO
            TASKS_DISABLE: u32,
            ///  Start the RSSI and take one single sample of the receive signal strength.
            TASKS_RSSISTART: u32,
            ///  Stop the RSSI measurement
            TASKS_RSSISTOP: u32,
            ///  Start the bit counter
            TASKS_BCSTART: u32,
            ///  Stop the bit counter
            TASKS_BCSTOP: u32,
            reserved256: [220]u8,
            ///  RADIO has ramped up and is ready to be started
            EVENTS_READY: u32,
            ///  Address sent or received
            EVENTS_ADDRESS: u32,
            ///  Packet payload sent or received
            EVENTS_PAYLOAD: u32,
            ///  Packet sent or received
            EVENTS_END: u32,
            ///  RADIO has been disabled
            EVENTS_DISABLED: u32,
            ///  A device address match occurred on the last received packet
            EVENTS_DEVMATCH: u32,
            ///  No device address match occurred on the last received packet
            EVENTS_DEVMISS: u32,
            ///  Sampling of receive signal strength complete.
            EVENTS_RSSIEND: u32,
            reserved296: [8]u8,
            ///  Bit counter reached bit count value.
            EVENTS_BCMATCH: u32,
            reserved304: [4]u8,
            ///  Packet received with CRC ok
            EVENTS_CRCOK: u32,
            ///  Packet received with CRC error
            EVENTS_CRCERROR: u32,
            reserved512: [200]u8,
            ///  Shortcut register
            SHORTS: mmio.Mmio(packed struct(u32) {
                ///  Shortcut between READY event and START task
                READY_START: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between END event and DISABLE task
                END_DISABLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between DISABLED event and TXEN task
                DISABLED_TXEN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between DISABLED event and RXEN task
                DISABLED_RXEN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between ADDRESS event and RSSISTART task
                ADDRESS_RSSISTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between END event and START task
                END_START: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between ADDRESS event and BCSTART task
                ADDRESS_BCSTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                reserved8: u1,
                ///  Shortcut between DISABLED event and RSSISTOP task
                DISABLED_RSSISTOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                padding: u23,
            }),
            reserved772: [256]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Enable interrupt for READY event
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for ADDRESS event
                ADDRESS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for PAYLOAD event
                PAYLOAD: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for END event
                END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for DISABLED event
                DISABLED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for DEVMATCH event
                DEVMATCH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for DEVMISS event
                DEVMISS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for RSSIEND event
                RSSIEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved10: u2,
                ///  Write '1' to Enable interrupt for BCMATCH event
                BCMATCH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved12: u1,
                ///  Write '1' to Enable interrupt for CRCOK event
                CRCOK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for CRCERROR event
                CRCERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u18,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Disable interrupt for READY event
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for ADDRESS event
                ADDRESS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for PAYLOAD event
                PAYLOAD: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for END event
                END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for DISABLED event
                DISABLED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for DEVMATCH event
                DEVMATCH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for DEVMISS event
                DEVMISS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for RSSIEND event
                RSSIEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved10: u2,
                ///  Write '1' to Disable interrupt for BCMATCH event
                BCMATCH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved12: u1,
                ///  Write '1' to Disable interrupt for CRCOK event
                CRCOK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for CRCERROR event
                CRCERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u18,
            }),
            reserved1024: [244]u8,
            ///  CRC status
            CRCSTATUS: mmio.Mmio(packed struct(u32) {
                ///  CRC status of packet received
                CRCSTATUS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Packet received with CRC error
                        CRCError = 0x0,
                        ///  Packet received with CRC ok
                        CRCOk = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved1032: [4]u8,
            ///  Received address
            RXMATCH: mmio.Mmio(packed struct(u32) {
                ///  Received address
                RXMATCH: u3,
                padding: u29,
            }),
            ///  CRC field of previously received packet
            RXCRC: mmio.Mmio(packed struct(u32) {
                ///  CRC field of previously received packet
                RXCRC: u24,
                padding: u8,
            }),
            ///  Device address match index
            DAI: mmio.Mmio(packed struct(u32) {
                ///  Device address match index
                DAI: u3,
                padding: u29,
            }),
            reserved1284: [240]u8,
            ///  Packet pointer
            PACKETPTR: mmio.Mmio(packed struct(u32) {
                ///  Packet pointer
                PACKETPTR: u32,
            }),
            ///  Frequency
            FREQUENCY: mmio.Mmio(packed struct(u32) {
                ///  Radio channel frequency
                FREQUENCY: u7,
                reserved8: u1,
                ///  Channel map selection.
                MAP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Channel map between 2400 MHZ .. 2500 MHz
                        Default = 0x0,
                        ///  Channel map between 2360 MHZ .. 2460 MHz
                        Low = 0x1,
                    },
                },
                padding: u23,
            }),
            ///  Output power
            TXPOWER: mmio.Mmio(packed struct(u32) {
                ///  RADIO output power.
                TXPOWER: packed union {
                    raw: u8,
                    value: enum(u8) {
                        ///  +4 dBm
                        Pos4dBm = 0x4,
                        ///  +3 dBm
                        Pos3dBm = 0x3,
                        ///  0 dBm
                        @"0dBm" = 0x0,
                        ///  -4 dBm
                        Neg4dBm = 0xfc,
                        ///  -8 dBm
                        Neg8dBm = 0xf8,
                        ///  -12 dBm
                        Neg12dBm = 0xf4,
                        ///  -16 dBm
                        Neg16dBm = 0xf0,
                        ///  -20 dBm
                        Neg20dBm = 0xec,
                        ///  Deprecated enumerator - -40 dBm
                        Neg30dBm = 0xff,
                        ///  -40 dBm
                        Neg40dBm = 0xd8,
                        _,
                    },
                },
                padding: u24,
            }),
            ///  Data rate and modulation
            MODE: mmio.Mmio(packed struct(u32) {
                ///  Radio data rate and modulation setting. The radio supports Frequency-shift Keying (FSK) modulation.
                MODE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        ///  1 Mbit/s Nordic proprietary radio mode
                        Nrf_1Mbit = 0x0,
                        ///  2 Mbit/s Nordic proprietary radio mode
                        Nrf_2Mbit = 0x1,
                        ///  Deprecated enumerator - 250 kbit/s Nordic proprietary radio mode
                        Nrf_250Kbit = 0x2,
                        ///  1 Mbit/s Bluetooth Low Energy
                        Ble_1Mbit = 0x3,
                        ///  2 Mbit/s Bluetooth Low Energy
                        Ble_2Mbit = 0x4,
                        _,
                    },
                },
                padding: u28,
            }),
            ///  Packet configuration register 0
            PCNF0: mmio.Mmio(packed struct(u32) {
                ///  Length on air of LENGTH field in number of bits.
                LFLEN: u4,
                reserved8: u4,
                ///  Length on air of S0 field in number of bytes.
                S0LEN: u1,
                reserved16: u7,
                ///  Length on air of S1 field in number of bits.
                S1LEN: u4,
                ///  Include or exclude S1 field in RAM
                S1INCL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Include S1 field in RAM only if S1LEN &gt; 0
                        Automatic = 0x0,
                        ///  Always include S1 field in RAM independent of S1LEN
                        Include = 0x1,
                    },
                },
                reserved24: u3,
                ///  Length of preamble on air. Decision point: TASKS_START task
                PLEN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  8-bit preamble
                        @"8bit" = 0x0,
                        ///  16-bit preamble
                        @"16bit" = 0x1,
                    },
                },
                padding: u7,
            }),
            ///  Packet configuration register 1
            PCNF1: mmio.Mmio(packed struct(u32) {
                ///  Maximum length of packet payload. If the packet payload is larger than MAXLEN, the radio will truncate the payload to MAXLEN.
                MAXLEN: u8,
                ///  Static length in number of bytes
                STATLEN: u8,
                ///  Base address length in number of bytes
                BALEN: u3,
                reserved24: u5,
                ///  On air endianness of packet, this applies to the S0, LENGTH, S1 and the PAYLOAD fields.
                ENDIAN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Least Significant bit on air first
                        Little = 0x0,
                        ///  Most significant bit on air first
                        Big = 0x1,
                    },
                },
                ///  Enable or disable packet whitening
                WHITEEN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                padding: u6,
            }),
            ///  Base address 0
            BASE0: mmio.Mmio(packed struct(u32) {
                ///  Base address 0
                BASE0: u32,
            }),
            ///  Base address 1
            BASE1: mmio.Mmio(packed struct(u32) {
                ///  Base address 1
                BASE1: u32,
            }),
            ///  Prefixes bytes for logical addresses 0-3
            PREFIX0: mmio.Mmio(packed struct(u32) {
                ///  Address prefix 0.
                AP0: u8,
                ///  Address prefix 1.
                AP1: u8,
                ///  Address prefix 2.
                AP2: u8,
                ///  Address prefix 3.
                AP3: u8,
            }),
            ///  Prefixes bytes for logical addresses 4-7
            PREFIX1: mmio.Mmio(packed struct(u32) {
                ///  Address prefix 4.
                AP4: u8,
                ///  Address prefix 5.
                AP5: u8,
                ///  Address prefix 6.
                AP6: u8,
                ///  Address prefix 7.
                AP7: u8,
            }),
            ///  Transmit address select
            TXADDRESS: mmio.Mmio(packed struct(u32) {
                ///  Transmit address select
                TXADDRESS: u3,
                padding: u29,
            }),
            ///  Receive address select
            RXADDRESSES: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable reception on logical address 0.
                ADDR0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable reception on logical address 1.
                ADDR1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable reception on logical address 2.
                ADDR2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable reception on logical address 3.
                ADDR3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable reception on logical address 4.
                ADDR4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable reception on logical address 5.
                ADDR5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable reception on logical address 6.
                ADDR6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable reception on logical address 7.
                ADDR7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                padding: u24,
            }),
            ///  CRC configuration
            CRCCNF: mmio.Mmio(packed struct(u32) {
                ///  CRC length in number of bytes.
                LEN: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  CRC length is zero and CRC calculation is disabled
                        Disabled = 0x0,
                        ///  CRC length is one byte and CRC calculation is enabled
                        One = 0x1,
                        ///  CRC length is two bytes and CRC calculation is enabled
                        Two = 0x2,
                        ///  CRC length is three bytes and CRC calculation is enabled
                        Three = 0x3,
                    },
                },
                reserved8: u6,
                ///  Include or exclude packet address field out of CRC calculation.
                SKIPADDR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  CRC calculation includes address field
                        Include = 0x0,
                        ///  CRC calculation does not include address field. The CRC calculation will start at the first byte after the address.
                        Skip = 0x1,
                    },
                },
                padding: u23,
            }),
            ///  CRC polynomial
            CRCPOLY: mmio.Mmio(packed struct(u32) {
                ///  CRC polynomial
                CRCPOLY: u24,
                padding: u8,
            }),
            ///  CRC initial value
            CRCINIT: mmio.Mmio(packed struct(u32) {
                ///  CRC initial value
                CRCINIT: u24,
                padding: u8,
            }),
            ///  Unspecified
            UNUSED0: u32,
            ///  Inter Frame Spacing in us
            TIFS: mmio.Mmio(packed struct(u32) {
                ///  Inter Frame Spacing in us
                TIFS: u8,
                padding: u24,
            }),
            ///  RSSI sample
            RSSISAMPLE: mmio.Mmio(packed struct(u32) {
                ///  RSSI sample
                RSSISAMPLE: u7,
                padding: u25,
            }),
            reserved1360: [4]u8,
            ///  Current radio state
            STATE: mmio.Mmio(packed struct(u32) {
                ///  Current radio state
                STATE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        ///  RADIO is in the Disabled state
                        Disabled = 0x0,
                        ///  RADIO is in the RXRU state
                        RxRu = 0x1,
                        ///  RADIO is in the RXIDLE state
                        RxIdle = 0x2,
                        ///  RADIO is in the RX state
                        Rx = 0x3,
                        ///  RADIO is in the RXDISABLED state
                        RxDisable = 0x4,
                        ///  RADIO is in the TXRU state
                        TxRu = 0x9,
                        ///  RADIO is in the TXIDLE state
                        TxIdle = 0xa,
                        ///  RADIO is in the TX state
                        Tx = 0xb,
                        ///  RADIO is in the TXDISABLED state
                        TxDisable = 0xc,
                        _,
                    },
                },
                padding: u28,
            }),
            ///  Data whitening initial value
            DATAWHITEIV: mmio.Mmio(packed struct(u32) {
                ///  Data whitening initial value. Bit 6 is hard-wired to '1', writing '0' to it has no effect, and it will always be read back and used by the device as '1'.
                DATAWHITEIV: u7,
                padding: u25,
            }),
            reserved1376: [8]u8,
            ///  Bit counter compare
            BCC: mmio.Mmio(packed struct(u32) {
                ///  Bit counter compare
                BCC: u32,
            }),
            reserved1536: [156]u8,
            ///  Description collection[0]: Device address base segment 0
            DAB: [8]mmio.Mmio(packed struct(u32) {
                ///  Device address base segment 0
                DAB: u32,
            }),
            ///  Description collection[0]: Device address prefix 0
            DAP: [8]mmio.Mmio(packed struct(u32) {
                ///  Device address prefix 0
                DAP: u16,
                padding: u16,
            }),
            ///  Device address match configuration
            DACNF: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable device address matching using device address 0
                ENA0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disabled
                        Disabled = 0x0,
                        ///  Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable device address matching using device address 1
                ENA1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disabled
                        Disabled = 0x0,
                        ///  Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable device address matching using device address 2
                ENA2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disabled
                        Disabled = 0x0,
                        ///  Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable device address matching using device address 3
                ENA3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disabled
                        Disabled = 0x0,
                        ///  Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable device address matching using device address 4
                ENA4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disabled
                        Disabled = 0x0,
                        ///  Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable device address matching using device address 5
                ENA5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disabled
                        Disabled = 0x0,
                        ///  Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable device address matching using device address 6
                ENA6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disabled
                        Disabled = 0x0,
                        ///  Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable device address matching using device address 7
                ENA7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disabled
                        Disabled = 0x0,
                        ///  Enabled
                        Enabled = 0x1,
                    },
                },
                ///  TxAdd for device address 0
                TXADD0: u1,
                ///  TxAdd for device address 1
                TXADD1: u1,
                ///  TxAdd for device address 2
                TXADD2: u1,
                ///  TxAdd for device address 3
                TXADD3: u1,
                ///  TxAdd for device address 4
                TXADD4: u1,
                ///  TxAdd for device address 5
                TXADD5: u1,
                ///  TxAdd for device address 6
                TXADD6: u1,
                ///  TxAdd for device address 7
                TXADD7: u1,
                padding: u16,
            }),
            reserved1616: [12]u8,
            ///  Radio mode configuration register 0
            MODECNF0: mmio.Mmio(packed struct(u32) {
                ///  Radio ramp-up time
                RU: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Default ramp-up time (tRXEN), compatible with firmware written for nRF51
                        Default = 0x0,
                        ///  Fast ramp-up (tRXEN,FAST), see electrical specification for more information
                        Fast = 0x1,
                    },
                },
                reserved8: u7,
                ///  Default TX value
                DTX: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Transmit '1'
                        B1 = 0x0,
                        ///  Transmit '0'
                        B0 = 0x1,
                        ///  Transmit center frequency
                        Center = 0x2,
                        _,
                    },
                },
                padding: u22,
            }),
            reserved4092: [2472]u8,
            ///  Peripheral power control
            POWER: mmio.Mmio(packed struct(u32) {
                ///  Peripheral power control. The peripheral and its registers will be reset to its initial state by switching the peripheral off and then back on again.
                POWER: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Peripheral is powered off
                        Disabled = 0x0,
                        ///  Peripheral is powered on
                        Enabled = 0x1,
                    },
                },
                padding: u31,
            }),
        };

        ///  UART with EasyDMA
        pub const UARTE0 = extern struct {
            ///  Start UART receiver
            TASKS_STARTRX: u32,
            ///  Stop UART receiver
            TASKS_STOPRX: u32,
            ///  Start UART transmitter
            TASKS_STARTTX: u32,
            ///  Stop UART transmitter
            TASKS_STOPTX: u32,
            reserved44: [28]u8,
            ///  Flush RX FIFO into RX buffer
            TASKS_FLUSHRX: u32,
            reserved256: [208]u8,
            ///  CTS is activated (set low). Clear To Send.
            EVENTS_CTS: u32,
            ///  CTS is deactivated (set high). Not Clear To Send.
            EVENTS_NCTS: u32,
            ///  Data received in RXD (but potentially not yet transferred to Data RAM)
            EVENTS_RXDRDY: u32,
            reserved272: [4]u8,
            ///  Receive buffer is filled up
            EVENTS_ENDRX: u32,
            reserved284: [8]u8,
            ///  Data sent from TXD
            EVENTS_TXDRDY: u32,
            ///  Last TX byte transmitted
            EVENTS_ENDTX: u32,
            ///  Error detected
            EVENTS_ERROR: u32,
            reserved324: [28]u8,
            ///  Receiver timeout
            EVENTS_RXTO: u32,
            reserved332: [4]u8,
            ///  UART receiver has started
            EVENTS_RXSTARTED: u32,
            ///  UART transmitter has started
            EVENTS_TXSTARTED: u32,
            reserved344: [4]u8,
            ///  Transmitter stopped
            EVENTS_TXSTOPPED: u32,
            reserved512: [164]u8,
            ///  Shortcut register
            SHORTS: mmio.Mmio(packed struct(u32) {
                reserved5: u5,
                ///  Shortcut between ENDRX event and STARTRX task
                ENDRX_STARTRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between ENDRX event and STOPRX task
                ENDRX_STOPRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                padding: u25,
            }),
            reserved768: [252]u8,
            ///  Enable or disable interrupt
            INTEN: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable interrupt for CTS event
                CTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for NCTS event
                NCTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for RXDRDY event
                RXDRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                reserved4: u1,
                ///  Enable or disable interrupt for ENDRX event
                ENDRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                reserved7: u2,
                ///  Enable or disable interrupt for TXDRDY event
                TXDRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for ENDTX event
                ENDTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for ERROR event
                ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                reserved17: u7,
                ///  Enable or disable interrupt for RXTO event
                RXTO: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                reserved19: u1,
                ///  Enable or disable interrupt for RXSTARTED event
                RXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for TXSTARTED event
                TXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                reserved22: u1,
                ///  Enable or disable interrupt for TXSTOPPED event
                TXSTOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                padding: u9,
            }),
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Enable interrupt for CTS event
                CTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for NCTS event
                NCTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for RXDRDY event
                RXDRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved4: u1,
                ///  Write '1' to Enable interrupt for ENDRX event
                ENDRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved7: u2,
                ///  Write '1' to Enable interrupt for TXDRDY event
                TXDRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for ENDTX event
                ENDTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for ERROR event
                ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved17: u7,
                ///  Write '1' to Enable interrupt for RXTO event
                RXTO: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved19: u1,
                ///  Write '1' to Enable interrupt for RXSTARTED event
                RXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for TXSTARTED event
                TXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved22: u1,
                ///  Write '1' to Enable interrupt for TXSTOPPED event
                TXSTOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u9,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Disable interrupt for CTS event
                CTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for NCTS event
                NCTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for RXDRDY event
                RXDRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved4: u1,
                ///  Write '1' to Disable interrupt for ENDRX event
                ENDRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved7: u2,
                ///  Write '1' to Disable interrupt for TXDRDY event
                TXDRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for ENDTX event
                ENDTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for ERROR event
                ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved17: u7,
                ///  Write '1' to Disable interrupt for RXTO event
                RXTO: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved19: u1,
                ///  Write '1' to Disable interrupt for RXSTARTED event
                RXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for TXSTARTED event
                TXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved22: u1,
                ///  Write '1' to Disable interrupt for TXSTOPPED event
                TXSTOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u9,
            }),
            reserved1152: [372]u8,
            ///  Error source
            ERRORSRC: mmio.Mmio(packed struct(u32) {
                ///  Overrun error
                OVERRUN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: error not present
                        NotPresent = 0x0,
                        ///  Read: error present
                        Present = 0x1,
                    },
                },
                ///  Parity error
                PARITY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: error not present
                        NotPresent = 0x0,
                        ///  Read: error present
                        Present = 0x1,
                    },
                },
                ///  Framing error occurred
                FRAMING: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: error not present
                        NotPresent = 0x0,
                        ///  Read: error present
                        Present = 0x1,
                    },
                },
                ///  Break condition
                BREAK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: error not present
                        NotPresent = 0x0,
                        ///  Read: error present
                        Present = 0x1,
                    },
                },
                padding: u28,
            }),
            reserved1280: [124]u8,
            ///  Enable UART
            ENABLE: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable UARTE
                ENABLE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        ///  Disable UARTE
                        Disabled = 0x0,
                        ///  Enable UARTE
                        Enabled = 0x8,
                        _,
                    },
                },
                padding: u28,
            }),
            reserved1316: [32]u8,
            ///  Baud rate. Accuracy depends on the HFCLK source selected.
            BAUDRATE: mmio.Mmio(packed struct(u32) {
                ///  Baud rate
                BAUDRATE: packed union {
                    raw: u32,
                    value: enum(u32) {
                        ///  1200 baud (actual rate: 1205)
                        Baud1200 = 0x4f000,
                        ///  2400 baud (actual rate: 2396)
                        Baud2400 = 0x9d000,
                        ///  4800 baud (actual rate: 4808)
                        Baud4800 = 0x13b000,
                        ///  9600 baud (actual rate: 9598)
                        Baud9600 = 0x275000,
                        ///  14400 baud (actual rate: 14401)
                        Baud14400 = 0x3af000,
                        ///  19200 baud (actual rate: 19208)
                        Baud19200 = 0x4ea000,
                        ///  28800 baud (actual rate: 28777)
                        Baud28800 = 0x75c000,
                        ///  31250 baud
                        Baud31250 = 0x800000,
                        ///  38400 baud (actual rate: 38369)
                        Baud38400 = 0x9d0000,
                        ///  56000 baud (actual rate: 55944)
                        Baud56000 = 0xe50000,
                        ///  57600 baud (actual rate: 57554)
                        Baud57600 = 0xeb0000,
                        ///  76800 baud (actual rate: 76923)
                        Baud76800 = 0x13a9000,
                        ///  115200 baud (actual rate: 115108)
                        Baud115200 = 0x1d60000,
                        ///  230400 baud (actual rate: 231884)
                        Baud230400 = 0x3b00000,
                        ///  250000 baud
                        Baud250000 = 0x4000000,
                        ///  460800 baud (actual rate: 457143)
                        Baud460800 = 0x7400000,
                        ///  921600 baud (actual rate: 941176)
                        Baud921600 = 0xf000000,
                        ///  1Mega baud
                        Baud1M = 0x10000000,
                        _,
                    },
                },
            }),
            reserved1388: [68]u8,
            ///  Configuration of parity and hardware flow control
            CONFIG: mmio.Mmio(packed struct(u32) {
                ///  Hardware flow control
                HWFC: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disabled
                        Disabled = 0x0,
                        ///  Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Parity
                PARITY: packed union {
                    raw: u3,
                    value: enum(u3) {
                        ///  Exclude parity bit
                        Excluded = 0x0,
                        ///  Include parity bit
                        Included = 0x7,
                        _,
                    },
                },
                padding: u28,
            }),
        };

        ///  Universal Asynchronous Receiver/Transmitter
        pub const UART0 = extern struct {
            ///  Start UART receiver
            TASKS_STARTRX: u32,
            ///  Stop UART receiver
            TASKS_STOPRX: u32,
            ///  Start UART transmitter
            TASKS_STARTTX: u32,
            ///  Stop UART transmitter
            TASKS_STOPTX: u32,
            reserved28: [12]u8,
            ///  Suspend UART
            TASKS_SUSPEND: u32,
            reserved256: [224]u8,
            ///  CTS is activated (set low). Clear To Send.
            EVENTS_CTS: u32,
            ///  CTS is deactivated (set high). Not Clear To Send.
            EVENTS_NCTS: u32,
            ///  Data received in RXD
            EVENTS_RXDRDY: u32,
            reserved284: [16]u8,
            ///  Data sent from TXD
            EVENTS_TXDRDY: u32,
            reserved292: [4]u8,
            ///  Error detected
            EVENTS_ERROR: u32,
            reserved324: [28]u8,
            ///  Receiver timeout
            EVENTS_RXTO: u32,
            reserved512: [184]u8,
            ///  Shortcut register
            SHORTS: mmio.Mmio(packed struct(u32) {
                reserved3: u3,
                ///  Shortcut between CTS event and STARTRX task
                CTS_STARTRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between NCTS event and STOPRX task
                NCTS_STOPRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                padding: u27,
            }),
            reserved772: [256]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Enable interrupt for CTS event
                CTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for NCTS event
                NCTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for RXDRDY event
                RXDRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved7: u4,
                ///  Write '1' to Enable interrupt for TXDRDY event
                TXDRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved9: u1,
                ///  Write '1' to Enable interrupt for ERROR event
                ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved17: u7,
                ///  Write '1' to Enable interrupt for RXTO event
                RXTO: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u14,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Disable interrupt for CTS event
                CTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for NCTS event
                NCTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for RXDRDY event
                RXDRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved7: u4,
                ///  Write '1' to Disable interrupt for TXDRDY event
                TXDRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved9: u1,
                ///  Write '1' to Disable interrupt for ERROR event
                ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved17: u7,
                ///  Write '1' to Disable interrupt for RXTO event
                RXTO: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u14,
            }),
            reserved1152: [372]u8,
            ///  Error source
            ERRORSRC: mmio.Mmio(packed struct(u32) {
                ///  Overrun error
                OVERRUN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: error not present
                        NotPresent = 0x0,
                        ///  Read: error present
                        Present = 0x1,
                    },
                },
                ///  Parity error
                PARITY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: error not present
                        NotPresent = 0x0,
                        ///  Read: error present
                        Present = 0x1,
                    },
                },
                ///  Framing error occurred
                FRAMING: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: error not present
                        NotPresent = 0x0,
                        ///  Read: error present
                        Present = 0x1,
                    },
                },
                ///  Break condition
                BREAK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: error not present
                        NotPresent = 0x0,
                        ///  Read: error present
                        Present = 0x1,
                    },
                },
                padding: u28,
            }),
            reserved1280: [124]u8,
            ///  Enable UART
            ENABLE: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable UART
                ENABLE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        ///  Disable UART
                        Disabled = 0x0,
                        ///  Enable UART
                        Enabled = 0x4,
                        _,
                    },
                },
                padding: u28,
            }),
            reserved1288: [4]u8,
            ///  Pin select for RTS
            PSELRTS: mmio.Mmio(packed struct(u32) {
                ///  Pin number configuration for UART RTS signal
                PSELRTS: packed union {
                    raw: u32,
                    value: enum(u32) {
                        ///  Disconnect
                        Disconnected = 0xffffffff,
                        _,
                    },
                },
            }),
            ///  Pin select for TXD
            PSELTXD: mmio.Mmio(packed struct(u32) {
                ///  Pin number configuration for UART TXD signal
                PSELTXD: packed union {
                    raw: u32,
                    value: enum(u32) {
                        ///  Disconnect
                        Disconnected = 0xffffffff,
                        _,
                    },
                },
            }),
            ///  Pin select for CTS
            PSELCTS: mmio.Mmio(packed struct(u32) {
                ///  Pin number configuration for UART CTS signal
                PSELCTS: packed union {
                    raw: u32,
                    value: enum(u32) {
                        ///  Disconnect
                        Disconnected = 0xffffffff,
                        _,
                    },
                },
            }),
            ///  Pin select for RXD
            PSELRXD: mmio.Mmio(packed struct(u32) {
                ///  Pin number configuration for UART RXD signal
                PSELRXD: packed union {
                    raw: u32,
                    value: enum(u32) {
                        ///  Disconnect
                        Disconnected = 0xffffffff,
                        _,
                    },
                },
            }),
            ///  RXD register
            RXD: mmio.Mmio(packed struct(u32) {
                ///  RX data received in previous transfers, double buffered
                RXD: u8,
                padding: u24,
            }),
            ///  TXD register
            TXD: mmio.Mmio(packed struct(u32) {
                ///  TX data to be transferred
                TXD: u8,
                padding: u24,
            }),
            reserved1316: [4]u8,
            ///  Baud rate
            BAUDRATE: mmio.Mmio(packed struct(u32) {
                ///  Baud rate
                BAUDRATE: packed union {
                    raw: u32,
                    value: enum(u32) {
                        ///  1200 baud (actual rate: 1205)
                        Baud1200 = 0x4f000,
                        ///  2400 baud (actual rate: 2396)
                        Baud2400 = 0x9d000,
                        ///  4800 baud (actual rate: 4808)
                        Baud4800 = 0x13b000,
                        ///  9600 baud (actual rate: 9598)
                        Baud9600 = 0x275000,
                        ///  14400 baud (actual rate: 14414)
                        Baud14400 = 0x3b0000,
                        ///  19200 baud (actual rate: 19208)
                        Baud19200 = 0x4ea000,
                        ///  28800 baud (actual rate: 28829)
                        Baud28800 = 0x75f000,
                        ///  31250 baud
                        Baud31250 = 0x800000,
                        ///  38400 baud (actual rate: 38462)
                        Baud38400 = 0x9d5000,
                        ///  56000 baud (actual rate: 55944)
                        Baud56000 = 0xe50000,
                        ///  57600 baud (actual rate: 57762)
                        Baud57600 = 0xebf000,
                        ///  76800 baud (actual rate: 76923)
                        Baud76800 = 0x13a9000,
                        ///  115200 baud (actual rate: 115942)
                        Baud115200 = 0x1d7e000,
                        ///  230400 baud (actual rate: 231884)
                        Baud230400 = 0x3afb000,
                        ///  250000 baud
                        Baud250000 = 0x4000000,
                        ///  460800 baud (actual rate: 470588)
                        Baud460800 = 0x75f7000,
                        ///  921600 baud (actual rate: 941176)
                        Baud921600 = 0xebed000,
                        ///  1Mega baud
                        Baud1M = 0x10000000,
                        _,
                    },
                },
            }),
            reserved1388: [68]u8,
            ///  Configuration of parity and hardware flow control
            CONFIG: mmio.Mmio(packed struct(u32) {
                ///  Hardware flow control
                HWFC: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disabled
                        Disabled = 0x0,
                        ///  Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Parity
                PARITY: packed union {
                    raw: u3,
                    value: enum(u3) {
                        ///  Exclude parity bit
                        Excluded = 0x0,
                        ///  Include parity bit
                        Included = 0x7,
                        _,
                    },
                },
                padding: u28,
            }),
        };

        ///  Serial Peripheral Interface Master with EasyDMA 0
        pub const SPIM0 = extern struct {
            reserved16: [16]u8,
            ///  Start SPI transaction
            TASKS_START: u32,
            ///  Stop SPI transaction
            TASKS_STOP: u32,
            reserved28: [4]u8,
            ///  Suspend SPI transaction
            TASKS_SUSPEND: u32,
            ///  Resume SPI transaction
            TASKS_RESUME: u32,
            reserved260: [224]u8,
            ///  SPI transaction has stopped
            EVENTS_STOPPED: u32,
            reserved272: [8]u8,
            ///  End of RXD buffer reached
            EVENTS_ENDRX: u32,
            reserved280: [4]u8,
            ///  End of RXD buffer and TXD buffer reached
            EVENTS_END: u32,
            reserved288: [4]u8,
            ///  End of TXD buffer reached
            EVENTS_ENDTX: u32,
            reserved332: [40]u8,
            ///  Transaction started
            EVENTS_STARTED: u32,
            reserved512: [176]u8,
            ///  Shortcut register
            SHORTS: mmio.Mmio(packed struct(u32) {
                reserved17: u17,
                ///  Shortcut between END event and START task
                END_START: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                padding: u14,
            }),
            reserved772: [256]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Write '1' to Enable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved4: u2,
                ///  Write '1' to Enable interrupt for ENDRX event
                ENDRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved6: u1,
                ///  Write '1' to Enable interrupt for END event
                END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved8: u1,
                ///  Write '1' to Enable interrupt for ENDTX event
                ENDTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved19: u10,
                ///  Write '1' to Enable interrupt for STARTED event
                STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u12,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Write '1' to Disable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved4: u2,
                ///  Write '1' to Disable interrupt for ENDRX event
                ENDRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved6: u1,
                ///  Write '1' to Disable interrupt for END event
                END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved8: u1,
                ///  Write '1' to Disable interrupt for ENDTX event
                ENDTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved19: u10,
                ///  Write '1' to Disable interrupt for STARTED event
                STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u12,
            }),
            reserved1280: [500]u8,
            ///  Enable SPIM
            ENABLE: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable SPIM
                ENABLE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        ///  Disable SPIM
                        Disabled = 0x0,
                        ///  Enable SPIM
                        Enabled = 0x7,
                        _,
                    },
                },
                padding: u28,
            }),
            reserved1316: [32]u8,
            ///  SPI frequency. Accuracy depends on the HFCLK source selected.
            FREQUENCY: mmio.Mmio(packed struct(u32) {
                ///  SPI master data rate
                FREQUENCY: packed union {
                    raw: u32,
                    value: enum(u32) {
                        ///  125 kbps
                        K125 = 0x2000000,
                        ///  250 kbps
                        K250 = 0x4000000,
                        ///  500 kbps
                        K500 = 0x8000000,
                        ///  1 Mbps
                        M1 = 0x10000000,
                        ///  2 Mbps
                        M2 = 0x20000000,
                        ///  4 Mbps
                        M4 = 0x40000000,
                        ///  8 Mbps
                        M8 = 0x80000000,
                        _,
                    },
                },
            }),
            reserved1364: [44]u8,
            ///  Configuration register
            CONFIG: mmio.Mmio(packed struct(u32) {
                ///  Bit order
                ORDER: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Most significant bit shifted out first
                        MsbFirst = 0x0,
                        ///  Least significant bit shifted out first
                        LsbFirst = 0x1,
                    },
                },
                ///  Serial clock (SCK) phase
                CPHA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Sample on leading edge of clock, shift serial data on trailing edge
                        Leading = 0x0,
                        ///  Sample on trailing edge of clock, shift serial data on leading edge
                        Trailing = 0x1,
                    },
                },
                ///  Serial clock (SCK) polarity
                CPOL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Active high
                        ActiveHigh = 0x0,
                        ///  Active low
                        ActiveLow = 0x1,
                    },
                },
                padding: u29,
            }),
            reserved1472: [104]u8,
            ///  Over-read character. Character clocked out in case and over-read of the TXD buffer.
            ORC: mmio.Mmio(packed struct(u32) {
                ///  Over-read character. Character clocked out in case and over-read of the TXD buffer.
                ORC: u8,
                padding: u24,
            }),
        };

        ///  SPI Slave 0
        pub const SPIS0 = extern struct {
            reserved36: [36]u8,
            ///  Acquire SPI semaphore
            TASKS_ACQUIRE: u32,
            ///  Release SPI semaphore, enabling the SPI slave to acquire it
            TASKS_RELEASE: u32,
            reserved260: [216]u8,
            ///  Granted transaction completed
            EVENTS_END: u32,
            reserved272: [8]u8,
            ///  End of RXD buffer reached
            EVENTS_ENDRX: u32,
            reserved296: [20]u8,
            ///  Semaphore acquired
            EVENTS_ACQUIRED: u32,
            reserved512: [212]u8,
            ///  Shortcut register
            SHORTS: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  Shortcut between END event and ACQUIRE task
                END_ACQUIRE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                padding: u29,
            }),
            reserved772: [256]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Write '1' to Enable interrupt for END event
                END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved4: u2,
                ///  Write '1' to Enable interrupt for ENDRX event
                ENDRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved10: u5,
                ///  Write '1' to Enable interrupt for ACQUIRED event
                ACQUIRED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u21,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Write '1' to Disable interrupt for END event
                END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved4: u2,
                ///  Write '1' to Disable interrupt for ENDRX event
                ENDRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved10: u5,
                ///  Write '1' to Disable interrupt for ACQUIRED event
                ACQUIRED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u21,
            }),
            reserved1024: [244]u8,
            ///  Semaphore status register
            SEMSTAT: mmio.Mmio(packed struct(u32) {
                ///  Semaphore status
                SEMSTAT: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Semaphore is free
                        Free = 0x0,
                        ///  Semaphore is assigned to CPU
                        CPU = 0x1,
                        ///  Semaphore is assigned to SPI slave
                        SPIS = 0x2,
                        ///  Semaphore is assigned to SPI but a handover to the CPU is pending
                        CPUPending = 0x3,
                    },
                },
                padding: u30,
            }),
            reserved1088: [60]u8,
            ///  Status from last transaction
            STATUS: mmio.Mmio(packed struct(u32) {
                ///  TX buffer over-read detected, and prevented
                OVERREAD: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: error not present
                        NotPresent = 0x0,
                        ///  Read: error present
                        Present = 0x1,
                    },
                },
                ///  RX buffer overflow detected, and prevented
                OVERFLOW: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: error not present
                        NotPresent = 0x0,
                        ///  Read: error present
                        Present = 0x1,
                    },
                },
                padding: u30,
            }),
            reserved1280: [188]u8,
            ///  Enable SPI slave
            ENABLE: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable SPI slave
                ENABLE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        ///  Disable SPI slave
                        Disabled = 0x0,
                        ///  Enable SPI slave
                        Enabled = 0x2,
                        _,
                    },
                },
                padding: u28,
            }),
            reserved1364: [80]u8,
            ///  Configuration register
            CONFIG: mmio.Mmio(packed struct(u32) {
                ///  Bit order
                ORDER: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Most significant bit shifted out first
                        MsbFirst = 0x0,
                        ///  Least significant bit shifted out first
                        LsbFirst = 0x1,
                    },
                },
                ///  Serial clock (SCK) phase
                CPHA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Sample on leading edge of clock, shift serial data on trailing edge
                        Leading = 0x0,
                        ///  Sample on trailing edge of clock, shift serial data on leading edge
                        Trailing = 0x1,
                    },
                },
                ///  Serial clock (SCK) polarity
                CPOL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Active high
                        ActiveHigh = 0x0,
                        ///  Active low
                        ActiveLow = 0x1,
                    },
                },
                padding: u29,
            }),
            reserved1372: [4]u8,
            ///  Default character. Character clocked out in case of an ignored transaction.
            DEF: mmio.Mmio(packed struct(u32) {
                ///  Default character. Character clocked out in case of an ignored transaction.
                DEF: u8,
                padding: u24,
            }),
            reserved1472: [96]u8,
            ///  Over-read character
            ORC: mmio.Mmio(packed struct(u32) {
                ///  Over-read character. Character clocked out after an over-read of the transmit buffer.
                ORC: u8,
                padding: u24,
            }),
        };

        ///  I2C compatible Two-Wire Master Interface with EasyDMA 0
        pub const TWIM0 = extern struct {
            ///  Start TWI receive sequence
            TASKS_STARTRX: u32,
            reserved8: [4]u8,
            ///  Start TWI transmit sequence
            TASKS_STARTTX: u32,
            reserved20: [8]u8,
            ///  Stop TWI transaction. Must be issued while the TWI master is not suspended.
            TASKS_STOP: u32,
            reserved28: [4]u8,
            ///  Suspend TWI transaction
            TASKS_SUSPEND: u32,
            ///  Resume TWI transaction
            TASKS_RESUME: u32,
            reserved260: [224]u8,
            ///  TWI stopped
            EVENTS_STOPPED: u32,
            reserved292: [28]u8,
            ///  TWI error
            EVENTS_ERROR: u32,
            reserved328: [32]u8,
            ///  Last byte has been sent out after the SUSPEND task has been issued, TWI traffic is now suspended.
            EVENTS_SUSPENDED: u32,
            ///  Receive sequence started
            EVENTS_RXSTARTED: u32,
            ///  Transmit sequence started
            EVENTS_TXSTARTED: u32,
            reserved348: [8]u8,
            ///  Byte boundary, starting to receive the last byte
            EVENTS_LASTRX: u32,
            ///  Byte boundary, starting to transmit the last byte
            EVENTS_LASTTX: u32,
            reserved512: [156]u8,
            ///  Shortcut register
            SHORTS: mmio.Mmio(packed struct(u32) {
                reserved7: u7,
                ///  Shortcut between LASTTX event and STARTRX task
                LASTTX_STARTRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between LASTTX event and SUSPEND task
                LASTTX_SUSPEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between LASTTX event and STOP task
                LASTTX_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between LASTRX event and STARTTX task
                LASTRX_STARTTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                reserved12: u1,
                ///  Shortcut between LASTRX event and STOP task
                LASTRX_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                padding: u19,
            }),
            reserved768: [252]u8,
            ///  Enable or disable interrupt
            INTEN: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Enable or disable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                reserved9: u7,
                ///  Enable or disable interrupt for ERROR event
                ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                reserved18: u8,
                ///  Enable or disable interrupt for SUSPENDED event
                SUSPENDED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for RXSTARTED event
                RXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for TXSTARTED event
                TXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                reserved23: u2,
                ///  Enable or disable interrupt for LASTRX event
                LASTRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for LASTTX event
                LASTTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                padding: u7,
            }),
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Write '1' to Enable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved9: u7,
                ///  Write '1' to Enable interrupt for ERROR event
                ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved18: u8,
                ///  Write '1' to Enable interrupt for SUSPENDED event
                SUSPENDED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for RXSTARTED event
                RXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for TXSTARTED event
                TXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved23: u2,
                ///  Write '1' to Enable interrupt for LASTRX event
                LASTRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for LASTTX event
                LASTTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u7,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Write '1' to Disable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved9: u7,
                ///  Write '1' to Disable interrupt for ERROR event
                ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved18: u8,
                ///  Write '1' to Disable interrupt for SUSPENDED event
                SUSPENDED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for RXSTARTED event
                RXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for TXSTARTED event
                TXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved23: u2,
                ///  Write '1' to Disable interrupt for LASTRX event
                LASTRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for LASTTX event
                LASTTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u7,
            }),
            reserved1220: [440]u8,
            ///  Error source
            ERRORSRC: mmio.Mmio(packed struct(u32) {
                ///  Overrun error
                OVERRUN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Error did not occur
                        NotReceived = 0x0,
                        ///  Error occurred
                        Received = 0x1,
                    },
                },
                ///  NACK received after sending the address (write '1' to clear)
                ANACK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Error did not occur
                        NotReceived = 0x0,
                        ///  Error occurred
                        Received = 0x1,
                    },
                },
                ///  NACK received after sending a data byte (write '1' to clear)
                DNACK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Error did not occur
                        NotReceived = 0x0,
                        ///  Error occurred
                        Received = 0x1,
                    },
                },
                padding: u29,
            }),
            reserved1280: [56]u8,
            ///  Enable TWIM
            ENABLE: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable TWIM
                ENABLE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        ///  Disable TWIM
                        Disabled = 0x0,
                        ///  Enable TWIM
                        Enabled = 0x6,
                        _,
                    },
                },
                padding: u28,
            }),
            reserved1316: [32]u8,
            ///  TWI frequency
            FREQUENCY: mmio.Mmio(packed struct(u32) {
                ///  TWI master clock frequency
                FREQUENCY: packed union {
                    raw: u32,
                    value: enum(u32) {
                        ///  100 kbps
                        K100 = 0x1980000,
                        ///  250 kbps
                        K250 = 0x4000000,
                        ///  400 kbps
                        K400 = 0x6400000,
                        _,
                    },
                },
            }),
            reserved1416: [96]u8,
            ///  Address used in the TWI transfer
            ADDRESS: mmio.Mmio(packed struct(u32) {
                ///  Address used in the TWI transfer
                ADDRESS: u7,
                padding: u25,
            }),
        };

        ///  I2C compatible Two-Wire Slave Interface with EasyDMA 0
        pub const TWIS0 = extern struct {
            reserved20: [20]u8,
            ///  Stop TWI transaction
            TASKS_STOP: u32,
            reserved28: [4]u8,
            ///  Suspend TWI transaction
            TASKS_SUSPEND: u32,
            ///  Resume TWI transaction
            TASKS_RESUME: u32,
            reserved48: [12]u8,
            ///  Prepare the TWI slave to respond to a write command
            TASKS_PREPARERX: u32,
            ///  Prepare the TWI slave to respond to a read command
            TASKS_PREPARETX: u32,
            reserved260: [204]u8,
            ///  TWI stopped
            EVENTS_STOPPED: u32,
            reserved292: [28]u8,
            ///  TWI error
            EVENTS_ERROR: u32,
            reserved332: [36]u8,
            ///  Receive sequence started
            EVENTS_RXSTARTED: u32,
            ///  Transmit sequence started
            EVENTS_TXSTARTED: u32,
            reserved356: [16]u8,
            ///  Write command received
            EVENTS_WRITE: u32,
            ///  Read command received
            EVENTS_READ: u32,
            reserved512: [148]u8,
            ///  Shortcut register
            SHORTS: mmio.Mmio(packed struct(u32) {
                reserved13: u13,
                ///  Shortcut between WRITE event and SUSPEND task
                WRITE_SUSPEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between READ event and SUSPEND task
                READ_SUSPEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                padding: u17,
            }),
            reserved768: [252]u8,
            ///  Enable or disable interrupt
            INTEN: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Enable or disable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                reserved9: u7,
                ///  Enable or disable interrupt for ERROR event
                ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                reserved19: u9,
                ///  Enable or disable interrupt for RXSTARTED event
                RXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for TXSTARTED event
                TXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                reserved25: u4,
                ///  Enable or disable interrupt for WRITE event
                WRITE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for READ event
                READ: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                padding: u5,
            }),
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Write '1' to Enable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved9: u7,
                ///  Write '1' to Enable interrupt for ERROR event
                ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved19: u9,
                ///  Write '1' to Enable interrupt for RXSTARTED event
                RXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for TXSTARTED event
                TXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved25: u4,
                ///  Write '1' to Enable interrupt for WRITE event
                WRITE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for READ event
                READ: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u5,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Write '1' to Disable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved9: u7,
                ///  Write '1' to Disable interrupt for ERROR event
                ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved19: u9,
                ///  Write '1' to Disable interrupt for RXSTARTED event
                RXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for TXSTARTED event
                TXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved25: u4,
                ///  Write '1' to Disable interrupt for WRITE event
                WRITE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for READ event
                READ: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u5,
            }),
            reserved1232: [452]u8,
            ///  Error source
            ERRORSRC: mmio.Mmio(packed struct(u32) {
                ///  RX buffer overflow detected, and prevented
                OVERFLOW: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Error did not occur
                        NotDetected = 0x0,
                        ///  Error occurred
                        Detected = 0x1,
                    },
                },
                reserved2: u1,
                ///  NACK sent after receiving a data byte
                DNACK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Error did not occur
                        NotReceived = 0x0,
                        ///  Error occurred
                        Received = 0x1,
                    },
                },
                ///  TX buffer over-read detected, and prevented
                OVERREAD: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Error did not occur
                        NotDetected = 0x0,
                        ///  Error occurred
                        Detected = 0x1,
                    },
                },
                padding: u28,
            }),
            ///  Status register indicating which address had a match
            MATCH: mmio.Mmio(packed struct(u32) {
                ///  Which of the addresses in {ADDRESS} matched the incoming address
                MATCH: u1,
                padding: u31,
            }),
            reserved1280: [40]u8,
            ///  Enable TWIS
            ENABLE: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable TWIS
                ENABLE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        ///  Disable TWIS
                        Disabled = 0x0,
                        ///  Enable TWIS
                        Enabled = 0x9,
                        _,
                    },
                },
                padding: u28,
            }),
            reserved1416: [132]u8,
            ///  Description collection[0]: TWI slave address 0
            ADDRESS: [2]mmio.Mmio(packed struct(u32) {
                ///  TWI slave address
                ADDRESS: u7,
                padding: u25,
            }),
            reserved1428: [4]u8,
            ///  Configuration register for the address match mechanism
            CONFIG: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable address matching on ADDRESS[0]
                ADDRESS0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disabled
                        Disabled = 0x0,
                        ///  Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable address matching on ADDRESS[1]
                ADDRESS1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disabled
                        Disabled = 0x0,
                        ///  Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u30,
            }),
            reserved1472: [40]u8,
            ///  Over-read character. Character sent out in case of an over-read of the transmit buffer.
            ORC: mmio.Mmio(packed struct(u32) {
                ///  Over-read character. Character sent out in case of an over-read of the transmit buffer.
                ORC: u8,
                padding: u24,
            }),
        };

        ///  Serial Peripheral Interface 0
        pub const SPI0 = extern struct {
            reserved264: [264]u8,
            ///  TXD byte sent and RXD byte received
            EVENTS_READY: u32,
            reserved772: [504]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  Write '1' to Enable interrupt for READY event
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u29,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  Write '1' to Disable interrupt for READY event
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u29,
            }),
            reserved1280: [500]u8,
            ///  Enable SPI
            ENABLE: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable SPI
                ENABLE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        ///  Disable SPI
                        Disabled = 0x0,
                        ///  Enable SPI
                        Enabled = 0x1,
                        _,
                    },
                },
                padding: u28,
            }),
            reserved1304: [20]u8,
            ///  RXD register
            RXD: mmio.Mmio(packed struct(u32) {
                ///  RX data received. Double buffered
                RXD: u8,
                padding: u24,
            }),
            ///  TXD register
            TXD: mmio.Mmio(packed struct(u32) {
                ///  TX data to send. Double buffered
                TXD: u8,
                padding: u24,
            }),
            reserved1316: [4]u8,
            ///  SPI frequency
            FREQUENCY: mmio.Mmio(packed struct(u32) {
                ///  SPI master data rate
                FREQUENCY: packed union {
                    raw: u32,
                    value: enum(u32) {
                        ///  125 kbps
                        K125 = 0x2000000,
                        ///  250 kbps
                        K250 = 0x4000000,
                        ///  500 kbps
                        K500 = 0x8000000,
                        ///  1 Mbps
                        M1 = 0x10000000,
                        ///  2 Mbps
                        M2 = 0x20000000,
                        ///  4 Mbps
                        M4 = 0x40000000,
                        ///  8 Mbps
                        M8 = 0x80000000,
                        _,
                    },
                },
            }),
            reserved1364: [44]u8,
            ///  Configuration register
            CONFIG: mmio.Mmio(packed struct(u32) {
                ///  Bit order
                ORDER: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Most significant bit shifted out first
                        MsbFirst = 0x0,
                        ///  Least significant bit shifted out first
                        LsbFirst = 0x1,
                    },
                },
                ///  Serial clock (SCK) phase
                CPHA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Sample on leading edge of clock, shift serial data on trailing edge
                        Leading = 0x0,
                        ///  Sample on trailing edge of clock, shift serial data on leading edge
                        Trailing = 0x1,
                    },
                },
                ///  Serial clock (SCK) polarity
                CPOL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Active high
                        ActiveHigh = 0x0,
                        ///  Active low
                        ActiveLow = 0x1,
                    },
                },
                padding: u29,
            }),
        };

        ///  I2C compatible Two-Wire Interface 0
        pub const TWI0 = extern struct {
            ///  Start TWI receive sequence
            TASKS_STARTRX: u32,
            reserved8: [4]u8,
            ///  Start TWI transmit sequence
            TASKS_STARTTX: u32,
            reserved20: [8]u8,
            ///  Stop TWI transaction
            TASKS_STOP: u32,
            reserved28: [4]u8,
            ///  Suspend TWI transaction
            TASKS_SUSPEND: u32,
            ///  Resume TWI transaction
            TASKS_RESUME: u32,
            reserved260: [224]u8,
            ///  TWI stopped
            EVENTS_STOPPED: u32,
            ///  TWI RXD byte received
            EVENTS_RXDREADY: u32,
            reserved284: [16]u8,
            ///  TWI TXD byte sent
            EVENTS_TXDSENT: u32,
            reserved292: [4]u8,
            ///  TWI error
            EVENTS_ERROR: u32,
            reserved312: [16]u8,
            ///  TWI byte boundary, generated before each byte that is sent or received
            EVENTS_BB: u32,
            reserved328: [12]u8,
            ///  TWI entered the suspended state
            EVENTS_SUSPENDED: u32,
            reserved512: [180]u8,
            ///  Shortcut register
            SHORTS: mmio.Mmio(packed struct(u32) {
                ///  Shortcut between BB event and SUSPEND task
                BB_SUSPEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between BB event and STOP task
                BB_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                padding: u30,
            }),
            reserved772: [256]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Write '1' to Enable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for RXDREADY event
                RXDREADY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved7: u4,
                ///  Write '1' to Enable interrupt for TXDSENT event
                TXDSENT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved9: u1,
                ///  Write '1' to Enable interrupt for ERROR event
                ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved14: u4,
                ///  Write '1' to Enable interrupt for BB event
                BB: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved18: u3,
                ///  Write '1' to Enable interrupt for SUSPENDED event
                SUSPENDED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u13,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Write '1' to Disable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for RXDREADY event
                RXDREADY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved7: u4,
                ///  Write '1' to Disable interrupt for TXDSENT event
                TXDSENT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved9: u1,
                ///  Write '1' to Disable interrupt for ERROR event
                ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved14: u4,
                ///  Write '1' to Disable interrupt for BB event
                BB: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved18: u3,
                ///  Write '1' to Disable interrupt for SUSPENDED event
                SUSPENDED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u13,
            }),
            reserved1220: [440]u8,
            ///  Error source
            ERRORSRC: mmio.Mmio(packed struct(u32) {
                ///  Overrun error
                OVERRUN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: no overrun occured
                        NotPresent = 0x0,
                        ///  Read: overrun occured
                        Present = 0x1,
                    },
                },
                ///  NACK received after sending the address (write '1' to clear)
                ANACK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: error not present
                        NotPresent = 0x0,
                        ///  Read: error present
                        Present = 0x1,
                    },
                },
                ///  NACK received after sending a data byte (write '1' to clear)
                DNACK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: error not present
                        NotPresent = 0x0,
                        ///  Read: error present
                        Present = 0x1,
                    },
                },
                padding: u29,
            }),
            reserved1280: [56]u8,
            ///  Enable TWI
            ENABLE: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable TWI
                ENABLE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        ///  Disable TWI
                        Disabled = 0x0,
                        ///  Enable TWI
                        Enabled = 0x5,
                        _,
                    },
                },
                padding: u28,
            }),
            reserved1288: [4]u8,
            ///  Pin select for SCL
            PSELSCL: mmio.Mmio(packed struct(u32) {
                ///  Pin number configuration for TWI SCL signal
                PSELSCL: packed union {
                    raw: u32,
                    value: enum(u32) {
                        ///  Disconnect
                        Disconnected = 0xffffffff,
                        _,
                    },
                },
            }),
            ///  Pin select for SDA
            PSELSDA: mmio.Mmio(packed struct(u32) {
                ///  Pin number configuration for TWI SDA signal
                PSELSDA: packed union {
                    raw: u32,
                    value: enum(u32) {
                        ///  Disconnect
                        Disconnected = 0xffffffff,
                        _,
                    },
                },
            }),
            reserved1304: [8]u8,
            ///  RXD register
            RXD: mmio.Mmio(packed struct(u32) {
                ///  RXD register
                RXD: u8,
                padding: u24,
            }),
            ///  TXD register
            TXD: mmio.Mmio(packed struct(u32) {
                ///  TXD register
                TXD: u8,
                padding: u24,
            }),
            reserved1316: [4]u8,
            ///  TWI frequency
            FREQUENCY: mmio.Mmio(packed struct(u32) {
                ///  TWI master clock frequency
                FREQUENCY: packed union {
                    raw: u32,
                    value: enum(u32) {
                        ///  100 kbps
                        K100 = 0x1980000,
                        ///  250 kbps
                        K250 = 0x4000000,
                        ///  400 kbps (actual rate 410.256 kbps)
                        K400 = 0x6680000,
                        _,
                    },
                },
            }),
            reserved1416: [96]u8,
            ///  Address used in the TWI transfer
            ADDRESS: mmio.Mmio(packed struct(u32) {
                ///  Address used in the TWI transfer
                ADDRESS: u7,
                padding: u25,
            }),
        };

        ///  GPIO Port 1
        pub const P0 = extern struct {
            reserved1284: [1284]u8,
            ///  Write GPIO port
            OUT: mmio.Mmio(packed struct(u32) {
                ///  Pin 0
                PIN0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 1
                PIN1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 2
                PIN2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 3
                PIN3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 4
                PIN4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 5
                PIN5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 6
                PIN6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 7
                PIN7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 8
                PIN8: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 9
                PIN9: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 10
                PIN10: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 11
                PIN11: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 12
                PIN12: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 13
                PIN13: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 14
                PIN14: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 15
                PIN15: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 16
                PIN16: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 17
                PIN17: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 18
                PIN18: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 19
                PIN19: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 20
                PIN20: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 21
                PIN21: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 22
                PIN22: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 23
                PIN23: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 24
                PIN24: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 25
                PIN25: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 26
                PIN26: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 27
                PIN27: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 28
                PIN28: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 29
                PIN29: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 30
                PIN30: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 31
                PIN31: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin driver is low
                        Low = 0x0,
                        ///  Pin driver is high
                        High = 0x1,
                    },
                },
            }),
            ///  Set individual bits in GPIO port
            OUTSET: mmio.Mmio(packed struct(u32) {
                ///  Pin 0
                PIN0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 1
                PIN1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 2
                PIN2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 3
                PIN3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 4
                PIN4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 5
                PIN5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 6
                PIN6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 7
                PIN7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 8
                PIN8: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 9
                PIN9: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 10
                PIN10: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 11
                PIN11: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 12
                PIN12: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 13
                PIN13: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 14
                PIN14: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 15
                PIN15: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 16
                PIN16: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 17
                PIN17: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 18
                PIN18: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 19
                PIN19: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 20
                PIN20: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 21
                PIN21: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 22
                PIN22: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 23
                PIN23: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 24
                PIN24: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 25
                PIN25: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 26
                PIN26: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 27
                PIN27: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 28
                PIN28: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 29
                PIN29: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 30
                PIN30: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 31
                PIN31: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
            }),
            ///  Clear individual bits in GPIO port
            OUTCLR: mmio.Mmio(packed struct(u32) {
                ///  Pin 0
                PIN0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 1
                PIN1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 2
                PIN2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 3
                PIN3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 4
                PIN4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 5
                PIN5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 6
                PIN6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 7
                PIN7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 8
                PIN8: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 9
                PIN9: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 10
                PIN10: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 11
                PIN11: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 12
                PIN12: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 13
                PIN13: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 14
                PIN14: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 15
                PIN15: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 16
                PIN16: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 17
                PIN17: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 18
                PIN18: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 19
                PIN19: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 20
                PIN20: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 21
                PIN21: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 22
                PIN22: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 23
                PIN23: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 24
                PIN24: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 25
                PIN25: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 26
                PIN26: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 27
                PIN27: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 28
                PIN28: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 29
                PIN29: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 30
                PIN30: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
                ///  Pin 31
                PIN31: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin driver is low
                        Low = 0x0,
                        ///  Read: pin driver is high
                        High = 0x1,
                    },
                },
            }),
            ///  Read GPIO port
            IN: mmio.Mmio(packed struct(u32) {
                ///  Pin 0
                PIN0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 1
                PIN1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 2
                PIN2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 3
                PIN3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 4
                PIN4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 5
                PIN5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 6
                PIN6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 7
                PIN7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 8
                PIN8: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 9
                PIN9: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 10
                PIN10: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 11
                PIN11: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 12
                PIN12: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 13
                PIN13: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 14
                PIN14: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 15
                PIN15: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 16
                PIN16: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 17
                PIN17: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 18
                PIN18: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 19
                PIN19: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 20
                PIN20: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 21
                PIN21: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 22
                PIN22: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 23
                PIN23: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 24
                PIN24: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 25
                PIN25: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 26
                PIN26: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 27
                PIN27: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 28
                PIN28: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 29
                PIN29: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 30
                PIN30: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
                ///  Pin 31
                PIN31: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin input is low
                        Low = 0x0,
                        ///  Pin input is high
                        High = 0x1,
                    },
                },
            }),
            ///  Direction of GPIO pins
            DIR: mmio.Mmio(packed struct(u32) {
                ///  Pin 0
                PIN0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 1
                PIN1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 2
                PIN2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 3
                PIN3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 4
                PIN4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 5
                PIN5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 6
                PIN6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 7
                PIN7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 8
                PIN8: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 9
                PIN9: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 10
                PIN10: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 11
                PIN11: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 12
                PIN12: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 13
                PIN13: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 14
                PIN14: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 15
                PIN15: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 16
                PIN16: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 17
                PIN17: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 18
                PIN18: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 19
                PIN19: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 20
                PIN20: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 21
                PIN21: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 22
                PIN22: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 23
                PIN23: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 24
                PIN24: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 25
                PIN25: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 26
                PIN26: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 27
                PIN27: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 28
                PIN28: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 29
                PIN29: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 30
                PIN30: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
                ///  Pin 31
                PIN31: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pin set as input
                        Input = 0x0,
                        ///  Pin set as output
                        Output = 0x1,
                    },
                },
            }),
            ///  DIR set register
            DIRSET: mmio.Mmio(packed struct(u32) {
                ///  Set as output pin 0
                PIN0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 1
                PIN1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 2
                PIN2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 3
                PIN3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 4
                PIN4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 5
                PIN5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 6
                PIN6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 7
                PIN7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 8
                PIN8: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 9
                PIN9: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 10
                PIN10: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 11
                PIN11: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 12
                PIN12: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 13
                PIN13: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 14
                PIN14: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 15
                PIN15: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 16
                PIN16: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 17
                PIN17: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 18
                PIN18: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 19
                PIN19: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 20
                PIN20: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 21
                PIN21: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 22
                PIN22: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 23
                PIN23: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 24
                PIN24: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 25
                PIN25: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 26
                PIN26: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 27
                PIN27: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 28
                PIN28: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 29
                PIN29: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 30
                PIN30: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as output pin 31
                PIN31: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
            }),
            ///  DIR clear register
            DIRCLR: mmio.Mmio(packed struct(u32) {
                ///  Set as input pin 0
                PIN0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 1
                PIN1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 2
                PIN2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 3
                PIN3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 4
                PIN4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 5
                PIN5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 6
                PIN6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 7
                PIN7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 8
                PIN8: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 9
                PIN9: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 10
                PIN10: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 11
                PIN11: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 12
                PIN12: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 13
                PIN13: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 14
                PIN14: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 15
                PIN15: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 16
                PIN16: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 17
                PIN17: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 18
                PIN18: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 19
                PIN19: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 20
                PIN20: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 21
                PIN21: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 22
                PIN22: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 23
                PIN23: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 24
                PIN24: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 25
                PIN25: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 26
                PIN26: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 27
                PIN27: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 28
                PIN28: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 29
                PIN29: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 30
                PIN30: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
                ///  Set as input pin 31
                PIN31: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: pin set as input
                        Input = 0x0,
                        ///  Read: pin set as output
                        Output = 0x1,
                    },
                },
            }),
            ///  Latch register indicating what GPIO pins that have met the criteria set in the PIN_CNF[n].SENSE registers
            LATCH: mmio.Mmio(packed struct(u32) {
                ///  Status on whether PIN0 has met criteria set in PIN_CNF0.SENSE register. Write '1' to clear.
                PIN0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN1 has met criteria set in PIN_CNF1.SENSE register. Write '1' to clear.
                PIN1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN2 has met criteria set in PIN_CNF2.SENSE register. Write '1' to clear.
                PIN2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN3 has met criteria set in PIN_CNF3.SENSE register. Write '1' to clear.
                PIN3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN4 has met criteria set in PIN_CNF4.SENSE register. Write '1' to clear.
                PIN4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN5 has met criteria set in PIN_CNF5.SENSE register. Write '1' to clear.
                PIN5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN6 has met criteria set in PIN_CNF6.SENSE register. Write '1' to clear.
                PIN6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN7 has met criteria set in PIN_CNF7.SENSE register. Write '1' to clear.
                PIN7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN8 has met criteria set in PIN_CNF8.SENSE register. Write '1' to clear.
                PIN8: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN9 has met criteria set in PIN_CNF9.SENSE register. Write '1' to clear.
                PIN9: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN10 has met criteria set in PIN_CNF10.SENSE register. Write '1' to clear.
                PIN10: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN11 has met criteria set in PIN_CNF11.SENSE register. Write '1' to clear.
                PIN11: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN12 has met criteria set in PIN_CNF12.SENSE register. Write '1' to clear.
                PIN12: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN13 has met criteria set in PIN_CNF13.SENSE register. Write '1' to clear.
                PIN13: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN14 has met criteria set in PIN_CNF14.SENSE register. Write '1' to clear.
                PIN14: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN15 has met criteria set in PIN_CNF15.SENSE register. Write '1' to clear.
                PIN15: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN16 has met criteria set in PIN_CNF16.SENSE register. Write '1' to clear.
                PIN16: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN17 has met criteria set in PIN_CNF17.SENSE register. Write '1' to clear.
                PIN17: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN18 has met criteria set in PIN_CNF18.SENSE register. Write '1' to clear.
                PIN18: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN19 has met criteria set in PIN_CNF19.SENSE register. Write '1' to clear.
                PIN19: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN20 has met criteria set in PIN_CNF20.SENSE register. Write '1' to clear.
                PIN20: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN21 has met criteria set in PIN_CNF21.SENSE register. Write '1' to clear.
                PIN21: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN22 has met criteria set in PIN_CNF22.SENSE register. Write '1' to clear.
                PIN22: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN23 has met criteria set in PIN_CNF23.SENSE register. Write '1' to clear.
                PIN23: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN24 has met criteria set in PIN_CNF24.SENSE register. Write '1' to clear.
                PIN24: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN25 has met criteria set in PIN_CNF25.SENSE register. Write '1' to clear.
                PIN25: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN26 has met criteria set in PIN_CNF26.SENSE register. Write '1' to clear.
                PIN26: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN27 has met criteria set in PIN_CNF27.SENSE register. Write '1' to clear.
                PIN27: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN28 has met criteria set in PIN_CNF28.SENSE register. Write '1' to clear.
                PIN28: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN29 has met criteria set in PIN_CNF29.SENSE register. Write '1' to clear.
                PIN29: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN30 has met criteria set in PIN_CNF30.SENSE register. Write '1' to clear.
                PIN30: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
                ///  Status on whether PIN31 has met criteria set in PIN_CNF31.SENSE register. Write '1' to clear.
                PIN31: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Criteria has not been met
                        NotLatched = 0x0,
                        ///  Criteria has been met
                        Latched = 0x1,
                    },
                },
            }),
            ///  Select between default DETECT signal behaviour and LDETECT mode
            DETECTMODE: mmio.Mmio(packed struct(u32) {
                ///  Select between default DETECT signal behaviour and LDETECT mode
                DETECTMODE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  DETECT directly connected to PIN DETECT signals
                        Default = 0x0,
                        ///  Use the latched LDETECT behaviour
                        LDETECT = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved1792: [472]u8,
            ///  Description collection[0]: Configuration of GPIO pins
            PIN_CNF: [32]mmio.Mmio(packed struct(u32) {
                ///  Pin direction. Same physical register as DIR register
                DIR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Configure pin as an input pin
                        Input = 0x0,
                        ///  Configure pin as an output pin
                        Output = 0x1,
                    },
                },
                ///  Connect or disconnect input buffer
                INPUT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Connect input buffer
                        Connect = 0x0,
                        ///  Disconnect input buffer
                        Disconnect = 0x1,
                    },
                },
                ///  Pull configuration
                PULL: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  No pull
                        Disabled = 0x0,
                        ///  Pull down on pin
                        Pulldown = 0x1,
                        ///  Pull up on pin
                        Pullup = 0x3,
                        _,
                    },
                },
                reserved8: u4,
                ///  Drive configuration
                DRIVE: packed union {
                    raw: u3,
                    value: enum(u3) {
                        ///  Standard '0', standard '1'
                        S0S1 = 0x0,
                        ///  High drive '0', standard '1'
                        H0S1 = 0x1,
                        ///  Standard '0', high drive '1'
                        S0H1 = 0x2,
                        ///  High drive '0', high 'drive '1''
                        H0H1 = 0x3,
                        ///  Disconnect '0' standard '1' (normally used for wired-or connections)
                        D0S1 = 0x4,
                        ///  Disconnect '0', high drive '1' (normally used for wired-or connections)
                        D0H1 = 0x5,
                        ///  Standard '0'. disconnect '1' (normally used for wired-and connections)
                        S0D1 = 0x6,
                        ///  High drive '0', disconnect '1' (normally used for wired-and connections)
                        H0D1 = 0x7,
                    },
                },
                reserved16: u5,
                ///  Pin sensing mechanism
                SENSE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Disabled
                        Disabled = 0x0,
                        ///  Sense for high level
                        High = 0x2,
                        ///  Sense for low level
                        Low = 0x3,
                        _,
                    },
                },
                padding: u14,
            }),
        };

        ///  FPU
        pub const FPU = extern struct {
            ///  Unused.
            UNUSED: u32,
        };

        ///  Inter-IC Sound
        pub const I2S = extern struct {
            ///  Starts continuous I2S transfer. Also starts MCK generator when this is enabled.
            TASKS_START: u32,
            ///  Stops I2S transfer. Also stops MCK generator. Triggering this task will cause the {event:STOPPED} event to be generated.
            TASKS_STOP: u32,
            reserved260: [252]u8,
            ///  The RXD.PTR register has been copied to internal double-buffers. When the I2S module is started and RX is enabled, this event will be generated for every RXTXD.MAXCNT words that are received on the SDIN pin.
            EVENTS_RXPTRUPD: u32,
            ///  I2S transfer stopped.
            EVENTS_STOPPED: u32,
            reserved276: [8]u8,
            ///  The TDX.PTR register has been copied to internal double-buffers. When the I2S module is started and TX is enabled, this event will be generated for every RXTXD.MAXCNT words that are sent on the SDOUT pin.
            EVENTS_TXPTRUPD: u32,
            reserved768: [488]u8,
            ///  Enable or disable interrupt
            INTEN: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Enable or disable interrupt for RXPTRUPD event
                RXPTRUPD: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                reserved5: u2,
                ///  Enable or disable interrupt for TXPTRUPD event
                TXPTRUPD: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                padding: u26,
            }),
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Write '1' to Enable interrupt for RXPTRUPD event
                RXPTRUPD: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved5: u2,
                ///  Write '1' to Enable interrupt for TXPTRUPD event
                TXPTRUPD: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u26,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Write '1' to Disable interrupt for RXPTRUPD event
                RXPTRUPD: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved5: u2,
                ///  Write '1' to Disable interrupt for TXPTRUPD event
                TXPTRUPD: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u26,
            }),
            reserved1280: [500]u8,
            ///  Enable I2S module.
            ENABLE: mmio.Mmio(packed struct(u32) {
                ///  Enable I2S module.
                ENABLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                padding: u31,
            }),
        };

        ///  Event Generator Unit 0
        pub const EGU0 = extern struct {
            ///  Description collection[0]: Trigger 0 for triggering the corresponding TRIGGERED[0] event
            TASKS_TRIGGER: [16]u32,
            reserved256: [192]u8,
            ///  Description collection[0]: Event number 0 generated by triggering the corresponding TRIGGER[0] task
            EVENTS_TRIGGERED: [16]u32,
            reserved768: [448]u8,
            ///  Enable or disable interrupt
            INTEN: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable interrupt for TRIGGERED[0] event
                TRIGGERED0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for TRIGGERED[1] event
                TRIGGERED1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for TRIGGERED[2] event
                TRIGGERED2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for TRIGGERED[3] event
                TRIGGERED3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for TRIGGERED[4] event
                TRIGGERED4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for TRIGGERED[5] event
                TRIGGERED5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for TRIGGERED[6] event
                TRIGGERED6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for TRIGGERED[7] event
                TRIGGERED7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for TRIGGERED[8] event
                TRIGGERED8: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for TRIGGERED[9] event
                TRIGGERED9: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for TRIGGERED[10] event
                TRIGGERED10: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for TRIGGERED[11] event
                TRIGGERED11: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for TRIGGERED[12] event
                TRIGGERED12: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for TRIGGERED[13] event
                TRIGGERED13: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for TRIGGERED[14] event
                TRIGGERED14: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for TRIGGERED[15] event
                TRIGGERED15: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                padding: u16,
            }),
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Enable interrupt for TRIGGERED[0] event
                TRIGGERED0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for TRIGGERED[1] event
                TRIGGERED1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for TRIGGERED[2] event
                TRIGGERED2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for TRIGGERED[3] event
                TRIGGERED3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for TRIGGERED[4] event
                TRIGGERED4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for TRIGGERED[5] event
                TRIGGERED5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for TRIGGERED[6] event
                TRIGGERED6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for TRIGGERED[7] event
                TRIGGERED7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for TRIGGERED[8] event
                TRIGGERED8: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for TRIGGERED[9] event
                TRIGGERED9: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for TRIGGERED[10] event
                TRIGGERED10: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for TRIGGERED[11] event
                TRIGGERED11: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for TRIGGERED[12] event
                TRIGGERED12: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for TRIGGERED[13] event
                TRIGGERED13: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for TRIGGERED[14] event
                TRIGGERED14: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for TRIGGERED[15] event
                TRIGGERED15: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u16,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Disable interrupt for TRIGGERED[0] event
                TRIGGERED0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for TRIGGERED[1] event
                TRIGGERED1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for TRIGGERED[2] event
                TRIGGERED2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for TRIGGERED[3] event
                TRIGGERED3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for TRIGGERED[4] event
                TRIGGERED4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for TRIGGERED[5] event
                TRIGGERED5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for TRIGGERED[6] event
                TRIGGERED6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for TRIGGERED[7] event
                TRIGGERED7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for TRIGGERED[8] event
                TRIGGERED8: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for TRIGGERED[9] event
                TRIGGERED9: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for TRIGGERED[10] event
                TRIGGERED10: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for TRIGGERED[11] event
                TRIGGERED11: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for TRIGGERED[12] event
                TRIGGERED12: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for TRIGGERED[13] event
                TRIGGERED13: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for TRIGGERED[14] event
                TRIGGERED14: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for TRIGGERED[15] event
                TRIGGERED15: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u16,
            }),
        };

        ///  Memory Watch Unit
        pub const MWU = extern struct {
            reserved768: [768]u8,
            ///  Enable or disable interrupt
            INTEN: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable interrupt for REGION[0].WA event
                REGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for REGION[0].RA event
                REGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for REGION[1].WA event
                REGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for REGION[1].RA event
                REGION1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for REGION[2].WA event
                REGION2WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for REGION[2].RA event
                REGION2RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for REGION[3].WA event
                REGION3WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for REGION[3].RA event
                REGION3RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                reserved24: u16,
                ///  Enable or disable interrupt for PREGION[0].WA event
                PREGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for PREGION[0].RA event
                PREGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for PREGION[1].WA event
                PREGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for PREGION[1].RA event
                PREGION1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                padding: u4,
            }),
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Enable interrupt for REGION[0].WA event
                REGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for REGION[0].RA event
                REGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for REGION[1].WA event
                REGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for REGION[1].RA event
                REGION1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for REGION[2].WA event
                REGION2WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for REGION[2].RA event
                REGION2RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for REGION[3].WA event
                REGION3WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for REGION[3].RA event
                REGION3RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved24: u16,
                ///  Write '1' to Enable interrupt for PREGION[0].WA event
                PREGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for PREGION[0].RA event
                PREGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for PREGION[1].WA event
                PREGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for PREGION[1].RA event
                PREGION1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u4,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Disable interrupt for REGION[0].WA event
                REGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for REGION[0].RA event
                REGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for REGION[1].WA event
                REGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for REGION[1].RA event
                REGION1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for REGION[2].WA event
                REGION2WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for REGION[2].RA event
                REGION2RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for REGION[3].WA event
                REGION3WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for REGION[3].RA event
                REGION3RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved24: u16,
                ///  Write '1' to Disable interrupt for PREGION[0].WA event
                PREGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for PREGION[0].RA event
                PREGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for PREGION[1].WA event
                PREGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for PREGION[1].RA event
                PREGION1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u4,
            }),
            reserved800: [20]u8,
            ///  Enable or disable non-maskable interrupt
            NMIEN: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable non-maskable interrupt for REGION[0].WA event
                REGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable non-maskable interrupt for REGION[0].RA event
                REGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable non-maskable interrupt for REGION[1].WA event
                REGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable non-maskable interrupt for REGION[1].RA event
                REGION1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable non-maskable interrupt for REGION[2].WA event
                REGION2WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable non-maskable interrupt for REGION[2].RA event
                REGION2RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable non-maskable interrupt for REGION[3].WA event
                REGION3WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable non-maskable interrupt for REGION[3].RA event
                REGION3RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                reserved24: u16,
                ///  Enable or disable non-maskable interrupt for PREGION[0].WA event
                PREGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable non-maskable interrupt for PREGION[0].RA event
                PREGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable non-maskable interrupt for PREGION[1].WA event
                PREGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable non-maskable interrupt for PREGION[1].RA event
                PREGION1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                padding: u4,
            }),
            ///  Enable non-maskable interrupt
            NMIENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Enable non-maskable interrupt for REGION[0].WA event
                REGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable non-maskable interrupt for REGION[0].RA event
                REGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable non-maskable interrupt for REGION[1].WA event
                REGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable non-maskable interrupt for REGION[1].RA event
                REGION1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable non-maskable interrupt for REGION[2].WA event
                REGION2WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable non-maskable interrupt for REGION[2].RA event
                REGION2RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable non-maskable interrupt for REGION[3].WA event
                REGION3WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable non-maskable interrupt for REGION[3].RA event
                REGION3RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved24: u16,
                ///  Write '1' to Enable non-maskable interrupt for PREGION[0].WA event
                PREGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable non-maskable interrupt for PREGION[0].RA event
                PREGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable non-maskable interrupt for PREGION[1].WA event
                PREGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable non-maskable interrupt for PREGION[1].RA event
                PREGION1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u4,
            }),
            ///  Disable non-maskable interrupt
            NMIENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Disable non-maskable interrupt for REGION[0].WA event
                REGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable non-maskable interrupt for REGION[0].RA event
                REGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable non-maskable interrupt for REGION[1].WA event
                REGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable non-maskable interrupt for REGION[1].RA event
                REGION1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable non-maskable interrupt for REGION[2].WA event
                REGION2WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable non-maskable interrupt for REGION[2].RA event
                REGION2RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable non-maskable interrupt for REGION[3].WA event
                REGION3WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable non-maskable interrupt for REGION[3].RA event
                REGION3RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved24: u16,
                ///  Write '1' to Disable non-maskable interrupt for PREGION[0].WA event
                PREGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable non-maskable interrupt for PREGION[0].RA event
                PREGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable non-maskable interrupt for PREGION[1].WA event
                PREGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable non-maskable interrupt for PREGION[1].RA event
                PREGION1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u4,
            }),
            reserved1296: [484]u8,
            ///  Enable/disable regions watch
            REGIONEN: mmio.Mmio(packed struct(u32) {
                ///  Enable/disable write access watch in region[0]
                RGN0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable write access watch in this region
                        Disable = 0x0,
                        ///  Enable write access watch in this region
                        Enable = 0x1,
                    },
                },
                ///  Enable/disable read access watch in region[0]
                RGN0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable read access watch in this region
                        Disable = 0x0,
                        ///  Enable read access watch in this region
                        Enable = 0x1,
                    },
                },
                ///  Enable/disable write access watch in region[1]
                RGN1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable write access watch in this region
                        Disable = 0x0,
                        ///  Enable write access watch in this region
                        Enable = 0x1,
                    },
                },
                ///  Enable/disable read access watch in region[1]
                RGN1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable read access watch in this region
                        Disable = 0x0,
                        ///  Enable read access watch in this region
                        Enable = 0x1,
                    },
                },
                ///  Enable/disable write access watch in region[2]
                RGN2WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable write access watch in this region
                        Disable = 0x0,
                        ///  Enable write access watch in this region
                        Enable = 0x1,
                    },
                },
                ///  Enable/disable read access watch in region[2]
                RGN2RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable read access watch in this region
                        Disable = 0x0,
                        ///  Enable read access watch in this region
                        Enable = 0x1,
                    },
                },
                ///  Enable/disable write access watch in region[3]
                RGN3WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable write access watch in this region
                        Disable = 0x0,
                        ///  Enable write access watch in this region
                        Enable = 0x1,
                    },
                },
                ///  Enable/disable read access watch in region[3]
                RGN3RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable read access watch in this region
                        Disable = 0x0,
                        ///  Enable read access watch in this region
                        Enable = 0x1,
                    },
                },
                reserved24: u16,
                ///  Enable/disable write access watch in PREGION[0]
                PRGN0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable write access watch in this PREGION
                        Disable = 0x0,
                        ///  Enable write access watch in this PREGION
                        Enable = 0x1,
                    },
                },
                ///  Enable/disable read access watch in PREGION[0]
                PRGN0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable read access watch in this PREGION
                        Disable = 0x0,
                        ///  Enable read access watch in this PREGION
                        Enable = 0x1,
                    },
                },
                ///  Enable/disable write access watch in PREGION[1]
                PRGN1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable write access watch in this PREGION
                        Disable = 0x0,
                        ///  Enable write access watch in this PREGION
                        Enable = 0x1,
                    },
                },
                ///  Enable/disable read access watch in PREGION[1]
                PRGN1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable read access watch in this PREGION
                        Disable = 0x0,
                        ///  Enable read access watch in this PREGION
                        Enable = 0x1,
                    },
                },
                padding: u4,
            }),
            ///  Enable regions watch
            REGIONENSET: mmio.Mmio(packed struct(u32) {
                ///  Enable write access watch in region[0]
                RGN0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Write access watch in this region is disabled
                        Disabled = 0x0,
                        ///  Write access watch in this region is enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable read access watch in region[0]
                RGN0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read access watch in this region is disabled
                        Disabled = 0x0,
                        ///  Read access watch in this region is enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable write access watch in region[1]
                RGN1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Write access watch in this region is disabled
                        Disabled = 0x0,
                        ///  Write access watch in this region is enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable read access watch in region[1]
                RGN1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read access watch in this region is disabled
                        Disabled = 0x0,
                        ///  Read access watch in this region is enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable write access watch in region[2]
                RGN2WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Write access watch in this region is disabled
                        Disabled = 0x0,
                        ///  Write access watch in this region is enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable read access watch in region[2]
                RGN2RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read access watch in this region is disabled
                        Disabled = 0x0,
                        ///  Read access watch in this region is enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable write access watch in region[3]
                RGN3WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Write access watch in this region is disabled
                        Disabled = 0x0,
                        ///  Write access watch in this region is enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable read access watch in region[3]
                RGN3RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read access watch in this region is disabled
                        Disabled = 0x0,
                        ///  Read access watch in this region is enabled
                        Enabled = 0x1,
                    },
                },
                reserved24: u16,
                ///  Enable write access watch in PREGION[0]
                PRGN0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Write access watch in this PREGION is disabled
                        Disabled = 0x0,
                        ///  Write access watch in this PREGION is enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable read access watch in PREGION[0]
                PRGN0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read access watch in this PREGION is disabled
                        Disabled = 0x0,
                        ///  Read access watch in this PREGION is enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable write access watch in PREGION[1]
                PRGN1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Write access watch in this PREGION is disabled
                        Disabled = 0x0,
                        ///  Write access watch in this PREGION is enabled
                        Enabled = 0x1,
                    },
                },
                ///  Enable read access watch in PREGION[1]
                PRGN1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read access watch in this PREGION is disabled
                        Disabled = 0x0,
                        ///  Read access watch in this PREGION is enabled
                        Enabled = 0x1,
                    },
                },
                padding: u4,
            }),
            ///  Disable regions watch
            REGIONENCLR: mmio.Mmio(packed struct(u32) {
                ///  Disable write access watch in region[0]
                RGN0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Write access watch in this region is disabled
                        Disabled = 0x0,
                        ///  Write access watch in this region is enabled
                        Enabled = 0x1,
                    },
                },
                ///  Disable read access watch in region[0]
                RGN0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read access watch in this region is disabled
                        Disabled = 0x0,
                        ///  Read access watch in this region is enabled
                        Enabled = 0x1,
                    },
                },
                ///  Disable write access watch in region[1]
                RGN1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Write access watch in this region is disabled
                        Disabled = 0x0,
                        ///  Write access watch in this region is enabled
                        Enabled = 0x1,
                    },
                },
                ///  Disable read access watch in region[1]
                RGN1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read access watch in this region is disabled
                        Disabled = 0x0,
                        ///  Read access watch in this region is enabled
                        Enabled = 0x1,
                    },
                },
                ///  Disable write access watch in region[2]
                RGN2WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Write access watch in this region is disabled
                        Disabled = 0x0,
                        ///  Write access watch in this region is enabled
                        Enabled = 0x1,
                    },
                },
                ///  Disable read access watch in region[2]
                RGN2RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read access watch in this region is disabled
                        Disabled = 0x0,
                        ///  Read access watch in this region is enabled
                        Enabled = 0x1,
                    },
                },
                ///  Disable write access watch in region[3]
                RGN3WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Write access watch in this region is disabled
                        Disabled = 0x0,
                        ///  Write access watch in this region is enabled
                        Enabled = 0x1,
                    },
                },
                ///  Disable read access watch in region[3]
                RGN3RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read access watch in this region is disabled
                        Disabled = 0x0,
                        ///  Read access watch in this region is enabled
                        Enabled = 0x1,
                    },
                },
                reserved24: u16,
                ///  Disable write access watch in PREGION[0]
                PRGN0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Write access watch in this PREGION is disabled
                        Disabled = 0x0,
                        ///  Write access watch in this PREGION is enabled
                        Enabled = 0x1,
                    },
                },
                ///  Disable read access watch in PREGION[0]
                PRGN0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read access watch in this PREGION is disabled
                        Disabled = 0x0,
                        ///  Read access watch in this PREGION is enabled
                        Enabled = 0x1,
                    },
                },
                ///  Disable write access watch in PREGION[1]
                PRGN1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Write access watch in this PREGION is disabled
                        Disabled = 0x0,
                        ///  Write access watch in this PREGION is enabled
                        Enabled = 0x1,
                    },
                },
                ///  Disable read access watch in PREGION[1]
                PRGN1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read access watch in this PREGION is disabled
                        Disabled = 0x0,
                        ///  Read access watch in this PREGION is enabled
                        Enabled = 0x1,
                    },
                },
                padding: u4,
            }),
        };

        ///  Programmable Peripheral Interconnect
        pub const PPI = extern struct {
            reserved1280: [1280]u8,
            ///  Channel enable register
            CHEN: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable channel 0
                CH0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 1
                CH1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 2
                CH2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 3
                CH3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 4
                CH4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 5
                CH5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 6
                CH6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 7
                CH7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 8
                CH8: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 9
                CH9: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 10
                CH10: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 11
                CH11: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 12
                CH12: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 13
                CH13: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 14
                CH14: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 15
                CH15: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 16
                CH16: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 17
                CH17: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 18
                CH18: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 19
                CH19: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 20
                CH20: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 21
                CH21: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 22
                CH22: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 23
                CH23: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 24
                CH24: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 25
                CH25: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 26
                CH26: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 27
                CH27: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 28
                CH28: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 29
                CH29: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 30
                CH30: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable channel 31
                CH31: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable channel
                        Disabled = 0x0,
                        ///  Enable channel
                        Enabled = 0x1,
                    },
                },
            }),
            ///  Channel enable set register
            CHENSET: mmio.Mmio(packed struct(u32) {
                ///  Channel 0 enable set register. Writing '0' has no effect
                CH0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 1 enable set register. Writing '0' has no effect
                CH1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 2 enable set register. Writing '0' has no effect
                CH2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 3 enable set register. Writing '0' has no effect
                CH3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 4 enable set register. Writing '0' has no effect
                CH4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 5 enable set register. Writing '0' has no effect
                CH5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 6 enable set register. Writing '0' has no effect
                CH6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 7 enable set register. Writing '0' has no effect
                CH7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 8 enable set register. Writing '0' has no effect
                CH8: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 9 enable set register. Writing '0' has no effect
                CH9: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 10 enable set register. Writing '0' has no effect
                CH10: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 11 enable set register. Writing '0' has no effect
                CH11: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 12 enable set register. Writing '0' has no effect
                CH12: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 13 enable set register. Writing '0' has no effect
                CH13: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 14 enable set register. Writing '0' has no effect
                CH14: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 15 enable set register. Writing '0' has no effect
                CH15: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 16 enable set register. Writing '0' has no effect
                CH16: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 17 enable set register. Writing '0' has no effect
                CH17: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 18 enable set register. Writing '0' has no effect
                CH18: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 19 enable set register. Writing '0' has no effect
                CH19: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 20 enable set register. Writing '0' has no effect
                CH20: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 21 enable set register. Writing '0' has no effect
                CH21: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 22 enable set register. Writing '0' has no effect
                CH22: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 23 enable set register. Writing '0' has no effect
                CH23: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 24 enable set register. Writing '0' has no effect
                CH24: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 25 enable set register. Writing '0' has no effect
                CH25: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 26 enable set register. Writing '0' has no effect
                CH26: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 27 enable set register. Writing '0' has no effect
                CH27: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 28 enable set register. Writing '0' has no effect
                CH28: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 29 enable set register. Writing '0' has no effect
                CH29: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 30 enable set register. Writing '0' has no effect
                CH30: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 31 enable set register. Writing '0' has no effect
                CH31: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
            }),
            ///  Channel enable clear register
            CHENCLR: mmio.Mmio(packed struct(u32) {
                ///  Channel 0 enable clear register. Writing '0' has no effect
                CH0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 1 enable clear register. Writing '0' has no effect
                CH1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 2 enable clear register. Writing '0' has no effect
                CH2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 3 enable clear register. Writing '0' has no effect
                CH3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 4 enable clear register. Writing '0' has no effect
                CH4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 5 enable clear register. Writing '0' has no effect
                CH5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 6 enable clear register. Writing '0' has no effect
                CH6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 7 enable clear register. Writing '0' has no effect
                CH7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 8 enable clear register. Writing '0' has no effect
                CH8: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 9 enable clear register. Writing '0' has no effect
                CH9: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 10 enable clear register. Writing '0' has no effect
                CH10: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 11 enable clear register. Writing '0' has no effect
                CH11: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 12 enable clear register. Writing '0' has no effect
                CH12: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 13 enable clear register. Writing '0' has no effect
                CH13: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 14 enable clear register. Writing '0' has no effect
                CH14: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 15 enable clear register. Writing '0' has no effect
                CH15: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 16 enable clear register. Writing '0' has no effect
                CH16: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 17 enable clear register. Writing '0' has no effect
                CH17: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 18 enable clear register. Writing '0' has no effect
                CH18: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 19 enable clear register. Writing '0' has no effect
                CH19: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 20 enable clear register. Writing '0' has no effect
                CH20: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 21 enable clear register. Writing '0' has no effect
                CH21: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 22 enable clear register. Writing '0' has no effect
                CH22: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 23 enable clear register. Writing '0' has no effect
                CH23: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 24 enable clear register. Writing '0' has no effect
                CH24: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 25 enable clear register. Writing '0' has no effect
                CH25: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 26 enable clear register. Writing '0' has no effect
                CH26: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 27 enable clear register. Writing '0' has no effect
                CH27: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 28 enable clear register. Writing '0' has no effect
                CH28: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 29 enable clear register. Writing '0' has no effect
                CH29: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 30 enable clear register. Writing '0' has no effect
                CH30: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
                ///  Channel 31 enable clear register. Writing '0' has no effect
                CH31: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: channel disabled
                        Disabled = 0x0,
                        ///  Read: channel enabled
                        Enabled = 0x1,
                    },
                },
            }),
            reserved2048: [756]u8,
            ///  Description collection[0]: Channel group 0
            CHG: [6]mmio.Mmio(packed struct(u32) {
                ///  Include or exclude channel 0
                CH0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 1
                CH1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 2
                CH2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 3
                CH3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 4
                CH4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 5
                CH5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 6
                CH6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 7
                CH7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 8
                CH8: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 9
                CH9: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 10
                CH10: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 11
                CH11: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 12
                CH12: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 13
                CH13: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 14
                CH14: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 15
                CH15: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 16
                CH16: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 17
                CH17: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 18
                CH18: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 19
                CH19: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 20
                CH20: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 21
                CH21: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 22
                CH22: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 23
                CH23: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 24
                CH24: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 25
                CH25: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 26
                CH26: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 27
                CH27: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 28
                CH28: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 29
                CH29: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 30
                CH30: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
                ///  Include or exclude channel 31
                CH31: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exclude
                        Excluded = 0x0,
                        ///  Include
                        Included = 0x1,
                    },
                },
            }),
        };

        ///  NFC-A compatible radio
        pub const NFCT = extern struct {
            ///  Activate NFC peripheral for incoming and outgoing frames, change state to activated
            TASKS_ACTIVATE: u32,
            ///  Disable NFC peripheral
            TASKS_DISABLE: u32,
            ///  Enable NFC sense field mode, change state to sense mode
            TASKS_SENSE: u32,
            ///  Start transmission of a outgoing frame, change state to transmit
            TASKS_STARTTX: u32,
            reserved28: [12]u8,
            ///  Initializes the EasyDMA for receive.
            TASKS_ENABLERXDATA: u32,
            reserved36: [4]u8,
            ///  Force state machine to IDLE state
            TASKS_GOIDLE: u32,
            ///  Force state machine to SLEEP_A state
            TASKS_GOSLEEP: u32,
            reserved256: [212]u8,
            ///  The NFC peripheral is ready to receive and send frames
            EVENTS_READY: u32,
            ///  Remote NFC field detected
            EVENTS_FIELDDETECTED: u32,
            ///  Remote NFC field lost
            EVENTS_FIELDLOST: u32,
            ///  Marks the start of the first symbol of a transmitted frame
            EVENTS_TXFRAMESTART: u32,
            ///  Marks the end of the last transmitted on-air symbol of a frame
            EVENTS_TXFRAMEEND: u32,
            ///  Marks the end of the first symbol of a received frame
            EVENTS_RXFRAMESTART: u32,
            ///  Received data have been checked (CRC, parity) and transferred to RAM, and EasyDMA has ended accessing the RX buffer
            EVENTS_RXFRAMEEND: u32,
            ///  NFC error reported. The ERRORSTATUS register contains details on the source of the error.
            EVENTS_ERROR: u32,
            reserved296: [8]u8,
            ///  NFC RX frame error reported. The FRAMESTATUS.RX register contains details on the source of the error.
            EVENTS_RXERROR: u32,
            ///  RX buffer (as defined by PACKETPTR and MAXLEN) in Data RAM full.
            EVENTS_ENDRX: u32,
            ///  Transmission of data in RAM has ended, and EasyDMA has ended accessing the TX buffer
            EVENTS_ENDTX: u32,
            reserved312: [4]u8,
            ///  Auto collision resolution process has started
            EVENTS_AUTOCOLRESSTARTED: u32,
            reserved328: [12]u8,
            ///  NFC Auto collision resolution error reported.
            EVENTS_COLLISION: u32,
            ///  NFC Auto collision resolution successfully completed
            EVENTS_SELECTED: u32,
            ///  EasyDMA is ready to receive or send frames.
            EVENTS_STARTED: u32,
            reserved512: [172]u8,
            ///  Shortcut register
            SHORTS: mmio.Mmio(packed struct(u32) {
                ///  Shortcut between FIELDDETECTED event and ACTIVATE task
                FIELDDETECTED_ACTIVATE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between FIELDLOST event and SENSE task
                FIELDLOST_SENSE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                padding: u30,
            }),
            reserved768: [252]u8,
            ///  Enable or disable interrupt
            INTEN: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable interrupt for READY event
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for FIELDDETECTED event
                FIELDDETECTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for FIELDLOST event
                FIELDLOST: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for TXFRAMESTART event
                TXFRAMESTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for TXFRAMEEND event
                TXFRAMEEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for RXFRAMESTART event
                RXFRAMESTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for RXFRAMEEND event
                RXFRAMEEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for ERROR event
                ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                reserved10: u2,
                ///  Enable or disable interrupt for RXERROR event
                RXERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for ENDRX event
                ENDRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for ENDTX event
                ENDTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                reserved14: u1,
                ///  Enable or disable interrupt for AUTOCOLRESSTARTED event
                AUTOCOLRESSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                reserved18: u3,
                ///  Enable or disable interrupt for COLLISION event
                COLLISION: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for SELECTED event
                SELECTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for STARTED event
                STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                padding: u11,
            }),
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Enable interrupt for READY event
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for FIELDDETECTED event
                FIELDDETECTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for FIELDLOST event
                FIELDLOST: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for TXFRAMESTART event
                TXFRAMESTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for TXFRAMEEND event
                TXFRAMEEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for RXFRAMESTART event
                RXFRAMESTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for RXFRAMEEND event
                RXFRAMEEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for ERROR event
                ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved10: u2,
                ///  Write '1' to Enable interrupt for RXERROR event
                RXERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for ENDRX event
                ENDRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for ENDTX event
                ENDTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved14: u1,
                ///  Write '1' to Enable interrupt for AUTOCOLRESSTARTED event
                AUTOCOLRESSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved18: u3,
                ///  Write '1' to Enable interrupt for COLLISION event
                COLLISION: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for SELECTED event
                SELECTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for STARTED event
                STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u11,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Disable interrupt for READY event
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for FIELDDETECTED event
                FIELDDETECTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for FIELDLOST event
                FIELDLOST: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for TXFRAMESTART event
                TXFRAMESTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for TXFRAMEEND event
                TXFRAMEEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for RXFRAMESTART event
                RXFRAMESTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for RXFRAMEEND event
                RXFRAMEEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for ERROR event
                ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved10: u2,
                ///  Write '1' to Disable interrupt for RXERROR event
                RXERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for ENDRX event
                ENDRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for ENDTX event
                ENDTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved14: u1,
                ///  Write '1' to Disable interrupt for AUTOCOLRESSTARTED event
                AUTOCOLRESSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved18: u3,
                ///  Write '1' to Disable interrupt for COLLISION event
                COLLISION: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for SELECTED event
                SELECTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for STARTED event
                STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u11,
            }),
            reserved1028: [248]u8,
            ///  NFC Error Status register
            ERRORSTATUS: mmio.Mmio(packed struct(u32) {
                ///  No STARTTX task triggered before expiration of the time set in FRAMEDELAYMAX
                FRAMEDELAYTIMEOUT: u1,
                reserved2: u1,
                ///  Field level is too high at max load resistance
                NFCFIELDTOOSTRONG: u1,
                ///  Field level is too low at min load resistance
                NFCFIELDTOOWEAK: u1,
                padding: u28,
            }),
            reserved1072: [40]u8,
            ///  Current value driven to the NFC Load Control
            CURRENTLOADCTRL: mmio.Mmio(packed struct(u32) {
                ///  Current value driven to the NFC Load Control
                CURRENTLOADCTRL: u6,
                padding: u26,
            }),
            reserved1084: [8]u8,
            ///  Indicates the presence or not of a valid field
            FIELDPRESENT: mmio.Mmio(packed struct(u32) {
                ///  Indicates the presence or not of a valid field. Available only in the activated state.
                FIELDPRESENT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  No valid field detected
                        NoField = 0x0,
                        ///  Valid field detected
                        FieldPresent = 0x1,
                    },
                },
                ///  Indicates if the low level has locked to the field
                LOCKDETECT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Not locked to field
                        NotLocked = 0x0,
                        ///  Locked to field
                        Locked = 0x1,
                    },
                },
                padding: u30,
            }),
            reserved1284: [196]u8,
            ///  Minimum frame delay
            FRAMEDELAYMIN: mmio.Mmio(packed struct(u32) {
                ///  Minimum frame delay in number of 13.56 MHz clocks
                FRAMEDELAYMIN: u16,
                padding: u16,
            }),
            ///  Maximum frame delay
            FRAMEDELAYMAX: mmio.Mmio(packed struct(u32) {
                ///  Maximum frame delay in number of 13.56 MHz clocks
                FRAMEDELAYMAX: u16,
                padding: u16,
            }),
            ///  Configuration register for the Frame Delay Timer
            FRAMEDELAYMODE: mmio.Mmio(packed struct(u32) {
                ///  Configuration register for the Frame Delay Timer
                FRAMEDELAYMODE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Transmission is independent of frame timer and will start when the STARTTX task is triggered. No timeout.
                        FreeRun = 0x0,
                        ///  Frame is transmitted between FRAMEDELAYMIN and FRAMEDELAYMAX
                        Window = 0x1,
                        ///  Frame is transmitted exactly at FRAMEDELAYMAX
                        ExactVal = 0x2,
                        ///  Frame is transmitted on a bit grid between FRAMEDELAYMIN and FRAMEDELAYMAX
                        WindowGrid = 0x3,
                    },
                },
                padding: u30,
            }),
            ///  Packet pointer for TXD and RXD data storage in Data RAM
            PACKETPTR: mmio.Mmio(packed struct(u32) {
                ///  Packet pointer for TXD and RXD data storage in Data RAM. This address is a byte aligned RAM address.
                PTR: u32,
            }),
            ///  Size of allocated for TXD and RXD data storage buffer in Data RAM
            MAXLEN: mmio.Mmio(packed struct(u32) {
                ///  Size of allocated for TXD and RXD data storage buffer in Data RAM
                MAXLEN: u9,
                padding: u23,
            }),
            reserved1424: [120]u8,
            ///  Last NFCID1 part (4, 7 or 10 bytes ID)
            NFCID1_LAST: mmio.Mmio(packed struct(u32) {
                ///  NFCID1 byte Z (very last byte sent)
                NFCID1_Z: u8,
                ///  NFCID1 byte Y
                NFCID1_Y: u8,
                ///  NFCID1 byte X
                NFCID1_X: u8,
                ///  NFCID1 byte W
                NFCID1_W: u8,
            }),
            ///  Second last NFCID1 part (7 or 10 bytes ID)
            NFCID1_2ND_LAST: mmio.Mmio(packed struct(u32) {
                ///  NFCID1 byte V
                NFCID1_V: u8,
                ///  NFCID1 byte U
                NFCID1_U: u8,
                ///  NFCID1 byte T
                NFCID1_T: u8,
                padding: u8,
            }),
            ///  Third last NFCID1 part (10 bytes ID)
            NFCID1_3RD_LAST: mmio.Mmio(packed struct(u32) {
                ///  NFCID1 byte S
                NFCID1_S: u8,
                ///  NFCID1 byte R
                NFCID1_R: u8,
                ///  NFCID1 byte Q
                NFCID1_Q: u8,
                padding: u8,
            }),
            reserved1440: [4]u8,
            ///  NFC-A SENS_RES auto-response settings
            SENSRES: mmio.Mmio(packed struct(u32) {
                ///  Bit frame SDD as defined by the b5:b1 of byte 1 in SENS_RES response in the NFC Forum, NFC Digital Protocol Technical Specification
                BITFRAMESDD: packed union {
                    raw: u5,
                    value: enum(u5) {
                        ///  SDD pattern 00000
                        SDD00000 = 0x0,
                        ///  SDD pattern 00001
                        SDD00001 = 0x1,
                        ///  SDD pattern 00010
                        SDD00010 = 0x2,
                        ///  SDD pattern 00100
                        SDD00100 = 0x4,
                        ///  SDD pattern 01000
                        SDD01000 = 0x8,
                        ///  SDD pattern 10000
                        SDD10000 = 0x10,
                        _,
                    },
                },
                ///  Reserved for future use. Shall be 0.
                RFU5: u1,
                ///  NFCID1 size. This value is used by the Auto collision resolution engine.
                NFCIDSIZE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  NFCID1 size: single (4 bytes)
                        NFCID1Single = 0x0,
                        ///  NFCID1 size: double (7 bytes)
                        NFCID1Double = 0x1,
                        ///  NFCID1 size: triple (10 bytes)
                        NFCID1Triple = 0x2,
                        _,
                    },
                },
                ///  Tag platform configuration as defined by the b4:b1 of byte 2 in SENS_RES response in the NFC Forum, NFC Digital Protocol Technical Specification
                PLATFCONFIG: u4,
                ///  Reserved for future use. Shall be 0.
                RFU74: u4,
                padding: u16,
            }),
            ///  NFC-A SEL_RES auto-response settings
            SELRES: mmio.Mmio(packed struct(u32) {
                ///  Reserved for future use. Shall be 0.
                RFU10: u2,
                ///  Cascade bit (controlled by hardware, write has no effect)
                CASCADE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  NFCID1 complete
                        Complete = 0x0,
                        ///  NFCID1 not complete
                        NotComplete = 0x1,
                    },
                },
                ///  Reserved for future use. Shall be 0.
                RFU43: u2,
                ///  Protocol as defined by the b7:b6 of SEL_RES response in the NFC Forum, NFC Digital Protocol Technical Specification
                PROTOCOL: u2,
                ///  Reserved for future use. Shall be 0.
                RFU7: u1,
                padding: u24,
            }),
        };

        ///  GPIO Tasks and Events
        pub const GPIOTE = extern struct {
            ///  Description collection[0]: Task for writing to pin specified in CONFIG[0].PSEL. Action on pin is configured in CONFIG[0].POLARITY.
            TASKS_OUT: [8]u32,
            reserved48: [16]u8,
            ///  Description collection[0]: Task for writing to pin specified in CONFIG[0].PSEL. Action on pin is to set it high.
            TASKS_SET: [8]u32,
            reserved96: [16]u8,
            ///  Description collection[0]: Task for writing to pin specified in CONFIG[0].PSEL. Action on pin is to set it low.
            TASKS_CLR: [8]u32,
            reserved256: [128]u8,
            ///  Description collection[0]: Event generated from pin specified in CONFIG[0].PSEL
            EVENTS_IN: [8]u32,
            reserved380: [92]u8,
            ///  Event generated from multiple input GPIO pins with SENSE mechanism enabled
            EVENTS_PORT: u32,
            reserved772: [388]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Enable interrupt for IN[0] event
                IN0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for IN[1] event
                IN1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for IN[2] event
                IN2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for IN[3] event
                IN3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for IN[4] event
                IN4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for IN[5] event
                IN5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for IN[6] event
                IN6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for IN[7] event
                IN7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved31: u23,
                ///  Write '1' to Enable interrupt for PORT event
                PORT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Disable interrupt for IN[0] event
                IN0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for IN[1] event
                IN1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for IN[2] event
                IN2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for IN[3] event
                IN3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for IN[4] event
                IN4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for IN[5] event
                IN5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for IN[6] event
                IN6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for IN[7] event
                IN7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved31: u23,
                ///  Write '1' to Disable interrupt for PORT event
                PORT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
            }),
            reserved1296: [516]u8,
            ///  Description collection[0]: Configuration for OUT[n], SET[n] and CLR[n] tasks and IN[n] event
            CONFIG: [8]mmio.Mmio(packed struct(u32) {
                ///  Mode
                MODE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Disabled. Pin specified by PSEL will not be acquired by the GPIOTE module.
                        Disabled = 0x0,
                        ///  Event mode
                        Event = 0x1,
                        ///  Task mode
                        Task = 0x3,
                        _,
                    },
                },
                reserved8: u6,
                ///  GPIO number associated with SET[n], CLR[n] and OUT[n] tasks and IN[n] event
                PSEL: u5,
                reserved16: u3,
                ///  When In task mode: Operation to be performed on output when OUT[n] task is triggered. When In event mode: Operation on input that shall trigger IN[n] event.
                POLARITY: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Task mode: No effect on pin from OUT[n] task. Event mode: no IN[n] event generated on pin activity.
                        None = 0x0,
                        ///  Task mode: Set pin from OUT[n] task. Event mode: Generate IN[n] event when rising edge on pin.
                        LoToHi = 0x1,
                        ///  Task mode: Clear pin from OUT[n] task. Event mode: Generate IN[n] event when falling edge on pin.
                        HiToLo = 0x2,
                        ///  Task mode: Toggle pin from OUT[n]. Event mode: Generate IN[n] when any change on pin.
                        Toggle = 0x3,
                    },
                },
                reserved20: u2,
                ///  When in task mode: Initial value of the output when the GPIOTE channel is configured. When in event mode: No effect.
                OUTINIT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Task mode: Initial value of pin before task triggering is low
                        Low = 0x0,
                        ///  Task mode: Initial value of pin before task triggering is high
                        High = 0x1,
                    },
                },
                padding: u11,
            }),
        };

        ///  Analog to Digital Converter
        pub const SAADC = extern struct {
            ///  Start the ADC and prepare the result buffer in RAM
            TASKS_START: u32,
            ///  Take one ADC sample, if scan is enabled all channels are sampled
            TASKS_SAMPLE: u32,
            ///  Stop the ADC and terminate any on-going conversion
            TASKS_STOP: u32,
            ///  Starts offset auto-calibration
            TASKS_CALIBRATEOFFSET: u32,
            reserved256: [240]u8,
            ///  The ADC has started
            EVENTS_STARTED: u32,
            ///  The ADC has filled up the Result buffer
            EVENTS_END: u32,
            ///  A conversion task has been completed. Depending on the mode, multiple conversions might be needed for a result to be transferred to RAM.
            EVENTS_DONE: u32,
            ///  A result is ready to get transferred to RAM.
            EVENTS_RESULTDONE: u32,
            ///  Calibration is complete
            EVENTS_CALIBRATEDONE: u32,
            ///  The ADC has stopped
            EVENTS_STOPPED: u32,
            reserved768: [488]u8,
            ///  Enable or disable interrupt
            INTEN: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable interrupt for STARTED event
                STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for END event
                END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for DONE event
                DONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for RESULTDONE event
                RESULTDONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for CALIBRATEDONE event
                CALIBRATEDONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for CH[0].LIMITH event
                CH0LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for CH[0].LIMITL event
                CH0LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for CH[1].LIMITH event
                CH1LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for CH[1].LIMITL event
                CH1LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for CH[2].LIMITH event
                CH2LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for CH[2].LIMITL event
                CH2LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for CH[3].LIMITH event
                CH3LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for CH[3].LIMITL event
                CH3LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for CH[4].LIMITH event
                CH4LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for CH[4].LIMITL event
                CH4LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for CH[5].LIMITH event
                CH5LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for CH[5].LIMITL event
                CH5LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for CH[6].LIMITH event
                CH6LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for CH[6].LIMITL event
                CH6LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for CH[7].LIMITH event
                CH7LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for CH[7].LIMITL event
                CH7LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                padding: u10,
            }),
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Enable interrupt for STARTED event
                STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for END event
                END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for DONE event
                DONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for RESULTDONE event
                RESULTDONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for CALIBRATEDONE event
                CALIBRATEDONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for CH[0].LIMITH event
                CH0LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for CH[0].LIMITL event
                CH0LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for CH[1].LIMITH event
                CH1LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for CH[1].LIMITL event
                CH1LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for CH[2].LIMITH event
                CH2LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for CH[2].LIMITL event
                CH2LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for CH[3].LIMITH event
                CH3LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for CH[3].LIMITL event
                CH3LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for CH[4].LIMITH event
                CH4LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for CH[4].LIMITL event
                CH4LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for CH[5].LIMITH event
                CH5LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for CH[5].LIMITL event
                CH5LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for CH[6].LIMITH event
                CH6LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for CH[6].LIMITL event
                CH6LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for CH[7].LIMITH event
                CH7LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for CH[7].LIMITL event
                CH7LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u10,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Disable interrupt for STARTED event
                STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for END event
                END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for DONE event
                DONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for RESULTDONE event
                RESULTDONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for CALIBRATEDONE event
                CALIBRATEDONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for CH[0].LIMITH event
                CH0LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for CH[0].LIMITL event
                CH0LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for CH[1].LIMITH event
                CH1LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for CH[1].LIMITL event
                CH1LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for CH[2].LIMITH event
                CH2LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for CH[2].LIMITL event
                CH2LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for CH[3].LIMITH event
                CH3LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for CH[3].LIMITL event
                CH3LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for CH[4].LIMITH event
                CH4LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for CH[4].LIMITL event
                CH4LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for CH[5].LIMITH event
                CH5LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for CH[5].LIMITL event
                CH5LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for CH[6].LIMITH event
                CH6LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for CH[6].LIMITL event
                CH6LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for CH[7].LIMITH event
                CH7LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for CH[7].LIMITL event
                CH7LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u10,
            }),
            reserved1024: [244]u8,
            ///  Status
            STATUS: mmio.Mmio(packed struct(u32) {
                ///  Status
                STATUS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  ADC is ready. No on-going conversion.
                        Ready = 0x0,
                        ///  ADC is busy. Conversion in progress.
                        Busy = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved1280: [252]u8,
            ///  Enable or disable ADC
            ENABLE: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable ADC
                ENABLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable ADC
                        Disabled = 0x0,
                        ///  Enable ADC
                        Enabled = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved1520: [236]u8,
            ///  Resolution configuration
            RESOLUTION: mmio.Mmio(packed struct(u32) {
                ///  Set the resolution
                VAL: packed union {
                    raw: u3,
                    value: enum(u3) {
                        ///  8 bit
                        @"8bit" = 0x0,
                        ///  10 bit
                        @"10bit" = 0x1,
                        ///  12 bit
                        @"12bit" = 0x2,
                        ///  14 bit
                        @"14bit" = 0x3,
                        _,
                    },
                },
                padding: u29,
            }),
            ///  Oversampling configuration. OVERSAMPLE should not be combined with SCAN. The RESOLUTION is applied before averaging, thus for high OVERSAMPLE a higher RESOLUTION should be used.
            OVERSAMPLE: mmio.Mmio(packed struct(u32) {
                ///  Oversample control
                OVERSAMPLE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        ///  Bypass oversampling
                        Bypass = 0x0,
                        ///  Oversample 2x
                        Over2x = 0x1,
                        ///  Oversample 4x
                        Over4x = 0x2,
                        ///  Oversample 8x
                        Over8x = 0x3,
                        ///  Oversample 16x
                        Over16x = 0x4,
                        ///  Oversample 32x
                        Over32x = 0x5,
                        ///  Oversample 64x
                        Over64x = 0x6,
                        ///  Oversample 128x
                        Over128x = 0x7,
                        ///  Oversample 256x
                        Over256x = 0x8,
                        _,
                    },
                },
                padding: u28,
            }),
            ///  Controls normal or continuous sample rate
            SAMPLERATE: mmio.Mmio(packed struct(u32) {
                ///  Capture and compare value. Sample rate is 16 MHz/CC
                CC: u11,
                reserved12: u1,
                ///  Select mode for sample rate control
                MODE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Rate is controlled from SAMPLE task
                        Task = 0x0,
                        ///  Rate is controlled from local timer (use CC to control the rate)
                        Timers = 0x1,
                    },
                },
                padding: u19,
            }),
        };

        ///  Timer/Counter 0
        pub const TIMER0 = extern struct {
            ///  Start Timer
            TASKS_START: u32,
            ///  Stop Timer
            TASKS_STOP: u32,
            ///  Increment Timer (Counter mode only)
            TASKS_COUNT: u32,
            ///  Clear time
            TASKS_CLEAR: u32,
            ///  Deprecated register - Shut down timer
            TASKS_SHUTDOWN: u32,
            reserved64: [44]u8,
            ///  Description collection[0]: Capture Timer value to CC[0] register
            TASKS_CAPTURE: [6]u32,
            reserved320: [232]u8,
            ///  Description collection[0]: Compare event on CC[0] match
            EVENTS_COMPARE: [6]u32,
            reserved512: [168]u8,
            ///  Shortcut register
            SHORTS: mmio.Mmio(packed struct(u32) {
                ///  Shortcut between COMPARE[0] event and CLEAR task
                COMPARE0_CLEAR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between COMPARE[1] event and CLEAR task
                COMPARE1_CLEAR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between COMPARE[2] event and CLEAR task
                COMPARE2_CLEAR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between COMPARE[3] event and CLEAR task
                COMPARE3_CLEAR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between COMPARE[4] event and CLEAR task
                COMPARE4_CLEAR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between COMPARE[5] event and CLEAR task
                COMPARE5_CLEAR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                reserved8: u2,
                ///  Shortcut between COMPARE[0] event and STOP task
                COMPARE0_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between COMPARE[1] event and STOP task
                COMPARE1_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between COMPARE[2] event and STOP task
                COMPARE2_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between COMPARE[3] event and STOP task
                COMPARE3_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between COMPARE[4] event and STOP task
                COMPARE4_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between COMPARE[5] event and STOP task
                COMPARE5_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                padding: u18,
            }),
            reserved772: [256]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                reserved16: u16,
                ///  Write '1' to Enable interrupt for COMPARE[0] event
                COMPARE0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for COMPARE[1] event
                COMPARE1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for COMPARE[2] event
                COMPARE2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for COMPARE[3] event
                COMPARE3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for COMPARE[4] event
                COMPARE4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for COMPARE[5] event
                COMPARE5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u10,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                reserved16: u16,
                ///  Write '1' to Disable interrupt for COMPARE[0] event
                COMPARE0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for COMPARE[1] event
                COMPARE1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for COMPARE[2] event
                COMPARE2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for COMPARE[3] event
                COMPARE3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for COMPARE[4] event
                COMPARE4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for COMPARE[5] event
                COMPARE5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u10,
            }),
            reserved1284: [504]u8,
            ///  Timer mode selection
            MODE: mmio.Mmio(packed struct(u32) {
                ///  Timer mode
                MODE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Select Timer mode
                        Timer = 0x0,
                        ///  Deprecated enumerator - Select Counter mode
                        Counter = 0x1,
                        ///  Select Low Power Counter mode
                        LowPowerCounter = 0x2,
                        _,
                    },
                },
                padding: u30,
            }),
            ///  Configure the number of bits used by the TIMER
            BITMODE: mmio.Mmio(packed struct(u32) {
                ///  Timer bit width
                BITMODE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  16 bit timer bit width
                        @"16Bit" = 0x0,
                        ///  8 bit timer bit width
                        @"08Bit" = 0x1,
                        ///  24 bit timer bit width
                        @"24Bit" = 0x2,
                        ///  32 bit timer bit width
                        @"32Bit" = 0x3,
                    },
                },
                padding: u30,
            }),
            reserved1296: [4]u8,
            ///  Timer prescaler register
            PRESCALER: mmio.Mmio(packed struct(u32) {
                ///  Prescaler value
                PRESCALER: u4,
                padding: u28,
            }),
            reserved1344: [44]u8,
            ///  Description collection[0]: Capture/Compare register 0
            CC: [6]mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare value
                CC: u32,
            }),
        };

        ///  Non Volatile Memory Controller
        pub const NVMC = extern struct {
            reserved1024: [1024]u8,
            ///  Ready flag
            READY: mmio.Mmio(packed struct(u32) {
                ///  NVMC is ready or busy
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  NVMC is busy (on-going write or erase operation)
                        Busy = 0x0,
                        ///  NVMC is ready
                        Ready = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved1284: [256]u8,
            ///  Configuration register
            CONFIG: mmio.Mmio(packed struct(u32) {
                ///  Program memory access mode. It is strongly recommended to only activate erase and write modes when they are actively used. Enabling write or erase will invalidate the cache and keep it invalidated.
                WEN: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Read only access
                        Ren = 0x0,
                        ///  Write Enabled
                        Wen = 0x1,
                        ///  Erase enabled
                        Een = 0x2,
                        _,
                    },
                },
                padding: u30,
            }),
            ///  Register for erasing a page in Code area
            ERASEPAGE: mmio.Mmio(packed struct(u32) {
                ///  Register for starting erase of a page in Code area
                ERASEPAGE: u32,
            }),
            ///  Register for erasing all non-volatile user memory
            ERASEALL: mmio.Mmio(packed struct(u32) {
                ///  Erase all non-volatile memory including UICR registers. Note that code erase has to be enabled by CONFIG.EEN before the UICR can be erased.
                ERASEALL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  No operation
                        NoOperation = 0x0,
                        ///  Start chip erase
                        Erase = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Deprecated register - Register for erasing a page in Code area. Equivalent to ERASEPAGE.
            ERASEPCR0: mmio.Mmio(packed struct(u32) {
                ///  Register for starting erase of a page in Code area. Equivalent to ERASEPAGE.
                ERASEPCR0: u32,
            }),
            ///  Register for erasing User Information Configuration Registers
            ERASEUICR: mmio.Mmio(packed struct(u32) {
                ///  Register starting erase of all User Information Configuration Registers. Note that code erase has to be enabled by CONFIG.EEN before the UICR can be erased.
                ERASEUICR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  No operation
                        NoOperation = 0x0,
                        ///  Start erase of UICR
                        Erase = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved1344: [40]u8,
            ///  I-Code cache configuration register.
            ICACHECNF: mmio.Mmio(packed struct(u32) {
                ///  Cache enable
                CACHEEN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable cache. Invalidates all cache entries.
                        Disabled = 0x0,
                        ///  Enable cache
                        Enabled = 0x1,
                    },
                },
                reserved8: u7,
                ///  Cache profiling enable
                CACHEPROFEN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable cache profiling
                        Disabled = 0x0,
                        ///  Enable cache profiling
                        Enabled = 0x1,
                    },
                },
                padding: u23,
            }),
            reserved1352: [4]u8,
            ///  I-Code cache hit counter.
            IHIT: mmio.Mmio(packed struct(u32) {
                ///  Number of cache hits
                HITS: u32,
            }),
            ///  I-Code cache miss counter.
            IMISS: mmio.Mmio(packed struct(u32) {
                ///  Number of cache misses
                MISSES: u32,
            }),
        };

        ///  Pulse Density Modulation (Digital Microphone) Interface
        pub const PDM = extern struct {
            ///  Starts continuous PDM transfer
            TASKS_START: u32,
            ///  Stops PDM transfer
            TASKS_STOP: u32,
            reserved256: [248]u8,
            ///  PDM transfer has started
            EVENTS_STARTED: u32,
            ///  PDM transfer has finished
            EVENTS_STOPPED: u32,
            ///  The PDM has written the last sample specified by SAMPLE.MAXCNT (or the last sample after a STOP task has been received) to Data RAM
            EVENTS_END: u32,
            reserved768: [500]u8,
            ///  Enable or disable interrupt
            INTEN: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable interrupt for STARTED event
                STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for END event
                END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                padding: u29,
            }),
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Enable interrupt for STARTED event
                STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for END event
                END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u29,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Disable interrupt for STARTED event
                STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for END event
                END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u29,
            }),
            reserved1280: [500]u8,
            ///  PDM module enable register
            ENABLE: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable PDM module
                ENABLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  PDM clock generator control
            PDMCLKCTRL: mmio.Mmio(packed struct(u32) {
                ///  PDM_CLK frequency
                FREQ: packed union {
                    raw: u32,
                    value: enum(u32) {
                        ///  PDM_CLK = 32 MHz / 32 = 1.000 MHz
                        @"1000K" = 0x8000000,
                        ///  PDM_CLK = 32 MHz / 31 = 1.032 MHz
                        Default = 0x8400000,
                        ///  PDM_CLK = 32 MHz / 30 = 1.067 MHz
                        @"1067K" = 0x8800000,
                        _,
                    },
                },
            }),
            ///  Defines the routing of the connected PDM microphones' signals
            MODE: mmio.Mmio(packed struct(u32) {
                ///  Mono or stereo operation
                OPERATION: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Sample and store one pair (Left + Right) of 16bit samples per RAM word R=[31:16]; L=[15:0]
                        Stereo = 0x0,
                        ///  Sample and store two successive Left samples (16 bit each) per RAM word L1=[31:16]; L0=[15:0]
                        Mono = 0x1,
                    },
                },
                ///  Defines on which PDM_CLK edge Left (or mono) is sampled
                EDGE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Left (or mono) is sampled on falling edge of PDM_CLK
                        LeftFalling = 0x0,
                        ///  Left (or mono) is sampled on rising edge of PDM_CLK
                        LeftRising = 0x1,
                    },
                },
                padding: u30,
            }),
            reserved1304: [12]u8,
            ///  Left output gain adjustment
            GAINL: mmio.Mmio(packed struct(u32) {
                ///  Left output gain adjustment, in 0.5 dB steps, around the default module gain (see electrical parameters) 0x00 -20 dB gain adjust 0x01 -19.5 dB gain adjust (...) 0x27 -0.5 dB gain adjust 0x28 0 dB gain adjust 0x29 +0.5 dB gain adjust (...) 0x4F +19.5 dB gain adjust 0x50 +20 dB gain adjust
                GAINL: packed union {
                    raw: u7,
                    value: enum(u7) {
                        ///  -20dB gain adjustment (minimum)
                        MinGain = 0x0,
                        ///  0dB gain adjustment ('2500 RMS' requirement)
                        DefaultGain = 0x28,
                        ///  +20dB gain adjustment (maximum)
                        MaxGain = 0x50,
                        _,
                    },
                },
                padding: u25,
            }),
            ///  Right output gain adjustment
            GAINR: mmio.Mmio(packed struct(u32) {
                ///  Right output gain adjustment, in 0.5 dB steps, around the default module gain (see electrical parameters)
                GAINR: packed union {
                    raw: u8,
                    value: enum(u8) {
                        ///  -20dB gain adjustment (minimum)
                        MinGain = 0x0,
                        ///  0dB gain adjustment ('2500 RMS' requirement)
                        DefaultGain = 0x28,
                        ///  +20dB gain adjustment (maximum)
                        MaxGain = 0x50,
                        _,
                    },
                },
                padding: u24,
            }),
        };

        ///  Real time counter 0
        pub const RTC0 = extern struct {
            ///  Start RTC COUNTER
            TASKS_START: u32,
            ///  Stop RTC COUNTER
            TASKS_STOP: u32,
            ///  Clear RTC COUNTER
            TASKS_CLEAR: u32,
            ///  Set COUNTER to 0xFFFFF0
            TASKS_TRIGOVRFLW: u32,
            reserved256: [240]u8,
            ///  Event on COUNTER increment
            EVENTS_TICK: u32,
            ///  Event on COUNTER overflow
            EVENTS_OVRFLW: u32,
            reserved320: [56]u8,
            ///  Description collection[0]: Compare event on CC[0] match
            EVENTS_COMPARE: [4]u32,
            reserved772: [436]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Enable interrupt for TICK event
                TICK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for OVRFLW event
                OVRFLW: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved16: u14,
                ///  Write '1' to Enable interrupt for COMPARE[0] event
                COMPARE0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for COMPARE[1] event
                COMPARE1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for COMPARE[2] event
                COMPARE2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for COMPARE[3] event
                COMPARE3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u12,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Disable interrupt for TICK event
                TICK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for OVRFLW event
                OVRFLW: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved16: u14,
                ///  Write '1' to Disable interrupt for COMPARE[0] event
                COMPARE0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for COMPARE[1] event
                COMPARE1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for COMPARE[2] event
                COMPARE2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for COMPARE[3] event
                COMPARE3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u12,
            }),
            reserved832: [52]u8,
            ///  Enable or disable event routing
            EVTEN: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable event routing for TICK event
                TICK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable event routing for OVRFLW event
                OVRFLW: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                reserved16: u14,
                ///  Enable or disable event routing for COMPARE[0] event
                COMPARE0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable event routing for COMPARE[1] event
                COMPARE1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable event routing for COMPARE[2] event
                COMPARE2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable event routing for COMPARE[3] event
                COMPARE3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                padding: u12,
            }),
            ///  Enable event routing
            EVTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Enable event routing for TICK event
                TICK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable event routing for OVRFLW event
                OVRFLW: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved16: u14,
                ///  Write '1' to Enable event routing for COMPARE[0] event
                COMPARE0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable event routing for COMPARE[1] event
                COMPARE1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable event routing for COMPARE[2] event
                COMPARE2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable event routing for COMPARE[3] event
                COMPARE3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u12,
            }),
            ///  Disable event routing
            EVTENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Disable event routing for TICK event
                TICK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable event routing for OVRFLW event
                OVRFLW: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved16: u14,
                ///  Write '1' to Disable event routing for COMPARE[0] event
                COMPARE0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable event routing for COMPARE[1] event
                COMPARE1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable event routing for COMPARE[2] event
                COMPARE2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable event routing for COMPARE[3] event
                COMPARE3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u12,
            }),
            reserved1284: [440]u8,
            ///  Current COUNTER value
            COUNTER: mmio.Mmio(packed struct(u32) {
                ///  Counter value
                COUNTER: u24,
                padding: u8,
            }),
            ///  12 bit prescaler for COUNTER frequency (32768/(PRESCALER+1)).Must be written when RTC is stopped
            PRESCALER: mmio.Mmio(packed struct(u32) {
                ///  Prescaler value
                PRESCALER: u12,
                padding: u20,
            }),
            reserved1344: [52]u8,
            ///  Description collection[0]: Compare register 0
            CC: [4]mmio.Mmio(packed struct(u32) {
                ///  Compare value
                COMPARE: u24,
                padding: u8,
            }),
        };

        ///  Temperature Sensor
        pub const TEMP = extern struct {
            ///  Start temperature measurement
            TASKS_START: u32,
            ///  Stop temperature measurement
            TASKS_STOP: u32,
            reserved256: [248]u8,
            ///  Temperature measurement complete, data ready
            EVENTS_DATARDY: u32,
            reserved772: [512]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Enable interrupt for DATARDY event
                DATARDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Disable interrupt for DATARDY event
                DATARDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved1288: [508]u8,
            ///  Temperature in degC (0.25deg steps)
            TEMP: mmio.Mmio(packed struct(u32) {
                ///  Temperature in degC (0.25deg steps)
                TEMP: u32,
            }),
            reserved1312: [20]u8,
            ///  Slope of 1st piece wise linear function
            A0: mmio.Mmio(packed struct(u32) {
                ///  Slope of 1st piece wise linear function
                A0: u12,
                padding: u20,
            }),
            ///  Slope of 2nd piece wise linear function
            A1: mmio.Mmio(packed struct(u32) {
                ///  Slope of 2nd piece wise linear function
                A1: u12,
                padding: u20,
            }),
            ///  Slope of 3rd piece wise linear function
            A2: mmio.Mmio(packed struct(u32) {
                ///  Slope of 3rd piece wise linear function
                A2: u12,
                padding: u20,
            }),
            ///  Slope of 4th piece wise linear function
            A3: mmio.Mmio(packed struct(u32) {
                ///  Slope of 4th piece wise linear function
                A3: u12,
                padding: u20,
            }),
            ///  Slope of 5th piece wise linear function
            A4: mmio.Mmio(packed struct(u32) {
                ///  Slope of 5th piece wise linear function
                A4: u12,
                padding: u20,
            }),
            ///  Slope of 6th piece wise linear function
            A5: mmio.Mmio(packed struct(u32) {
                ///  Slope of 6th piece wise linear function
                A5: u12,
                padding: u20,
            }),
            reserved1344: [8]u8,
            ///  y-intercept of 1st piece wise linear function
            B0: mmio.Mmio(packed struct(u32) {
                ///  y-intercept of 1st piece wise linear function
                B0: u14,
                padding: u18,
            }),
            ///  y-intercept of 2nd piece wise linear function
            B1: mmio.Mmio(packed struct(u32) {
                ///  y-intercept of 2nd piece wise linear function
                B1: u14,
                padding: u18,
            }),
            ///  y-intercept of 3rd piece wise linear function
            B2: mmio.Mmio(packed struct(u32) {
                ///  y-intercept of 3rd piece wise linear function
                B2: u14,
                padding: u18,
            }),
            ///  y-intercept of 4th piece wise linear function
            B3: mmio.Mmio(packed struct(u32) {
                ///  y-intercept of 4th piece wise linear function
                B3: u14,
                padding: u18,
            }),
            ///  y-intercept of 5th piece wise linear function
            B4: mmio.Mmio(packed struct(u32) {
                ///  y-intercept of 5th piece wise linear function
                B4: u14,
                padding: u18,
            }),
            ///  y-intercept of 6th piece wise linear function
            B5: mmio.Mmio(packed struct(u32) {
                ///  y-intercept of 6th piece wise linear function
                B5: u14,
                padding: u18,
            }),
            reserved1376: [8]u8,
            ///  End point of 1st piece wise linear function
            T0: mmio.Mmio(packed struct(u32) {
                ///  End point of 1st piece wise linear function
                T0: u8,
                padding: u24,
            }),
            ///  End point of 2nd piece wise linear function
            T1: mmio.Mmio(packed struct(u32) {
                ///  End point of 2nd piece wise linear function
                T1: u8,
                padding: u24,
            }),
            ///  End point of 3rd piece wise linear function
            T2: mmio.Mmio(packed struct(u32) {
                ///  End point of 3rd piece wise linear function
                T2: u8,
                padding: u24,
            }),
            ///  End point of 4th piece wise linear function
            T3: mmio.Mmio(packed struct(u32) {
                ///  End point of 4th piece wise linear function
                T3: u8,
                padding: u24,
            }),
            ///  End point of 5th piece wise linear function
            T4: mmio.Mmio(packed struct(u32) {
                ///  End point of 5th piece wise linear function
                T4: u8,
                padding: u24,
            }),
        };

        ///  Random Number Generator
        pub const RNG = extern struct {
            ///  Task starting the random number generator
            TASKS_START: u32,
            ///  Task stopping the random number generator
            TASKS_STOP: u32,
            reserved256: [248]u8,
            ///  Event being generated for every new random number written to the VALUE register
            EVENTS_VALRDY: u32,
            reserved512: [252]u8,
            ///  Shortcut register
            SHORTS: mmio.Mmio(packed struct(u32) {
                ///  Shortcut between VALRDY event and STOP task
                VALRDY_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved772: [256]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Enable interrupt for VALRDY event
                VALRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Disable interrupt for VALRDY event
                VALRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved1284: [504]u8,
            ///  Configuration register
            CONFIG: mmio.Mmio(packed struct(u32) {
                ///  Bias correction
                DERCEN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disabled
                        Disabled = 0x0,
                        ///  Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Output random number
            VALUE: mmio.Mmio(packed struct(u32) {
                ///  Generated random number
                VALUE: u8,
                padding: u24,
            }),
        };

        ///  AES ECB Mode Encryption
        pub const ECB = extern struct {
            ///  Start ECB block encrypt
            TASKS_STARTECB: u32,
            ///  Abort a possible executing ECB operation
            TASKS_STOPECB: u32,
            reserved256: [248]u8,
            ///  ECB block encrypt complete
            EVENTS_ENDECB: u32,
            ///  ECB block encrypt aborted because of a STOPECB task or due to an error
            EVENTS_ERRORECB: u32,
            reserved772: [508]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Enable interrupt for ENDECB event
                ENDECB: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for ERRORECB event
                ERRORECB: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u30,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Disable interrupt for ENDECB event
                ENDECB: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for ERRORECB event
                ERRORECB: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u30,
            }),
            reserved1284: [504]u8,
            ///  ECB block encrypt memory pointers
            ECBDATAPTR: mmio.Mmio(packed struct(u32) {
                ///  Pointer to the ECB data structure (see Table 1 ECB data structure overview)
                ECBDATAPTR: u32,
            }),
        };

        ///  AES CCM Mode Encryption
        pub const CCM = extern struct {
            ///  Start generation of key-stream. This operation will stop by itself when completed.
            TASKS_KSGEN: u32,
            ///  Start encryption/decryption. This operation will stop by itself when completed.
            TASKS_CRYPT: u32,
            ///  Stop encryption/decryption
            TASKS_STOP: u32,
            reserved256: [244]u8,
            ///  Key-stream generation complete
            EVENTS_ENDKSGEN: u32,
            ///  Encrypt/decrypt complete
            EVENTS_ENDCRYPT: u32,
            ///  CCM error event
            EVENTS_ERROR: u32,
            reserved512: [244]u8,
            ///  Shortcut register
            SHORTS: mmio.Mmio(packed struct(u32) {
                ///  Shortcut between ENDKSGEN event and CRYPT task
                ENDKSGEN_CRYPT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved772: [256]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Enable interrupt for ENDKSGEN event
                ENDKSGEN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for ENDCRYPT event
                ENDCRYPT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for ERROR event
                ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u29,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Disable interrupt for ENDKSGEN event
                ENDKSGEN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for ENDCRYPT event
                ENDCRYPT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for ERROR event
                ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u29,
            }),
            reserved1024: [244]u8,
            ///  MIC check result
            MICSTATUS: mmio.Mmio(packed struct(u32) {
                ///  The result of the MIC check performed during the previous decryption operation
                MICSTATUS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  MIC check failed
                        CheckFailed = 0x0,
                        ///  MIC check passed
                        CheckPassed = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved1280: [252]u8,
            ///  Enable
            ENABLE: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable CCM
                ENABLE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x2,
                        _,
                    },
                },
                padding: u30,
            }),
            ///  Operation mode
            MODE: mmio.Mmio(packed struct(u32) {
                ///  The mode of operation to be used
                MODE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  AES CCM packet encryption mode
                        Encryption = 0x0,
                        ///  AES CCM packet decryption mode
                        Decryption = 0x1,
                    },
                },
                reserved16: u15,
                ///  Data rate that the CCM shall run in synch with
                DATARATE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  In synch with 1 Mbit data rate
                        @"1Mbit" = 0x0,
                        ///  In synch with 2 Mbit data rate
                        @"2Mbit" = 0x1,
                    },
                },
                reserved24: u7,
                ///  Packet length configuration
                LENGTH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Default length. Effective length of LENGTH field is 5-bit
                        Default = 0x0,
                        ///  Extended length. Effective length of LENGTH field is 8-bit
                        Extended = 0x1,
                    },
                },
                padding: u7,
            }),
            ///  Pointer to data structure holding AES key and NONCE vector
            CNFPTR: mmio.Mmio(packed struct(u32) {
                ///  Pointer to the data structure holding the AES key and the CCM NONCE vector (see Table 1 CCM data structure overview)
                CNFPTR: u32,
            }),
            ///  Input pointer
            INPTR: mmio.Mmio(packed struct(u32) {
                ///  Input pointer
                INPTR: u32,
            }),
            ///  Output pointer
            OUTPTR: mmio.Mmio(packed struct(u32) {
                ///  Output pointer
                OUTPTR: u32,
            }),
            ///  Pointer to data area used for temporary storage
            SCRATCHPTR: mmio.Mmio(packed struct(u32) {
                ///  Pointer to a scratch data area used for temporary storage during key-stream generation, MIC generation and encryption/decryption.
                SCRATCHPTR: u32,
            }),
        };

        ///  Accelerated Address Resolver
        pub const AAR = extern struct {
            ///  Start resolving addresses based on IRKs specified in the IRK data structure
            TASKS_START: u32,
            reserved8: [4]u8,
            ///  Stop resolving addresses
            TASKS_STOP: u32,
            reserved256: [244]u8,
            ///  Address resolution procedure complete
            EVENTS_END: u32,
            ///  Address resolved
            EVENTS_RESOLVED: u32,
            ///  Address not resolved
            EVENTS_NOTRESOLVED: u32,
            reserved772: [504]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Enable interrupt for END event
                END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for RESOLVED event
                RESOLVED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for NOTRESOLVED event
                NOTRESOLVED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u29,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Disable interrupt for END event
                END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for RESOLVED event
                RESOLVED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for NOTRESOLVED event
                NOTRESOLVED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u29,
            }),
            reserved1024: [244]u8,
            ///  Resolution status
            STATUS: mmio.Mmio(packed struct(u32) {
                ///  The IRK that was used last time an address was resolved
                STATUS: u4,
                padding: u28,
            }),
            reserved1280: [252]u8,
            ///  Enable AAR
            ENABLE: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable AAR
                ENABLE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x3,
                        _,
                    },
                },
                padding: u30,
            }),
            ///  Number of IRKs
            NIRK: mmio.Mmio(packed struct(u32) {
                ///  Number of Identity root keys available in the IRK data structure
                NIRK: u5,
                padding: u27,
            }),
            ///  Pointer to IRK data structure
            IRKPTR: mmio.Mmio(packed struct(u32) {
                ///  Pointer to the IRK data structure
                IRKPTR: u32,
            }),
            reserved1296: [4]u8,
            ///  Pointer to the resolvable address
            ADDRPTR: mmio.Mmio(packed struct(u32) {
                ///  Pointer to the resolvable address (6-bytes)
                ADDRPTR: u32,
            }),
            ///  Pointer to data area used for temporary storage
            SCRATCHPTR: mmio.Mmio(packed struct(u32) {
                ///  Pointer to a scratch data area used for temporary storage during resolution.A space of minimum 3 bytes must be reserved.
                SCRATCHPTR: u32,
            }),
        };

        ///  Watchdog Timer
        pub const WDT = extern struct {
            ///  Start the watchdog
            TASKS_START: u32,
            reserved256: [252]u8,
            ///  Watchdog timeout
            EVENTS_TIMEOUT: u32,
            reserved772: [512]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Enable interrupt for TIMEOUT event
                TIMEOUT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Disable interrupt for TIMEOUT event
                TIMEOUT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved1024: [244]u8,
            ///  Run status
            RUNSTATUS: mmio.Mmio(packed struct(u32) {
                ///  Indicates whether or not the watchdog is running
                RUNSTATUS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Watchdog not running
                        NotRunning = 0x0,
                        ///  Watchdog is running
                        Running = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Request status
            REQSTATUS: mmio.Mmio(packed struct(u32) {
                ///  Request status for RR[0] register
                RR0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  RR[0] register is not enabled, or are already requesting reload
                        DisabledOrRequested = 0x0,
                        ///  RR[0] register is enabled, and are not yet requesting reload
                        EnabledAndUnrequested = 0x1,
                    },
                },
                ///  Request status for RR[1] register
                RR1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  RR[1] register is not enabled, or are already requesting reload
                        DisabledOrRequested = 0x0,
                        ///  RR[1] register is enabled, and are not yet requesting reload
                        EnabledAndUnrequested = 0x1,
                    },
                },
                ///  Request status for RR[2] register
                RR2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  RR[2] register is not enabled, or are already requesting reload
                        DisabledOrRequested = 0x0,
                        ///  RR[2] register is enabled, and are not yet requesting reload
                        EnabledAndUnrequested = 0x1,
                    },
                },
                ///  Request status for RR[3] register
                RR3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  RR[3] register is not enabled, or are already requesting reload
                        DisabledOrRequested = 0x0,
                        ///  RR[3] register is enabled, and are not yet requesting reload
                        EnabledAndUnrequested = 0x1,
                    },
                },
                ///  Request status for RR[4] register
                RR4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  RR[4] register is not enabled, or are already requesting reload
                        DisabledOrRequested = 0x0,
                        ///  RR[4] register is enabled, and are not yet requesting reload
                        EnabledAndUnrequested = 0x1,
                    },
                },
                ///  Request status for RR[5] register
                RR5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  RR[5] register is not enabled, or are already requesting reload
                        DisabledOrRequested = 0x0,
                        ///  RR[5] register is enabled, and are not yet requesting reload
                        EnabledAndUnrequested = 0x1,
                    },
                },
                ///  Request status for RR[6] register
                RR6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  RR[6] register is not enabled, or are already requesting reload
                        DisabledOrRequested = 0x0,
                        ///  RR[6] register is enabled, and are not yet requesting reload
                        EnabledAndUnrequested = 0x1,
                    },
                },
                ///  Request status for RR[7] register
                RR7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  RR[7] register is not enabled, or are already requesting reload
                        DisabledOrRequested = 0x0,
                        ///  RR[7] register is enabled, and are not yet requesting reload
                        EnabledAndUnrequested = 0x1,
                    },
                },
                padding: u24,
            }),
            reserved1284: [252]u8,
            ///  Counter reload value
            CRV: mmio.Mmio(packed struct(u32) {
                ///  Counter reload value in number of cycles of the 32.768 kHz clock
                CRV: u32,
            }),
            ///  Enable register for reload request registers
            RREN: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable RR[0] register
                RR0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable RR[0] register
                        Disabled = 0x0,
                        ///  Enable RR[0] register
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable RR[1] register
                RR1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable RR[1] register
                        Disabled = 0x0,
                        ///  Enable RR[1] register
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable RR[2] register
                RR2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable RR[2] register
                        Disabled = 0x0,
                        ///  Enable RR[2] register
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable RR[3] register
                RR3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable RR[3] register
                        Disabled = 0x0,
                        ///  Enable RR[3] register
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable RR[4] register
                RR4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable RR[4] register
                        Disabled = 0x0,
                        ///  Enable RR[4] register
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable RR[5] register
                RR5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable RR[5] register
                        Disabled = 0x0,
                        ///  Enable RR[5] register
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable RR[6] register
                RR6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable RR[6] register
                        Disabled = 0x0,
                        ///  Enable RR[6] register
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable RR[7] register
                RR7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable RR[7] register
                        Disabled = 0x0,
                        ///  Enable RR[7] register
                        Enabled = 0x1,
                    },
                },
                padding: u24,
            }),
            ///  Configuration register
            CONFIG: mmio.Mmio(packed struct(u32) {
                ///  Configure the watchdog to either be paused, or kept running, while the CPU is sleeping
                SLEEP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pause watchdog while the CPU is sleeping
                        Pause = 0x0,
                        ///  Keep the watchdog running while the CPU is sleeping
                        Run = 0x1,
                    },
                },
                reserved3: u2,
                ///  Configure the watchdog to either be paused, or kept running, while the CPU is halted by the debugger
                HALT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pause watchdog while the CPU is halted by the debugger
                        Pause = 0x0,
                        ///  Keep the watchdog running while the CPU is halted by the debugger
                        Run = 0x1,
                    },
                },
                padding: u28,
            }),
            reserved1536: [240]u8,
            ///  Description collection[0]: Reload request 0
            RR: [8]mmio.Mmio(packed struct(u32) {
                ///  Reload request register
                RR: packed union {
                    raw: u32,
                    value: enum(u32) {
                        ///  Value to request a reload of the watchdog timer
                        Reload = 0x6e524635,
                        _,
                    },
                },
            }),
        };

        ///  Pulse Width Modulation Unit 0
        pub const PWM0 = extern struct {
            reserved4: [4]u8,
            ///  Stops PWM pulse generation on all channels at the end of current PWM period, and stops sequence playback
            TASKS_STOP: u32,
            ///  Description collection[0]: Loads the first PWM value on all enabled channels from sequence 0, and starts playing that sequence at the rate defined in SEQ[0]REFRESH and/or DECODER.MODE. Causes PWM generation to start it was not running.
            TASKS_SEQSTART: [2]u32,
            ///  Steps by one value in the current sequence on all enabled channels if DECODER.MODE=NextStep. Does not cause PWM generation to start it was not running.
            TASKS_NEXTSTEP: u32,
            reserved260: [240]u8,
            ///  Response to STOP task, emitted when PWM pulses are no longer generated
            EVENTS_STOPPED: u32,
            ///  Description collection[0]: First PWM period started on sequence 0
            EVENTS_SEQSTARTED: [2]u32,
            ///  Description collection[0]: Emitted at end of every sequence 0, when last value from RAM has been applied to wave counter
            EVENTS_SEQEND: [2]u32,
            ///  Emitted at the end of each PWM period
            EVENTS_PWMPERIODEND: u32,
            ///  Concatenated sequences have been played the amount of times defined in LOOP.CNT
            EVENTS_LOOPSDONE: u32,
            reserved512: [224]u8,
            ///  Shortcut register
            SHORTS: mmio.Mmio(packed struct(u32) {
                ///  Shortcut between SEQEND[0] event and STOP task
                SEQEND0_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between SEQEND[1] event and STOP task
                SEQEND1_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between LOOPSDONE event and SEQSTART[0] task
                LOOPSDONE_SEQSTART0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between LOOPSDONE event and SEQSTART[1] task
                LOOPSDONE_SEQSTART1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between LOOPSDONE event and STOP task
                LOOPSDONE_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                padding: u27,
            }),
            reserved768: [252]u8,
            ///  Enable or disable interrupt
            INTEN: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Enable or disable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for SEQSTARTED[0] event
                SEQSTARTED0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for SEQSTARTED[1] event
                SEQSTARTED1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for SEQEND[0] event
                SEQEND0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for SEQEND[1] event
                SEQEND1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for PWMPERIODEND event
                PWMPERIODEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for LOOPSDONE event
                LOOPSDONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                padding: u24,
            }),
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Write '1' to Enable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for SEQSTARTED[0] event
                SEQSTARTED0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for SEQSTARTED[1] event
                SEQSTARTED1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for SEQEND[0] event
                SEQEND0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for SEQEND[1] event
                SEQEND1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for PWMPERIODEND event
                PWMPERIODEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for LOOPSDONE event
                LOOPSDONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u24,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Write '1' to Disable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for SEQSTARTED[0] event
                SEQSTARTED0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for SEQSTARTED[1] event
                SEQSTARTED1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for SEQEND[0] event
                SEQEND0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for SEQEND[1] event
                SEQEND1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for PWMPERIODEND event
                PWMPERIODEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for LOOPSDONE event
                LOOPSDONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u24,
            }),
            reserved1280: [500]u8,
            ///  PWM module enable register
            ENABLE: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable PWM module
                ENABLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disabled
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Selects operating mode of the wave counter
            MODE: mmio.Mmio(packed struct(u32) {
                ///  Selects up or up and down as wave counter mode
                UPDOWN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Up counter - edge aligned PWM duty-cycle
                        Up = 0x0,
                        ///  Up and down counter - center aligned PWM duty cycle
                        UpAndDown = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Value up to which the pulse generator counter counts
            COUNTERTOP: mmio.Mmio(packed struct(u32) {
                ///  Value up to which the pulse generator counter counts. This register is ignored when DECODER.MODE=WaveForm and only values from RAM will be used.
                COUNTERTOP: u15,
                padding: u17,
            }),
            ///  Configuration for PWM_CLK
            PRESCALER: mmio.Mmio(packed struct(u32) {
                ///  Pre-scaler of PWM_CLK
                PRESCALER: packed union {
                    raw: u3,
                    value: enum(u3) {
                        ///  Divide by 1 (16MHz)
                        DIV_1 = 0x0,
                        ///  Divide by 2 ( 8MHz)
                        DIV_2 = 0x1,
                        ///  Divide by 4 ( 4MHz)
                        DIV_4 = 0x2,
                        ///  Divide by 8 ( 2MHz)
                        DIV_8 = 0x3,
                        ///  Divide by 16 ( 1MHz)
                        DIV_16 = 0x4,
                        ///  Divide by 32 ( 500kHz)
                        DIV_32 = 0x5,
                        ///  Divide by 64 ( 250kHz)
                        DIV_64 = 0x6,
                        ///  Divide by 128 ( 125kHz)
                        DIV_128 = 0x7,
                    },
                },
                padding: u29,
            }),
            ///  Configuration of the decoder
            DECODER: mmio.Mmio(packed struct(u32) {
                ///  How a sequence is read from RAM and spread to the compare register
                LOAD: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  1st half word (16-bit) used in all PWM channels 0..3
                        Common = 0x0,
                        ///  1st half word (16-bit) used in channel 0..1; 2nd word in channel 2..3
                        Grouped = 0x1,
                        ///  1st half word (16-bit) in ch.0; 2nd in ch.1; ...; 4th in ch.3
                        Individual = 0x2,
                        ///  1st half word (16-bit) in ch.0; 2nd in ch.1; ...; 4th in COUNTERTOP
                        WaveForm = 0x3,
                    },
                },
                reserved8: u6,
                ///  Selects source for advancing the active sequence
                MODE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  SEQ[n].REFRESH is used to determine loading internal compare registers
                        RefreshCount = 0x0,
                        ///  NEXTSTEP task causes a new value to be loaded to internal compare registers
                        NextStep = 0x1,
                    },
                },
                padding: u23,
            }),
            ///  Amount of playback of a loop
            LOOP: mmio.Mmio(packed struct(u32) {
                ///  Amount of playback of pattern cycles
                CNT: packed union {
                    raw: u16,
                    value: enum(u16) {
                        ///  Looping disabled (stop at the end of the sequence)
                        Disabled = 0x0,
                        _,
                    },
                },
                padding: u16,
            }),
        };

        ///  Quadrature Decoder
        pub const QDEC = extern struct {
            ///  Task starting the quadrature decoder
            TASKS_START: u32,
            ///  Task stopping the quadrature decoder
            TASKS_STOP: u32,
            ///  Read and clear ACC and ACCDBL
            TASKS_READCLRACC: u32,
            ///  Read and clear ACC
            TASKS_RDCLRACC: u32,
            ///  Read and clear ACCDBL
            TASKS_RDCLRDBL: u32,
            reserved256: [236]u8,
            ///  Event being generated for every new sample value written to the SAMPLE register
            EVENTS_SAMPLERDY: u32,
            ///  Non-null report ready
            EVENTS_REPORTRDY: u32,
            ///  ACC or ACCDBL register overflow
            EVENTS_ACCOF: u32,
            ///  Double displacement(s) detected
            EVENTS_DBLRDY: u32,
            ///  QDEC has been stopped
            EVENTS_STOPPED: u32,
            reserved512: [236]u8,
            ///  Shortcut register
            SHORTS: mmio.Mmio(packed struct(u32) {
                ///  Shortcut between REPORTRDY event and READCLRACC task
                REPORTRDY_READCLRACC: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between SAMPLERDY event and STOP task
                SAMPLERDY_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between REPORTRDY event and RDCLRACC task
                REPORTRDY_RDCLRACC: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between REPORTRDY event and STOP task
                REPORTRDY_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between DBLRDY event and RDCLRDBL task
                DBLRDY_RDCLRDBL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between DBLRDY event and STOP task
                DBLRDY_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between SAMPLERDY event and READCLRACC task
                SAMPLERDY_READCLRACC: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                padding: u25,
            }),
            reserved772: [256]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Enable interrupt for SAMPLERDY event
                SAMPLERDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for REPORTRDY event
                REPORTRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for ACCOF event
                ACCOF: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for DBLRDY event
                DBLRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u27,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Disable interrupt for SAMPLERDY event
                SAMPLERDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for REPORTRDY event
                REPORTRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for ACCOF event
                ACCOF: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for DBLRDY event
                DBLRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for STOPPED event
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u27,
            }),
            reserved1280: [500]u8,
            ///  Enable the quadrature decoder
            ENABLE: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable the quadrature decoder
                ENABLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  LED output pin polarity
            LEDPOL: mmio.Mmio(packed struct(u32) {
                ///  LED output pin polarity
                LEDPOL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Led active on output pin low
                        ActiveLow = 0x0,
                        ///  Led active on output pin high
                        ActiveHigh = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Sample period
            SAMPLEPER: mmio.Mmio(packed struct(u32) {
                ///  Sample period. The SAMPLE register will be updated for every new sample
                SAMPLEPER: packed union {
                    raw: u4,
                    value: enum(u4) {
                        ///  128 us
                        @"128us" = 0x0,
                        ///  256 us
                        @"256us" = 0x1,
                        ///  512 us
                        @"512us" = 0x2,
                        ///  1024 us
                        @"1024us" = 0x3,
                        ///  2048 us
                        @"2048us" = 0x4,
                        ///  4096 us
                        @"4096us" = 0x5,
                        ///  8192 us
                        @"8192us" = 0x6,
                        ///  16384 us
                        @"16384us" = 0x7,
                        ///  32768 us
                        @"32ms" = 0x8,
                        ///  65536 us
                        @"65ms" = 0x9,
                        ///  131072 us
                        @"131ms" = 0xa,
                        _,
                    },
                },
                padding: u28,
            }),
            ///  Motion sample value
            SAMPLE: mmio.Mmio(packed struct(u32) {
                ///  Last motion sample
                SAMPLE: u32,
            }),
            ///  Number of samples to be taken before REPORTRDY and DBLRDY events can be generated
            REPORTPER: mmio.Mmio(packed struct(u32) {
                ///  Specifies the number of samples to be accumulated in the ACC register before the REPORTRDY and DBLRDY events can be generated
                REPORTPER: packed union {
                    raw: u4,
                    value: enum(u4) {
                        ///  10 samples / report
                        @"10Smpl" = 0x0,
                        ///  40 samples / report
                        @"40Smpl" = 0x1,
                        ///  80 samples / report
                        @"80Smpl" = 0x2,
                        ///  120 samples / report
                        @"120Smpl" = 0x3,
                        ///  160 samples / report
                        @"160Smpl" = 0x4,
                        ///  200 samples / report
                        @"200Smpl" = 0x5,
                        ///  240 samples / report
                        @"240Smpl" = 0x6,
                        ///  280 samples / report
                        @"280Smpl" = 0x7,
                        ///  1 sample / report
                        @"1Smpl" = 0x8,
                        _,
                    },
                },
                padding: u28,
            }),
            ///  Register accumulating the valid transitions
            ACC: mmio.Mmio(packed struct(u32) {
                ///  Register accumulating all valid samples (not double transition) read from the SAMPLE register
                ACC: u32,
            }),
            ///  Snapshot of the ACC register, updated by the READCLRACC or RDCLRACC task
            ACCREAD: mmio.Mmio(packed struct(u32) {
                ///  Snapshot of the ACC register.
                ACCREAD: u32,
            }),
            reserved1320: [12]u8,
            ///  Enable input debounce filters
            DBFEN: mmio.Mmio(packed struct(u32) {
                ///  Enable input debounce filters
                DBFEN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Debounce input filters disabled
                        Disabled = 0x0,
                        ///  Debounce input filters enabled
                        Enabled = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved1344: [20]u8,
            ///  Time period the LED is switched ON prior to sampling
            LEDPRE: mmio.Mmio(packed struct(u32) {
                ///  Period in us the LED is switched on prior to sampling
                LEDPRE: u9,
                padding: u23,
            }),
            ///  Register accumulating the number of detected double transitions
            ACCDBL: mmio.Mmio(packed struct(u32) {
                ///  Register accumulating the number of detected double or illegal transitions. ( SAMPLE = 2 ).
                ACCDBL: u4,
                padding: u28,
            }),
            ///  Snapshot of the ACCDBL, updated by the READCLRACC or RDCLRDBL task
            ACCDBLREAD: mmio.Mmio(packed struct(u32) {
                ///  Snapshot of the ACCDBL register. This field is updated when the READCLRACC or RDCLRDBL task is triggered.
                ACCDBLREAD: u4,
                padding: u28,
            }),
        };

        ///  Comparator
        pub const COMP = extern struct {
            ///  Start comparator
            TASKS_START: u32,
            ///  Stop comparator
            TASKS_STOP: u32,
            ///  Sample comparator value
            TASKS_SAMPLE: u32,
            reserved256: [244]u8,
            ///  COMP is ready and output is valid
            EVENTS_READY: u32,
            ///  Downward crossing
            EVENTS_DOWN: u32,
            ///  Upward crossing
            EVENTS_UP: u32,
            ///  Downward or upward crossing
            EVENTS_CROSS: u32,
            reserved512: [240]u8,
            ///  Shortcut register
            SHORTS: mmio.Mmio(packed struct(u32) {
                ///  Shortcut between READY event and SAMPLE task
                READY_SAMPLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between READY event and STOP task
                READY_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between DOWN event and STOP task
                DOWN_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between UP event and STOP task
                UP_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between CROSS event and STOP task
                CROSS_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                padding: u27,
            }),
            reserved768: [252]u8,
            ///  Enable or disable interrupt
            INTEN: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable interrupt for READY event
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for DOWN event
                DOWN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for UP event
                UP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for CROSS event
                CROSS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                padding: u28,
            }),
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Enable interrupt for READY event
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for DOWN event
                DOWN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for UP event
                UP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for CROSS event
                CROSS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u28,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Disable interrupt for READY event
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for DOWN event
                DOWN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for UP event
                UP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for CROSS event
                CROSS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u28,
            }),
            reserved1024: [244]u8,
            ///  Compare result
            RESULT: mmio.Mmio(packed struct(u32) {
                ///  Result of last compare. Decision point SAMPLE task.
                RESULT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Input voltage is below the threshold (VIN+ &lt; VIN-)
                        Below = 0x0,
                        ///  Input voltage is above the threshold (VIN+ &gt; VIN-)
                        Above = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved1280: [252]u8,
            ///  COMP enable
            ENABLE: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable COMP
                ENABLE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x2,
                        _,
                    },
                },
                padding: u30,
            }),
            ///  Pin select
            PSEL: mmio.Mmio(packed struct(u32) {
                ///  Analog pin select
                PSEL: packed union {
                    raw: u3,
                    value: enum(u3) {
                        ///  AIN0 selected as analog input
                        AnalogInput0 = 0x0,
                        ///  AIN1 selected as analog input
                        AnalogInput1 = 0x1,
                        ///  AIN2 selected as analog input
                        AnalogInput2 = 0x2,
                        ///  AIN3 selected as analog input
                        AnalogInput3 = 0x3,
                        ///  AIN4 selected as analog input
                        AnalogInput4 = 0x4,
                        ///  AIN5 selected as analog input
                        AnalogInput5 = 0x5,
                        ///  AIN6 selected as analog input
                        AnalogInput6 = 0x6,
                        ///  AIN7 selected as analog input
                        AnalogInput7 = 0x7,
                    },
                },
                padding: u29,
            }),
            ///  Reference source select for single-ended mode
            REFSEL: mmio.Mmio(packed struct(u32) {
                ///  Reference select
                REFSEL: packed union {
                    raw: u3,
                    value: enum(u3) {
                        ///  VREF = internal 1.2 V reference (VDD &gt;= 1.7 V)
                        Int1V2 = 0x0,
                        ///  VREF = internal 1.8 V reference (VDD &gt;= VREF + 0.2 V)
                        Int1V8 = 0x1,
                        ///  VREF = internal 2.4 V reference (VDD &gt;= VREF + 0.2 V)
                        Int2V4 = 0x2,
                        ///  VREF = VDD
                        VDD = 0x4,
                        ///  VREF = AREF (VDD &gt;= VREF &gt;= AREFMIN)
                        ARef = 0x7,
                        _,
                    },
                },
                padding: u29,
            }),
            ///  External reference select
            EXTREFSEL: mmio.Mmio(packed struct(u32) {
                ///  External analog reference select
                EXTREFSEL: packed union {
                    raw: u3,
                    value: enum(u3) {
                        ///  Use AIN0 as external analog reference
                        AnalogReference0 = 0x0,
                        ///  Use AIN1 as external analog reference
                        AnalogReference1 = 0x1,
                        ///  Use AIN2 as external analog reference
                        AnalogReference2 = 0x2,
                        ///  Use AIN3 as external analog reference
                        AnalogReference3 = 0x3,
                        ///  Use AIN4 as external analog reference
                        AnalogReference4 = 0x4,
                        ///  Use AIN5 as external analog reference
                        AnalogReference5 = 0x5,
                        ///  Use AIN6 as external analog reference
                        AnalogReference6 = 0x6,
                        ///  Use AIN7 as external analog reference
                        AnalogReference7 = 0x7,
                    },
                },
                padding: u29,
            }),
            reserved1328: [32]u8,
            ///  Threshold configuration for hysteresis unit
            TH: mmio.Mmio(packed struct(u32) {
                ///  VDOWN = (THDOWN+1)/64*VREF
                THDOWN: u6,
                reserved8: u2,
                ///  VUP = (THUP+1)/64*VREF
                THUP: u6,
                padding: u18,
            }),
            ///  Mode configuration
            MODE: mmio.Mmio(packed struct(u32) {
                ///  Speed and power modes
                SP: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Low-power mode
                        Low = 0x0,
                        ///  Normal mode
                        Normal = 0x1,
                        ///  High-speed mode
                        High = 0x2,
                        _,
                    },
                },
                reserved8: u6,
                ///  Main operation modes
                MAIN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Single-ended mode
                        SE = 0x0,
                        ///  Differential mode
                        Diff = 0x1,
                    },
                },
                padding: u23,
            }),
            ///  Comparator hysteresis enable
            HYST: mmio.Mmio(packed struct(u32) {
                ///  Comparator hysteresis
                HYST: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Comparator hysteresis disabled
                        NoHyst = 0x0,
                        ///  Comparator hysteresis enabled
                        Hyst50mV = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Current source select on analog input
            ISOURCE: mmio.Mmio(packed struct(u32) {
                ///  Comparator hysteresis
                ISOURCE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Current source disabled
                        Off = 0x0,
                        ///  Current source enabled (+/- 2.5 uA)
                        Ien2mA5 = 0x1,
                        ///  Current source enabled (+/- 5 uA)
                        Ien5mA = 0x2,
                        ///  Current source enabled (+/- 10 uA)
                        Ien10mA = 0x3,
                    },
                },
                padding: u30,
            }),
        };

        ///  Low Power Comparator
        pub const LPCOMP = extern struct {
            ///  Start comparator
            TASKS_START: u32,
            ///  Stop comparator
            TASKS_STOP: u32,
            ///  Sample comparator value
            TASKS_SAMPLE: u32,
            reserved256: [244]u8,
            ///  LPCOMP is ready and output is valid
            EVENTS_READY: u32,
            ///  Downward crossing
            EVENTS_DOWN: u32,
            ///  Upward crossing
            EVENTS_UP: u32,
            ///  Downward or upward crossing
            EVENTS_CROSS: u32,
            reserved512: [240]u8,
            ///  Shortcut register
            SHORTS: mmio.Mmio(packed struct(u32) {
                ///  Shortcut between READY event and SAMPLE task
                READY_SAMPLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between READY event and STOP task
                READY_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between DOWN event and STOP task
                DOWN_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between UP event and STOP task
                UP_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between CROSS event and STOP task
                CROSS_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                padding: u27,
            }),
            reserved772: [256]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Enable interrupt for READY event
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for DOWN event
                DOWN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for UP event
                UP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Enable interrupt for CROSS event
                CROSS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u28,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to Disable interrupt for READY event
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for DOWN event
                DOWN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for UP event
                UP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to Disable interrupt for CROSS event
                CROSS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u28,
            }),
            reserved1024: [244]u8,
            ///  Compare result
            RESULT: mmio.Mmio(packed struct(u32) {
                ///  Result of last compare. Decision point SAMPLE task.
                RESULT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Input voltage is below the reference threshold (VIN+ &lt; VIN-).
                        Below = 0x0,
                        ///  Input voltage is above the reference threshold (VIN+ &gt; VIN-).
                        Above = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved1280: [252]u8,
            ///  Enable LPCOMP
            ENABLE: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable LPCOMP
                ENABLE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                        _,
                    },
                },
                padding: u30,
            }),
            ///  Input pin select
            PSEL: mmio.Mmio(packed struct(u32) {
                ///  Analog pin select
                PSEL: packed union {
                    raw: u3,
                    value: enum(u3) {
                        ///  AIN0 selected as analog input
                        AnalogInput0 = 0x0,
                        ///  AIN1 selected as analog input
                        AnalogInput1 = 0x1,
                        ///  AIN2 selected as analog input
                        AnalogInput2 = 0x2,
                        ///  AIN3 selected as analog input
                        AnalogInput3 = 0x3,
                        ///  AIN4 selected as analog input
                        AnalogInput4 = 0x4,
                        ///  AIN5 selected as analog input
                        AnalogInput5 = 0x5,
                        ///  AIN6 selected as analog input
                        AnalogInput6 = 0x6,
                        ///  AIN7 selected as analog input
                        AnalogInput7 = 0x7,
                    },
                },
                padding: u29,
            }),
            ///  Reference select
            REFSEL: mmio.Mmio(packed struct(u32) {
                ///  Reference select
                REFSEL: packed union {
                    raw: u4,
                    value: enum(u4) {
                        ///  VDD * 1/8 selected as reference
                        Ref1_8Vdd = 0x0,
                        ///  VDD * 2/8 selected as reference
                        Ref2_8Vdd = 0x1,
                        ///  VDD * 3/8 selected as reference
                        Ref3_8Vdd = 0x2,
                        ///  VDD * 4/8 selected as reference
                        Ref4_8Vdd = 0x3,
                        ///  VDD * 5/8 selected as reference
                        Ref5_8Vdd = 0x4,
                        ///  VDD * 6/8 selected as reference
                        Ref6_8Vdd = 0x5,
                        ///  VDD * 7/8 selected as reference
                        Ref7_8Vdd = 0x6,
                        ///  External analog reference selected
                        ARef = 0x7,
                        ///  VDD * 1/16 selected as reference
                        Ref1_16Vdd = 0x8,
                        ///  VDD * 3/16 selected as reference
                        Ref3_16Vdd = 0x9,
                        ///  VDD * 5/16 selected as reference
                        Ref5_16Vdd = 0xa,
                        ///  VDD * 7/16 selected as reference
                        Ref7_16Vdd = 0xb,
                        ///  VDD * 9/16 selected as reference
                        Ref9_16Vdd = 0xc,
                        ///  VDD * 11/16 selected as reference
                        Ref11_16Vdd = 0xd,
                        ///  VDD * 13/16 selected as reference
                        Ref13_16Vdd = 0xe,
                        ///  VDD * 15/16 selected as reference
                        Ref15_16Vdd = 0xf,
                    },
                },
                padding: u28,
            }),
            ///  External reference select
            EXTREFSEL: mmio.Mmio(packed struct(u32) {
                ///  External analog reference select
                EXTREFSEL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Use AIN0 as external analog reference
                        AnalogReference0 = 0x0,
                        ///  Use AIN1 as external analog reference
                        AnalogReference1 = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved1312: [16]u8,
            ///  Analog detect configuration
            ANADETECT: mmio.Mmio(packed struct(u32) {
                ///  Analog detect configuration
                ANADETECT: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Generate ANADETECT on crossing, both upward crossing and downward crossing
                        Cross = 0x0,
                        ///  Generate ANADETECT on upward crossing only
                        Up = 0x1,
                        ///  Generate ANADETECT on downward crossing only
                        Down = 0x2,
                        _,
                    },
                },
                padding: u30,
            }),
            reserved1336: [20]u8,
            ///  Comparator hysteresis enable
            HYST: mmio.Mmio(packed struct(u32) {
                ///  Comparator hysteresis enable
                HYST: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Comparator hysteresis disabled
                        NoHyst = 0x0,
                        ///  Comparator hysteresis disabled (typ. 50 mV)
                        Hyst50mV = 0x1,
                    },
                },
                padding: u31,
            }),
        };

        ///  Software interrupt 0
        pub const SWI0 = extern struct {
            ///  Unused.
            UNUSED: u32,
        };
    };
};
