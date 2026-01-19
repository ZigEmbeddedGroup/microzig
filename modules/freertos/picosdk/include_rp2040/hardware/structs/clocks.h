#ifndef _HARDWARE_STRUCTS_CLOCKS_H
#define _HARDWARE_STRUCTS_CLOCKS_H

typedef enum clock_num_rp2040 {
    clk_gpout0 = 0, ///< Select CLK_GPOUT0 as clock source
    clk_gpout1 = 1, ///< Select CLK_GPOUT1 as clock source
    clk_gpout2 = 2, ///< Select CLK_GPOUT2 as clock source
    clk_gpout3 = 3, ///< Select CLK_GPOUT3 as clock source
    clk_ref = 4, ///< Select CLK_REF as clock source
    clk_sys = 5, ///< Select CLK_SYS as clock source
    clk_peri = 6, ///< Select CLK_PERI as clock source
    clk_usb = 7, ///< Select CLK_USB as clock source
    clk_adc = 8, ///< Select CLK_ADC as clock source
    clk_rtc = 9, ///< Select CLK_RTC as clock source
    CLK_COUNT
} clock_num_t;

#endif // _HARDWARE_STRUCTS_CLOCKS_H