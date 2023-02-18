const micro = @import("microzig");
const mmio = micro.mmio;

pub const devices = struct {
    ///  nRF52840 reference description for radio MCU with ARM 32-bit Cortex-M4 Microcontroller
    pub const nrf52840 = struct {
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
            USBD: Handler = unhandled,
            UARTE1: Handler = unhandled,
            QSPI: Handler = unhandled,
            CRYPTOCELL: Handler = unhandled,
            reserved57: [2]u32 = undefined,
            PWM3: Handler = unhandled,
            reserved60: [1]u32 = undefined,
            SPIM3: Handler = unhandled,
        };

        pub const peripherals = struct {
            ///  Factory information configuration registers
            pub const FICR = @intToPtr(*volatile types.peripherals.FICR, 0x10000000);
            ///  User information configuration registers
            pub const UICR = @intToPtr(*volatile types.peripherals.UICR, 0x10001000);
            ///  Clock control
            pub const CLOCK = @intToPtr(*volatile types.peripherals.CLOCK, 0x40000000);
            ///  Power control
            pub const POWER = @intToPtr(*volatile types.peripherals.POWER, 0x40000000);
            ///  2.4 GHz radio
            pub const RADIO = @intToPtr(*volatile types.peripherals.RADIO, 0x40001000);
            ///  Universal Asynchronous Receiver/Transmitter
            pub const UART0 = @intToPtr(*volatile types.peripherals.UART0, 0x40002000);
            ///  UART with EasyDMA 0
            pub const UARTE0 = @intToPtr(*volatile types.peripherals.UARTE0, 0x40002000);
            ///  Serial Peripheral Interface 0
            pub const SPI0 = @intToPtr(*volatile types.peripherals.SPI0, 0x40003000);
            ///  Serial Peripheral Interface Master with EasyDMA 0
            pub const SPIM0 = @intToPtr(*volatile types.peripherals.SPIM0, 0x40003000);
            ///  SPI Slave 0
            pub const SPIS0 = @intToPtr(*volatile types.peripherals.SPIS0, 0x40003000);
            ///  I2C compatible Two-Wire Interface 0
            pub const TWI0 = @intToPtr(*volatile types.peripherals.TWI0, 0x40003000);
            ///  I2C compatible Two-Wire Master Interface with EasyDMA 0
            pub const TWIM0 = @intToPtr(*volatile types.peripherals.TWIM0, 0x40003000);
            ///  I2C compatible Two-Wire Slave Interface with EasyDMA 0
            pub const TWIS0 = @intToPtr(*volatile types.peripherals.TWIS0, 0x40003000);
            ///  Serial Peripheral Interface 1
            pub const SPI1 = @intToPtr(*volatile types.peripherals.SPI0, 0x40004000);
            ///  Serial Peripheral Interface Master with EasyDMA 1
            pub const SPIM1 = @intToPtr(*volatile types.peripherals.SPIM0, 0x40004000);
            ///  SPI Slave 1
            pub const SPIS1 = @intToPtr(*volatile types.peripherals.SPIS0, 0x40004000);
            ///  I2C compatible Two-Wire Interface 1
            pub const TWI1 = @intToPtr(*volatile types.peripherals.TWI0, 0x40004000);
            ///  I2C compatible Two-Wire Master Interface with EasyDMA 1
            pub const TWIM1 = @intToPtr(*volatile types.peripherals.TWIM0, 0x40004000);
            ///  I2C compatible Two-Wire Slave Interface with EasyDMA 1
            pub const TWIS1 = @intToPtr(*volatile types.peripherals.TWIS0, 0x40004000);
            ///  NFC-A compatible radio
            pub const NFCT = @intToPtr(*volatile types.peripherals.NFCT, 0x40005000);
            ///  GPIO Tasks and Events
            pub const GPIOTE = @intToPtr(*volatile types.peripherals.GPIOTE, 0x40006000);
            ///  Successive approximation register (SAR) analog-to-digital converter
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
            ///  Accelerated Address Resolver
            pub const AAR = @intToPtr(*volatile types.peripherals.AAR, 0x4000f000);
            ///  AES CCM Mode Encryption
            pub const CCM = @intToPtr(*volatile types.peripherals.CCM, 0x4000f000);
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
            ///  Event Generator Unit 0
            pub const EGU0 = @intToPtr(*volatile types.peripherals.EGU0, 0x40014000);
            ///  Software interrupt 0
            pub const SWI0 = @intToPtr(*volatile types.peripherals.SWI0, 0x40014000);
            ///  Event Generator Unit 1
            pub const EGU1 = @intToPtr(*volatile types.peripherals.EGU0, 0x40015000);
            ///  Software interrupt 1
            pub const SWI1 = @intToPtr(*volatile types.peripherals.SWI0, 0x40015000);
            ///  Event Generator Unit 2
            pub const EGU2 = @intToPtr(*volatile types.peripherals.EGU0, 0x40016000);
            ///  Software interrupt 2
            pub const SWI2 = @intToPtr(*volatile types.peripherals.SWI0, 0x40016000);
            ///  Event Generator Unit 3
            pub const EGU3 = @intToPtr(*volatile types.peripherals.EGU0, 0x40017000);
            ///  Software interrupt 3
            pub const SWI3 = @intToPtr(*volatile types.peripherals.SWI0, 0x40017000);
            ///  Event Generator Unit 4
            pub const EGU4 = @intToPtr(*volatile types.peripherals.EGU0, 0x40018000);
            ///  Software interrupt 4
            pub const SWI4 = @intToPtr(*volatile types.peripherals.SWI0, 0x40018000);
            ///  Event Generator Unit 5
            pub const EGU5 = @intToPtr(*volatile types.peripherals.EGU0, 0x40019000);
            ///  Software interrupt 5
            pub const SWI5 = @intToPtr(*volatile types.peripherals.SWI0, 0x40019000);
            ///  Timer/Counter 3
            pub const TIMER3 = @intToPtr(*volatile types.peripherals.TIMER0, 0x4001a000);
            ///  Timer/Counter 4
            pub const TIMER4 = @intToPtr(*volatile types.peripherals.TIMER0, 0x4001b000);
            ///  Pulse width modulation unit 0
            pub const PWM0 = @intToPtr(*volatile types.peripherals.PWM0, 0x4001c000);
            ///  Pulse Density Modulation (Digital Microphone) Interface
            pub const PDM = @intToPtr(*volatile types.peripherals.PDM, 0x4001d000);
            ///  Access control lists
            pub const ACL = @intToPtr(*volatile types.peripherals.ACL, 0x4001e000);
            ///  Non Volatile Memory Controller
            pub const NVMC = @intToPtr(*volatile types.peripherals.NVMC, 0x4001e000);
            ///  Programmable Peripheral Interconnect
            pub const PPI = @intToPtr(*volatile types.peripherals.PPI, 0x4001f000);
            ///  Memory Watch Unit
            pub const MWU = @intToPtr(*volatile types.peripherals.MWU, 0x40020000);
            ///  Pulse width modulation unit 1
            pub const PWM1 = @intToPtr(*volatile types.peripherals.PWM0, 0x40021000);
            ///  Pulse width modulation unit 2
            pub const PWM2 = @intToPtr(*volatile types.peripherals.PWM0, 0x40022000);
            ///  Serial Peripheral Interface 2
            pub const SPI2 = @intToPtr(*volatile types.peripherals.SPI0, 0x40023000);
            ///  Serial Peripheral Interface Master with EasyDMA 2
            pub const SPIM2 = @intToPtr(*volatile types.peripherals.SPIM0, 0x40023000);
            ///  SPI Slave 2
            pub const SPIS2 = @intToPtr(*volatile types.peripherals.SPIS0, 0x40023000);
            ///  Real time counter 2
            pub const RTC2 = @intToPtr(*volatile types.peripherals.RTC0, 0x40024000);
            ///  Inter-IC Sound
            pub const I2S = @intToPtr(*volatile types.peripherals.I2S, 0x40025000);
            ///  FPU
            pub const FPU = @intToPtr(*volatile types.peripherals.FPU, 0x40026000);
            ///  Universal serial bus device
            pub const USBD = @intToPtr(*volatile types.peripherals.USBD, 0x40027000);
            ///  UART with EasyDMA 1
            pub const UARTE1 = @intToPtr(*volatile types.peripherals.UARTE0, 0x40028000);
            ///  External flash interface
            pub const QSPI = @intToPtr(*volatile types.peripherals.QSPI, 0x40029000);
            ///  Pulse width modulation unit 3
            pub const PWM3 = @intToPtr(*volatile types.peripherals.PWM0, 0x4002d000);
            ///  Serial Peripheral Interface Master with EasyDMA 3
            pub const SPIM3 = @intToPtr(*volatile types.peripherals.SPIM0, 0x4002f000);
            ///  GPIO Port 1
            pub const P0 = @intToPtr(*volatile types.peripherals.P0, 0x50000000);
            ///  GPIO Port 2
            pub const P1 = @intToPtr(*volatile types.peripherals.P0, 0x50000300);
            ///  CRYPTOCELL HOST_RGF interface
            pub const CC_HOST_RGF = @intToPtr(*volatile types.peripherals.CC_HOST_RGF, 0x5002a000);
            ///  ARM TrustZone CryptoCell register interface
            pub const CRYPTOCELL = @intToPtr(*volatile types.peripherals.CRYPTOCELL, 0x5002a000);
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

        ///  Factory information configuration registers
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
            ///  Description collection: Device identifier
            DEVICEID: [2]mmio.Mmio(packed struct(u32) {
                ///  64 bit unique device identifier
                DEVICEID: u32,
            }),
            reserved128: [24]u8,
            ///  Description collection: Encryption root, word n
            ER: [4]mmio.Mmio(packed struct(u32) {
                ///  Encryption root, word n
                ER: u32,
            }),
            ///  Description collection: Identity Root, word n
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
            ///  Description collection: Device address n
            DEVICEADDR: [2]mmio.Mmio(packed struct(u32) {
                ///  48 bit device address
                DEVICEADDR: u32,
            }),
            reserved848: [676]u8,
            ///  Description collection: Production test signature n
            PRODTEST: [3]mmio.Mmio(packed struct(u32) {
                ///  Production test signature n
                PRODTEST: packed union {
                    raw: u32,
                    value: enum(u32) {
                        ///  Production tests done
                        Done = 0xbb42319f,
                        ///  Production tests not done
                        NotDone = 0xffffffff,
                        _,
                    },
                },
            }),
        };

        ///  User information configuration registers
        pub const UICR = extern struct {
            reserved20: [20]u8,
            ///  Description collection: Reserved for Nordic firmware design
            NRFFW: [13]mmio.Mmio(packed struct(u32) {
                ///  Reserved for Nordic firmware design
                NRFFW: u32,
            }),
            reserved80: [8]u8,
            ///  Description collection: Reserved for Nordic hardware design
            NRFHW: [12]mmio.Mmio(packed struct(u32) {
                ///  Reserved for Nordic hardware design
                NRFHW: u32,
            }),
            ///  Description collection: Reserved for customer
            CUSTOMER: [32]mmio.Mmio(packed struct(u32) {
                ///  Reserved for customer
                CUSTOMER: u32,
            }),
            reserved512: [256]u8,
            ///  Description collection: Mapping of the nRESET function (see POWER chapter for details)
            PSELRESET: [2]mmio.Mmio(packed struct(u32) {
                ///  GPIO pin number onto which nRESET is exposed
                PIN: u5,
                ///  Port number onto which nRESET is exposed
                PORT: u1,
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
            ///  Access port protection
            APPROTECT: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable access port protection.
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
            ///  Processor debug control
            DEBUGCTRL: mmio.Mmio(packed struct(u32) {
                ///  Configure CPU non-intrusive debug features
                CPUNIDEN: packed union {
                    raw: u8,
                    value: enum(u8) {
                        ///  Enable CPU ITM and ETM functionality (default behavior)
                        Enabled = 0xff,
                        ///  Disable CPU ITM and ETM functionality
                        Disabled = 0x0,
                        _,
                    },
                },
                ///  Configure CPU flash patch and breakpoint (FPB) unit behavior
                CPUFPBEN: packed union {
                    raw: u8,
                    value: enum(u8) {
                        ///  Enable CPU FPB unit (default behavior)
                        Enabled = 0xff,
                        ///  Disable CPU FPB unit. Writes into the FPB registers will be ignored.
                        Disabled = 0x0,
                        _,
                    },
                },
                padding: u16,
            }),
            reserved772: [240]u8,
            ///  GPIO reference voltage / external output supply voltage in high voltage mode
            REGOUT0: mmio.Mmio(packed struct(u32) {
                ///  Output voltage from of REG0 regulator stage. The maximum output voltage from this stage is given as VDDH - VEXDIF.
                VOUT: packed union {
                    raw: u3,
                    value: enum(u3) {
                        ///  1.8 V
                        @"1V8" = 0x0,
                        ///  2.1 V
                        @"2V1" = 0x1,
                        ///  2.4 V
                        @"2V4" = 0x2,
                        ///  2.7 V
                        @"2V7" = 0x3,
                        ///  3.0 V
                        @"3V0" = 0x4,
                        ///  3.3 V
                        @"3V3" = 0x5,
                        ///  Default voltage: 1.8 V
                        DEFAULT = 0x7,
                        _,
                    },
                },
                padding: u29,
            }),
        };

        ///  Clock control
        pub const CLOCK = extern struct {
            ///  Start HFXO crystal oscillator
            TASKS_HFCLKSTART: mmio.Mmio(packed struct(u32) {
                ///  Start HFXO crystal oscillator
                TASKS_HFCLKSTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stop HFXO crystal oscillator
            TASKS_HFCLKSTOP: mmio.Mmio(packed struct(u32) {
                ///  Stop HFXO crystal oscillator
                TASKS_HFCLKSTOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Start LFCLK
            TASKS_LFCLKSTART: mmio.Mmio(packed struct(u32) {
                ///  Start LFCLK
                TASKS_LFCLKSTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stop LFCLK
            TASKS_LFCLKSTOP: mmio.Mmio(packed struct(u32) {
                ///  Stop LFCLK
                TASKS_LFCLKSTOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Start calibration of LFRC
            TASKS_CAL: mmio.Mmio(packed struct(u32) {
                ///  Start calibration of LFRC
                TASKS_CAL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Start calibration timer
            TASKS_CTSTART: mmio.Mmio(packed struct(u32) {
                ///  Start calibration timer
                TASKS_CTSTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stop calibration timer
            TASKS_CTSTOP: mmio.Mmio(packed struct(u32) {
                ///  Stop calibration timer
                TASKS_CTSTOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved256: [228]u8,
            ///  HFXO crystal oscillator started
            EVENTS_HFCLKSTARTED: mmio.Mmio(packed struct(u32) {
                ///  HFXO crystal oscillator started
                EVENTS_HFCLKSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  LFCLK started
            EVENTS_LFCLKSTARTED: mmio.Mmio(packed struct(u32) {
                ///  LFCLK started
                EVENTS_LFCLKSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved268: [4]u8,
            ///  Calibration of LFRC completed
            EVENTS_DONE: mmio.Mmio(packed struct(u32) {
                ///  Calibration of LFRC completed
                EVENTS_DONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Calibration timer timeout
            EVENTS_CTTO: mmio.Mmio(packed struct(u32) {
                ///  Calibration timer timeout
                EVENTS_CTTO: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved296: [20]u8,
            ///  Calibration timer has been started and is ready to process new tasks
            EVENTS_CTSTARTED: mmio.Mmio(packed struct(u32) {
                ///  Calibration timer has been started and is ready to process new tasks
                EVENTS_CTSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Calibration timer has been stopped and is ready to process new tasks
            EVENTS_CTSTOPPED: mmio.Mmio(packed struct(u32) {
                ///  Calibration timer has been stopped and is ready to process new tasks
                EVENTS_CTSTOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved772: [468]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to enable interrupt for event HFCLKSTARTED
                HFCLKSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event LFCLKSTARTED
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
                ///  Write '1' to enable interrupt for event DONE
                DONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CTTO
                CTTO: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved10: u5,
                ///  Write '1' to enable interrupt for event CTSTARTED
                CTSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CTSTOPPED
                CTSTOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u20,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to disable interrupt for event HFCLKSTARTED
                HFCLKSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event LFCLKSTARTED
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
                ///  Write '1' to disable interrupt for event DONE
                DONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CTTO
                CTTO: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved10: u5,
                ///  Write '1' to disable interrupt for event CTSTARTED
                CTSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CTSTOPPED
                CTSTOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u20,
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
                        ///  32.768 kHz RC oscillator (LFRC)
                        RC = 0x0,
                        ///  32.768 kHz crystal oscillator (LFXO)
                        Xtal = 0x1,
                        ///  32.768 kHz synthesized from HFCLK (LFSYNT)
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
                        ///  32.768 kHz RC oscillator (LFRC)
                        RC = 0x0,
                        ///  32.768 kHz crystal oscillator (LFXO)
                        Xtal = 0x1,
                        ///  32.768 kHz synthesized from HFCLK (LFSYNT)
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
                        ///  32.768 kHz RC oscillator (LFRC)
                        RC = 0x0,
                        ///  32.768 kHz crystal oscillator (LFXO)
                        Xtal = 0x1,
                        ///  32.768 kHz synthesized from HFCLK (LFSYNT)
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
            reserved1320: [12]u8,
            ///  HFXO debounce time. The HFXO is started by triggering the TASKS_HFCLKSTART task.
            HFXODEBOUNCE: mmio.Mmio(packed struct(u32) {
                ///  HFXO debounce time. Debounce time = HFXODEBOUNCE * 16 us.
                HFXODEBOUNCE: packed union {
                    raw: u8,
                    value: enum(u8) {
                        ///  256 us debounce time. Recommended for TSX-3225, FA-20H and FA-128 crystals.
                        Db256us = 0x10,
                        ///  1024 us debounce time. Recommended for NX1612AA and NX1210AB crystals.
                        Db1024us = 0x40,
                        _,
                    },
                },
                padding: u24,
            }),
            reserved1336: [12]u8,
            ///  Calibration timer interval
            CTIV: mmio.Mmio(packed struct(u32) {
                ///  Calibration timer interval in multiple of 0.25 seconds. Range: 0.25 seconds to 31.75 seconds.
                CTIV: u7,
                padding: u25,
            }),
            reserved1372: [32]u8,
            ///  Clocking options for the trace port debug interface
            TRACECONFIG: mmio.Mmio(packed struct(u32) {
                ///  Speed of trace port clock. Note that the TRACECLK pin will output this clock divided by two.
                TRACEPORTSPEED: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  32 MHz trace port clock (TRACECLK = 16 MHz)
                        @"32MHz" = 0x0,
                        ///  16 MHz trace port clock (TRACECLK = 8 MHz)
                        @"16MHz" = 0x1,
                        ///  8 MHz trace port clock (TRACECLK = 4 MHz)
                        @"8MHz" = 0x2,
                        ///  4 MHz trace port clock (TRACECLK = 2 MHz)
                        @"4MHz" = 0x3,
                    },
                },
                reserved16: u14,
                ///  Pin multiplexing of trace signals. See pin assignment chapter for more details.
                TRACEMUX: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  No trace signals routed to pins. All pins can be used as regular GPIOs.
                        GPIO = 0x0,
                        ///  SWO trace signal routed to pin. Remaining pins can be used as regular GPIOs.
                        Serial = 0x1,
                        ///  All trace signals (TRACECLK and TRACEDATA[n]) routed to pins.
                        Parallel = 0x2,
                        _,
                    },
                },
                padding: u14,
            }),
            reserved1460: [84]u8,
            ///  LFRC mode configuration
            LFRCMODE: mmio.Mmio(packed struct(u32) {
                ///  Set LFRC mode
                MODE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Normal mode
                        Normal = 0x0,
                        ///  Ultra-low power mode (ULP)
                        ULP = 0x1,
                    },
                },
                reserved16: u15,
                ///  Active LFRC mode. This field is read only.
                STATUS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Normal mode
                        Normal = 0x0,
                        ///  Ultra-low power mode (ULP)
                        ULP = 0x1,
                    },
                },
                padding: u15,
            }),
        };

        ///  Power control
        pub const POWER = extern struct {
            reserved120: [120]u8,
            ///  Enable Constant Latency mode
            TASKS_CONSTLAT: mmio.Mmio(packed struct(u32) {
                ///  Enable Constant Latency mode
                TASKS_CONSTLAT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Enable Low-power mode (variable latency)
            TASKS_LOWPWR: mmio.Mmio(packed struct(u32) {
                ///  Enable Low-power mode (variable latency)
                TASKS_LOWPWR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved264: [136]u8,
            ///  Power failure warning
            EVENTS_POFWARN: mmio.Mmio(packed struct(u32) {
                ///  Power failure warning
                EVENTS_POFWARN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved276: [8]u8,
            ///  CPU entered WFI/WFE sleep
            EVENTS_SLEEPENTER: mmio.Mmio(packed struct(u32) {
                ///  CPU entered WFI/WFE sleep
                EVENTS_SLEEPENTER: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  CPU exited WFI/WFE sleep
            EVENTS_SLEEPEXIT: mmio.Mmio(packed struct(u32) {
                ///  CPU exited WFI/WFE sleep
                EVENTS_SLEEPEXIT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Voltage supply detected on VBUS
            EVENTS_USBDETECTED: mmio.Mmio(packed struct(u32) {
                ///  Voltage supply detected on VBUS
                EVENTS_USBDETECTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Voltage supply removed from VBUS
            EVENTS_USBREMOVED: mmio.Mmio(packed struct(u32) {
                ///  Voltage supply removed from VBUS
                EVENTS_USBREMOVED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  USB 3.3 V supply ready
            EVENTS_USBPWRRDY: mmio.Mmio(packed struct(u32) {
                ///  USB 3.3 V supply ready
                EVENTS_USBPWRRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved772: [476]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  Write '1' to enable interrupt for event POFWARN
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
                ///  Write '1' to enable interrupt for event SLEEPENTER
                SLEEPENTER: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event SLEEPEXIT
                SLEEPEXIT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event USBDETECTED
                USBDETECTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event USBREMOVED
                USBREMOVED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event USBPWRRDY
                USBPWRRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u22,
            }),
            ///  Disable interrupt
            INTENCLR: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  Write '1' to disable interrupt for event POFWARN
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
                ///  Write '1' to disable interrupt for event SLEEPENTER
                SLEEPENTER: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event SLEEPEXIT
                SLEEPEXIT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event USBDETECTED
                USBDETECTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event USBREMOVED
                USBREMOVED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event USBPWRRDY
                USBPWRRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                padding: u22,
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
                ///  Reset due to wake up from System OFF mode by VBUS rising into valid range
                VBUS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Not detected
                        NotDetected = 0x0,
                        ///  Detected
                        Detected = 0x1,
                    },
                },
                padding: u11,
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
            reserved1080: [12]u8,
            ///  USB supply status
            USBREGSTATUS: mmio.Mmio(packed struct(u32) {
                ///  VBUS input detection status (USBDETECTED and USBREMOVED events are derived from this information)
                VBUSDETECT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  VBUS voltage below valid threshold
                        NoVbus = 0x0,
                        ///  VBUS voltage above valid threshold
                        VbusPresent = 0x1,
                    },
                },
                ///  USB supply output settling time elapsed
                OUTPUTRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  USBREG output settling time not elapsed
                        NotReady = 0x0,
                        ///  USBREG output settling time elapsed (same information as USBPWRRDY event)
                        Ready = 0x1,
                    },
                },
                padding: u30,
            }),
            reserved1280: [196]u8,
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
            ///  Power-fail comparator configuration
            POFCON: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable power failure warning
                POF: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Power-fail comparator threshold setting. This setting applies both for normal voltage mode (supply connected to both VDD and VDDH) and high voltage mode (supply connected to VDDH only). Values 0-3 set threshold below 1.7 V and should not be used as brown out detection will be activated before power failure warning on such low voltages.
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
                reserved8: u3,
                ///  Power-fail comparator threshold setting for high voltage mode (supply connected to VDDH only). This setting does not apply for normal voltage mode (supply connected to both VDD and VDDH).
                THRESHOLDVDDH: packed union {
                    raw: u4,
                    value: enum(u4) {
                        ///  Set threshold to 2.7 V
                        V27 = 0x0,
                        ///  Set threshold to 2.8 V
                        V28 = 0x1,
                        ///  Set threshold to 2.9 V
                        V29 = 0x2,
                        ///  Set threshold to 3.0 V
                        V30 = 0x3,
                        ///  Set threshold to 3.1 V
                        V31 = 0x4,
                        ///  Set threshold to 3.2 V
                        V32 = 0x5,
                        ///  Set threshold to 3.3 V
                        V33 = 0x6,
                        ///  Set threshold to 3.4 V
                        V34 = 0x7,
                        ///  Set threshold to 3.5 V
                        V35 = 0x8,
                        ///  Set threshold to 3.6 V
                        V36 = 0x9,
                        ///  Set threshold to 3.7 V
                        V37 = 0xa,
                        ///  Set threshold to 3.8 V
                        V38 = 0xb,
                        ///  Set threshold to 3.9 V
                        V39 = 0xc,
                        ///  Set threshold to 4.0 V
                        V40 = 0xd,
                        ///  Set threshold to 4.1 V
                        V41 = 0xe,
                        ///  Set threshold to 4.2 V
                        V42 = 0xf,
                    },
                },
                padding: u20,
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
            reserved1400: [84]u8,
            ///  Enable DC/DC converter for REG1 stage
            DCDCEN: mmio.Mmio(packed struct(u32) {
                ///  Enable DC/DC converter for REG1 stage.
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
            reserved1408: [4]u8,
            ///  Enable DC/DC converter for REG0 stage
            DCDCEN0: mmio.Mmio(packed struct(u32) {
                ///  Enable DC/DC converter for REG0 stage.
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
            reserved1600: [188]u8,
            ///  Main supply status
            MAINREGSTATUS: mmio.Mmio(packed struct(u32) {
                ///  Main supply status
                MAINREGSTATUS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Normal voltage mode. Voltage supplied on VDD.
                        Normal = 0x0,
                        ///  High voltage mode. Voltage supplied on VDDH.
                        High = 0x1,
                    },
                },
                padding: u31,
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
            ///  Description collection: Configuration of GPIO pins
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

        ///  Access control lists
        pub const ACL = struct {};

        ///  2.4 GHz radio
        pub const RADIO = extern struct {
            ///  Enable RADIO in TX mode
            TASKS_TXEN: mmio.Mmio(packed struct(u32) {
                ///  Enable RADIO in TX mode
                TASKS_TXEN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Enable RADIO in RX mode
            TASKS_RXEN: mmio.Mmio(packed struct(u32) {
                ///  Enable RADIO in RX mode
                TASKS_RXEN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Start RADIO
            TASKS_START: mmio.Mmio(packed struct(u32) {
                ///  Start RADIO
                TASKS_START: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stop RADIO
            TASKS_STOP: mmio.Mmio(packed struct(u32) {
                ///  Stop RADIO
                TASKS_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Disable RADIO
            TASKS_DISABLE: mmio.Mmio(packed struct(u32) {
                ///  Disable RADIO
                TASKS_DISABLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Start the RSSI and take one single sample of the receive signal strength
            TASKS_RSSISTART: mmio.Mmio(packed struct(u32) {
                ///  Start the RSSI and take one single sample of the receive signal strength
                TASKS_RSSISTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stop the RSSI measurement
            TASKS_RSSISTOP: mmio.Mmio(packed struct(u32) {
                ///  Stop the RSSI measurement
                TASKS_RSSISTOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Start the bit counter
            TASKS_BCSTART: mmio.Mmio(packed struct(u32) {
                ///  Start the bit counter
                TASKS_BCSTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stop the bit counter
            TASKS_BCSTOP: mmio.Mmio(packed struct(u32) {
                ///  Stop the bit counter
                TASKS_BCSTOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Start the energy detect measurement used in IEEE 802.15.4 mode
            TASKS_EDSTART: mmio.Mmio(packed struct(u32) {
                ///  Start the energy detect measurement used in IEEE 802.15.4 mode
                TASKS_EDSTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stop the energy detect measurement
            TASKS_EDSTOP: mmio.Mmio(packed struct(u32) {
                ///  Stop the energy detect measurement
                TASKS_EDSTOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Start the clear channel assessment used in IEEE 802.15.4 mode
            TASKS_CCASTART: mmio.Mmio(packed struct(u32) {
                ///  Start the clear channel assessment used in IEEE 802.15.4 mode
                TASKS_CCASTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stop the clear channel assessment
            TASKS_CCASTOP: mmio.Mmio(packed struct(u32) {
                ///  Stop the clear channel assessment
                TASKS_CCASTOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved256: [204]u8,
            ///  RADIO has ramped up and is ready to be started
            EVENTS_READY: mmio.Mmio(packed struct(u32) {
                ///  RADIO has ramped up and is ready to be started
                EVENTS_READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Address sent or received
            EVENTS_ADDRESS: mmio.Mmio(packed struct(u32) {
                ///  Address sent or received
                EVENTS_ADDRESS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Packet payload sent or received
            EVENTS_PAYLOAD: mmio.Mmio(packed struct(u32) {
                ///  Packet payload sent or received
                EVENTS_PAYLOAD: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Packet sent or received
            EVENTS_END: mmio.Mmio(packed struct(u32) {
                ///  Packet sent or received
                EVENTS_END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  RADIO has been disabled
            EVENTS_DISABLED: mmio.Mmio(packed struct(u32) {
                ///  RADIO has been disabled
                EVENTS_DISABLED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  A device address match occurred on the last received packet
            EVENTS_DEVMATCH: mmio.Mmio(packed struct(u32) {
                ///  A device address match occurred on the last received packet
                EVENTS_DEVMATCH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  No device address match occurred on the last received packet
            EVENTS_DEVMISS: mmio.Mmio(packed struct(u32) {
                ///  No device address match occurred on the last received packet
                EVENTS_DEVMISS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Sampling of receive signal strength complete
            EVENTS_RSSIEND: mmio.Mmio(packed struct(u32) {
                ///  Sampling of receive signal strength complete
                EVENTS_RSSIEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved296: [8]u8,
            ///  Bit counter reached bit count value
            EVENTS_BCMATCH: mmio.Mmio(packed struct(u32) {
                ///  Bit counter reached bit count value
                EVENTS_BCMATCH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved304: [4]u8,
            ///  Packet received with CRC ok
            EVENTS_CRCOK: mmio.Mmio(packed struct(u32) {
                ///  Packet received with CRC ok
                EVENTS_CRCOK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Packet received with CRC error
            EVENTS_CRCERROR: mmio.Mmio(packed struct(u32) {
                ///  Packet received with CRC error
                EVENTS_CRCERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  IEEE 802.15.4 length field received
            EVENTS_FRAMESTART: mmio.Mmio(packed struct(u32) {
                ///  IEEE 802.15.4 length field received
                EVENTS_FRAMESTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Sampling of energy detection complete. A new ED sample is ready for readout from the RADIO.EDSAMPLE register.
            EVENTS_EDEND: mmio.Mmio(packed struct(u32) {
                ///  Sampling of energy detection complete. A new ED sample is ready for readout from the RADIO.EDSAMPLE register.
                EVENTS_EDEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  The sampling of energy detection has stopped
            EVENTS_EDSTOPPED: mmio.Mmio(packed struct(u32) {
                ///  The sampling of energy detection has stopped
                EVENTS_EDSTOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Wireless medium in idle - clear to send
            EVENTS_CCAIDLE: mmio.Mmio(packed struct(u32) {
                ///  Wireless medium in idle - clear to send
                EVENTS_CCAIDLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Wireless medium busy - do not send
            EVENTS_CCABUSY: mmio.Mmio(packed struct(u32) {
                ///  Wireless medium busy - do not send
                EVENTS_CCABUSY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  The CCA has stopped
            EVENTS_CCASTOPPED: mmio.Mmio(packed struct(u32) {
                ///  The CCA has stopped
                EVENTS_CCASTOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Ble_LR CI field received, receive mode is changed from Ble_LR125Kbit to Ble_LR500Kbit.
            EVENTS_RATEBOOST: mmio.Mmio(packed struct(u32) {
                ///  Ble_LR CI field received, receive mode is changed from Ble_LR125Kbit to Ble_LR500Kbit.
                EVENTS_RATEBOOST: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  RADIO has ramped up and is ready to be started TX path
            EVENTS_TXREADY: mmio.Mmio(packed struct(u32) {
                ///  RADIO has ramped up and is ready to be started TX path
                EVENTS_TXREADY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  RADIO has ramped up and is ready to be started RX path
            EVENTS_RXREADY: mmio.Mmio(packed struct(u32) {
                ///  RADIO has ramped up and is ready to be started RX path
                EVENTS_RXREADY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  MAC header match found
            EVENTS_MHRMATCH: mmio.Mmio(packed struct(u32) {
                ///  MAC header match found
                EVENTS_MHRMATCH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved360: [8]u8,
            ///  Preamble indicator.
            EVENTS_SYNC: mmio.Mmio(packed struct(u32) {
                ///  Preamble indicator.
                EVENTS_SYNC: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Generated in Ble_LR125Kbit, Ble_LR500Kbit and Ieee802154_250Kbit modes when last bit is sent on air.
            EVENTS_PHYEND: mmio.Mmio(packed struct(u32) {
                ///  Generated in Ble_LR125Kbit, Ble_LR500Kbit and Ieee802154_250Kbit modes when last bit is sent on air.
                EVENTS_PHYEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved512: [144]u8,
            ///  Shortcuts between local events and tasks
            SHORTS: mmio.Mmio(packed struct(u32) {
                ///  Shortcut between event READY and task START
                READY_START: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event END and task DISABLE
                END_DISABLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event DISABLED and task TXEN
                DISABLED_TXEN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event DISABLED and task RXEN
                DISABLED_RXEN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event ADDRESS and task RSSISTART
                ADDRESS_RSSISTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event END and task START
                END_START: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event ADDRESS and task BCSTART
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
                ///  Shortcut between event DISABLED and task RSSISTOP
                DISABLED_RSSISTOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                reserved11: u2,
                ///  Shortcut between event RXREADY and task CCASTART
                RXREADY_CCASTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event CCAIDLE and task TXEN
                CCAIDLE_TXEN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event CCABUSY and task DISABLE
                CCABUSY_DISABLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event FRAMESTART and task BCSTART
                FRAMESTART_BCSTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event READY and task EDSTART
                READY_EDSTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event EDEND and task DISABLE
                EDEND_DISABLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event CCAIDLE and task STOP
                CCAIDLE_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event TXREADY and task START
                TXREADY_START: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event RXREADY and task START
                RXREADY_START: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event PHYEND and task DISABLE
                PHYEND_DISABLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event PHYEND and task START
                PHYEND_START: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                padding: u10,
            }),
            reserved772: [256]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to enable interrupt for event READY
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ADDRESS
                ADDRESS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event PAYLOAD
                PAYLOAD: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event END
                END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event DISABLED
                DISABLED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event DEVMATCH
                DEVMATCH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event DEVMISS
                DEVMISS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event RSSIEND
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
                ///  Write '1' to enable interrupt for event BCMATCH
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
                ///  Write '1' to enable interrupt for event CRCOK
                CRCOK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CRCERROR
                CRCERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event FRAMESTART
                FRAMESTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event EDEND
                EDEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event EDSTOPPED
                EDSTOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CCAIDLE
                CCAIDLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CCABUSY
                CCABUSY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CCASTOPPED
                CCASTOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event RATEBOOST
                RATEBOOST: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event TXREADY
                TXREADY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event RXREADY
                RXREADY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event MHRMATCH
                MHRMATCH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved26: u2,
                ///  Write '1' to enable interrupt for event SYNC
                SYNC: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event PHYEND
                PHYEND: packed union {
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
                ///  Write '1' to disable interrupt for event READY
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ADDRESS
                ADDRESS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event PAYLOAD
                PAYLOAD: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event END
                END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event DISABLED
                DISABLED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event DEVMATCH
                DEVMATCH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event DEVMISS
                DEVMISS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event RSSIEND
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
                ///  Write '1' to disable interrupt for event BCMATCH
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
                ///  Write '1' to disable interrupt for event CRCOK
                CRCOK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CRCERROR
                CRCERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event FRAMESTART
                FRAMESTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event EDEND
                EDEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event EDSTOPPED
                EDSTOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CCAIDLE
                CCAIDLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CCABUSY
                CCABUSY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CCASTOPPED
                CCASTOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event RATEBOOST
                RATEBOOST: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event TXREADY
                TXREADY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event RXREADY
                RXREADY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event MHRMATCH
                MHRMATCH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                reserved26: u2,
                ///  Write '1' to disable interrupt for event SYNC
                SYNC: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event PHYEND
                PHYEND: packed union {
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
            ///  Payload status
            PDUSTAT: mmio.Mmio(packed struct(u32) {
                ///  Status on payload length vs. PCNF1.MAXLEN
                PDUSTAT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Payload less than PCNF1.MAXLEN
                        LessThan = 0x0,
                        ///  Payload greater than PCNF1.MAXLEN
                        GreaterThan = 0x1,
                    },
                },
                ///  Status on what rate packet is received with in Long Range
                CISTAT: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Frame is received at 125kbps
                        LR125kbit = 0x0,
                        ///  Frame is received at 500kbps
                        LR500kbit = 0x1,
                        _,
                    },
                },
                padding: u29,
            }),
            reserved1284: [236]u8,
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
                ///  RADIO output power
                TXPOWER: packed union {
                    raw: u8,
                    value: enum(u8) {
                        ///  +8 dBm
                        Pos8dBm = 0x8,
                        ///  +7 dBm
                        Pos7dBm = 0x7,
                        ///  +6 dBm
                        Pos6dBm = 0x6,
                        ///  +5 dBm
                        Pos5dBm = 0x5,
                        ///  +4 dBm
                        Pos4dBm = 0x4,
                        ///  +3 dBm
                        Pos3dBm = 0x3,
                        ///  +2 dBm
                        Pos2dBm = 0x2,
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
                        Neg30dBm = 0xe2,
                        ///  -40 dBm
                        Neg40dBm = 0xd8,
                        _,
                    },
                },
                padding: u24,
            }),
            ///  Data rate and modulation
            MODE: mmio.Mmio(packed struct(u32) {
                ///  Radio data rate and modulation setting. The radio supports frequency-shift keying (FSK) modulation.
                MODE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        ///  1 Mbit/s Nordic proprietary radio mode
                        Nrf_1Mbit = 0x0,
                        ///  2 Mbit/s Nordic proprietary radio mode
                        Nrf_2Mbit = 0x1,
                        ///  1 Mbit/s BLE
                        Ble_1Mbit = 0x3,
                        ///  2 Mbit/s BLE
                        Ble_2Mbit = 0x4,
                        ///  Long range 125 kbit/s TX, 125 kbit/s and 500 kbit/s RX
                        Ble_LR125Kbit = 0x5,
                        ///  Long range 500 kbit/s TX, 125 kbit/s and 500 kbit/s RX
                        Ble_LR500Kbit = 0x6,
                        ///  IEEE 802.15.4-2006 250 kbit/s
                        Ieee802154_250Kbit = 0xf,
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
                reserved22: u1,
                ///  Length of code indicator - long range
                CILEN: u2,
                ///  Length of preamble on air. Decision point: TASKS_START task
                PLEN: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  8-bit preamble
                        @"8bit" = 0x0,
                        ///  16-bit preamble
                        @"16bit" = 0x1,
                        ///  32-bit zero preamble - used for IEEE 802.15.4
                        @"32bitZero" = 0x2,
                        ///  Preamble - used for BLE long range
                        LongRange = 0x3,
                    },
                },
                ///  Indicates if LENGTH field contains CRC or not
                CRCINC: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  LENGTH does not contain CRC
                        Exclude = 0x0,
                        ///  LENGTH includes CRC
                        Include = 0x1,
                    },
                },
                reserved29: u2,
                ///  Length of TERM field in Long Range operation
                TERMLEN: u2,
                padding: u1,
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
                        ///  Least significant bit on air first
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
                    raw: u2,
                    value: enum(u2) {
                        ///  CRC calculation includes address field
                        Include = 0x0,
                        ///  CRC calculation does not include address field. The CRC calculation will start at the first byte after the address.
                        Skip = 0x1,
                        ///  CRC calculation as per 802.15.4 standard. Starting at first byte after length field.
                        Ieee802154 = 0x2,
                        _,
                    },
                },
                padding: u22,
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
            reserved1348: [4]u8,
            ///  Interframe spacing in us
            TIFS: mmio.Mmio(packed struct(u32) {
                ///  Interframe spacing in us
                TIFS: u10,
                padding: u22,
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
            ///  Description collection: Device address base segment n
            DAB: [8]mmio.Mmio(packed struct(u32) {
                ///  Device address base segment n
                DAB: u32,
            }),
            ///  Description collection: Device address prefix n
            DAP: [8]mmio.Mmio(packed struct(u32) {
                ///  Device address prefix n
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
            ///  Search pattern configuration
            MHRMATCHCONF: mmio.Mmio(packed struct(u32) {
                ///  Search pattern configuration
                MHRMATCHCONF: u32,
            }),
            ///  Pattern mask
            MHRMATCHMAS: mmio.Mmio(packed struct(u32) {
                ///  Pattern mask
                MHRMATCHMAS: u32,
            }),
            reserved1616: [4]u8,
            ///  Radio mode configuration register 0
            MODECNF0: mmio.Mmio(packed struct(u32) {
                ///  Radio ramp-up time
                RU: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Default ramp-up time (tRXEN and tTXEN), compatible with firmware written for nRF51
                        Default = 0x0,
                        ///  Fast ramp-up (tRXEN,FAST and tTXEN,FAST), see electrical specification for more information
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
            reserved1632: [12]u8,
            ///  IEEE 802.15.4 start of frame delimiter
            SFD: mmio.Mmio(packed struct(u32) {
                ///  IEEE 802.15.4 start of frame delimiter
                SFD: u8,
                padding: u24,
            }),
            ///  IEEE 802.15.4 energy detect loop count
            EDCNT: mmio.Mmio(packed struct(u32) {
                ///  IEEE 802.15.4 energy detect loop count
                EDCNT: u21,
                padding: u11,
            }),
            ///  IEEE 802.15.4 energy detect level
            EDSAMPLE: mmio.Mmio(packed struct(u32) {
                ///  IEEE 802.15.4 energy detect level
                EDLVL: u8,
                padding: u24,
            }),
            ///  IEEE 802.15.4 clear channel assessment control
            CCACTRL: mmio.Mmio(packed struct(u32) {
                ///  CCA mode of operation
                CCAMODE: packed union {
                    raw: u3,
                    value: enum(u3) {
                        ///  Energy above threshold
                        EdMode = 0x0,
                        ///  Carrier seen
                        CarrierMode = 0x1,
                        ///  Energy above threshold AND carrier seen
                        CarrierAndEdMode = 0x2,
                        ///  Energy above threshold OR carrier seen
                        CarrierOrEdMode = 0x3,
                        ///  Energy above threshold test mode that will abort when first ED measurement over threshold is seen. No averaging.
                        EdModeTest1 = 0x4,
                        _,
                    },
                },
                reserved8: u5,
                ///  CCA energy busy threshold. Used in all the CCA modes except CarrierMode.
                CCAEDTHRES: u8,
                ///  CCA correlator busy threshold. Only relevant to CarrierMode, CarrierAndEdMode and CarrierOrEdMode.
                CCACORRTHRES: u8,
                ///  Limit for occurances above CCACORRTHRES. When not equal to zero the corrolator based signal detect is enabled.
                CCACORRCNT: u8,
            }),
            reserved4092: [2444]u8,
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

        ///  Universal Asynchronous Receiver/Transmitter
        pub const UART0 = extern struct {
            ///  Start UART receiver
            TASKS_STARTRX: mmio.Mmio(packed struct(u32) {
                ///  Start UART receiver
                TASKS_STARTRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stop UART receiver
            TASKS_STOPRX: mmio.Mmio(packed struct(u32) {
                ///  Stop UART receiver
                TASKS_STOPRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Start UART transmitter
            TASKS_STARTTX: mmio.Mmio(packed struct(u32) {
                ///  Start UART transmitter
                TASKS_STARTTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stop UART transmitter
            TASKS_STOPTX: mmio.Mmio(packed struct(u32) {
                ///  Stop UART transmitter
                TASKS_STOPTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved28: [12]u8,
            ///  Suspend UART
            TASKS_SUSPEND: mmio.Mmio(packed struct(u32) {
                ///  Suspend UART
                TASKS_SUSPEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved256: [224]u8,
            ///  CTS is activated (set low). Clear To Send.
            EVENTS_CTS: mmio.Mmio(packed struct(u32) {
                ///  CTS is activated (set low). Clear To Send.
                EVENTS_CTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  CTS is deactivated (set high). Not Clear To Send.
            EVENTS_NCTS: mmio.Mmio(packed struct(u32) {
                ///  CTS is deactivated (set high). Not Clear To Send.
                EVENTS_NCTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Data received in RXD
            EVENTS_RXDRDY: mmio.Mmio(packed struct(u32) {
                ///  Data received in RXD
                EVENTS_RXDRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved284: [16]u8,
            ///  Data sent from TXD
            EVENTS_TXDRDY: mmio.Mmio(packed struct(u32) {
                ///  Data sent from TXD
                EVENTS_TXDRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved292: [4]u8,
            ///  Error detected
            EVENTS_ERROR: mmio.Mmio(packed struct(u32) {
                ///  Error detected
                EVENTS_ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved324: [28]u8,
            ///  Receiver timeout
            EVENTS_RXTO: mmio.Mmio(packed struct(u32) {
                ///  Receiver timeout
                EVENTS_RXTO: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved512: [184]u8,
            ///  Shortcuts between local events and tasks
            SHORTS: mmio.Mmio(packed struct(u32) {
                reserved3: u3,
                ///  Shortcut between event CTS and task STARTRX
                CTS_STARTRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event NCTS and task STOPRX
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
                ///  Write '1' to enable interrupt for event CTS
                CTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event NCTS
                NCTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event RXDRDY
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
                ///  Write '1' to enable interrupt for event TXDRDY
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
                ///  Write '1' to enable interrupt for event ERROR
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
                ///  Write '1' to enable interrupt for event RXTO
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
                ///  Write '1' to disable interrupt for event CTS
                CTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event NCTS
                NCTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event RXDRDY
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
                ///  Write '1' to disable interrupt for event TXDRDY
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
                ///  Write '1' to disable interrupt for event ERROR
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
                ///  Write '1' to disable interrupt for event RXTO
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
            reserved1304: [20]u8,
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
                ///  Stop bits
                STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  One stop bit
                        One = 0x0,
                        ///  Two stop bits
                        Two = 0x1,
                    },
                },
                padding: u27,
            }),
        };

        ///  UART with EasyDMA 0
        pub const UARTE0 = extern struct {
            ///  Start UART receiver
            TASKS_STARTRX: mmio.Mmio(packed struct(u32) {
                ///  Start UART receiver
                TASKS_STARTRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stop UART receiver
            TASKS_STOPRX: mmio.Mmio(packed struct(u32) {
                ///  Stop UART receiver
                TASKS_STOPRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Start UART transmitter
            TASKS_STARTTX: mmio.Mmio(packed struct(u32) {
                ///  Start UART transmitter
                TASKS_STARTTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stop UART transmitter
            TASKS_STOPTX: mmio.Mmio(packed struct(u32) {
                ///  Stop UART transmitter
                TASKS_STOPTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved44: [28]u8,
            ///  Flush RX FIFO into RX buffer
            TASKS_FLUSHRX: mmio.Mmio(packed struct(u32) {
                ///  Flush RX FIFO into RX buffer
                TASKS_FLUSHRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved256: [208]u8,
            ///  CTS is activated (set low). Clear To Send.
            EVENTS_CTS: mmio.Mmio(packed struct(u32) {
                ///  CTS is activated (set low). Clear To Send.
                EVENTS_CTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  CTS is deactivated (set high). Not Clear To Send.
            EVENTS_NCTS: mmio.Mmio(packed struct(u32) {
                ///  CTS is deactivated (set high). Not Clear To Send.
                EVENTS_NCTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Data received in RXD (but potentially not yet transferred to Data RAM)
            EVENTS_RXDRDY: mmio.Mmio(packed struct(u32) {
                ///  Data received in RXD (but potentially not yet transferred to Data RAM)
                EVENTS_RXDRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved272: [4]u8,
            ///  Receive buffer is filled up
            EVENTS_ENDRX: mmio.Mmio(packed struct(u32) {
                ///  Receive buffer is filled up
                EVENTS_ENDRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved284: [8]u8,
            ///  Data sent from TXD
            EVENTS_TXDRDY: mmio.Mmio(packed struct(u32) {
                ///  Data sent from TXD
                EVENTS_TXDRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Last TX byte transmitted
            EVENTS_ENDTX: mmio.Mmio(packed struct(u32) {
                ///  Last TX byte transmitted
                EVENTS_ENDTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Error detected
            EVENTS_ERROR: mmio.Mmio(packed struct(u32) {
                ///  Error detected
                EVENTS_ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved324: [28]u8,
            ///  Receiver timeout
            EVENTS_RXTO: mmio.Mmio(packed struct(u32) {
                ///  Receiver timeout
                EVENTS_RXTO: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved332: [4]u8,
            ///  UART receiver has started
            EVENTS_RXSTARTED: mmio.Mmio(packed struct(u32) {
                ///  UART receiver has started
                EVENTS_RXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  UART transmitter has started
            EVENTS_TXSTARTED: mmio.Mmio(packed struct(u32) {
                ///  UART transmitter has started
                EVENTS_TXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved344: [4]u8,
            ///  Transmitter stopped
            EVENTS_TXSTOPPED: mmio.Mmio(packed struct(u32) {
                ///  Transmitter stopped
                EVENTS_TXSTOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved512: [164]u8,
            ///  Shortcuts between local events and tasks
            SHORTS: mmio.Mmio(packed struct(u32) {
                reserved5: u5,
                ///  Shortcut between event ENDRX and task STARTRX
                ENDRX_STARTRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event ENDRX and task STOPRX
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
                ///  Enable or disable interrupt for event CTS
                CTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event NCTS
                NCTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event RXDRDY
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
                ///  Enable or disable interrupt for event ENDRX
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
                ///  Enable or disable interrupt for event TXDRDY
                TXDRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event ENDTX
                ENDTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event ERROR
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
                ///  Enable or disable interrupt for event RXTO
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
                ///  Enable or disable interrupt for event RXSTARTED
                RXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event TXSTARTED
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
                ///  Enable or disable interrupt for event TXSTOPPED
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
                ///  Write '1' to enable interrupt for event CTS
                CTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event NCTS
                NCTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event RXDRDY
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
                ///  Write '1' to enable interrupt for event ENDRX
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
                ///  Write '1' to enable interrupt for event TXDRDY
                TXDRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ENDTX
                ENDTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ERROR
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
                ///  Write '1' to enable interrupt for event RXTO
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
                ///  Write '1' to enable interrupt for event RXSTARTED
                RXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event TXSTARTED
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
                ///  Write '1' to enable interrupt for event TXSTOPPED
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
                ///  Write '1' to disable interrupt for event CTS
                CTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event NCTS
                NCTS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event RXDRDY
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
                ///  Write '1' to disable interrupt for event ENDRX
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
                ///  Write '1' to disable interrupt for event TXDRDY
                TXDRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ENDTX
                ENDTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ERROR
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
                ///  Write '1' to disable interrupt for event RXTO
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
                ///  Write '1' to disable interrupt for event RXSTARTED
                RXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event TXSTARTED
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
                ///  Write '1' to disable interrupt for event TXSTOPPED
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
            ///  Error source Note : this register is read / write one to clear.
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
                        ///  Include even parity bit
                        Included = 0x7,
                        _,
                    },
                },
                ///  Stop bits
                STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  One stop bit
                        One = 0x0,
                        ///  Two stop bits
                        Two = 0x1,
                    },
                },
                padding: u27,
            }),
        };

        ///  Serial Peripheral Interface 0
        pub const SPI0 = extern struct {
            reserved264: [264]u8,
            ///  TXD byte sent and RXD byte received
            EVENTS_READY: mmio.Mmio(packed struct(u32) {
                ///  TXD byte sent and RXD byte received
                EVENTS_READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved772: [504]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  Write '1' to enable interrupt for event READY
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
                ///  Write '1' to disable interrupt for event READY
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
        };

        ///  Serial Peripheral Interface Master with EasyDMA 0
        pub const SPIM0 = extern struct {
            reserved16: [16]u8,
            ///  Start SPI transaction
            TASKS_START: mmio.Mmio(packed struct(u32) {
                ///  Start SPI transaction
                TASKS_START: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stop SPI transaction
            TASKS_STOP: mmio.Mmio(packed struct(u32) {
                ///  Stop SPI transaction
                TASKS_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved28: [4]u8,
            ///  Suspend SPI transaction
            TASKS_SUSPEND: mmio.Mmio(packed struct(u32) {
                ///  Suspend SPI transaction
                TASKS_SUSPEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Resume SPI transaction
            TASKS_RESUME: mmio.Mmio(packed struct(u32) {
                ///  Resume SPI transaction
                TASKS_RESUME: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved260: [224]u8,
            ///  SPI transaction has stopped
            EVENTS_STOPPED: mmio.Mmio(packed struct(u32) {
                ///  SPI transaction has stopped
                EVENTS_STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved272: [8]u8,
            ///  End of RXD buffer reached
            EVENTS_ENDRX: mmio.Mmio(packed struct(u32) {
                ///  End of RXD buffer reached
                EVENTS_ENDRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved280: [4]u8,
            ///  End of RXD buffer and TXD buffer reached
            EVENTS_END: mmio.Mmio(packed struct(u32) {
                ///  End of RXD buffer and TXD buffer reached
                EVENTS_END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved288: [4]u8,
            ///  End of TXD buffer reached
            EVENTS_ENDTX: mmio.Mmio(packed struct(u32) {
                ///  End of TXD buffer reached
                EVENTS_ENDTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved332: [40]u8,
            ///  Transaction started
            EVENTS_STARTED: mmio.Mmio(packed struct(u32) {
                ///  Transaction started
                EVENTS_STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved512: [176]u8,
            ///  Shortcuts between local events and tasks
            SHORTS: mmio.Mmio(packed struct(u32) {
                reserved17: u17,
                ///  Shortcut between event END and task START
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
                ///  Write '1' to enable interrupt for event STOPPED
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
                ///  Write '1' to enable interrupt for event ENDRX
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
                ///  Write '1' to enable interrupt for event END
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
                ///  Write '1' to enable interrupt for event ENDTX
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
                ///  Write '1' to enable interrupt for event STARTED
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
                ///  Write '1' to disable interrupt for event STOPPED
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
                ///  Write '1' to disable interrupt for event ENDRX
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
                ///  Write '1' to disable interrupt for event END
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
                ///  Write '1' to disable interrupt for event ENDTX
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
                ///  Write '1' to disable interrupt for event STARTED
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
            reserved1024: [244]u8,
            ///  Stall status for EasyDMA RAM accesses. The fields in this register is set to STALL by hardware whenever a stall occurres and can be cleared (set to NOSTALL) by the CPU.
            STALLSTAT: mmio.Mmio(packed struct(u32) {
                ///  Stall status for EasyDMA RAM reads
                TX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  No stall
                        NOSTALL = 0x0,
                        ///  A stall has occurred
                        STALL = 0x1,
                    },
                },
                ///  Stall status for EasyDMA RAM writes
                RX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  No stall
                        NOSTALL = 0x0,
                        ///  A stall has occurred
                        STALL = 0x1,
                    },
                },
                padding: u30,
            }),
            reserved1280: [252]u8,
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
                        ///  16 Mbps
                        M16 = 0xa000000,
                        ///  32 Mbps
                        M32 = 0x14000000,
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
            reserved1384: [16]u8,
            ///  Polarity of CSN output
            CSNPOL: mmio.Mmio(packed struct(u32) {
                ///  Polarity of CSN output
                CSNPOL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Active low (idle state high)
                        LOW = 0x0,
                        ///  Active high (idle state low)
                        HIGH = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Pin select for DCX signal
            PSELDCX: mmio.Mmio(packed struct(u32) {
                ///  Pin number
                PIN: u5,
                ///  Port number
                PORT: u1,
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
            ///  DCX configuration
            DCXCNT: mmio.Mmio(packed struct(u32) {
                ///  This register specifies the number of command bytes preceding the data bytes. The PSEL.DCX line will be low during transmission of command bytes and high during transmission of data bytes. Value 0xF indicates that all bytes are command bytes.
                DCXCNT: u4,
                padding: u28,
            }),
            reserved1472: [76]u8,
            ///  Byte transmitted after TXD.MAXCNT bytes have been transmitted in the case when RXD.MAXCNT is greater than TXD.MAXCNT
            ORC: mmio.Mmio(packed struct(u32) {
                ///  Byte transmitted after TXD.MAXCNT bytes have been transmitted in the case when RXD.MAXCNT is greater than TXD.MAXCNT.
                ORC: u8,
                padding: u24,
            }),
        };

        ///  SPI Slave 0
        pub const SPIS0 = extern struct {
            reserved36: [36]u8,
            ///  Acquire SPI semaphore
            TASKS_ACQUIRE: mmio.Mmio(packed struct(u32) {
                ///  Acquire SPI semaphore
                TASKS_ACQUIRE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Release SPI semaphore, enabling the SPI slave to acquire it
            TASKS_RELEASE: mmio.Mmio(packed struct(u32) {
                ///  Release SPI semaphore, enabling the SPI slave to acquire it
                TASKS_RELEASE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved260: [216]u8,
            ///  Granted transaction completed
            EVENTS_END: mmio.Mmio(packed struct(u32) {
                ///  Granted transaction completed
                EVENTS_END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved272: [8]u8,
            ///  End of RXD buffer reached
            EVENTS_ENDRX: mmio.Mmio(packed struct(u32) {
                ///  End of RXD buffer reached
                EVENTS_ENDRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved296: [20]u8,
            ///  Semaphore acquired
            EVENTS_ACQUIRED: mmio.Mmio(packed struct(u32) {
                ///  Semaphore acquired
                EVENTS_ACQUIRED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved512: [212]u8,
            ///  Shortcuts between local events and tasks
            SHORTS: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  Shortcut between event END and task ACQUIRE
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
                ///  Write '1' to enable interrupt for event END
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
                ///  Write '1' to enable interrupt for event ENDRX
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
                ///  Write '1' to enable interrupt for event ACQUIRED
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
                ///  Write '1' to disable interrupt for event END
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
                ///  Write '1' to disable interrupt for event ENDRX
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
                ///  Write '1' to disable interrupt for event ACQUIRED
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

        ///  I2C compatible Two-Wire Interface 0
        pub const TWI0 = extern struct {
            ///  Start TWI receive sequence
            TASKS_STARTRX: mmio.Mmio(packed struct(u32) {
                ///  Start TWI receive sequence
                TASKS_STARTRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved8: [4]u8,
            ///  Start TWI transmit sequence
            TASKS_STARTTX: mmio.Mmio(packed struct(u32) {
                ///  Start TWI transmit sequence
                TASKS_STARTTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved20: [8]u8,
            ///  Stop TWI transaction
            TASKS_STOP: mmio.Mmio(packed struct(u32) {
                ///  Stop TWI transaction
                TASKS_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved28: [4]u8,
            ///  Suspend TWI transaction
            TASKS_SUSPEND: mmio.Mmio(packed struct(u32) {
                ///  Suspend TWI transaction
                TASKS_SUSPEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Resume TWI transaction
            TASKS_RESUME: mmio.Mmio(packed struct(u32) {
                ///  Resume TWI transaction
                TASKS_RESUME: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved260: [224]u8,
            ///  TWI stopped
            EVENTS_STOPPED: mmio.Mmio(packed struct(u32) {
                ///  TWI stopped
                EVENTS_STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  TWI RXD byte received
            EVENTS_RXDREADY: mmio.Mmio(packed struct(u32) {
                ///  TWI RXD byte received
                EVENTS_RXDREADY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved284: [16]u8,
            ///  TWI TXD byte sent
            EVENTS_TXDSENT: mmio.Mmio(packed struct(u32) {
                ///  TWI TXD byte sent
                EVENTS_TXDSENT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved292: [4]u8,
            ///  TWI error
            EVENTS_ERROR: mmio.Mmio(packed struct(u32) {
                ///  TWI error
                EVENTS_ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved312: [16]u8,
            ///  TWI byte boundary, generated before each byte that is sent or received
            EVENTS_BB: mmio.Mmio(packed struct(u32) {
                ///  TWI byte boundary, generated before each byte that is sent or received
                EVENTS_BB: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved328: [12]u8,
            ///  TWI entered the suspended state
            EVENTS_SUSPENDED: mmio.Mmio(packed struct(u32) {
                ///  TWI entered the suspended state
                EVENTS_SUSPENDED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved512: [180]u8,
            ///  Shortcuts between local events and tasks
            SHORTS: mmio.Mmio(packed struct(u32) {
                ///  Shortcut between event BB and task SUSPEND
                BB_SUSPEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event BB and task STOP
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
                ///  Write '1' to enable interrupt for event STOPPED
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event RXDREADY
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
                ///  Write '1' to enable interrupt for event TXDSENT
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
                ///  Write '1' to enable interrupt for event ERROR
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
                ///  Write '1' to enable interrupt for event BB
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
                ///  Write '1' to enable interrupt for event SUSPENDED
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
                ///  Write '1' to disable interrupt for event STOPPED
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event RXDREADY
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
                ///  Write '1' to disable interrupt for event TXDSENT
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
                ///  Write '1' to disable interrupt for event ERROR
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
                ///  Write '1' to disable interrupt for event BB
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
                ///  Write '1' to disable interrupt for event SUSPENDED
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
            reserved1304: [20]u8,
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
            ///  TWI frequency. Accuracy depends on the HFCLK source selected.
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

        ///  I2C compatible Two-Wire Master Interface with EasyDMA 0
        pub const TWIM0 = extern struct {
            ///  Start TWI receive sequence
            TASKS_STARTRX: mmio.Mmio(packed struct(u32) {
                ///  Start TWI receive sequence
                TASKS_STARTRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved8: [4]u8,
            ///  Start TWI transmit sequence
            TASKS_STARTTX: mmio.Mmio(packed struct(u32) {
                ///  Start TWI transmit sequence
                TASKS_STARTTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved20: [8]u8,
            ///  Stop TWI transaction. Must be issued while the TWI master is not suspended.
            TASKS_STOP: mmio.Mmio(packed struct(u32) {
                ///  Stop TWI transaction. Must be issued while the TWI master is not suspended.
                TASKS_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved28: [4]u8,
            ///  Suspend TWI transaction
            TASKS_SUSPEND: mmio.Mmio(packed struct(u32) {
                ///  Suspend TWI transaction
                TASKS_SUSPEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Resume TWI transaction
            TASKS_RESUME: mmio.Mmio(packed struct(u32) {
                ///  Resume TWI transaction
                TASKS_RESUME: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved260: [224]u8,
            ///  TWI stopped
            EVENTS_STOPPED: mmio.Mmio(packed struct(u32) {
                ///  TWI stopped
                EVENTS_STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved292: [28]u8,
            ///  TWI error
            EVENTS_ERROR: mmio.Mmio(packed struct(u32) {
                ///  TWI error
                EVENTS_ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved328: [32]u8,
            ///  Last byte has been sent out after the SUSPEND task has been issued, TWI traffic is now suspended.
            EVENTS_SUSPENDED: mmio.Mmio(packed struct(u32) {
                ///  Last byte has been sent out after the SUSPEND task has been issued, TWI traffic is now suspended.
                EVENTS_SUSPENDED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Receive sequence started
            EVENTS_RXSTARTED: mmio.Mmio(packed struct(u32) {
                ///  Receive sequence started
                EVENTS_RXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Transmit sequence started
            EVENTS_TXSTARTED: mmio.Mmio(packed struct(u32) {
                ///  Transmit sequence started
                EVENTS_TXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved348: [8]u8,
            ///  Byte boundary, starting to receive the last byte
            EVENTS_LASTRX: mmio.Mmio(packed struct(u32) {
                ///  Byte boundary, starting to receive the last byte
                EVENTS_LASTRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Byte boundary, starting to transmit the last byte
            EVENTS_LASTTX: mmio.Mmio(packed struct(u32) {
                ///  Byte boundary, starting to transmit the last byte
                EVENTS_LASTTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved512: [156]u8,
            ///  Shortcuts between local events and tasks
            SHORTS: mmio.Mmio(packed struct(u32) {
                reserved7: u7,
                ///  Shortcut between event LASTTX and task STARTRX
                LASTTX_STARTRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event LASTTX and task SUSPEND
                LASTTX_SUSPEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event LASTTX and task STOP
                LASTTX_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event LASTRX and task STARTTX
                LASTRX_STARTTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event LASTRX and task SUSPEND
                LASTRX_SUSPEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event LASTRX and task STOP
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
                ///  Enable or disable interrupt for event STOPPED
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
                ///  Enable or disable interrupt for event ERROR
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
                ///  Enable or disable interrupt for event SUSPENDED
                SUSPENDED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event RXSTARTED
                RXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event TXSTARTED
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
                ///  Enable or disable interrupt for event LASTRX
                LASTRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event LASTTX
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
                ///  Write '1' to enable interrupt for event STOPPED
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
                ///  Write '1' to enable interrupt for event ERROR
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
                ///  Write '1' to enable interrupt for event SUSPENDED
                SUSPENDED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event RXSTARTED
                RXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event TXSTARTED
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
                ///  Write '1' to enable interrupt for event LASTRX
                LASTRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event LASTTX
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
                ///  Write '1' to disable interrupt for event STOPPED
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
                ///  Write '1' to disable interrupt for event ERROR
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
                ///  Write '1' to disable interrupt for event SUSPENDED
                SUSPENDED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event RXSTARTED
                RXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event TXSTARTED
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
                ///  Write '1' to disable interrupt for event LASTRX
                LASTRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event LASTTX
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
            ///  TWI frequency. Accuracy depends on the HFCLK source selected.
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
            TASKS_STOP: mmio.Mmio(packed struct(u32) {
                ///  Stop TWI transaction
                TASKS_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved28: [4]u8,
            ///  Suspend TWI transaction
            TASKS_SUSPEND: mmio.Mmio(packed struct(u32) {
                ///  Suspend TWI transaction
                TASKS_SUSPEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Resume TWI transaction
            TASKS_RESUME: mmio.Mmio(packed struct(u32) {
                ///  Resume TWI transaction
                TASKS_RESUME: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved48: [12]u8,
            ///  Prepare the TWI slave to respond to a write command
            TASKS_PREPARERX: mmio.Mmio(packed struct(u32) {
                ///  Prepare the TWI slave to respond to a write command
                TASKS_PREPARERX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Prepare the TWI slave to respond to a read command
            TASKS_PREPARETX: mmio.Mmio(packed struct(u32) {
                ///  Prepare the TWI slave to respond to a read command
                TASKS_PREPARETX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved260: [204]u8,
            ///  TWI stopped
            EVENTS_STOPPED: mmio.Mmio(packed struct(u32) {
                ///  TWI stopped
                EVENTS_STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved292: [28]u8,
            ///  TWI error
            EVENTS_ERROR: mmio.Mmio(packed struct(u32) {
                ///  TWI error
                EVENTS_ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved332: [36]u8,
            ///  Receive sequence started
            EVENTS_RXSTARTED: mmio.Mmio(packed struct(u32) {
                ///  Receive sequence started
                EVENTS_RXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Transmit sequence started
            EVENTS_TXSTARTED: mmio.Mmio(packed struct(u32) {
                ///  Transmit sequence started
                EVENTS_TXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved356: [16]u8,
            ///  Write command received
            EVENTS_WRITE: mmio.Mmio(packed struct(u32) {
                ///  Write command received
                EVENTS_WRITE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Read command received
            EVENTS_READ: mmio.Mmio(packed struct(u32) {
                ///  Read command received
                EVENTS_READ: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved512: [148]u8,
            ///  Shortcuts between local events and tasks
            SHORTS: mmio.Mmio(packed struct(u32) {
                reserved13: u13,
                ///  Shortcut between event WRITE and task SUSPEND
                WRITE_SUSPEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event READ and task SUSPEND
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
                ///  Enable or disable interrupt for event STOPPED
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
                ///  Enable or disable interrupt for event ERROR
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
                ///  Enable or disable interrupt for event RXSTARTED
                RXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event TXSTARTED
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
                ///  Enable or disable interrupt for event WRITE
                WRITE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event READ
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
                ///  Write '1' to enable interrupt for event STOPPED
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
                ///  Write '1' to enable interrupt for event ERROR
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
                ///  Write '1' to enable interrupt for event RXSTARTED
                RXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event TXSTARTED
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
                ///  Write '1' to enable interrupt for event WRITE
                WRITE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event READ
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
                ///  Write '1' to disable interrupt for event STOPPED
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
                ///  Write '1' to disable interrupt for event ERROR
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
                ///  Write '1' to disable interrupt for event RXSTARTED
                RXSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event TXSTARTED
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
                ///  Write '1' to disable interrupt for event WRITE
                WRITE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event READ
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
            ///  Description collection: TWI slave address n
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

        ///  Pulse Density Modulation (Digital Microphone) Interface
        pub const PDM = extern struct {
            ///  Starts continuous PDM transfer
            TASKS_START: mmio.Mmio(packed struct(u32) {
                ///  Starts continuous PDM transfer
                TASKS_START: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stops PDM transfer
            TASKS_STOP: mmio.Mmio(packed struct(u32) {
                ///  Stops PDM transfer
                TASKS_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved256: [248]u8,
            ///  PDM transfer has started
            EVENTS_STARTED: mmio.Mmio(packed struct(u32) {
                ///  PDM transfer has started
                EVENTS_STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  PDM transfer has finished
            EVENTS_STOPPED: mmio.Mmio(packed struct(u32) {
                ///  PDM transfer has finished
                EVENTS_STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  The PDM has written the last sample specified by SAMPLE.MAXCNT (or the last sample after a STOP task has been received) to Data RAM
            EVENTS_END: mmio.Mmio(packed struct(u32) {
                ///  The PDM has written the last sample specified by SAMPLE.MAXCNT (or the last sample after a STOP task has been received) to Data RAM
                EVENTS_END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved768: [500]u8,
            ///  Enable or disable interrupt
            INTEN: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable interrupt for event STARTED
                STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event STOPPED
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event END
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
                ///  Write '1' to enable interrupt for event STARTED
                STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event STOPPED
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event END
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
                ///  Write '1' to disable interrupt for event STARTED
                STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event STOPPED
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event END
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
                        ///  PDM_CLK = 32 MHz / 31 = 1.032 MHz. Nominal clock for RATIO=Ratio64.
                        Default = 0x8400000,
                        ///  PDM_CLK = 32 MHz / 30 = 1.067 MHz
                        @"1067K" = 0x8800000,
                        ///  PDM_CLK = 32 MHz / 26 = 1.231 MHz
                        @"1231K" = 0x9800000,
                        ///  PDM_CLK = 32 MHz / 25 = 1.280 MHz. Nominal clock for RATIO=Ratio80.
                        @"1280K" = 0xa000000,
                        ///  PDM_CLK = 32 MHz / 24 = 1.333 MHz
                        @"1333K" = 0xa800000,
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
                        ///  0dB gain adjustment
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
                    raw: u7,
                    value: enum(u7) {
                        ///  -20dB gain adjustment (minimum)
                        MinGain = 0x0,
                        ///  0dB gain adjustment
                        DefaultGain = 0x28,
                        ///  +20dB gain adjustment (maximum)
                        MaxGain = 0x50,
                        _,
                    },
                },
                padding: u25,
            }),
            ///  Selects the ratio between PDM_CLK and output sample rate. Change PDMCLKCTRL accordingly.
            RATIO: mmio.Mmio(packed struct(u32) {
                ///  Selects the ratio between PDM_CLK and output sample rate
                RATIO: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Ratio of 64
                        Ratio64 = 0x0,
                        ///  Ratio of 80
                        Ratio80 = 0x1,
                    },
                },
                padding: u31,
            }),
        };

        ///  ARM TrustZone CryptoCell register interface
        pub const CRYPTOCELL = extern struct {
            reserved1280: [1280]u8,
            ///  Enable CRYPTOCELL subsystem
            ENABLE: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable the CRYPTOCELL subsystem
                ENABLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  CRYPTOCELL subsystem disabled
                        Disabled = 0x0,
                        ///  CRYPTOCELL subsystem enabled
                        Enabled = 0x1,
                    },
                },
                padding: u31,
            }),
        };

        ///  CRYPTOCELL HOST_RGF interface
        pub const CC_HOST_RGF = extern struct {
            reserved6712: [6712]u8,
            ///  AES hardware key select
            HOST_CRYPTOKEY_SEL: mmio.Mmio(packed struct(u32) {
                ///  Select the source of the HW key that is used by the AES engine
                HOST_CRYPTOKEY_SEL: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Use device root key K_DR from CRYPTOCELL AO power domain
                        K_DR = 0x0,
                        ///  Use hard-coded RTL key K_PRTL
                        K_PRTL = 0x1,
                        ///  Use provided session key
                        Session = 0x2,
                        _,
                    },
                },
                padding: u30,
            }),
            reserved6732: [16]u8,
            ///  This write-once register is the K_PRTL lock register. When this register is set, K_PRTL can not be used and a zeroed key will be used instead. The value of this register is saved in the CRYPTOCELL AO power domain.
            HOST_IOT_KPRTL_LOCK: mmio.Mmio(packed struct(u32) {
                ///  This register is the K_PRTL lock register. When this register is set, K_PRTL can not be used and a zeroed key will be used instead. The value of this register is saved in the CRYPTOCELL AO power domain.
                HOST_IOT_KPRTL_LOCK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  K_PRTL can be selected for use from register HOST_CRYPTOKEY_SEL
                        Disabled = 0x0,
                        ///  K_PRTL has been locked until next power-on reset (POR). If K_PRTL is selected anyway, a zeroed key will be used instead.
                        Enabled = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  This register holds bits 31:0 of K_DR. The value of this register is saved in the CRYPTOCELL AO power domain. Reading from this address returns the K_DR valid status indicating if K_DR is successfully retained.
            HOST_IOT_KDR0: mmio.Mmio(packed struct(u32) {
                ///  Write: K_DR bits 31:0 Read: 0x00000000 when 128-bit K_DR key value is not yet retained in the CRYPTOCELL AO power domain Read: 0x00000001 when 128-bit K_DR key value is successfully retained in the CRYPTOCELL AO power domain
                HOST_IOT_KDR0: u32,
            }),
            ///  This register holds bits 63:32 of K_DR. The value of this register is saved in the CRYPTOCELL AO power domain.
            HOST_IOT_KDR1: mmio.Mmio(packed struct(u32) {
                ///  K_DR bits 63:32
                HOST_IOT_KDR1: u32,
            }),
            ///  This register holds bits 95:64 of K_DR. The value of this register is saved in the CRYPTOCELL AO power domain.
            HOST_IOT_KDR2: mmio.Mmio(packed struct(u32) {
                ///  K_DR bits 95:64
                HOST_IOT_KDR2: u32,
            }),
            ///  This register holds bits 127:96 of K_DR. The value of this register is saved in the CRYPTOCELL AO power domain.
            HOST_IOT_KDR3: mmio.Mmio(packed struct(u32) {
                ///  K_DR bits 127:96
                HOST_IOT_KDR3: u32,
            }),
            ///  Controls lifecycle state (LCS) for CRYPTOCELL subsystem
            HOST_IOT_LCS: mmio.Mmio(packed struct(u32) {
                ///  Lifecycle state value. This field is write-once per reset.
                LCS: packed union {
                    raw: u3,
                    value: enum(u3) {
                        ///  CC310 operates in debug mode
                        Debug = 0x0,
                        ///  CC310 operates in secure mode
                        Secure = 0x2,
                        _,
                    },
                },
                reserved8: u5,
                ///  This field is read-only and indicates if CRYPTOCELL LCS has been successfully configured since last reset
                LCS_IS_VALID: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  A valid LCS is not yet retained in the CRYPTOCELL AO power domain
                        Invalid = 0x0,
                        ///  A valid LCS is successfully retained in the CRYPTOCELL AO power domain
                        Valid = 0x1,
                    },
                },
                padding: u23,
            }),
        };

        ///  External flash interface
        pub const QSPI = extern struct {
            ///  Activate QSPI interface
            TASKS_ACTIVATE: mmio.Mmio(packed struct(u32) {
                ///  Activate QSPI interface
                TASKS_ACTIVATE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Start transfer from external flash memory to internal RAM
            TASKS_READSTART: mmio.Mmio(packed struct(u32) {
                ///  Start transfer from external flash memory to internal RAM
                TASKS_READSTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Start transfer from internal RAM to external flash memory
            TASKS_WRITESTART: mmio.Mmio(packed struct(u32) {
                ///  Start transfer from internal RAM to external flash memory
                TASKS_WRITESTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Start external flash memory erase operation
            TASKS_ERASESTART: mmio.Mmio(packed struct(u32) {
                ///  Start external flash memory erase operation
                TASKS_ERASESTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Deactivate QSPI interface
            TASKS_DEACTIVATE: mmio.Mmio(packed struct(u32) {
                ///  Deactivate QSPI interface
                TASKS_DEACTIVATE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved256: [236]u8,
            ///  QSPI peripheral is ready. This event will be generated as a response to any QSPI task.
            EVENTS_READY: mmio.Mmio(packed struct(u32) {
                ///  QSPI peripheral is ready. This event will be generated as a response to any QSPI task.
                EVENTS_READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved768: [508]u8,
            ///  Enable or disable interrupt
            INTEN: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable interrupt for event READY
                READY: packed union {
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
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to enable interrupt for event READY
                READY: packed union {
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
                ///  Write '1' to disable interrupt for event READY
                READY: packed union {
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
            reserved1280: [500]u8,
            ///  Enable QSPI peripheral and acquire the pins selected in PSELn registers
            ENABLE: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable QSPI
                ENABLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable QSPI
                        Disabled = 0x0,
                        ///  Enable QSPI
                        Enabled = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved1344: [60]u8,
            ///  Address offset into the external memory for Execute in Place operation.
            XIPOFFSET: mmio.Mmio(packed struct(u32) {
                ///  Address offset into the external memory for Execute in Place operation. Value must be a multiple of 4.
                XIPOFFSET: u32,
            }),
            ///  Interface configuration.
            IFCONFIG0: mmio.Mmio(packed struct(u32) {
                ///  Configure number of data lines and opcode used for reading.
                READOC: packed union {
                    raw: u3,
                    value: enum(u3) {
                        ///  Single data line SPI. FAST_READ (opcode 0x0B).
                        FASTREAD = 0x0,
                        ///  Dual data line SPI. READ2O (opcode 0x3B).
                        READ2O = 0x1,
                        ///  Dual data line SPI. READ2IO (opcode 0xBB).
                        READ2IO = 0x2,
                        ///  Quad data line SPI. READ4O (opcode 0x6B).
                        READ4O = 0x3,
                        ///  Quad data line SPI. READ4IO (opcode 0xEB).
                        READ4IO = 0x4,
                        _,
                    },
                },
                ///  Configure number of data lines and opcode used for writing.
                WRITEOC: packed union {
                    raw: u3,
                    value: enum(u3) {
                        ///  Single data line SPI. PP (opcode 0x02).
                        PP = 0x0,
                        ///  Dual data line SPI. PP2O (opcode 0xA2).
                        PP2O = 0x1,
                        ///  Quad data line SPI. PP4O (opcode 0x32).
                        PP4O = 0x2,
                        ///  Quad data line SPI. PP4IO (opcode 0x38).
                        PP4IO = 0x3,
                        _,
                    },
                },
                ///  Addressing mode.
                ADDRMODE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  24-bit addressing.
                        @"24BIT" = 0x0,
                        ///  32-bit addressing.
                        @"32BIT" = 0x1,
                    },
                },
                ///  Enable deep power-down mode (DPM) feature.
                DPMENABLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable DPM feature.
                        Disable = 0x0,
                        ///  Enable DPM feature.
                        Enable = 0x1,
                    },
                },
                reserved12: u4,
                ///  Page size for commands PP, PP2O, PP4O and PP4IO.
                PPSIZE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  256 bytes.
                        @"256Bytes" = 0x0,
                        ///  512 bytes.
                        @"512Bytes" = 0x1,
                    },
                },
                padding: u19,
            }),
            reserved1536: [184]u8,
            ///  Interface configuration.
            IFCONFIG1: mmio.Mmio(packed struct(u32) {
                ///  Minimum amount of time that the CSN pin must stay high before it can go low again. Value is specified in number of 16 MHz periods (62.5 ns).
                SCKDELAY: u8,
                reserved24: u16,
                ///  Enter/exit deep power-down mode (DPM) for external flash memory.
                DPMEN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Exit DPM.
                        Exit = 0x0,
                        ///  Enter DPM.
                        Enter = 0x1,
                    },
                },
                ///  Select SPI mode.
                SPIMODE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Mode 0: Data are captured on the clock rising edge and data is output on a falling edge. Base level of clock is 0 (CPOL=0, CPHA=0).
                        MODE0 = 0x0,
                        ///  Mode 3: Data are captured on the clock falling edge and data is output on a rising edge. Base level of clock is 1 (CPOL=1, CPHA=1).
                        MODE3 = 0x1,
                    },
                },
                reserved28: u2,
                ///  SCK frequency is given as 32 MHz / (SCKFREQ + 1).
                SCKFREQ: u4,
            }),
            ///  Status register.
            STATUS: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  Deep power-down mode (DPM) status of external flash.
                DPM: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  External flash is not in DPM.
                        Disabled = 0x0,
                        ///  External flash is in DPM.
                        Enabled = 0x1,
                    },
                },
                ///  Ready status.
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  QSPI peripheral is ready. It is allowed to trigger new tasks, writing custom instructions or enter/exit DPM.
                        READY = 0x1,
                        ///  QSPI peripheral is busy. It is not allowed to trigger any new tasks, writing custom instructions or enter/exit DPM.
                        BUSY = 0x0,
                    },
                },
                reserved24: u20,
                ///  Value of external flash device Status Register. When the external flash has two bytes status register this field includes the value of the low byte.
                SREG: u8,
            }),
            reserved1556: [12]u8,
            ///  Set the duration required to enter/exit deep power-down mode (DPM).
            DPMDUR: mmio.Mmio(packed struct(u32) {
                ///  Duration needed by external flash to enter DPM. Duration is given as ENTER * 256 * 62.5 ns.
                ENTER: u16,
                ///  Duration needed by external flash to exit DPM. Duration is given as EXIT * 256 * 62.5 ns.
                EXIT: u16,
            }),
            reserved1572: [12]u8,
            ///  Extended address configuration.
            ADDRCONF: mmio.Mmio(packed struct(u32) {
                ///  Opcode that enters the 32-bit addressing mode.
                OPCODE: u8,
                ///  Byte 0 following opcode.
                BYTE0: u8,
                ///  Byte 1 following byte 0.
                BYTE1: u8,
                ///  Extended addressing mode.
                MODE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Do not send any instruction.
                        NoInstr = 0x0,
                        ///  Send opcode.
                        Opcode = 0x1,
                        ///  Send opcode, byte0.
                        OpByte0 = 0x2,
                        ///  Send opcode, byte0, byte1.
                        All = 0x3,
                    },
                },
                ///  Wait for write complete before sending command.
                WIPWAIT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  No wait.
                        Disable = 0x0,
                        ///  Wait.
                        Enable = 0x1,
                    },
                },
                ///  Send WREN (write enable opcode 0x06) before instruction.
                WREN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Do not send WREN.
                        Disable = 0x0,
                        ///  Send WREN.
                        Enable = 0x1,
                    },
                },
                padding: u4,
            }),
            reserved1588: [12]u8,
            ///  Custom instruction configuration register.
            CINSTRCONF: mmio.Mmio(packed struct(u32) {
                ///  Opcode of Custom instruction.
                OPCODE: u8,
                ///  Length of custom instruction in number of bytes.
                LENGTH: packed union {
                    raw: u4,
                    value: enum(u4) {
                        ///  Send opcode only.
                        @"1B" = 0x1,
                        ///  Send opcode, CINSTRDAT0.BYTE0.
                        @"2B" = 0x2,
                        ///  Send opcode, CINSTRDAT0.BYTE0 -&gt; CINSTRDAT0.BYTE1.
                        @"3B" = 0x3,
                        ///  Send opcode, CINSTRDAT0.BYTE0 -&gt; CINSTRDAT0.BYTE2.
                        @"4B" = 0x4,
                        ///  Send opcode, CINSTRDAT0.BYTE0 -&gt; CINSTRDAT0.BYTE3.
                        @"5B" = 0x5,
                        ///  Send opcode, CINSTRDAT0.BYTE0 -&gt; CINSTRDAT1.BYTE4.
                        @"6B" = 0x6,
                        ///  Send opcode, CINSTRDAT0.BYTE0 -&gt; CINSTRDAT1.BYTE5.
                        @"7B" = 0x7,
                        ///  Send opcode, CINSTRDAT0.BYTE0 -&gt; CINSTRDAT1.BYTE6.
                        @"8B" = 0x8,
                        ///  Send opcode, CINSTRDAT0.BYTE0 -&gt; CINSTRDAT1.BYTE7.
                        @"9B" = 0x9,
                        _,
                    },
                },
                ///  Level of the IO2 pin (if connected) during transmission of custom instruction.
                LIO2: u1,
                ///  Level of the IO3 pin (if connected) during transmission of custom instruction.
                LIO3: u1,
                ///  Wait for write complete before sending command.
                WIPWAIT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  No wait.
                        Disable = 0x0,
                        ///  Wait.
                        Enable = 0x1,
                    },
                },
                ///  Send WREN (write enable opcode 0x06) before instruction.
                WREN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Do not send WREN.
                        Disable = 0x0,
                        ///  Send WREN.
                        Enable = 0x1,
                    },
                },
                ///  Enable long frame mode. When enabled, a custom instruction transaction has to be ended by writing the LFSTOP field.
                LFEN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Long frame mode disabled
                        Disable = 0x0,
                        ///  Long frame mode enabled
                        Enable = 0x1,
                    },
                },
                ///  Stop (finalize) long frame transaction
                LFSTOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Stop
                        Stop = 0x1,
                        _,
                    },
                },
                padding: u14,
            }),
            ///  Custom instruction data register 0.
            CINSTRDAT0: mmio.Mmio(packed struct(u32) {
                ///  Data byte 0
                BYTE0: u8,
                ///  Data byte 1
                BYTE1: u8,
                ///  Data byte 2
                BYTE2: u8,
                ///  Data byte 3
                BYTE3: u8,
            }),
            ///  Custom instruction data register 1.
            CINSTRDAT1: mmio.Mmio(packed struct(u32) {
                ///  Data byte 4
                BYTE4: u8,
                ///  Data byte 5
                BYTE5: u8,
                ///  Data byte 6
                BYTE6: u8,
                ///  Data byte 7
                BYTE7: u8,
            }),
            ///  SPI interface timing.
            IFTIMING: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  Timing related to sampling of the input serial data. The value of RXDELAY specifies the number of 64 MHz cycles (15.625 ns) delay from the the rising edge of the SPI Clock (SCK) until the input serial data is sampled. As en example, if set to 0 the input serial data is sampled on the rising edge of SCK.
                RXDELAY: u3,
                padding: u21,
            }),
        };

        ///  Pulse width modulation unit 0
        pub const PWM0 = extern struct {
            reserved4: [4]u8,
            ///  Stops PWM pulse generation on all channels at the end of current PWM period, and stops sequence playback
            TASKS_STOP: mmio.Mmio(packed struct(u32) {
                ///  Stops PWM pulse generation on all channels at the end of current PWM period, and stops sequence playback
                TASKS_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Description collection: Loads the first PWM value on all enabled channels from sequence n, and starts playing that sequence at the rate defined in SEQ[n]REFRESH and/or DECODER.MODE. Causes PWM generation to start if not running.
            TASKS_SEQSTART: [2]mmio.Mmio(packed struct(u32) {
                ///  Loads the first PWM value on all enabled channels from sequence n, and starts playing that sequence at the rate defined in SEQ[n]REFRESH and/or DECODER.MODE. Causes PWM generation to start if not running.
                TASKS_SEQSTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Steps by one value in the current sequence on all enabled channels if DECODER.MODE=NextStep. Does not cause PWM generation to start if not running.
            TASKS_NEXTSTEP: mmio.Mmio(packed struct(u32) {
                ///  Steps by one value in the current sequence on all enabled channels if DECODER.MODE=NextStep. Does not cause PWM generation to start if not running.
                TASKS_NEXTSTEP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved260: [240]u8,
            ///  Response to STOP task, emitted when PWM pulses are no longer generated
            EVENTS_STOPPED: mmio.Mmio(packed struct(u32) {
                ///  Response to STOP task, emitted when PWM pulses are no longer generated
                EVENTS_STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Description collection: First PWM period started on sequence n
            EVENTS_SEQSTARTED: [2]mmio.Mmio(packed struct(u32) {
                ///  First PWM period started on sequence n
                EVENTS_SEQSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Description collection: Emitted at end of every sequence n, when last value from RAM has been applied to wave counter
            EVENTS_SEQEND: [2]mmio.Mmio(packed struct(u32) {
                ///  Emitted at end of every sequence n, when last value from RAM has been applied to wave counter
                EVENTS_SEQEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Emitted at the end of each PWM period
            EVENTS_PWMPERIODEND: mmio.Mmio(packed struct(u32) {
                ///  Emitted at the end of each PWM period
                EVENTS_PWMPERIODEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Concatenated sequences have been played the amount of times defined in LOOP.CNT
            EVENTS_LOOPSDONE: mmio.Mmio(packed struct(u32) {
                ///  Concatenated sequences have been played the amount of times defined in LOOP.CNT
                EVENTS_LOOPSDONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved512: [224]u8,
            ///  Shortcuts between local events and tasks
            SHORTS: mmio.Mmio(packed struct(u32) {
                ///  Shortcut between event SEQEND[0] and task STOP
                SEQEND0_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event SEQEND[1] and task STOP
                SEQEND1_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event LOOPSDONE and task SEQSTART[0]
                LOOPSDONE_SEQSTART0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event LOOPSDONE and task SEQSTART[1]
                LOOPSDONE_SEQSTART1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event LOOPSDONE and task STOP
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
                ///  Enable or disable interrupt for event STOPPED
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event SEQSTARTED[0]
                SEQSTARTED0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event SEQSTARTED[1]
                SEQSTARTED1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event SEQEND[0]
                SEQEND0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event SEQEND[1]
                SEQEND1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event PWMPERIODEND
                PWMPERIODEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event LOOPSDONE
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
                ///  Write '1' to enable interrupt for event STOPPED
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event SEQSTARTED[0]
                SEQSTARTED0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event SEQSTARTED[1]
                SEQSTARTED1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event SEQEND[0]
                SEQEND0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event SEQEND[1]
                SEQEND1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event PWMPERIODEND
                PWMPERIODEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event LOOPSDONE
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
                ///  Write '1' to disable interrupt for event STOPPED
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event SEQSTARTED[0]
                SEQSTARTED0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event SEQSTARTED[1]
                SEQSTARTED1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event SEQEND[0]
                SEQEND0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event SEQEND[1]
                SEQEND1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event PWMPERIODEND
                PWMPERIODEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event LOOPSDONE
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
                ///  Selects up mode or up-and-down mode for the counter
                UPDOWN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Up counter, edge-aligned PWM duty cycle
                        Up = 0x0,
                        ///  Up and down counter, center-aligned PWM duty cycle
                        UpAndDown = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Value up to which the pulse generator counter counts
            COUNTERTOP: mmio.Mmio(packed struct(u32) {
                ///  Value up to which the pulse generator counter counts. This register is ignored when DECODER.MODE=WaveForm and only values from RAM are used.
                COUNTERTOP: u15,
                padding: u17,
            }),
            ///  Configuration for PWM_CLK
            PRESCALER: mmio.Mmio(packed struct(u32) {
                ///  Prescaler of PWM_CLK
                PRESCALER: packed union {
                    raw: u3,
                    value: enum(u3) {
                        ///  Divide by 1 (16 MHz)
                        DIV_1 = 0x0,
                        ///  Divide by 2 (8 MHz)
                        DIV_2 = 0x1,
                        ///  Divide by 4 (4 MHz)
                        DIV_4 = 0x2,
                        ///  Divide by 8 (2 MHz)
                        DIV_8 = 0x3,
                        ///  Divide by 16 (1 MHz)
                        DIV_16 = 0x4,
                        ///  Divide by 32 (500 kHz)
                        DIV_32 = 0x5,
                        ///  Divide by 64 (250 kHz)
                        DIV_64 = 0x6,
                        ///  Divide by 128 (125 kHz)
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
            ///  Number of playbacks of a loop
            LOOP: mmio.Mmio(packed struct(u32) {
                ///  Number of playbacks of pattern cycles
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

        ///  Universal serial bus device
        pub const USBD = extern struct {
            reserved4: [4]u8,
            ///  Description collection: Captures the EPIN[n].PTR and EPIN[n].MAXCNT registers values, and enables endpoint IN n to respond to traffic from host
            TASKS_STARTEPIN: [8]mmio.Mmio(packed struct(u32) {
                ///  Captures the EPIN[n].PTR and EPIN[n].MAXCNT registers values, and enables endpoint IN n to respond to traffic from host
                TASKS_STARTEPIN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Captures the ISOIN.PTR and ISOIN.MAXCNT registers values, and enables sending data on ISO endpoint
            TASKS_STARTISOIN: mmio.Mmio(packed struct(u32) {
                ///  Captures the ISOIN.PTR and ISOIN.MAXCNT registers values, and enables sending data on ISO endpoint
                TASKS_STARTISOIN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Description collection: Captures the EPOUT[n].PTR and EPOUT[n].MAXCNT registers values, and enables endpoint n to respond to traffic from host
            TASKS_STARTEPOUT: [8]mmio.Mmio(packed struct(u32) {
                ///  Captures the EPOUT[n].PTR and EPOUT[n].MAXCNT registers values, and enables endpoint n to respond to traffic from host
                TASKS_STARTEPOUT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Captures the ISOOUT.PTR and ISOOUT.MAXCNT registers values, and enables receiving of data on ISO endpoint
            TASKS_STARTISOOUT: mmio.Mmio(packed struct(u32) {
                ///  Captures the ISOOUT.PTR and ISOOUT.MAXCNT registers values, and enables receiving of data on ISO endpoint
                TASKS_STARTISOOUT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Allows OUT data stage on control endpoint 0
            TASKS_EP0RCVOUT: mmio.Mmio(packed struct(u32) {
                ///  Allows OUT data stage on control endpoint 0
                TASKS_EP0RCVOUT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Allows status stage on control endpoint 0
            TASKS_EP0STATUS: mmio.Mmio(packed struct(u32) {
                ///  Allows status stage on control endpoint 0
                TASKS_EP0STATUS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stalls data and status stage on control endpoint 0
            TASKS_EP0STALL: mmio.Mmio(packed struct(u32) {
                ///  Stalls data and status stage on control endpoint 0
                TASKS_EP0STALL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Forces D+ and D- lines into the state defined in the DPDMVALUE register
            TASKS_DPDMDRIVE: mmio.Mmio(packed struct(u32) {
                ///  Forces D+ and D- lines into the state defined in the DPDMVALUE register
                TASKS_DPDMDRIVE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stops forcing D+ and D- lines into any state (USB engine takes control)
            TASKS_DPDMNODRIVE: mmio.Mmio(packed struct(u32) {
                ///  Stops forcing D+ and D- lines into any state (USB engine takes control)
                TASKS_DPDMNODRIVE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved256: [160]u8,
            ///  Signals that a USB reset condition has been detected on USB lines
            EVENTS_USBRESET: mmio.Mmio(packed struct(u32) {
                ///  Signals that a USB reset condition has been detected on USB lines
                EVENTS_USBRESET: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Confirms that the EPIN[n].PTR and EPIN[n].MAXCNT, or EPOUT[n].PTR and EPOUT[n].MAXCNT registers have been captured on all endpoints reported in the EPSTATUS register
            EVENTS_STARTED: mmio.Mmio(packed struct(u32) {
                ///  Confirms that the EPIN[n].PTR and EPIN[n].MAXCNT, or EPOUT[n].PTR and EPOUT[n].MAXCNT registers have been captured on all endpoints reported in the EPSTATUS register
                EVENTS_STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Description collection: The whole EPIN[n] buffer has been consumed. The RAM buffer can be accessed safely by software.
            EVENTS_ENDEPIN: [8]mmio.Mmio(packed struct(u32) {
                ///  The whole EPIN[n] buffer has been consumed. The RAM buffer can be accessed safely by software.
                EVENTS_ENDEPIN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  An acknowledged data transfer has taken place on the control endpoint
            EVENTS_EP0DATADONE: mmio.Mmio(packed struct(u32) {
                ///  An acknowledged data transfer has taken place on the control endpoint
                EVENTS_EP0DATADONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  The whole ISOIN buffer has been consumed. The RAM buffer can be accessed safely by software.
            EVENTS_ENDISOIN: mmio.Mmio(packed struct(u32) {
                ///  The whole ISOIN buffer has been consumed. The RAM buffer can be accessed safely by software.
                EVENTS_ENDISOIN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Description collection: The whole EPOUT[n] buffer has been consumed. The RAM buffer can be accessed safely by software.
            EVENTS_ENDEPOUT: [8]mmio.Mmio(packed struct(u32) {
                ///  The whole EPOUT[n] buffer has been consumed. The RAM buffer can be accessed safely by software.
                EVENTS_ENDEPOUT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  The whole ISOOUT buffer has been consumed. The RAM buffer can be accessed safely by software.
            EVENTS_ENDISOOUT: mmio.Mmio(packed struct(u32) {
                ///  The whole ISOOUT buffer has been consumed. The RAM buffer can be accessed safely by software.
                EVENTS_ENDISOOUT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Signals that a SOF (start of frame) condition has been detected on USB lines
            EVENTS_SOF: mmio.Mmio(packed struct(u32) {
                ///  Signals that a SOF (start of frame) condition has been detected on USB lines
                EVENTS_SOF: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  An event or an error not covered by specific events has occurred. Check EVENTCAUSE register to find the cause.
            EVENTS_USBEVENT: mmio.Mmio(packed struct(u32) {
                ///  An event or an error not covered by specific events has occurred. Check EVENTCAUSE register to find the cause.
                EVENTS_USBEVENT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  A valid SETUP token has been received (and acknowledged) on the control endpoint
            EVENTS_EP0SETUP: mmio.Mmio(packed struct(u32) {
                ///  A valid SETUP token has been received (and acknowledged) on the control endpoint
                EVENTS_EP0SETUP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  A data transfer has occurred on a data endpoint, indicated by the EPDATASTATUS register
            EVENTS_EPDATA: mmio.Mmio(packed struct(u32) {
                ///  A data transfer has occurred on a data endpoint, indicated by the EPDATASTATUS register
                EVENTS_EPDATA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved512: [156]u8,
            ///  Shortcuts between local events and tasks
            SHORTS: mmio.Mmio(packed struct(u32) {
                ///  Shortcut between event EP0DATADONE and task STARTEPIN[0]
                EP0DATADONE_STARTEPIN0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event EP0DATADONE and task STARTEPOUT[0]
                EP0DATADONE_STARTEPOUT0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event EP0DATADONE and task EP0STATUS
                EP0DATADONE_EP0STATUS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event ENDEPOUT[0] and task EP0STATUS
                ENDEPOUT0_EP0STATUS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event ENDEPOUT[0] and task EP0RCVOUT
                ENDEPOUT0_EP0RCVOUT: packed union {
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
                ///  Enable or disable interrupt for event USBRESET
                USBRESET: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event STARTED
                STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event ENDEPIN[0]
                ENDEPIN0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event ENDEPIN[1]
                ENDEPIN1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event ENDEPIN[2]
                ENDEPIN2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event ENDEPIN[3]
                ENDEPIN3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event ENDEPIN[4]
                ENDEPIN4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event ENDEPIN[5]
                ENDEPIN5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event ENDEPIN[6]
                ENDEPIN6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event ENDEPIN[7]
                ENDEPIN7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event EP0DATADONE
                EP0DATADONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event ENDISOIN
                ENDISOIN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event ENDEPOUT[0]
                ENDEPOUT0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event ENDEPOUT[1]
                ENDEPOUT1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event ENDEPOUT[2]
                ENDEPOUT2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event ENDEPOUT[3]
                ENDEPOUT3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event ENDEPOUT[4]
                ENDEPOUT4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event ENDEPOUT[5]
                ENDEPOUT5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event ENDEPOUT[6]
                ENDEPOUT6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event ENDEPOUT[7]
                ENDEPOUT7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event ENDISOOUT
                ENDISOOUT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event SOF
                SOF: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event USBEVENT
                USBEVENT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event EP0SETUP
                EP0SETUP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event EPDATA
                EPDATA: packed union {
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
                ///  Write '1' to enable interrupt for event USBRESET
                USBRESET: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event STARTED
                STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ENDEPIN[0]
                ENDEPIN0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ENDEPIN[1]
                ENDEPIN1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ENDEPIN[2]
                ENDEPIN2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ENDEPIN[3]
                ENDEPIN3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ENDEPIN[4]
                ENDEPIN4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ENDEPIN[5]
                ENDEPIN5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ENDEPIN[6]
                ENDEPIN6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ENDEPIN[7]
                ENDEPIN7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event EP0DATADONE
                EP0DATADONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ENDISOIN
                ENDISOIN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ENDEPOUT[0]
                ENDEPOUT0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ENDEPOUT[1]
                ENDEPOUT1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ENDEPOUT[2]
                ENDEPOUT2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ENDEPOUT[3]
                ENDEPOUT3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ENDEPOUT[4]
                ENDEPOUT4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ENDEPOUT[5]
                ENDEPOUT5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ENDEPOUT[6]
                ENDEPOUT6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ENDEPOUT[7]
                ENDEPOUT7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ENDISOOUT
                ENDISOOUT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event SOF
                SOF: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event USBEVENT
                USBEVENT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event EP0SETUP
                EP0SETUP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event EPDATA
                EPDATA: packed union {
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
                ///  Write '1' to disable interrupt for event USBRESET
                USBRESET: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event STARTED
                STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ENDEPIN[0]
                ENDEPIN0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ENDEPIN[1]
                ENDEPIN1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ENDEPIN[2]
                ENDEPIN2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ENDEPIN[3]
                ENDEPIN3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ENDEPIN[4]
                ENDEPIN4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ENDEPIN[5]
                ENDEPIN5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ENDEPIN[6]
                ENDEPIN6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ENDEPIN[7]
                ENDEPIN7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event EP0DATADONE
                EP0DATADONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ENDISOIN
                ENDISOIN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ENDEPOUT[0]
                ENDEPOUT0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ENDEPOUT[1]
                ENDEPOUT1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ENDEPOUT[2]
                ENDEPOUT2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ENDEPOUT[3]
                ENDEPOUT3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ENDEPOUT[4]
                ENDEPOUT4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ENDEPOUT[5]
                ENDEPOUT5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ENDEPOUT[6]
                ENDEPOUT6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ENDEPOUT[7]
                ENDEPOUT7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ENDISOOUT
                ENDISOOUT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event SOF
                SOF: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event USBEVENT
                USBEVENT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event EP0SETUP
                EP0SETUP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event EPDATA
                EPDATA: packed union {
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
            reserved1024: [244]u8,
            ///  Details on what caused the USBEVENT event
            EVENTCAUSE: mmio.Mmio(packed struct(u32) {
                ///  CRC error was detected on isochronous OUT endpoint 8. Write '1' to clear.
                ISOOUTCRC: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  No error detected
                        NotDetected = 0x0,
                        ///  Error detected
                        Detected = 0x1,
                    },
                },
                reserved8: u7,
                ///  Signals that USB lines have been idle long enough for the device to enter suspend. Write '1' to clear.
                SUSPEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Suspend not detected
                        NotDetected = 0x0,
                        ///  Suspend detected
                        Detected = 0x1,
                    },
                },
                ///  Signals that a RESUME condition (K state or activity restart) has been detected on USB lines. Write '1' to clear.
                RESUME: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Resume not detected
                        NotDetected = 0x0,
                        ///  Resume detected
                        Detected = 0x1,
                    },
                },
                ///  USB MAC has been woken up and operational. Write '1' to clear.
                USBWUALLOWED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Wake up not allowed
                        NotAllowed = 0x0,
                        ///  Wake up allowed
                        Allowed = 0x1,
                    },
                },
                ///  USB device is ready for normal operation. Write '1' to clear.
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  USBEVENT was not issued due to USBD peripheral ready
                        NotDetected = 0x0,
                        ///  USBD peripheral is ready
                        Ready = 0x1,
                    },
                },
                padding: u20,
            }),
            reserved1128: [100]u8,
            ///  Provides information on which endpoint's EasyDMA registers have been captured
            EPSTATUS: mmio.Mmio(packed struct(u32) {
                ///  Captured state of endpoint's EasyDMA registers. Write '1' to clear.
                EPIN0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  EasyDMA registers have not been captured for this endpoint
                        NoData = 0x0,
                        ///  EasyDMA registers have been captured for this endpoint
                        DataDone = 0x1,
                    },
                },
                ///  Captured state of endpoint's EasyDMA registers. Write '1' to clear.
                EPIN1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  EasyDMA registers have not been captured for this endpoint
                        NoData = 0x0,
                        ///  EasyDMA registers have been captured for this endpoint
                        DataDone = 0x1,
                    },
                },
                ///  Captured state of endpoint's EasyDMA registers. Write '1' to clear.
                EPIN2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  EasyDMA registers have not been captured for this endpoint
                        NoData = 0x0,
                        ///  EasyDMA registers have been captured for this endpoint
                        DataDone = 0x1,
                    },
                },
                ///  Captured state of endpoint's EasyDMA registers. Write '1' to clear.
                EPIN3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  EasyDMA registers have not been captured for this endpoint
                        NoData = 0x0,
                        ///  EasyDMA registers have been captured for this endpoint
                        DataDone = 0x1,
                    },
                },
                ///  Captured state of endpoint's EasyDMA registers. Write '1' to clear.
                EPIN4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  EasyDMA registers have not been captured for this endpoint
                        NoData = 0x0,
                        ///  EasyDMA registers have been captured for this endpoint
                        DataDone = 0x1,
                    },
                },
                ///  Captured state of endpoint's EasyDMA registers. Write '1' to clear.
                EPIN5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  EasyDMA registers have not been captured for this endpoint
                        NoData = 0x0,
                        ///  EasyDMA registers have been captured for this endpoint
                        DataDone = 0x1,
                    },
                },
                ///  Captured state of endpoint's EasyDMA registers. Write '1' to clear.
                EPIN6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  EasyDMA registers have not been captured for this endpoint
                        NoData = 0x0,
                        ///  EasyDMA registers have been captured for this endpoint
                        DataDone = 0x1,
                    },
                },
                ///  Captured state of endpoint's EasyDMA registers. Write '1' to clear.
                EPIN7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  EasyDMA registers have not been captured for this endpoint
                        NoData = 0x0,
                        ///  EasyDMA registers have been captured for this endpoint
                        DataDone = 0x1,
                    },
                },
                ///  Captured state of endpoint's EasyDMA registers. Write '1' to clear.
                EPIN8: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  EasyDMA registers have not been captured for this endpoint
                        NoData = 0x0,
                        ///  EasyDMA registers have been captured for this endpoint
                        DataDone = 0x1,
                    },
                },
                reserved16: u7,
                ///  Captured state of endpoint's EasyDMA registers. Write '1' to clear.
                EPOUT0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  EasyDMA registers have not been captured for this endpoint
                        NoData = 0x0,
                        ///  EasyDMA registers have been captured for this endpoint
                        DataDone = 0x1,
                    },
                },
                ///  Captured state of endpoint's EasyDMA registers. Write '1' to clear.
                EPOUT1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  EasyDMA registers have not been captured for this endpoint
                        NoData = 0x0,
                        ///  EasyDMA registers have been captured for this endpoint
                        DataDone = 0x1,
                    },
                },
                ///  Captured state of endpoint's EasyDMA registers. Write '1' to clear.
                EPOUT2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  EasyDMA registers have not been captured for this endpoint
                        NoData = 0x0,
                        ///  EasyDMA registers have been captured for this endpoint
                        DataDone = 0x1,
                    },
                },
                ///  Captured state of endpoint's EasyDMA registers. Write '1' to clear.
                EPOUT3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  EasyDMA registers have not been captured for this endpoint
                        NoData = 0x0,
                        ///  EasyDMA registers have been captured for this endpoint
                        DataDone = 0x1,
                    },
                },
                ///  Captured state of endpoint's EasyDMA registers. Write '1' to clear.
                EPOUT4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  EasyDMA registers have not been captured for this endpoint
                        NoData = 0x0,
                        ///  EasyDMA registers have been captured for this endpoint
                        DataDone = 0x1,
                    },
                },
                ///  Captured state of endpoint's EasyDMA registers. Write '1' to clear.
                EPOUT5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  EasyDMA registers have not been captured for this endpoint
                        NoData = 0x0,
                        ///  EasyDMA registers have been captured for this endpoint
                        DataDone = 0x1,
                    },
                },
                ///  Captured state of endpoint's EasyDMA registers. Write '1' to clear.
                EPOUT6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  EasyDMA registers have not been captured for this endpoint
                        NoData = 0x0,
                        ///  EasyDMA registers have been captured for this endpoint
                        DataDone = 0x1,
                    },
                },
                ///  Captured state of endpoint's EasyDMA registers. Write '1' to clear.
                EPOUT7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  EasyDMA registers have not been captured for this endpoint
                        NoData = 0x0,
                        ///  EasyDMA registers have been captured for this endpoint
                        DataDone = 0x1,
                    },
                },
                ///  Captured state of endpoint's EasyDMA registers. Write '1' to clear.
                EPOUT8: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  EasyDMA registers have not been captured for this endpoint
                        NoData = 0x0,
                        ///  EasyDMA registers have been captured for this endpoint
                        DataDone = 0x1,
                    },
                },
                padding: u7,
            }),
            ///  Provides information on which endpoint(s) an acknowledged data transfer has occurred (EPDATA event)
            EPDATASTATUS: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Acknowledged data transfer on this IN endpoint. Write '1' to clear.
                EPIN1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  No acknowledged data transfer on this endpoint
                        NotDone = 0x0,
                        ///  Acknowledged data transfer on this endpoint has occurred
                        DataDone = 0x1,
                    },
                },
                ///  Acknowledged data transfer on this IN endpoint. Write '1' to clear.
                EPIN2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  No acknowledged data transfer on this endpoint
                        NotDone = 0x0,
                        ///  Acknowledged data transfer on this endpoint has occurred
                        DataDone = 0x1,
                    },
                },
                ///  Acknowledged data transfer on this IN endpoint. Write '1' to clear.
                EPIN3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  No acknowledged data transfer on this endpoint
                        NotDone = 0x0,
                        ///  Acknowledged data transfer on this endpoint has occurred
                        DataDone = 0x1,
                    },
                },
                ///  Acknowledged data transfer on this IN endpoint. Write '1' to clear.
                EPIN4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  No acknowledged data transfer on this endpoint
                        NotDone = 0x0,
                        ///  Acknowledged data transfer on this endpoint has occurred
                        DataDone = 0x1,
                    },
                },
                ///  Acknowledged data transfer on this IN endpoint. Write '1' to clear.
                EPIN5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  No acknowledged data transfer on this endpoint
                        NotDone = 0x0,
                        ///  Acknowledged data transfer on this endpoint has occurred
                        DataDone = 0x1,
                    },
                },
                ///  Acknowledged data transfer on this IN endpoint. Write '1' to clear.
                EPIN6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  No acknowledged data transfer on this endpoint
                        NotDone = 0x0,
                        ///  Acknowledged data transfer on this endpoint has occurred
                        DataDone = 0x1,
                    },
                },
                ///  Acknowledged data transfer on this IN endpoint. Write '1' to clear.
                EPIN7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  No acknowledged data transfer on this endpoint
                        NotDone = 0x0,
                        ///  Acknowledged data transfer on this endpoint has occurred
                        DataDone = 0x1,
                    },
                },
                reserved17: u9,
                ///  Acknowledged data transfer on this OUT endpoint. Write '1' to clear.
                EPOUT1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  No acknowledged data transfer on this endpoint
                        NotStarted = 0x0,
                        ///  Acknowledged data transfer on this endpoint has occurred
                        Started = 0x1,
                    },
                },
                ///  Acknowledged data transfer on this OUT endpoint. Write '1' to clear.
                EPOUT2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  No acknowledged data transfer on this endpoint
                        NotStarted = 0x0,
                        ///  Acknowledged data transfer on this endpoint has occurred
                        Started = 0x1,
                    },
                },
                ///  Acknowledged data transfer on this OUT endpoint. Write '1' to clear.
                EPOUT3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  No acknowledged data transfer on this endpoint
                        NotStarted = 0x0,
                        ///  Acknowledged data transfer on this endpoint has occurred
                        Started = 0x1,
                    },
                },
                ///  Acknowledged data transfer on this OUT endpoint. Write '1' to clear.
                EPOUT4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  No acknowledged data transfer on this endpoint
                        NotStarted = 0x0,
                        ///  Acknowledged data transfer on this endpoint has occurred
                        Started = 0x1,
                    },
                },
                ///  Acknowledged data transfer on this OUT endpoint. Write '1' to clear.
                EPOUT5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  No acknowledged data transfer on this endpoint
                        NotStarted = 0x0,
                        ///  Acknowledged data transfer on this endpoint has occurred
                        Started = 0x1,
                    },
                },
                ///  Acknowledged data transfer on this OUT endpoint. Write '1' to clear.
                EPOUT6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  No acknowledged data transfer on this endpoint
                        NotStarted = 0x0,
                        ///  Acknowledged data transfer on this endpoint has occurred
                        Started = 0x1,
                    },
                },
                ///  Acknowledged data transfer on this OUT endpoint. Write '1' to clear.
                EPOUT7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  No acknowledged data transfer on this endpoint
                        NotStarted = 0x0,
                        ///  Acknowledged data transfer on this endpoint has occurred
                        Started = 0x1,
                    },
                },
                padding: u8,
            }),
            ///  Device USB address
            USBADDR: mmio.Mmio(packed struct(u32) {
                ///  Device USB address
                ADDR: u7,
                padding: u25,
            }),
            reserved1152: [12]u8,
            ///  SETUP data, byte 0, bmRequestType
            BMREQUESTTYPE: mmio.Mmio(packed struct(u32) {
                ///  Data transfer type
                RECIPIENT: packed union {
                    raw: u5,
                    value: enum(u5) {
                        ///  Device
                        Device = 0x0,
                        ///  Interface
                        Interface = 0x1,
                        ///  Endpoint
                        Endpoint = 0x2,
                        ///  Other
                        Other = 0x3,
                        _,
                    },
                },
                ///  Data transfer type
                TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Standard
                        Standard = 0x0,
                        ///  Class
                        Class = 0x1,
                        ///  Vendor
                        Vendor = 0x2,
                        _,
                    },
                },
                ///  Data transfer direction
                DIRECTION: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Host-to-device
                        HostToDevice = 0x0,
                        ///  Device-to-host
                        DeviceToHost = 0x1,
                    },
                },
                padding: u24,
            }),
            ///  SETUP data, byte 1, bRequest
            BREQUEST: mmio.Mmio(packed struct(u32) {
                ///  SETUP data, byte 1, bRequest. Values provided for standard requests only, user must implement class and vendor values.
                BREQUEST: packed union {
                    raw: u8,
                    value: enum(u8) {
                        ///  Standard request GET_STATUS
                        STD_GET_STATUS = 0x0,
                        ///  Standard request CLEAR_FEATURE
                        STD_CLEAR_FEATURE = 0x1,
                        ///  Standard request SET_FEATURE
                        STD_SET_FEATURE = 0x3,
                        ///  Standard request SET_ADDRESS
                        STD_SET_ADDRESS = 0x5,
                        ///  Standard request GET_DESCRIPTOR
                        STD_GET_DESCRIPTOR = 0x6,
                        ///  Standard request SET_DESCRIPTOR
                        STD_SET_DESCRIPTOR = 0x7,
                        ///  Standard request GET_CONFIGURATION
                        STD_GET_CONFIGURATION = 0x8,
                        ///  Standard request SET_CONFIGURATION
                        STD_SET_CONFIGURATION = 0x9,
                        ///  Standard request GET_INTERFACE
                        STD_GET_INTERFACE = 0xa,
                        ///  Standard request SET_INTERFACE
                        STD_SET_INTERFACE = 0xb,
                        ///  Standard request SYNCH_FRAME
                        STD_SYNCH_FRAME = 0xc,
                        _,
                    },
                },
                padding: u24,
            }),
            ///  SETUP data, byte 2, LSB of wValue
            WVALUEL: mmio.Mmio(packed struct(u32) {
                ///  SETUP data, byte 2, LSB of wValue
                WVALUEL: u8,
                padding: u24,
            }),
            ///  SETUP data, byte 3, MSB of wValue
            WVALUEH: mmio.Mmio(packed struct(u32) {
                ///  SETUP data, byte 3, MSB of wValue
                WVALUEH: u8,
                padding: u24,
            }),
            ///  SETUP data, byte 4, LSB of wIndex
            WINDEXL: mmio.Mmio(packed struct(u32) {
                ///  SETUP data, byte 4, LSB of wIndex
                WINDEXL: u8,
                padding: u24,
            }),
            ///  SETUP data, byte 5, MSB of wIndex
            WINDEXH: mmio.Mmio(packed struct(u32) {
                ///  SETUP data, byte 5, MSB of wIndex
                WINDEXH: u8,
                padding: u24,
            }),
            ///  SETUP data, byte 6, LSB of wLength
            WLENGTHL: mmio.Mmio(packed struct(u32) {
                ///  SETUP data, byte 6, LSB of wLength
                WLENGTHL: u8,
                padding: u24,
            }),
            ///  SETUP data, byte 7, MSB of wLength
            WLENGTHH: mmio.Mmio(packed struct(u32) {
                ///  SETUP data, byte 7, MSB of wLength
                WLENGTHH: u8,
                padding: u24,
            }),
            reserved1280: [96]u8,
            ///  Enable USB
            ENABLE: mmio.Mmio(packed struct(u32) {
                ///  Enable USB
                ENABLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  USB peripheral is disabled
                        Disabled = 0x0,
                        ///  USB peripheral is enabled
                        Enabled = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Control of the USB pull-up
            USBPULLUP: mmio.Mmio(packed struct(u32) {
                ///  Control of the USB pull-up on the D+ line
                CONNECT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Pull-up is disconnected
                        Disabled = 0x0,
                        ///  Pull-up is connected to D+
                        Enabled = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  State D+ and D- lines will be forced into by the DPDMDRIVE task. The DPDMNODRIVE task reverts the control of the lines to MAC IP (no forcing).
            DPDMVALUE: mmio.Mmio(packed struct(u32) {
                ///  State D+ and D- lines will be forced into by the DPDMDRIVE task
                STATE: packed union {
                    raw: u5,
                    value: enum(u5) {
                        ///  D+ forced low, D- forced high (K state) for a timing preset in hardware (50 us or 5 ms, depending on bus state)
                        Resume = 0x1,
                        ///  D+ forced high, D- forced low (J state)
                        J = 0x2,
                        ///  D+ forced low, D- forced high (K state)
                        K = 0x4,
                        _,
                    },
                },
                padding: u27,
            }),
            ///  Data toggle control and status
            DTOGGLE: mmio.Mmio(packed struct(u32) {
                ///  Select bulk endpoint number
                EP: u3,
                reserved7: u4,
                ///  Selects IN or OUT endpoint
                IO: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Selects OUT endpoint
                        Out = 0x0,
                        ///  Selects IN endpoint
                        In = 0x1,
                    },
                },
                ///  Data toggle value
                VALUE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  No action on data toggle when writing the register with this value
                        Nop = 0x0,
                        ///  Data toggle is DATA0 on endpoint set by EP and IO
                        Data0 = 0x1,
                        ///  Data toggle is DATA1 on endpoint set by EP and IO
                        Data1 = 0x2,
                        _,
                    },
                },
                padding: u22,
            }),
            ///  Endpoint IN enable
            EPINEN: mmio.Mmio(packed struct(u32) {
                ///  Enable IN endpoint 0
                IN0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable endpoint IN 0 (no response to IN tokens)
                        Disable = 0x0,
                        ///  Enable endpoint IN 0 (response to IN tokens)
                        Enable = 0x1,
                    },
                },
                ///  Enable IN endpoint 1
                IN1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable endpoint IN 1 (no response to IN tokens)
                        Disable = 0x0,
                        ///  Enable endpoint IN 1 (response to IN tokens)
                        Enable = 0x1,
                    },
                },
                ///  Enable IN endpoint 2
                IN2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable endpoint IN 2 (no response to IN tokens)
                        Disable = 0x0,
                        ///  Enable endpoint IN 2 (response to IN tokens)
                        Enable = 0x1,
                    },
                },
                ///  Enable IN endpoint 3
                IN3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable endpoint IN 3 (no response to IN tokens)
                        Disable = 0x0,
                        ///  Enable endpoint IN 3 (response to IN tokens)
                        Enable = 0x1,
                    },
                },
                ///  Enable IN endpoint 4
                IN4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable endpoint IN 4 (no response to IN tokens)
                        Disable = 0x0,
                        ///  Enable endpoint IN 4 (response to IN tokens)
                        Enable = 0x1,
                    },
                },
                ///  Enable IN endpoint 5
                IN5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable endpoint IN 5 (no response to IN tokens)
                        Disable = 0x0,
                        ///  Enable endpoint IN 5 (response to IN tokens)
                        Enable = 0x1,
                    },
                },
                ///  Enable IN endpoint 6
                IN6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable endpoint IN 6 (no response to IN tokens)
                        Disable = 0x0,
                        ///  Enable endpoint IN 6 (response to IN tokens)
                        Enable = 0x1,
                    },
                },
                ///  Enable IN endpoint 7
                IN7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable endpoint IN 7 (no response to IN tokens)
                        Disable = 0x0,
                        ///  Enable endpoint IN 7 (response to IN tokens)
                        Enable = 0x1,
                    },
                },
                ///  Enable ISO IN endpoint
                ISOIN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable ISO IN endpoint 8
                        Disable = 0x0,
                        ///  Enable ISO IN endpoint 8
                        Enable = 0x1,
                    },
                },
                padding: u23,
            }),
            ///  Endpoint OUT enable
            EPOUTEN: mmio.Mmio(packed struct(u32) {
                ///  Enable OUT endpoint 0
                OUT0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable endpoint OUT 0 (no response to OUT tokens)
                        Disable = 0x0,
                        ///  Enable endpoint OUT 0 (response to OUT tokens)
                        Enable = 0x1,
                    },
                },
                ///  Enable OUT endpoint 1
                OUT1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable endpoint OUT 1 (no response to OUT tokens)
                        Disable = 0x0,
                        ///  Enable endpoint OUT 1 (response to OUT tokens)
                        Enable = 0x1,
                    },
                },
                ///  Enable OUT endpoint 2
                OUT2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable endpoint OUT 2 (no response to OUT tokens)
                        Disable = 0x0,
                        ///  Enable endpoint OUT 2 (response to OUT tokens)
                        Enable = 0x1,
                    },
                },
                ///  Enable OUT endpoint 3
                OUT3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable endpoint OUT 3 (no response to OUT tokens)
                        Disable = 0x0,
                        ///  Enable endpoint OUT 3 (response to OUT tokens)
                        Enable = 0x1,
                    },
                },
                ///  Enable OUT endpoint 4
                OUT4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable endpoint OUT 4 (no response to OUT tokens)
                        Disable = 0x0,
                        ///  Enable endpoint OUT 4 (response to OUT tokens)
                        Enable = 0x1,
                    },
                },
                ///  Enable OUT endpoint 5
                OUT5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable endpoint OUT 5 (no response to OUT tokens)
                        Disable = 0x0,
                        ///  Enable endpoint OUT 5 (response to OUT tokens)
                        Enable = 0x1,
                    },
                },
                ///  Enable OUT endpoint 6
                OUT6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable endpoint OUT 6 (no response to OUT tokens)
                        Disable = 0x0,
                        ///  Enable endpoint OUT 6 (response to OUT tokens)
                        Enable = 0x1,
                    },
                },
                ///  Enable OUT endpoint 7
                OUT7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable endpoint OUT 7 (no response to OUT tokens)
                        Disable = 0x0,
                        ///  Enable endpoint OUT 7 (response to OUT tokens)
                        Enable = 0x1,
                    },
                },
                ///  Enable ISO OUT endpoint 8
                ISOOUT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable ISO OUT endpoint 8
                        Disable = 0x0,
                        ///  Enable ISO OUT endpoint 8
                        Enable = 0x1,
                    },
                },
                padding: u23,
            }),
            ///  STALL endpoints
            EPSTALL: mmio.Mmio(packed struct(u32) {
                ///  Select endpoint number
                EP: u3,
                reserved7: u4,
                ///  Selects IN or OUT endpoint
                IO: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Selects OUT endpoint
                        Out = 0x0,
                        ///  Selects IN endpoint
                        In = 0x1,
                    },
                },
                ///  Stall selected endpoint
                STALL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Don't stall selected endpoint
                        UnStall = 0x0,
                        ///  Stall selected endpoint
                        Stall = 0x1,
                    },
                },
                padding: u23,
            }),
            ///  Controls the split of ISO buffers
            ISOSPLIT: mmio.Mmio(packed struct(u32) {
                ///  Controls the split of ISO buffers
                SPLIT: packed union {
                    raw: u16,
                    value: enum(u16) {
                        ///  Full buffer dedicated to either iso IN or OUT
                        OneDir = 0x0,
                        ///  Lower half for IN, upper half for OUT
                        HalfIN = 0x80,
                        _,
                    },
                },
                padding: u16,
            }),
            ///  Returns the current value of the start of frame counter
            FRAMECNTR: mmio.Mmio(packed struct(u32) {
                ///  Returns the current value of the start of frame counter
                FRAMECNTR: u11,
                padding: u21,
            }),
            reserved1324: [8]u8,
            ///  Controls USBD peripheral low power mode during USB suspend
            LOWPOWER: mmio.Mmio(packed struct(u32) {
                ///  Controls USBD peripheral low-power mode during USB suspend
                LOWPOWER: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Software must write this value to exit low power mode and before performing a remote wake-up
                        ForceNormal = 0x0,
                        ///  Software must write this value to enter low power mode after DMA and software have finished interacting with the USB peripheral
                        LowPower = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Controls the response of the ISO IN endpoint to an IN token when no data is ready to be sent
            ISOINCONFIG: mmio.Mmio(packed struct(u32) {
                ///  Controls the response of the ISO IN endpoint to an IN token when no data is ready to be sent
                RESPONSE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Endpoint does not respond in that case
                        NoResp = 0x0,
                        ///  Endpoint responds with a zero-length data packet in that case
                        ZeroData = 0x1,
                    },
                },
                padding: u31,
            }),
        };

        ///  NFC-A compatible radio
        pub const NFCT = extern struct {
            ///  Activate NFCT peripheral for incoming and outgoing frames, change state to activated
            TASKS_ACTIVATE: mmio.Mmio(packed struct(u32) {
                ///  Activate NFCT peripheral for incoming and outgoing frames, change state to activated
                TASKS_ACTIVATE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Disable NFCT peripheral
            TASKS_DISABLE: mmio.Mmio(packed struct(u32) {
                ///  Disable NFCT peripheral
                TASKS_DISABLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Enable NFC sense field mode, change state to sense mode
            TASKS_SENSE: mmio.Mmio(packed struct(u32) {
                ///  Enable NFC sense field mode, change state to sense mode
                TASKS_SENSE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Start transmission of an outgoing frame, change state to transmit
            TASKS_STARTTX: mmio.Mmio(packed struct(u32) {
                ///  Start transmission of an outgoing frame, change state to transmit
                TASKS_STARTTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved28: [12]u8,
            ///  Initializes the EasyDMA for receive.
            TASKS_ENABLERXDATA: mmio.Mmio(packed struct(u32) {
                ///  Initializes the EasyDMA for receive.
                TASKS_ENABLERXDATA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved36: [4]u8,
            ///  Force state machine to IDLE state
            TASKS_GOIDLE: mmio.Mmio(packed struct(u32) {
                ///  Force state machine to IDLE state
                TASKS_GOIDLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Force state machine to SLEEP_A state
            TASKS_GOSLEEP: mmio.Mmio(packed struct(u32) {
                ///  Force state machine to SLEEP_A state
                TASKS_GOSLEEP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved256: [212]u8,
            ///  The NFCT peripheral is ready to receive and send frames
            EVENTS_READY: mmio.Mmio(packed struct(u32) {
                ///  The NFCT peripheral is ready to receive and send frames
                EVENTS_READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Remote NFC field detected
            EVENTS_FIELDDETECTED: mmio.Mmio(packed struct(u32) {
                ///  Remote NFC field detected
                EVENTS_FIELDDETECTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Remote NFC field lost
            EVENTS_FIELDLOST: mmio.Mmio(packed struct(u32) {
                ///  Remote NFC field lost
                EVENTS_FIELDLOST: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Marks the start of the first symbol of a transmitted frame
            EVENTS_TXFRAMESTART: mmio.Mmio(packed struct(u32) {
                ///  Marks the start of the first symbol of a transmitted frame
                EVENTS_TXFRAMESTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Marks the end of the last transmitted on-air symbol of a frame
            EVENTS_TXFRAMEEND: mmio.Mmio(packed struct(u32) {
                ///  Marks the end of the last transmitted on-air symbol of a frame
                EVENTS_TXFRAMEEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Marks the end of the first symbol of a received frame
            EVENTS_RXFRAMESTART: mmio.Mmio(packed struct(u32) {
                ///  Marks the end of the first symbol of a received frame
                EVENTS_RXFRAMESTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Received data has been checked (CRC, parity) and transferred to RAM, and EasyDMA has ended accessing the RX buffer
            EVENTS_RXFRAMEEND: mmio.Mmio(packed struct(u32) {
                ///  Received data has been checked (CRC, parity) and transferred to RAM, and EasyDMA has ended accessing the RX buffer
                EVENTS_RXFRAMEEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  NFC error reported. The ERRORSTATUS register contains details on the source of the error.
            EVENTS_ERROR: mmio.Mmio(packed struct(u32) {
                ///  NFC error reported. The ERRORSTATUS register contains details on the source of the error.
                EVENTS_ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved296: [8]u8,
            ///  NFC RX frame error reported. The FRAMESTATUS.RX register contains details on the source of the error.
            EVENTS_RXERROR: mmio.Mmio(packed struct(u32) {
                ///  NFC RX frame error reported. The FRAMESTATUS.RX register contains details on the source of the error.
                EVENTS_RXERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  RX buffer (as defined by PACKETPTR and MAXLEN) in Data RAM full.
            EVENTS_ENDRX: mmio.Mmio(packed struct(u32) {
                ///  RX buffer (as defined by PACKETPTR and MAXLEN) in Data RAM full.
                EVENTS_ENDRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Transmission of data in RAM has ended, and EasyDMA has ended accessing the TX buffer
            EVENTS_ENDTX: mmio.Mmio(packed struct(u32) {
                ///  Transmission of data in RAM has ended, and EasyDMA has ended accessing the TX buffer
                EVENTS_ENDTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved312: [4]u8,
            ///  Auto collision resolution process has started
            EVENTS_AUTOCOLRESSTARTED: mmio.Mmio(packed struct(u32) {
                ///  Auto collision resolution process has started
                EVENTS_AUTOCOLRESSTARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved328: [12]u8,
            ///  NFC auto collision resolution error reported.
            EVENTS_COLLISION: mmio.Mmio(packed struct(u32) {
                ///  NFC auto collision resolution error reported.
                EVENTS_COLLISION: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  NFC auto collision resolution successfully completed
            EVENTS_SELECTED: mmio.Mmio(packed struct(u32) {
                ///  NFC auto collision resolution successfully completed
                EVENTS_SELECTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  EasyDMA is ready to receive or send frames.
            EVENTS_STARTED: mmio.Mmio(packed struct(u32) {
                ///  EasyDMA is ready to receive or send frames.
                EVENTS_STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved512: [172]u8,
            ///  Shortcuts between local events and tasks
            SHORTS: mmio.Mmio(packed struct(u32) {
                ///  Shortcut between event FIELDDETECTED and task ACTIVATE
                FIELDDETECTED_ACTIVATE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event FIELDLOST and task SENSE
                FIELDLOST_SENSE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                reserved5: u3,
                ///  Shortcut between event TXFRAMEEND and task ENABLERXDATA
                TXFRAMEEND_ENABLERXDATA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                padding: u26,
            }),
            reserved768: [252]u8,
            ///  Enable or disable interrupt
            INTEN: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable interrupt for event READY
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event FIELDDETECTED
                FIELDDETECTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event FIELDLOST
                FIELDLOST: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event TXFRAMESTART
                TXFRAMESTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event TXFRAMEEND
                TXFRAMEEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event RXFRAMESTART
                RXFRAMESTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event RXFRAMEEND
                RXFRAMEEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event ERROR
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
                ///  Enable or disable interrupt for event RXERROR
                RXERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event ENDRX
                ENDRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event ENDTX
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
                ///  Enable or disable interrupt for event AUTOCOLRESSTARTED
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
                ///  Enable or disable interrupt for event COLLISION
                COLLISION: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event SELECTED
                SELECTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event STARTED
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
                ///  Write '1' to enable interrupt for event READY
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event FIELDDETECTED
                FIELDDETECTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event FIELDLOST
                FIELDLOST: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event TXFRAMESTART
                TXFRAMESTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event TXFRAMEEND
                TXFRAMEEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event RXFRAMESTART
                RXFRAMESTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event RXFRAMEEND
                RXFRAMEEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ERROR
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
                ///  Write '1' to enable interrupt for event RXERROR
                RXERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ENDRX
                ENDRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ENDTX
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
                ///  Write '1' to enable interrupt for event AUTOCOLRESSTARTED
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
                ///  Write '1' to enable interrupt for event COLLISION
                COLLISION: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event SELECTED
                SELECTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event STARTED
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
                ///  Write '1' to disable interrupt for event READY
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event FIELDDETECTED
                FIELDDETECTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event FIELDLOST
                FIELDLOST: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event TXFRAMESTART
                TXFRAMESTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event TXFRAMEEND
                TXFRAMEEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event RXFRAMESTART
                RXFRAMESTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event RXFRAMEEND
                RXFRAMEEND: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ERROR
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
                ///  Write '1' to disable interrupt for event RXERROR
                RXERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ENDRX
                ENDRX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ENDTX
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
                ///  Write '1' to disable interrupt for event AUTOCOLRESSTARTED
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
                ///  Write '1' to disable interrupt for event COLLISION
                COLLISION: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event SELECTED
                SELECTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event STARTED
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
                padding: u31,
            }),
            reserved1040: [8]u8,
            ///  NfcTag state register
            NFCTAGSTATE: mmio.Mmio(packed struct(u32) {
                ///  NfcTag state
                NFCTAGSTATE: packed union {
                    raw: u3,
                    value: enum(u3) {
                        ///  Disabled or sense
                        Disabled = 0x0,
                        ///  RampUp
                        RampUp = 0x2,
                        ///  Idle
                        Idle = 0x3,
                        ///  Receive
                        Receive = 0x4,
                        ///  FrameDelay
                        FrameDelay = 0x5,
                        ///  Transmit
                        Transmit = 0x6,
                        _,
                    },
                },
                padding: u29,
            }),
            reserved1056: [12]u8,
            ///  Sleep state during automatic collision resolution
            SLEEPSTATE: mmio.Mmio(packed struct(u32) {
                ///  Reflects the sleep state during automatic collision resolution. Set to IDLE by a GOIDLE task. Set to SLEEP_A when a valid SLEEP_REQ frame is received or by a GOSLEEP task.
                SLEEPSTATE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  State is IDLE.
                        Idle = 0x0,
                        ///  State is SLEEP_A.
                        SleepA = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved1084: [24]u8,
            ///  Indicates the presence or not of a valid field
            FIELDPRESENT: mmio.Mmio(packed struct(u32) {
                ///  Indicates if a valid field is present. Available only in the activated state.
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
                FRAMEDELAYMAX: u20,
                padding: u12,
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
                ///  Packet pointer for TXD and RXD data storage in Data RAM. This address is a byte-aligned RAM address.
                PTR: u32,
            }),
            ///  Size of the RAM buffer allocated to TXD and RXD data storage each
            MAXLEN: mmio.Mmio(packed struct(u32) {
                ///  Size of the RAM buffer allocated to TXD and RXD data storage each
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
            ///  Controls the auto collision resolution function. This setting must be done before the NFCT peripheral is enabled.
            AUTOCOLRESCONFIG: mmio.Mmio(packed struct(u32) {
                ///  Enables/disables auto collision resolution
                MODE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Auto collision resolution enabled
                        Enabled = 0x0,
                        ///  Auto collision resolution disabled
                        Disabled = 0x1,
                    },
                },
                padding: u31,
            }),
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
                ///  NFCID1 size. This value is used by the auto collision resolution engine.
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
                ///  Cascade as defined by the b3 of SEL_RES response in the NFC Forum, NFC Digital Protocol Technical Specification (controlled by hardware, shall be 0)
                CASCADE: u1,
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
            ///  Description collection: Task for writing to pin specified in CONFIG[n].PSEL. Action on pin is configured in CONFIG[n].POLARITY.
            TASKS_OUT: [8]mmio.Mmio(packed struct(u32) {
                ///  Task for writing to pin specified in CONFIG[n].PSEL. Action on pin is configured in CONFIG[n].POLARITY.
                TASKS_OUT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved48: [16]u8,
            ///  Description collection: Task for writing to pin specified in CONFIG[n].PSEL. Action on pin is to set it high.
            TASKS_SET: [8]mmio.Mmio(packed struct(u32) {
                ///  Task for writing to pin specified in CONFIG[n].PSEL. Action on pin is to set it high.
                TASKS_SET: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved96: [16]u8,
            ///  Description collection: Task for writing to pin specified in CONFIG[n].PSEL. Action on pin is to set it low.
            TASKS_CLR: [8]mmio.Mmio(packed struct(u32) {
                ///  Task for writing to pin specified in CONFIG[n].PSEL. Action on pin is to set it low.
                TASKS_CLR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved256: [128]u8,
            ///  Description collection: Event generated from pin specified in CONFIG[n].PSEL
            EVENTS_IN: [8]mmio.Mmio(packed struct(u32) {
                ///  Event generated from pin specified in CONFIG[n].PSEL
                EVENTS_IN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved380: [92]u8,
            ///  Event generated from multiple input GPIO pins with SENSE mechanism enabled
            EVENTS_PORT: mmio.Mmio(packed struct(u32) {
                ///  Event generated from multiple input GPIO pins with SENSE mechanism enabled
                EVENTS_PORT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved772: [388]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to enable interrupt for event IN[0]
                IN0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event IN[1]
                IN1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event IN[2]
                IN2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event IN[3]
                IN3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event IN[4]
                IN4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event IN[5]
                IN5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event IN[6]
                IN6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event IN[7]
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
                ///  Write '1' to enable interrupt for event PORT
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
                ///  Write '1' to disable interrupt for event IN[0]
                IN0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event IN[1]
                IN1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event IN[2]
                IN2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event IN[3]
                IN3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event IN[4]
                IN4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event IN[5]
                IN5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event IN[6]
                IN6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event IN[7]
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
                ///  Write '1' to disable interrupt for event PORT
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
            ///  Description collection: Configuration for OUT[n], SET[n] and CLR[n] tasks and IN[n] event
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
                ///  Port number
                PORT: u1,
                reserved16: u2,
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

        ///  Successive approximation register (SAR) analog-to-digital converter
        pub const SAADC = extern struct {
            ///  Starts the SAADC and prepares the result buffer in RAM
            TASKS_START: mmio.Mmio(packed struct(u32) {
                ///  Starts the SAADC and prepares the result buffer in RAM
                TASKS_START: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Takes one SAADC sample
            TASKS_SAMPLE: mmio.Mmio(packed struct(u32) {
                ///  Takes one SAADC sample
                TASKS_SAMPLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stops the SAADC and terminates all on-going conversions
            TASKS_STOP: mmio.Mmio(packed struct(u32) {
                ///  Stops the SAADC and terminates all on-going conversions
                TASKS_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Starts offset auto-calibration
            TASKS_CALIBRATEOFFSET: mmio.Mmio(packed struct(u32) {
                ///  Starts offset auto-calibration
                TASKS_CALIBRATEOFFSET: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved256: [240]u8,
            ///  The SAADC has started
            EVENTS_STARTED: mmio.Mmio(packed struct(u32) {
                ///  The SAADC has started
                EVENTS_STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  The SAADC has filled up the result buffer
            EVENTS_END: mmio.Mmio(packed struct(u32) {
                ///  The SAADC has filled up the result buffer
                EVENTS_END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  A conversion task has been completed. Depending on the configuration, multiple conversions might be needed for a result to be transferred to RAM.
            EVENTS_DONE: mmio.Mmio(packed struct(u32) {
                ///  A conversion task has been completed. Depending on the configuration, multiple conversions might be needed for a result to be transferred to RAM.
                EVENTS_DONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Result ready for transfer to RAM
            EVENTS_RESULTDONE: mmio.Mmio(packed struct(u32) {
                ///  Result ready for transfer to RAM
                EVENTS_RESULTDONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Calibration is complete
            EVENTS_CALIBRATEDONE: mmio.Mmio(packed struct(u32) {
                ///  Calibration is complete
                EVENTS_CALIBRATEDONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  The SAADC has stopped
            EVENTS_STOPPED: mmio.Mmio(packed struct(u32) {
                ///  The SAADC has stopped
                EVENTS_STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved768: [488]u8,
            ///  Enable or disable interrupt
            INTEN: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable interrupt for event STARTED
                STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event END
                END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event DONE
                DONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event RESULTDONE
                RESULTDONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event CALIBRATEDONE
                CALIBRATEDONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event STOPPED
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event CH0LIMITH
                CH0LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event CH0LIMITL
                CH0LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event CH1LIMITH
                CH1LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event CH1LIMITL
                CH1LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event CH2LIMITH
                CH2LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event CH2LIMITL
                CH2LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event CH3LIMITH
                CH3LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event CH3LIMITL
                CH3LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event CH4LIMITH
                CH4LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event CH4LIMITL
                CH4LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event CH5LIMITH
                CH5LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event CH5LIMITL
                CH5LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event CH6LIMITH
                CH6LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event CH6LIMITL
                CH6LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event CH7LIMITH
                CH7LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event CH7LIMITL
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
                ///  Write '1' to enable interrupt for event STARTED
                STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event END
                END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event DONE
                DONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event RESULTDONE
                RESULTDONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CALIBRATEDONE
                CALIBRATEDONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event STOPPED
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CH0LIMITH
                CH0LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CH0LIMITL
                CH0LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CH1LIMITH
                CH1LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CH1LIMITL
                CH1LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CH2LIMITH
                CH2LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CH2LIMITL
                CH2LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CH3LIMITH
                CH3LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CH3LIMITL
                CH3LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CH4LIMITH
                CH4LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CH4LIMITL
                CH4LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CH5LIMITH
                CH5LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CH5LIMITL
                CH5LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CH6LIMITH
                CH6LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CH6LIMITL
                CH6LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CH7LIMITH
                CH7LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CH7LIMITL
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
                ///  Write '1' to disable interrupt for event STARTED
                STARTED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event END
                END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event DONE
                DONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event RESULTDONE
                RESULTDONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CALIBRATEDONE
                CALIBRATEDONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event STOPPED
                STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CH0LIMITH
                CH0LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CH0LIMITL
                CH0LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CH1LIMITH
                CH1LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CH1LIMITL
                CH1LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CH2LIMITH
                CH2LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CH2LIMITL
                CH2LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CH3LIMITH
                CH3LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CH3LIMITL
                CH3LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CH4LIMITH
                CH4LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CH4LIMITL
                CH4LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CH5LIMITH
                CH5LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CH5LIMITL
                CH5LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CH6LIMITH
                CH6LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CH6LIMITL
                CH6LIMITL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CH7LIMITH
                CH7LIMITH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CH7LIMITL
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
                        ///  SAADC is ready. No on-going conversions.
                        Ready = 0x0,
                        ///  SAADC is busy. Conversion in progress.
                        Busy = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved1280: [252]u8,
            ///  Enable or disable SAADC
            ENABLE: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable SAADC
                ENABLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable SAADC
                        Disabled = 0x0,
                        ///  Enable SAADC
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
                        ///  8 bits
                        @"8bit" = 0x0,
                        ///  10 bits
                        @"10bit" = 0x1,
                        ///  12 bits
                        @"12bit" = 0x2,
                        ///  14 bits
                        @"14bit" = 0x3,
                        _,
                    },
                },
                padding: u29,
            }),
            ///  Oversampling configuration. The RESOLUTION is applied before averaging, thus for high OVERSAMPLE a higher RESOLUTION should be used.
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
            TASKS_START: mmio.Mmio(packed struct(u32) {
                ///  Start Timer
                TASKS_START: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stop Timer
            TASKS_STOP: mmio.Mmio(packed struct(u32) {
                ///  Stop Timer
                TASKS_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Increment Timer (Counter mode only)
            TASKS_COUNT: mmio.Mmio(packed struct(u32) {
                ///  Increment Timer (Counter mode only)
                TASKS_COUNT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Clear time
            TASKS_CLEAR: mmio.Mmio(packed struct(u32) {
                ///  Clear time
                TASKS_CLEAR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Deprecated register - Shut down timer
            TASKS_SHUTDOWN: mmio.Mmio(packed struct(u32) {
                ///  Deprecated field - Shut down timer
                TASKS_SHUTDOWN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved64: [44]u8,
            ///  Description collection: Capture Timer value to CC[n] register
            TASKS_CAPTURE: [6]mmio.Mmio(packed struct(u32) {
                ///  Capture Timer value to CC[n] register
                TASKS_CAPTURE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved320: [232]u8,
            ///  Description collection: Compare event on CC[n] match
            EVENTS_COMPARE: [6]mmio.Mmio(packed struct(u32) {
                ///  Compare event on CC[n] match
                EVENTS_COMPARE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved512: [168]u8,
            ///  Shortcuts between local events and tasks
            SHORTS: mmio.Mmio(packed struct(u32) {
                ///  Shortcut between event COMPARE[0] and task CLEAR
                COMPARE0_CLEAR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event COMPARE[1] and task CLEAR
                COMPARE1_CLEAR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event COMPARE[2] and task CLEAR
                COMPARE2_CLEAR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event COMPARE[3] and task CLEAR
                COMPARE3_CLEAR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event COMPARE[4] and task CLEAR
                COMPARE4_CLEAR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event COMPARE[5] and task CLEAR
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
                ///  Shortcut between event COMPARE[0] and task STOP
                COMPARE0_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event COMPARE[1] and task STOP
                COMPARE1_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event COMPARE[2] and task STOP
                COMPARE2_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event COMPARE[3] and task STOP
                COMPARE3_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event COMPARE[4] and task STOP
                COMPARE4_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event COMPARE[5] and task STOP
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
                ///  Write '1' to enable interrupt for event COMPARE[0]
                COMPARE0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event COMPARE[1]
                COMPARE1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event COMPARE[2]
                COMPARE2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event COMPARE[3]
                COMPARE3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event COMPARE[4]
                COMPARE4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event COMPARE[5]
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
                ///  Write '1' to disable interrupt for event COMPARE[0]
                COMPARE0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event COMPARE[1]
                COMPARE1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event COMPARE[2]
                COMPARE2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event COMPARE[3]
                COMPARE3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event COMPARE[4]
                COMPARE4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event COMPARE[5]
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
            ///  Description collection: Capture/Compare register n
            CC: [6]mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare value
                CC: u32,
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
            TASKS_START: mmio.Mmio(packed struct(u32) {
                ///  Starts continuous I2S transfer. Also starts MCK generator when this is enabled.
                TASKS_START: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stops I2S transfer. Also stops MCK generator. Triggering this task will cause the STOPPED event to be generated.
            TASKS_STOP: mmio.Mmio(packed struct(u32) {
                ///  Stops I2S transfer. Also stops MCK generator. Triggering this task will cause the STOPPED event to be generated.
                TASKS_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved260: [252]u8,
            ///  The RXD.PTR register has been copied to internal double-buffers. When the I2S module is started and RX is enabled, this event will be generated for every RXTXD.MAXCNT words that are received on the SDIN pin.
            EVENTS_RXPTRUPD: mmio.Mmio(packed struct(u32) {
                ///  The RXD.PTR register has been copied to internal double-buffers. When the I2S module is started and RX is enabled, this event will be generated for every RXTXD.MAXCNT words that are received on the SDIN pin.
                EVENTS_RXPTRUPD: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  I2S transfer stopped.
            EVENTS_STOPPED: mmio.Mmio(packed struct(u32) {
                ///  I2S transfer stopped.
                EVENTS_STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved276: [8]u8,
            ///  The TDX.PTR register has been copied to internal double-buffers. When the I2S module is started and TX is enabled, this event will be generated for every RXTXD.MAXCNT words that are sent on the SDOUT pin.
            EVENTS_TXPTRUPD: mmio.Mmio(packed struct(u32) {
                ///  The TDX.PTR register has been copied to internal double-buffers. When the I2S module is started and TX is enabled, this event will be generated for every RXTXD.MAXCNT words that are sent on the SDOUT pin.
                EVENTS_TXPTRUPD: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved768: [488]u8,
            ///  Enable or disable interrupt
            INTEN: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Enable or disable interrupt for event RXPTRUPD
                RXPTRUPD: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event STOPPED
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
                ///  Enable or disable interrupt for event TXPTRUPD
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
                ///  Write '1' to enable interrupt for event RXPTRUPD
                RXPTRUPD: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event STOPPED
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
                ///  Write '1' to enable interrupt for event TXPTRUPD
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
                ///  Write '1' to disable interrupt for event RXPTRUPD
                RXPTRUPD: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event STOPPED
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
                ///  Write '1' to disable interrupt for event TXPTRUPD
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

        ///  Real time counter 0
        pub const RTC0 = extern struct {
            ///  Start RTC COUNTER
            TASKS_START: mmio.Mmio(packed struct(u32) {
                ///  Start RTC COUNTER
                TASKS_START: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stop RTC COUNTER
            TASKS_STOP: mmio.Mmio(packed struct(u32) {
                ///  Stop RTC COUNTER
                TASKS_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Clear RTC COUNTER
            TASKS_CLEAR: mmio.Mmio(packed struct(u32) {
                ///  Clear RTC COUNTER
                TASKS_CLEAR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Set COUNTER to 0xFFFFF0
            TASKS_TRIGOVRFLW: mmio.Mmio(packed struct(u32) {
                ///  Set COUNTER to 0xFFFFF0
                TASKS_TRIGOVRFLW: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved256: [240]u8,
            ///  Event on COUNTER increment
            EVENTS_TICK: mmio.Mmio(packed struct(u32) {
                ///  Event on COUNTER increment
                EVENTS_TICK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Event on COUNTER overflow
            EVENTS_OVRFLW: mmio.Mmio(packed struct(u32) {
                ///  Event on COUNTER overflow
                EVENTS_OVRFLW: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved320: [56]u8,
            ///  Description collection: Compare event on CC[n] match
            EVENTS_COMPARE: [4]mmio.Mmio(packed struct(u32) {
                ///  Compare event on CC[n] match
                EVENTS_COMPARE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved772: [436]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to enable interrupt for event TICK
                TICK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event OVRFLW
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
                ///  Write '1' to enable interrupt for event COMPARE[0]
                COMPARE0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event COMPARE[1]
                COMPARE1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event COMPARE[2]
                COMPARE2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event COMPARE[3]
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
                ///  Write '1' to disable interrupt for event TICK
                TICK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event OVRFLW
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
                ///  Write '1' to disable interrupt for event COMPARE[0]
                COMPARE0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event COMPARE[1]
                COMPARE1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event COMPARE[2]
                COMPARE2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event COMPARE[3]
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
                ///  Enable or disable event routing for event TICK
                TICK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Disable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable event routing for event OVRFLW
                OVRFLW: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Disable
                        Enabled = 0x1,
                    },
                },
                reserved16: u14,
                ///  Enable or disable event routing for event COMPARE[0]
                COMPARE0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Disable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable event routing for event COMPARE[1]
                COMPARE1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Disable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable event routing for event COMPARE[2]
                COMPARE2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Disable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable event routing for event COMPARE[3]
                COMPARE3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Disable
                        Enabled = 0x1,
                    },
                },
                padding: u12,
            }),
            ///  Enable event routing
            EVTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to enable event routing for event TICK
                TICK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable event routing for event OVRFLW
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
                ///  Write '1' to enable event routing for event COMPARE[0]
                COMPARE0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable event routing for event COMPARE[1]
                COMPARE1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable event routing for event COMPARE[2]
                COMPARE2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable event routing for event COMPARE[3]
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
                ///  Write '1' to disable event routing for event TICK
                TICK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable event routing for event OVRFLW
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
                ///  Write '1' to disable event routing for event COMPARE[0]
                COMPARE0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable event routing for event COMPARE[1]
                COMPARE1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable event routing for event COMPARE[2]
                COMPARE2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable event routing for event COMPARE[3]
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
            ///  Description collection: Compare register n
            CC: [4]mmio.Mmio(packed struct(u32) {
                ///  Compare value
                COMPARE: u24,
                padding: u8,
            }),
        };

        ///  Temperature Sensor
        pub const TEMP = extern struct {
            ///  Start temperature measurement
            TASKS_START: mmio.Mmio(packed struct(u32) {
                ///  Start temperature measurement
                TASKS_START: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stop temperature measurement
            TASKS_STOP: mmio.Mmio(packed struct(u32) {
                ///  Stop temperature measurement
                TASKS_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved256: [248]u8,
            ///  Temperature measurement complete, data ready
            EVENTS_DATARDY: mmio.Mmio(packed struct(u32) {
                ///  Temperature measurement complete, data ready
                EVENTS_DATARDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved772: [512]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to enable interrupt for event DATARDY
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
                ///  Write '1' to disable interrupt for event DATARDY
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
            TASKS_START: mmio.Mmio(packed struct(u32) {
                ///  Task starting the random number generator
                TASKS_START: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Task stopping the random number generator
            TASKS_STOP: mmio.Mmio(packed struct(u32) {
                ///  Task stopping the random number generator
                TASKS_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved256: [248]u8,
            ///  Event being generated for every new random number written to the VALUE register
            EVENTS_VALRDY: mmio.Mmio(packed struct(u32) {
                ///  Event being generated for every new random number written to the VALUE register
                EVENTS_VALRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved512: [252]u8,
            ///  Shortcuts between local events and tasks
            SHORTS: mmio.Mmio(packed struct(u32) {
                ///  Shortcut between event VALRDY and task STOP
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
                ///  Write '1' to enable interrupt for event VALRDY
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
                ///  Write '1' to disable interrupt for event VALRDY
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
            TASKS_STARTECB: mmio.Mmio(packed struct(u32) {
                ///  Start ECB block encrypt
                TASKS_STARTECB: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Abort a possible executing ECB operation
            TASKS_STOPECB: mmio.Mmio(packed struct(u32) {
                ///  Abort a possible executing ECB operation
                TASKS_STOPECB: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved256: [248]u8,
            ///  ECB block encrypt complete
            EVENTS_ENDECB: mmio.Mmio(packed struct(u32) {
                ///  ECB block encrypt complete
                EVENTS_ENDECB: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  ECB block encrypt aborted because of a STOPECB task or due to an error
            EVENTS_ERRORECB: mmio.Mmio(packed struct(u32) {
                ///  ECB block encrypt aborted because of a STOPECB task or due to an error
                EVENTS_ERRORECB: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved772: [508]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to enable interrupt for event ENDECB
                ENDECB: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ERRORECB
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
                ///  Write '1' to disable interrupt for event ENDECB
                ENDECB: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ERRORECB
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

        ///  Accelerated Address Resolver
        pub const AAR = extern struct {
            ///  Start resolving addresses based on IRKs specified in the IRK data structure
            TASKS_START: mmio.Mmio(packed struct(u32) {
                ///  Start resolving addresses based on IRKs specified in the IRK data structure
                TASKS_START: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved8: [4]u8,
            ///  Stop resolving addresses
            TASKS_STOP: mmio.Mmio(packed struct(u32) {
                ///  Stop resolving addresses
                TASKS_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved256: [244]u8,
            ///  Address resolution procedure complete
            EVENTS_END: mmio.Mmio(packed struct(u32) {
                ///  Address resolution procedure complete
                EVENTS_END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Address resolved
            EVENTS_RESOLVED: mmio.Mmio(packed struct(u32) {
                ///  Address resolved
                EVENTS_RESOLVED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Address not resolved
            EVENTS_NOTRESOLVED: mmio.Mmio(packed struct(u32) {
                ///  Address not resolved
                EVENTS_NOTRESOLVED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved772: [504]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to enable interrupt for event END
                END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event RESOLVED
                RESOLVED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event NOTRESOLVED
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
                ///  Write '1' to disable interrupt for event END
                END: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event RESOLVED
                RESOLVED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event NOTRESOLVED
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
                ///  Pointer to a scratch data area used for temporary storage during resolution. A space of minimum 3 bytes must be reserved.
                SCRATCHPTR: u32,
            }),
        };

        ///  AES CCM Mode Encryption
        pub const CCM = extern struct {
            ///  Start generation of key-stream. This operation will stop by itself when completed.
            TASKS_KSGEN: mmio.Mmio(packed struct(u32) {
                ///  Start generation of key-stream. This operation will stop by itself when completed.
                TASKS_KSGEN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Start encryption/decryption. This operation will stop by itself when completed.
            TASKS_CRYPT: mmio.Mmio(packed struct(u32) {
                ///  Start encryption/decryption. This operation will stop by itself when completed.
                TASKS_CRYPT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stop encryption/decryption
            TASKS_STOP: mmio.Mmio(packed struct(u32) {
                ///  Stop encryption/decryption
                TASKS_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Override DATARATE setting in MODE register with the contents of the RATEOVERRIDE register for any ongoing encryption/decryption
            TASKS_RATEOVERRIDE: mmio.Mmio(packed struct(u32) {
                ///  Override DATARATE setting in MODE register with the contents of the RATEOVERRIDE register for any ongoing encryption/decryption
                TASKS_RATEOVERRIDE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved256: [240]u8,
            ///  Key-stream generation complete
            EVENTS_ENDKSGEN: mmio.Mmio(packed struct(u32) {
                ///  Key-stream generation complete
                EVENTS_ENDKSGEN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Encrypt/decrypt complete
            EVENTS_ENDCRYPT: mmio.Mmio(packed struct(u32) {
                ///  Encrypt/decrypt complete
                EVENTS_ENDCRYPT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Deprecated register - CCM error event
            EVENTS_ERROR: mmio.Mmio(packed struct(u32) {
                ///  Deprecated field - CCM error event
                EVENTS_ERROR: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved512: [244]u8,
            ///  Shortcuts between local events and tasks
            SHORTS: mmio.Mmio(packed struct(u32) {
                ///  Shortcut between event ENDKSGEN and task CRYPT
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
                ///  Write '1' to enable interrupt for event ENDKSGEN
                ENDKSGEN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ENDCRYPT
                ENDCRYPT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Deprecated intsetfield - Write '1' to enable interrupt for event ERROR
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
                ///  Write '1' to disable interrupt for event ENDKSGEN
                ENDKSGEN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ENDCRYPT
                ENDCRYPT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Deprecated intclrfield - Write '1' to disable interrupt for event ERROR
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
                ///  The mode of operation to be used. The settings in this register apply whenever either the KSGEN or CRYPT tasks are triggered.
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
                ///  Radio data rate that the CCM shall run synchronous with
                DATARATE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  1 Mbps
                        @"1Mbit" = 0x0,
                        ///  2 Mbps
                        @"2Mbit" = 0x1,
                        ///  125 Kbps
                        @"125Kbps" = 0x2,
                        ///  500 Kbps
                        @"500Kbps" = 0x3,
                    },
                },
                reserved24: u6,
                ///  Packet length configuration
                LENGTH: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Default length. Effective length of LENGTH field in encrypted/decrypted packet is 5 bits. A key-stream for packet payloads up to 27 bytes will be generated.
                        Default = 0x0,
                        ///  Extended length. Effective length of LENGTH field in encrypted/decrypted packet is 8 bits. A key-stream for packet payloads up to MAXPACKETSIZE bytes will be generated.
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
            ///  Length of key-stream generated when MODE.LENGTH = Extended.
            MAXPACKETSIZE: mmio.Mmio(packed struct(u32) {
                ///  Length of key-stream generated when MODE.LENGTH = Extended. This value must be greater or equal to the subsequent packet payload to be encrypted/decrypted.
                MAXPACKETSIZE: u8,
                padding: u24,
            }),
            ///  Data rate override setting.
            RATEOVERRIDE: mmio.Mmio(packed struct(u32) {
                ///  Data rate override setting.
                RATEOVERRIDE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  1 Mbps
                        @"1Mbit" = 0x0,
                        ///  2 Mbps
                        @"2Mbit" = 0x1,
                        ///  125 Kbps
                        @"125Kbps" = 0x2,
                        ///  500 Kbps
                        @"500Kbps" = 0x3,
                    },
                },
                padding: u30,
            }),
        };

        ///  Watchdog Timer
        pub const WDT = extern struct {
            ///  Start the watchdog
            TASKS_START: mmio.Mmio(packed struct(u32) {
                ///  Start the watchdog
                TASKS_START: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved256: [252]u8,
            ///  Watchdog timeout
            EVENTS_TIMEOUT: mmio.Mmio(packed struct(u32) {
                ///  Watchdog timeout
                EVENTS_TIMEOUT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved772: [512]u8,
            ///  Enable interrupt
            INTENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to enable interrupt for event TIMEOUT
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
                ///  Write '1' to disable interrupt for event TIMEOUT
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
            ///  Description collection: Reload request n
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

        ///  Memory Watch Unit
        pub const MWU = extern struct {
            reserved768: [768]u8,
            ///  Enable or disable interrupt
            INTEN: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable interrupt for event REGION0WA
                REGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event REGION0RA
                REGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event REGION1WA
                REGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event REGION1RA
                REGION1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event REGION2WA
                REGION2WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event REGION2RA
                REGION2RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event REGION3WA
                REGION3WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event REGION3RA
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
                ///  Enable or disable interrupt for event PREGION0WA
                PREGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event PREGION0RA
                PREGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event PREGION1WA
                PREGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event PREGION1RA
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
                ///  Write '1' to enable interrupt for event REGION0WA
                REGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event REGION0RA
                REGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event REGION1WA
                REGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event REGION1RA
                REGION1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event REGION2WA
                REGION2WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event REGION2RA
                REGION2RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event REGION3WA
                REGION3WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event REGION3RA
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
                ///  Write '1' to enable interrupt for event PREGION0WA
                PREGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event PREGION0RA
                PREGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event PREGION1WA
                PREGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event PREGION1RA
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
                ///  Write '1' to disable interrupt for event REGION0WA
                REGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event REGION0RA
                REGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event REGION1WA
                REGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event REGION1RA
                REGION1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event REGION2WA
                REGION2WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event REGION2RA
                REGION2RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event REGION3WA
                REGION3WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event REGION3RA
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
                ///  Write '1' to disable interrupt for event PREGION0WA
                PREGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event PREGION0RA
                PREGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event PREGION1WA
                PREGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event PREGION1RA
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
            ///  Enable or disable interrupt
            NMIEN: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable interrupt for event REGION0WA
                REGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event REGION0RA
                REGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event REGION1WA
                REGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event REGION1RA
                REGION1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event REGION2WA
                REGION2WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event REGION2RA
                REGION2RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event REGION3WA
                REGION3WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event REGION3RA
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
                ///  Enable or disable interrupt for event PREGION0WA
                PREGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event PREGION0RA
                PREGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event PREGION1WA
                PREGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event PREGION1RA
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
            NMIENSET: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to enable interrupt for event REGION0WA
                REGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event REGION0RA
                REGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event REGION1WA
                REGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event REGION1RA
                REGION1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event REGION2WA
                REGION2WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event REGION2RA
                REGION2RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event REGION3WA
                REGION3WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event REGION3RA
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
                ///  Write '1' to enable interrupt for event PREGION0WA
                PREGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event PREGION0RA
                PREGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event PREGION1WA
                PREGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event PREGION1RA
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
            NMIENCLR: mmio.Mmio(packed struct(u32) {
                ///  Write '1' to disable interrupt for event REGION0WA
                REGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event REGION0RA
                REGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event REGION1WA
                REGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event REGION1RA
                REGION1RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event REGION2WA
                REGION2WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event REGION2RA
                REGION2RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event REGION3WA
                REGION3WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event REGION3RA
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
                ///  Write '1' to disable interrupt for event PREGION0WA
                PREGION0WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event PREGION0RA
                PREGION0RA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event PREGION1WA
                PREGION1WA: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event PREGION1RA
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

        ///  Quadrature Decoder
        pub const QDEC = extern struct {
            ///  Task starting the quadrature decoder
            TASKS_START: mmio.Mmio(packed struct(u32) {
                ///  Task starting the quadrature decoder
                TASKS_START: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Task stopping the quadrature decoder
            TASKS_STOP: mmio.Mmio(packed struct(u32) {
                ///  Task stopping the quadrature decoder
                TASKS_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Read and clear ACC and ACCDBL
            TASKS_READCLRACC: mmio.Mmio(packed struct(u32) {
                ///  Read and clear ACC and ACCDBL
                TASKS_READCLRACC: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Read and clear ACC
            TASKS_RDCLRACC: mmio.Mmio(packed struct(u32) {
                ///  Read and clear ACC
                TASKS_RDCLRACC: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Read and clear ACCDBL
            TASKS_RDCLRDBL: mmio.Mmio(packed struct(u32) {
                ///  Read and clear ACCDBL
                TASKS_RDCLRDBL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved256: [236]u8,
            ///  Event being generated for every new sample value written to the SAMPLE register
            EVENTS_SAMPLERDY: mmio.Mmio(packed struct(u32) {
                ///  Event being generated for every new sample value written to the SAMPLE register
                EVENTS_SAMPLERDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Non-null report ready
            EVENTS_REPORTRDY: mmio.Mmio(packed struct(u32) {
                ///  Non-null report ready
                EVENTS_REPORTRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  ACC or ACCDBL register overflow
            EVENTS_ACCOF: mmio.Mmio(packed struct(u32) {
                ///  ACC or ACCDBL register overflow
                EVENTS_ACCOF: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Double displacement(s) detected
            EVENTS_DBLRDY: mmio.Mmio(packed struct(u32) {
                ///  Double displacement(s) detected
                EVENTS_DBLRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  QDEC has been stopped
            EVENTS_STOPPED: mmio.Mmio(packed struct(u32) {
                ///  QDEC has been stopped
                EVENTS_STOPPED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved512: [236]u8,
            ///  Shortcuts between local events and tasks
            SHORTS: mmio.Mmio(packed struct(u32) {
                ///  Shortcut between event REPORTRDY and task READCLRACC
                REPORTRDY_READCLRACC: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event SAMPLERDY and task STOP
                SAMPLERDY_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event REPORTRDY and task RDCLRACC
                REPORTRDY_RDCLRACC: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event REPORTRDY and task STOP
                REPORTRDY_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event DBLRDY and task RDCLRDBL
                DBLRDY_RDCLRDBL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event DBLRDY and task STOP
                DBLRDY_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event SAMPLERDY and task READCLRACC
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
                ///  Write '1' to enable interrupt for event SAMPLERDY
                SAMPLERDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event REPORTRDY
                REPORTRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event ACCOF
                ACCOF: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event DBLRDY
                DBLRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event STOPPED
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
                ///  Write '1' to disable interrupt for event SAMPLERDY
                SAMPLERDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event REPORTRDY
                REPORTRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event ACCOF
                ACCOF: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event DBLRDY
                DBLRDY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event STOPPED
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
            TASKS_START: mmio.Mmio(packed struct(u32) {
                ///  Start comparator
                TASKS_START: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stop comparator
            TASKS_STOP: mmio.Mmio(packed struct(u32) {
                ///  Stop comparator
                TASKS_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Sample comparator value
            TASKS_SAMPLE: mmio.Mmio(packed struct(u32) {
                ///  Sample comparator value
                TASKS_SAMPLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved256: [244]u8,
            ///  COMP is ready and output is valid
            EVENTS_READY: mmio.Mmio(packed struct(u32) {
                ///  COMP is ready and output is valid
                EVENTS_READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Downward crossing
            EVENTS_DOWN: mmio.Mmio(packed struct(u32) {
                ///  Downward crossing
                EVENTS_DOWN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Upward crossing
            EVENTS_UP: mmio.Mmio(packed struct(u32) {
                ///  Upward crossing
                EVENTS_UP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Downward or upward crossing
            EVENTS_CROSS: mmio.Mmio(packed struct(u32) {
                ///  Downward or upward crossing
                EVENTS_CROSS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved512: [240]u8,
            ///  Shortcuts between local events and tasks
            SHORTS: mmio.Mmio(packed struct(u32) {
                ///  Shortcut between event READY and task SAMPLE
                READY_SAMPLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event READY and task STOP
                READY_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event DOWN and task STOP
                DOWN_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event UP and task STOP
                UP_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event CROSS and task STOP
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
                ///  Enable or disable interrupt for event READY
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event DOWN
                DOWN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event UP
                UP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event CROSS
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
                ///  Write '1' to enable interrupt for event READY
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event DOWN
                DOWN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event UP
                UP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CROSS
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
                ///  Write '1' to disable interrupt for event READY
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event DOWN
                DOWN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event UP
                UP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CROSS
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
                        ARef = 0x5,
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
        };

        ///  Low Power Comparator
        pub const LPCOMP = extern struct {
            ///  Start comparator
            TASKS_START: mmio.Mmio(packed struct(u32) {
                ///  Start comparator
                TASKS_START: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Stop comparator
            TASKS_STOP: mmio.Mmio(packed struct(u32) {
                ///  Stop comparator
                TASKS_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            ///  Sample comparator value
            TASKS_SAMPLE: mmio.Mmio(packed struct(u32) {
                ///  Sample comparator value
                TASKS_SAMPLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved256: [244]u8,
            ///  LPCOMP is ready and output is valid
            EVENTS_READY: mmio.Mmio(packed struct(u32) {
                ///  LPCOMP is ready and output is valid
                EVENTS_READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Downward crossing
            EVENTS_DOWN: mmio.Mmio(packed struct(u32) {
                ///  Downward crossing
                EVENTS_DOWN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Upward crossing
            EVENTS_UP: mmio.Mmio(packed struct(u32) {
                ///  Upward crossing
                EVENTS_UP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Downward or upward crossing
            EVENTS_CROSS: mmio.Mmio(packed struct(u32) {
                ///  Downward or upward crossing
                EVENTS_CROSS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved512: [240]u8,
            ///  Shortcuts between local events and tasks
            SHORTS: mmio.Mmio(packed struct(u32) {
                ///  Shortcut between event READY and task SAMPLE
                READY_SAMPLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event READY and task STOP
                READY_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event DOWN and task STOP
                DOWN_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event UP and task STOP
                UP_STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable shortcut
                        Disabled = 0x0,
                        ///  Enable shortcut
                        Enabled = 0x1,
                    },
                },
                ///  Shortcut between event CROSS and task STOP
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
                ///  Write '1' to enable interrupt for event READY
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event DOWN
                DOWN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event UP
                UP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event CROSS
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
                ///  Write '1' to disable interrupt for event READY
                READY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event DOWN
                DOWN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event UP
                UP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event CROSS
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
                        Disabled = 0x0,
                        ///  Comparator hysteresis enabled
                        Enabled = 0x1,
                    },
                },
                padding: u31,
            }),
        };

        ///  Event Generator Unit 0
        pub const EGU0 = extern struct {
            ///  Description collection: Trigger n for triggering the corresponding TRIGGERED[n] event
            TASKS_TRIGGER: [16]mmio.Mmio(packed struct(u32) {
                ///  Trigger n for triggering the corresponding TRIGGERED[n] event
                TASKS_TRIGGER: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Trigger task
                        Trigger = 0x1,
                        _,
                    },
                },
                padding: u31,
            }),
            reserved256: [192]u8,
            ///  Description collection: Event number n generated by triggering the corresponding TRIGGER[n] task
            EVENTS_TRIGGERED: [16]mmio.Mmio(packed struct(u32) {
                ///  Event number n generated by triggering the corresponding TRIGGER[n] task
                EVENTS_TRIGGERED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Event not generated
                        NotGenerated = 0x0,
                        ///  Event generated
                        Generated = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved768: [448]u8,
            ///  Enable or disable interrupt
            INTEN: mmio.Mmio(packed struct(u32) {
                ///  Enable or disable interrupt for event TRIGGERED[0]
                TRIGGERED0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event TRIGGERED[1]
                TRIGGERED1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event TRIGGERED[2]
                TRIGGERED2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event TRIGGERED[3]
                TRIGGERED3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event TRIGGERED[4]
                TRIGGERED4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event TRIGGERED[5]
                TRIGGERED5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event TRIGGERED[6]
                TRIGGERED6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event TRIGGERED[7]
                TRIGGERED7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event TRIGGERED[8]
                TRIGGERED8: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event TRIGGERED[9]
                TRIGGERED9: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event TRIGGERED[10]
                TRIGGERED10: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event TRIGGERED[11]
                TRIGGERED11: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event TRIGGERED[12]
                TRIGGERED12: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event TRIGGERED[13]
                TRIGGERED13: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event TRIGGERED[14]
                TRIGGERED14: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disable
                        Disabled = 0x0,
                        ///  Enable
                        Enabled = 0x1,
                    },
                },
                ///  Enable or disable interrupt for event TRIGGERED[15]
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
                ///  Write '1' to enable interrupt for event TRIGGERED[0]
                TRIGGERED0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event TRIGGERED[1]
                TRIGGERED1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event TRIGGERED[2]
                TRIGGERED2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event TRIGGERED[3]
                TRIGGERED3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event TRIGGERED[4]
                TRIGGERED4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event TRIGGERED[5]
                TRIGGERED5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event TRIGGERED[6]
                TRIGGERED6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event TRIGGERED[7]
                TRIGGERED7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event TRIGGERED[8]
                TRIGGERED8: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event TRIGGERED[9]
                TRIGGERED9: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event TRIGGERED[10]
                TRIGGERED10: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event TRIGGERED[11]
                TRIGGERED11: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event TRIGGERED[12]
                TRIGGERED12: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event TRIGGERED[13]
                TRIGGERED13: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event TRIGGERED[14]
                TRIGGERED14: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to enable interrupt for event TRIGGERED[15]
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
                ///  Write '1' to disable interrupt for event TRIGGERED[0]
                TRIGGERED0: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event TRIGGERED[1]
                TRIGGERED1: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event TRIGGERED[2]
                TRIGGERED2: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event TRIGGERED[3]
                TRIGGERED3: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event TRIGGERED[4]
                TRIGGERED4: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event TRIGGERED[5]
                TRIGGERED5: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event TRIGGERED[6]
                TRIGGERED6: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event TRIGGERED[7]
                TRIGGERED7: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event TRIGGERED[8]
                TRIGGERED8: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event TRIGGERED[9]
                TRIGGERED9: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event TRIGGERED[10]
                TRIGGERED10: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event TRIGGERED[11]
                TRIGGERED11: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event TRIGGERED[12]
                TRIGGERED12: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event TRIGGERED[13]
                TRIGGERED13: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event TRIGGERED[14]
                TRIGGERED14: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Read: Disabled
                        Disabled = 0x0,
                        ///  Read: Enabled
                        Enabled = 0x1,
                    },
                },
                ///  Write '1' to disable interrupt for event TRIGGERED[15]
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

        ///  Software interrupt 0
        pub const SWI0 = extern struct {
            ///  Unused.
            UNUSED: u32,
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
            ///  Description collection: Channel group n
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
            reserved1032: [4]u8,
            ///  Ready flag
            READYNEXT: mmio.Mmio(packed struct(u32) {
                ///  NVMC can accept a new write operation
                READYNEXT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  NVMC cannot accept any write operation
                        Busy = 0x0,
                        ///  NVMC is ready
                        Ready = 0x1,
                    },
                },
                padding: u31,
            }),
            reserved1284: [248]u8,
            ///  Configuration register
            CONFIG: mmio.Mmio(packed struct(u32) {
                ///  Program memory access mode. It is strongly recommended to only activate erase and write modes when they are actively used. Enabling write or erase will invalidate the cache and keep it invalidated.
                WEN: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Read only access
                        Ren = 0x0,
                        ///  Write enabled
                        Wen = 0x1,
                        ///  Erase enabled
                        Een = 0x2,
                        _,
                    },
                },
                padding: u30,
            }),
            ///  Register for erasing a page in code area
            ERASEPAGE: mmio.Mmio(packed struct(u32) {
                ///  Register for starting erase of a page in code area
                ERASEPAGE: u32,
            }),
            ///  Register for erasing all non-volatile user memory
            ERASEALL: mmio.Mmio(packed struct(u32) {
                ///  Erase all non-volatile memory including UICR registers. Note that the erase must be enabled using CONFIG.WEN before the non-volatile memory can be erased.
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
            ///  Deprecated register - Register for erasing a page in code area. Equivalent to ERASEPAGE.
            ERASEPCR0: mmio.Mmio(packed struct(u32) {
                ///  Register for starting erase of a page in code area. Equivalent to ERASEPAGE.
                ERASEPCR0: u32,
            }),
            ///  Register for erasing user information configuration registers
            ERASEUICR: mmio.Mmio(packed struct(u32) {
                ///  Register starting erase of all user information configuration registers. Note that the erase must be enabled using CONFIG.WEN before the UICR can be erased.
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
            ///  Register for partial erase of a page in code area
            ERASEPAGEPARTIAL: mmio.Mmio(packed struct(u32) {
                ///  Register for starting partial erase of a page in code area
                ERASEPAGEPARTIAL: u32,
            }),
            ///  Register for partial erase configuration
            ERASEPAGEPARTIALCFG: mmio.Mmio(packed struct(u32) {
                ///  Duration of the partial erase in milliseconds
                DURATION: u7,
                padding: u25,
            }),
            reserved1344: [32]u8,
            ///  I-code cache configuration register.
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
            ///  I-code cache hit counter.
            IHIT: mmio.Mmio(packed struct(u32) {
                ///  Number of cache hits
                HITS: u32,
            }),
            ///  I-code cache miss counter.
            IMISS: mmio.Mmio(packed struct(u32) {
                ///  Number of cache misses
                MISSES: u32,
            }),
        };
    };
};
