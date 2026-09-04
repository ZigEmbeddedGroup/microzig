/*
 * SPDX-FileCopyrightText: 2022-2024 Espressif Systems (Shanghai) CO LTD
 *
 * SPDX-License-Identifier: Apache-2.0
 */
/** ROM APIs
 */

PROVIDE ( esp_rom_crc32_le = crc32_le );
PROVIDE ( esp_rom_crc16_le = crc16_le );
PROVIDE ( esp_rom_crc8_le  = crc8_le );
PROVIDE ( esp_rom_crc32_be = crc32_be );
PROVIDE ( esp_rom_crc16_be = crc16_be );
PROVIDE ( esp_rom_crc8_be  = crc8_be );

PROVIDE ( esp_rom_gpio_pad_select_gpio    = gpio_pad_select_gpio );
PROVIDE ( esp_rom_gpio_pad_pullup_only    = gpio_pad_pullup );
PROVIDE ( esp_rom_gpio_pad_set_drv        = gpio_pad_set_drv );
PROVIDE ( esp_rom_gpio_pad_unhold         = gpio_pad_unhold );
PROVIDE ( esp_rom_gpio_connect_in_signal  = gpio_matrix_in );
PROVIDE ( esp_rom_gpio_connect_out_signal = gpio_matrix_out );

PROVIDE ( esp_rom_efuse_mac_address_crc8       = esp_crc8 );
PROVIDE ( esp_rom_efuse_is_secure_boot_enabled = ets_efuse_secure_boot_enabled );

PROVIDE ( esp_rom_uart_flush_tx       = uart_tx_flush );
PROVIDE ( esp_rom_uart_tx_one_char    = uart_tx_one_char2 );
PROVIDE ( esp_rom_uart_tx_wait_idle   = uart_tx_wait_idle );
PROVIDE ( esp_rom_uart_rx_one_char    = uart_rx_one_char );
PROVIDE ( esp_rom_uart_rx_string      = UartRxString );
PROVIDE ( esp_rom_uart_set_as_console = uart_tx_switch );
PROVIDE ( esp_rom_uart_putc           = ets_write_char_uart );

PROVIDE ( esp_rom_output_flush_tx       = uart_tx_flush );
PROVIDE ( esp_rom_output_tx_one_char    = uart_tx_one_char );
PROVIDE ( esp_rom_output_tx_wait_idle   = uart_tx_wait_idle );
PROVIDE ( esp_rom_output_rx_one_char    = uart_rx_one_char );
PROVIDE ( esp_rom_output_rx_string      = UartRxString );
PROVIDE ( esp_rom_output_set_as_console = uart_tx_switch );
PROVIDE ( esp_rom_output_putc           = ets_write_char_uart );

PROVIDE ( esp_rom_md5_init   = MD5Init );
PROVIDE ( esp_rom_md5_update = MD5Update );
PROVIDE ( esp_rom_md5_final  = MD5Final );

PROVIDE ( esp_rom_software_reset_system = software_reset );
PROVIDE ( esp_rom_software_reset_cpu    = software_reset_cpu );

PROVIDE ( esp_rom_printf   = ets_printf );
PROVIDE ( esp_rom_install_uart_printf = ets_install_uart_printf );
PROVIDE ( esp_rom_delay_us = ets_delay_us );
PROVIDE ( esp_rom_get_reset_reason = rtc_get_reset_reason );
PROVIDE ( esp_rom_route_intr_matrix = intr_matrix_set );
PROVIDE ( esp_rom_get_cpu_ticks_per_us = ets_get_cpu_frequency );
PROVIDE ( esp_rom_set_cpu_ticks_per_us = ets_update_cpu_frequency );

PROVIDE ( esp_rom_spiflash_attach = spi_flash_attach );
PROVIDE ( esp_rom_spiflash_clear_bp = esp_rom_spiflash_unlock );
PROVIDE ( esp_rom_spiflash_write_enable = SPI_write_enable );
PROVIDE ( esp_rom_spiflash_erase_area = SPIEraseArea );

PROVIDE ( esp_rom_spiflash_fix_dummylen = spi_dummy_len_fix );
PROVIDE ( esp_rom_spiflash_set_drvs = SetSpiDrvs);
PROVIDE ( esp_rom_spiflash_select_padsfunc = SelectSpiFunction );
PROVIDE ( esp_rom_spiflash_common_cmd = SPI_Common_Command );

/*
 * SPDX-FileCopyrightText: 2022-2023 Espressif Systems (Shanghai) CO LTD
 *
 * SPDX-License-Identifier: Apache-2.0
 */
/* ROM function interface esp32c6.rom.ld for esp32c6
 *
 *
 * Generated from ./target/esp32c6/interface-esp32c6.yml md5sum 06c13e133e0743d09b87aba30d3e213b
 *
 * Compatible with ROM where ECO version equal or greater to 0.
 *
 * THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT.
 */

/***************************************
 Group common
 ***************************************/

/* Functions */
rtc_get_reset_reason = 0x40000018;
analog_super_wdt_reset_happened = 0x4000001c;
rtc_get_wakeup_cause = 0x40000020;
rtc_unhold_all_pads = 0x40000024;
ets_printf = 0x40000028;
ets_install_putc1 = 0x4000002c;
ets_install_putc2 = 0x40000030;
ets_install_uart_printf = 0x40000034;
ets_install_usb_printf = 0x40000038;
ets_get_printf_channel = 0x4000003c;
ets_delay_us = 0x40000040;
ets_get_cpu_frequency = 0x40000044;
ets_update_cpu_frequency = 0x40000048;
ets_install_lock = 0x4000004c;
UartRxString = 0x40000050;
UartGetCmdLn = 0x40000054;
uart_tx_one_char = 0x40000058;
uart_tx_one_char2 = 0x4000005c;
uart_rx_one_char = 0x40000060;
uart_rx_one_char_block = 0x40000064;
uart_rx_intr_handler = 0x40000068;
uart_rx_readbuff = 0x4000006c;
uartAttach = 0x40000070;
uart_tx_flush = 0x40000074;
uart_tx_wait_idle = 0x40000078;
uart_div_modify = 0x4000007c;
ets_write_char_uart = 0x40000080;
uart_tx_switch = 0x40000084;
roundup2 = 0x40000088;
multofup = 0x4000008c;
software_reset = 0x40000090;
software_reset_cpu = 0x40000094;
ets_clk_assist_debug_clock_enable = 0x40000098;
clear_super_wdt_reset_flag = 0x4000009c;
disable_default_watchdog = 0x400000a0;
esp_rom_set_rtc_wake_addr = 0x400000a4;
esp_rom_get_rtc_wake_addr = 0x400000a8;
send_packet = 0x400000ac;
recv_packet = 0x400000b0;
GetUartDevice = 0x400000b4;
UartDwnLdProc = 0x400000b8;
GetSecurityInfoProc = 0x400000bc;
Uart_Init = 0x400000c0;
ets_set_user_start = 0x400000c4;
/* Data (.data, .bss, .rodata) */
ets_rom_layout_p = 0x4004fffc;
ets_ops_table_ptr = 0x4087fff8;
g_saved_pc = 0x4087fffc;


/***************************************
 Group miniz
 ***************************************/

/* Functions */
mz_adler32 = 0x400000c8;
mz_free = 0x400000cc;
tdefl_compress = 0x400000d0;
tdefl_compress_buffer = 0x400000d4;
tdefl_compress_mem_to_heap = 0x400000d8;
tdefl_compress_mem_to_mem = 0x400000dc;
tdefl_compress_mem_to_output = 0x400000e0;
tdefl_get_adler32 = 0x400000e4;
tdefl_get_prev_return_status = 0x400000e8;
tdefl_init = 0x400000ec;
tdefl_write_image_to_png_file_in_memory = 0x400000f0;
tdefl_write_image_to_png_file_in_memory_ex = 0x400000f4;
tinfl_decompress = 0x400000f8;
tinfl_decompress_mem_to_callback = 0x400000fc;
tinfl_decompress_mem_to_heap = 0x40000100;
tinfl_decompress_mem_to_mem = 0x40000104;


/***************************************
 Group tjpgd
 ***************************************/

/* Functions */
jd_prepare = 0x40000108;
jd_decomp = 0x4000010c;


/***************************************
 Group spiflash_legacy
 ***************************************/

/* Functions */
esp_rom_spiflash_wait_idle = 0x40000110;
esp_rom_spiflash_write_encrypted = 0x40000114;
esp_rom_spiflash_write_encrypted_dest = 0x40000118;
esp_rom_spiflash_write_encrypted_enable = 0x4000011c;
esp_rom_spiflash_write_encrypted_disable = 0x40000120;
esp_rom_spiflash_erase_chip = 0x40000124;
_esp_rom_spiflash_erase_sector = 0x40000128;
_esp_rom_spiflash_erase_block = 0x4000012c;
_esp_rom_spiflash_write = 0x40000130;
_esp_rom_spiflash_read = 0x40000134;
_esp_rom_spiflash_unlock = 0x40000138;
_SPIEraseArea = 0x4000013c;
_SPI_write_enable = 0x40000140;
esp_rom_spiflash_erase_sector = 0x40000144;
esp_rom_spiflash_erase_block = 0x40000148;
esp_rom_spiflash_write = 0x4000014c;
esp_rom_spiflash_read = 0x40000150;
esp_rom_spiflash_unlock = 0x40000154;
SPIEraseArea = 0x40000158;
SPI_write_enable = 0x4000015c;
esp_rom_spiflash_config_param = 0x40000160;
esp_rom_spiflash_read_user_cmd = 0x40000164;
esp_rom_spiflash_select_qio_pins = 0x40000168;
esp_rom_spi_flash_auto_sus_res = 0x4000016c;
esp_rom_spi_flash_send_resume = 0x40000170;
esp_rom_spi_flash_update_id = 0x40000174;
esp_rom_spiflash_config_clk = 0x40000178;
esp_rom_spiflash_config_readmode = 0x4000017c;
esp_rom_spiflash_read_status = 0x40000180;
esp_rom_spiflash_read_statushigh = 0x40000184;
esp_rom_spiflash_write_status = 0x40000188;
spi_cache_mode_switch = 0x4000018c;
spi_common_set_dummy_output = 0x40000190;
spi_common_set_flash_cs_timing = 0x40000194;
esp_rom_spi_set_address_bit_len = 0x40000198;
SPILock = 0x4000019c;
SPIMasterReadModeCnfig = 0x400001a0;
SPI_Common_Command = 0x400001a4;
SPI_WakeUp = 0x400001a8;
SPI_block_erase = 0x400001ac;
SPI_chip_erase = 0x400001b0;
SPI_init = 0x400001b4;
SPI_page_program = 0x400001b8;
SPI_read_data = 0x400001bc;
SPI_sector_erase = 0x400001c0;
SelectSpiFunction = 0x400001c4;
SetSpiDrvs = 0x400001c8;
Wait_SPI_Idle = 0x400001cc;
spi_dummy_len_fix = 0x400001d0;
Disable_QMode = 0x400001d4;
Enable_QMode = 0x400001d8;
spi_flash_attach = 0x400001dc;
spi_flash_get_chip_size = 0x400001e0;
spi_flash_guard_set = 0x400001e4;
spi_flash_guard_get = 0x400001e8;
spi_flash_read_encrypted = 0x400001ec;
/* Data (.data, .bss, .rodata) */
rom_spiflash_legacy_funcs = 0x4087fff0;
rom_spiflash_legacy_data = 0x4087ffec;
g_flash_guard_ops = 0x4087fff4;

/* Note: esp_rom_spiflash_write_disable was moved from esp32c6.rom.spiflash.ld */
esp_rom_spiflash_write_disable = 0x40000278;


/***************************************
 Group cache
 ***************************************/

/* Functions */
Cache_Get_ICache_Line_Size = 0x40000628;
Cache_Get_Mode = 0x4000062c;
Cache_Address_Through_Cache = 0x40000630;
ROM_Boot_Cache_Init = 0x40000634;
MMU_Set_Page_Mode = 0x40000638;
MMU_Get_Page_Mode = 0x4000063c;
Cache_Invalidate_ICache_Items = 0x40000640;
Cache_Op_Addr = 0x40000644;
Cache_Invalidate_Addr = 0x40000648;
Cache_Invalidate_ICache_All = 0x4000064c;
Cache_Mask_All = 0x40000650;
Cache_UnMask_Dram0 = 0x40000654;
Cache_Suspend_ICache_Autoload = 0x40000658;
Cache_Resume_ICache_Autoload = 0x4000065c;
Cache_Start_ICache_Preload = 0x40000660;
Cache_ICache_Preload_Done = 0x40000664;
Cache_End_ICache_Preload = 0x40000668;
Cache_Config_ICache_Autoload = 0x4000066c;
Cache_Enable_ICache_Autoload = 0x40000670;
Cache_Disable_ICache_Autoload = 0x40000674;
Cache_Enable_ICache_PreLock = 0x40000678;
Cache_Disable_ICache_PreLock = 0x4000067c;
Cache_Lock_ICache_Items = 0x40000680;
Cache_Unlock_ICache_Items = 0x40000684;
Cache_Lock_Addr = 0x40000688;
Cache_Unlock_Addr = 0x4000068c;
Cache_Disable_ICache = 0x40000690;
Cache_Enable_ICache = 0x40000694;
Cache_Suspend_ICache = 0x40000698;
Cache_Resume_ICache = 0x4000069c;
Cache_Freeze_ICache_Enable = 0x400006a0;
Cache_Freeze_ICache_Disable = 0x400006a4;
Cache_Set_IDROM_MMU_Size = 0x400006a8;
Cache_Get_IROM_MMU_End = 0x400006ac;
Cache_Get_DROM_MMU_End = 0x400006b0;
Cache_MMU_Init = 0x400006b4;
Cache_MSPI_MMU_Set = 0x400006b8;
Cache_Travel_Tag_Memory = 0x400006bc;
Cache_Get_Virtual_Addr = 0x400006c0;
/* Data (.data, .bss, .rodata) */
rom_cache_op_cb = 0x4087ffcc;
rom_cache_internal_table_ptr = 0x4087ffc8;


/***************************************
 Group clock
 ***************************************/

/* Functions */
ets_clk_get_xtal_freq = 0x400006c4;
ets_clk_get_cpu_freq = 0x400006c8;
ets_clk_apb_wait_ready = 0x400006cc;
ets_clk_mspi_apb_wait_ready = 0x400006d0;


/***************************************
 Group gpio
 ***************************************/

/* Functions */
gpio_input_get = 0x400006d4;
gpio_matrix_in = 0x400006d8;
gpio_matrix_out = 0x400006dc;
/* gpio_output_disable = 0x400006e0; */
/* gpio_output_enable = 0x400006e4; */
gpio_output_set = 0x400006e8;
gpio_pad_hold = 0x400006ec;
gpio_pad_input_disable = 0x400006f0;
gpio_pad_input_enable = 0x400006f4;
gpio_pad_pulldown = 0x400006f8;
gpio_pad_pullup = 0x400006fc;
gpio_pad_select_gpio = 0x40000700;
gpio_pad_set_drv = 0x40000704;
gpio_pad_unhold = 0x40000708;
gpio_pin_wakeup_disable = 0x4000070c;
gpio_pin_wakeup_enable = 0x40000710;
gpio_bypass_matrix_in = 0x40000714;


/***************************************
 Group interrupts
 ***************************************/

/* Functions */
esprv_intc_int_set_priority = 0x40000718;
esprv_intc_int_set_threshold = 0x4000071c;
esprv_intc_int_enable = 0x40000720;
esprv_intc_int_disable = 0x40000724;
esprv_intc_int_set_type = 0x40000728;
PROVIDE( intr_handler_set = 0x4000072c );
intr_matrix_set = 0x40000730;
ets_intr_lock = 0x40000734;
ets_intr_unlock = 0x40000738;
ets_isr_attach = 0x4000073c;
ets_isr_mask = 0x40000740;
ets_isr_unmask = 0x40000744;


/***************************************
 Group crypto
 ***************************************/

/* Functions */
md5_vector = 0x40000748;
MD5Init = 0x4000074c;
MD5Update = 0x40000750;
MD5Final = 0x40000754;
crc32_le = 0x40000758;
crc16_le = 0x4000075c;
crc8_le = 0x40000760;
crc32_be = 0x40000764;
crc16_be = 0x40000768;
crc8_be = 0x4000076c;
esp_crc8 = 0x40000770;
ets_sha_enable = 0x40000774;
ets_sha_disable = 0x40000778;
ets_sha_get_state = 0x4000077c;
ets_sha_init = 0x40000780;
ets_sha_process = 0x40000784;
ets_sha_starts = 0x40000788;
ets_sha_update = 0x4000078c;
ets_sha_finish = 0x40000790;
ets_sha_clone = 0x40000794;
ets_hmac_enable = 0x40000798;
ets_hmac_disable = 0x4000079c;
ets_hmac_calculate_message = 0x400007a0;
ets_hmac_calculate_downstream = 0x400007a4;
ets_hmac_invalidate_downstream = 0x400007a8;
ets_jtag_enable_temporarily = 0x400007ac;
ets_aes_enable = 0x400007b0;
ets_aes_disable = 0x400007b4;
ets_aes_setkey = 0x400007b8;
ets_aes_block = 0x400007bc;
ets_aes_setkey_dec = 0x400007c0;
ets_aes_setkey_enc = 0x400007c4;
ets_bigint_enable = 0x400007c8;
ets_bigint_disable = 0x400007cc;
ets_bigint_multiply = 0x400007d0;
ets_bigint_modmult = 0x400007d4;
ets_bigint_modexp = 0x400007d8;
ets_bigint_wait_finish = 0x400007dc;
ets_bigint_getz = 0x400007e0;
ets_ds_enable = 0x400007e4;
ets_ds_disable = 0x400007e8;
ets_ds_start_sign = 0x400007ec;
ets_ds_is_busy = 0x400007f0;
ets_ds_finish_sign = 0x400007f4;
ets_ds_encrypt_params = 0x400007f8;
ets_mgf1_sha256 = 0x400007fc;
/* Data (.data, .bss, .rodata) */
crc32_le_table_ptr = 0x4004fff8;
crc16_le_table_ptr = 0x4004fff4;
crc8_le_table_ptr = 0x4004fff0;
crc32_be_table_ptr = 0x4004ffec;
crc16_be_table_ptr = 0x4004ffe8;
crc8_be_table_ptr = 0x4004ffe4;


/***************************************
 Group efuse
 ***************************************/

/* Functions */
ets_efuse_read = 0x40000800;
ets_efuse_program = 0x40000804;
ets_efuse_clear_program_registers = 0x40000808;
ets_efuse_write_key = 0x4000080c;
ets_efuse_get_read_register_address = 0x40000810;
ets_efuse_get_key_purpose = 0x40000814;
ets_efuse_key_block_unused = 0x40000818;
ets_efuse_find_unused_key_block = 0x4000081c;
ets_efuse_rs_calculate = 0x40000820;
ets_efuse_count_unused_key_blocks = 0x40000824;
ets_efuse_secure_boot_enabled = 0x40000828;
ets_efuse_secure_boot_aggressive_revoke_enabled = 0x4000082c;
ets_efuse_cache_encryption_enabled = 0x40000830;
ets_efuse_download_modes_disabled = 0x40000834;
ets_efuse_find_purpose = 0x40000838;
ets_efuse_force_send_resume = 0x4000083c;
ets_efuse_get_flash_delay_us = 0x40000840;
ets_efuse_get_mac = 0x40000844;
ets_efuse_get_uart_print_control = 0x40000848;
ets_efuse_direct_boot_mode_disabled = 0x4000084c;
ets_efuse_security_download_modes_enabled = 0x40000850;
ets_efuse_set_timing = 0x40000854;
ets_efuse_jtag_disabled = 0x40000858;
ets_efuse_usb_print_is_disabled = 0x4000085c;
ets_efuse_usb_download_mode_disabled = 0x40000860;
ets_efuse_usb_device_disabled = 0x40000864;
ets_efuse_secure_boot_fast_wake_enabled = 0x40000868;


/***************************************
 Group secureboot
 ***************************************/

/* Functions */
ets_emsa_pss_verify = 0x4000086c;
ets_rsa_pss_verify = 0x40000870;
ets_secure_boot_verify_bootloader_with_keys = 0x40000874;
ets_secure_boot_verify_signature = 0x40000878;
ets_secure_boot_read_key_digests = 0x4000087c;
ets_secure_boot_revoke_public_key_digest = 0x40000880;


/***************************************
 Group usb_device_uart
 ***************************************/

/* Functions */
usb_serial_device_rx_one_char = 0x40000a80;
usb_serial_device_rx_one_char_block = 0x40000a84;
usb_serial_device_tx_flush = 0x40000a88;
usb_serial_device_tx_one_char = 0x40000a8c;


/***************************************
 Group lldesc
 ***************************************/

/* Functions */
lldesc_build_chain = 0x40000a90;


/***************************************
 Group sip
 ***************************************/

/* Functions */
sip_after_tx_complete = 0x40000a94;
sip_alloc_to_host_evt = 0x40000a98;
sip_download_begin = 0x40000a9c;
sip_get_ptr = 0x40000aa0;
sip_get_state = 0x40000aa4;
sip_init_attach = 0x40000aa8;
sip_install_rx_ctrl_cb = 0x40000aac;
sip_install_rx_data_cb = 0x40000ab0;
sip_is_active = 0x40000ab4;
sip_post_init = 0x40000ab8;
sip_reclaim_from_host_cmd = 0x40000abc;
sip_reclaim_tx_data_pkt = 0x40000ac0;
sip_send = 0x40000ac4;
sip_to_host_chain_append = 0x40000ac8;
sip_to_host_evt_send_done = 0x40000acc;


/***************************************
 Group slc
 ***************************************/

/* Functions */
slc_add_credits = 0x40000ad0;
slc_enable = 0x40000ad4;
slc_from_host_chain_fetch = 0x40000ad8;
slc_from_host_chain_recycle = 0x40000adc;
slc_has_pkt_to_host = 0x40000ae0;
slc_init_attach = 0x40000ae4;
slc_init_credit = 0x40000ae8;
slc_reattach = 0x40000aec;
slc_send_to_host_chain = 0x40000af0;
slc_set_host_io_max_window = 0x40000af4;
slc_to_host_chain_recycle = 0x40000af8;

/*
 * SPDX-FileCopyrightText: 2022 Espressif Systems (Shanghai) CO LTD
 *
 * SPDX-License-Identifier: Apache-2.0
 */
/* ROM function interface esp32c6.rom.libgcc.ld for esp32c6
 *
 *
 * Generated from ./target/esp32c6/interface-esp32c6.yml md5sum 06c13e133e0743d09b87aba30d3e213b
 *
 * Compatible with ROM where ECO version equal or greater to 0.
 *
 * THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT.
 */

/***************************************
 Group libgcc
 ***************************************/

/* Functions */
__absvdi2 = 0x40000884;
__absvsi2 = 0x40000888;
__adddf3 = 0x4000088c;
__addsf3 = 0x40000890;
__addvdi3 = 0x40000894;
__addvsi3 = 0x40000898;
__ashldi3 = 0x4000089c;
__ashrdi3 = 0x400008a0;
__bswapdi2 = 0x400008a4;
__bswapsi2 = 0x400008a8;
__clear_cache = 0x400008ac;
__clrsbdi2 = 0x400008b0;
__clrsbsi2 = 0x400008b4;
__clzdi2 = 0x400008b8;
__clzsi2 = 0x400008bc;
__cmpdi2 = 0x400008c0;
__ctzdi2 = 0x400008c4;
__ctzsi2 = 0x400008c8;
__divdc3 = 0x400008cc;
__divdf3 = 0x400008d0;
__divdi3 = 0x400008d4;
__divsc3 = 0x400008d8;
__divsf3 = 0x400008dc;
__divsi3 = 0x400008e0;
__eqdf2 = 0x400008e4;
__eqsf2 = 0x400008e8;
__extendsfdf2 = 0x400008ec;
__ffsdi2 = 0x400008f0;
__ffssi2 = 0x400008f4;
__fixdfdi = 0x400008f8;
__fixdfsi = 0x400008fc;
__fixsfdi = 0x40000900;
__fixsfsi = 0x40000904;
__fixunsdfsi = 0x40000908;
__fixunssfdi = 0x4000090c;
__fixunssfsi = 0x40000910;
__floatdidf = 0x40000914;
__floatdisf = 0x40000918;
__floatsidf = 0x4000091c;
__floatsisf = 0x40000920;
__floatundidf = 0x40000924;
__floatundisf = 0x40000928;
__floatunsidf = 0x4000092c;
__floatunsisf = 0x40000930;
__gcc_bcmp = 0x40000934;
__gedf2 = 0x40000938;
__gesf2 = 0x4000093c;
__gtdf2 = 0x40000940;
__gtsf2 = 0x40000944;
__ledf2 = 0x40000948;
__lesf2 = 0x4000094c;
__lshrdi3 = 0x40000950;
__ltdf2 = 0x40000954;
__ltsf2 = 0x40000958;
__moddi3 = 0x4000095c;
__modsi3 = 0x40000960;
__muldc3 = 0x40000964;
__muldf3 = 0x40000968;
__muldi3 = 0x4000096c;
__mulsc3 = 0x40000970;
__mulsf3 = 0x40000974;
__mulsi3 = 0x40000978;
__mulvdi3 = 0x4000097c;
__mulvsi3 = 0x40000980;
__nedf2 = 0x40000984;
__negdf2 = 0x40000988;
__negdi2 = 0x4000098c;
__negsf2 = 0x40000990;
__negvdi2 = 0x40000994;
__negvsi2 = 0x40000998;
__nesf2 = 0x4000099c;
__paritysi2 = 0x400009a0;
__popcountdi2 = 0x400009a4;
__popcountsi2 = 0x400009a8;
__powidf2 = 0x400009ac;
__powisf2 = 0x400009b0;
__subdf3 = 0x400009b4;
__subsf3 = 0x400009b8;
__subvdi3 = 0x400009bc;
__subvsi3 = 0x400009c0;
__truncdfsf2 = 0x400009c4;
__ucmpdi2 = 0x400009c8;
__udivdi3 = 0x400009cc;
__udivmoddi4 = 0x400009d0;
__udivsi3 = 0x400009d4;
__udiv_w_sdiv = 0x400009d8;
__umoddi3 = 0x400009dc;
__umodsi3 = 0x400009e0;
__unorddf2 = 0x400009e4;
__unordsf2 = 0x400009e8;
__extenddftf2 = 0x400009ec;
__trunctfdf2 = 0x400009f0;

/*
 * SPDX-FileCopyrightText: 2022 Espressif Systems (Shanghai) CO LTD
 *
 * SPDX-License-Identifier: Apache-2.0
 */
/* ROM function interface esp32c6.rom.newlib.ld for esp32c6
 *
 *
 * Generated from ./target/esp32c6/interface-esp32c6.yml md5sum 06c13e133e0743d09b87aba30d3e213b
 *
 * Compatible with ROM where ECO version equal or greater to 0.
 *
 * THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT.
 */

/***************************************
 Group newlib
 ***************************************/

/* Functions */
esp_rom_newlib_init_common_mutexes = 0x400004a4;
memset = 0x400004a8;
memcpy = 0x400004ac;
memmove = 0x400004b0;
memcmp = 0x400004b4;
strcpy = 0x400004b8;
strncpy = 0x400004bc;
strcmp = 0x400004c0;
strncmp = 0x400004c4;
strlen = 0x400004c8;
strstr = 0x400004cc;
bzero = 0x400004d0;
_isatty_r = 0x400004d4;
sbrk = 0x400004d8;
isalnum = 0x400004dc;
isalpha = 0x400004e0;
isascii = 0x400004e4;
isblank = 0x400004e8;
iscntrl = 0x400004ec;
isdigit = 0x400004f0;
islower = 0x400004f4;
isgraph = 0x400004f8;
isprint = 0x400004fc;
ispunct = 0x40000500;
isspace = 0x40000504;
isupper = 0x40000508;
toupper = 0x4000050c;
tolower = 0x40000510;
toascii = 0x40000514;
memccpy = 0x40000518;
memchr = 0x4000051c;
memrchr = 0x40000520;
strcasecmp = 0x40000524;
strcasestr = 0x40000528;
strcat = 0x4000052c;
strdup = 0x40000530;
strchr = 0x40000534;
strcspn = 0x40000538;
strcoll = 0x4000053c;
strlcat = 0x40000540;
strlcpy = 0x40000544;
strlwr = 0x40000548;
strncasecmp = 0x4000054c;
strncat = 0x40000550;
strndup = 0x40000554;
strnlen = 0x40000558;
strrchr = 0x4000055c;
strsep = 0x40000560;
strspn = 0x40000564;
strtok_r = 0x40000568;
strupr = 0x4000056c;
longjmp = 0x40000570;
setjmp = 0x40000574;
abs = 0x40000578;
div = 0x4000057c;
labs = 0x40000580;
ldiv = 0x40000584;
qsort = 0x40000588;
rand_r = 0x4000058c;
rand = 0x40000590;
srand = 0x40000594;
utoa = 0x40000598;
itoa = 0x4000059c;
atoi = 0x400005a0;
atol = 0x400005a4;
strtol = 0x400005a8;
strtoul = 0x400005ac;
fflush = 0x400005b0;
_fflush_r = 0x400005b4;
_fwalk = 0x400005b8;
_fwalk_reent = 0x400005bc;
__smakebuf_r = 0x400005c0;
__swhatbuf_r = 0x400005c4;
__swbuf_r = 0x400005c8;
__swbuf = 0x400005cc;
__swsetup_r = 0x400005d0;
/* Data (.data, .bss, .rodata) */
syscall_table_ptr = 0x4087ffd4;
_global_impure_ptr = 0x4087ffd0;

/*
 * SPDX-FileCopyrightText: 2022 Espressif Systems (Shanghai) CO LTD
 *
 * SPDX-License-Identifier: Apache-2.0
 */
/* ROM function interface esp32c6.rom.newlib-normal.ld for esp32c6
 *
 *
 * Generated from ./target/esp32c6/interface-esp32c6.yml md5sum 06c13e133e0743d09b87aba30d3e213b
 *
 * Compatible with ROM where ECO version equal or greater to 0.
 *
 * THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT.
 */

/***************************************
 Group newlib_normal_format
 ***************************************/

/* Functions */
__sprint_r = 0x400005d4;
_fiprintf_r = 0x400005d8;
_fprintf_r = 0x400005dc;
_vfiprintf_r = 0x400005e0;
_vfprintf_r = 0x400005e4;
fiprintf = 0x400005e8;
fprintf = 0x400005ec;
printf = 0x400005f0;
vfiprintf = 0x400005f4;
vfprintf = 0x400005f8;
asprintf = 0x400005fc;
sprintf = 0x40000600;
snprintf = 0x40000604;
siprintf = 0x40000608;
sniprintf = 0x4000060c;
vprintf = 0x40000610;
viprintf = 0x40000614;
vsnprintf = 0x40000618;
vsniprintf = 0x4000061c;
sscanf = 0x40000620;
siscanf = 0x40000624;

/*
 * SPDX-FileCopyrightText: 2022 Espressif Systems (Shanghai) CO LTD
 *
 * SPDX-License-Identifier: Apache-2.0
 */
/* ROM function interface esp32c6.rom.heap.ld for esp32c6
 *
 *
 * Generated from ./target/esp32c6/interface-esp32c6.yml md5sum 06c13e133e0743d09b87aba30d3e213b
 *
 * Compatible with ROM where ECO version equal or greater to 0.
 *
 * THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT.
 */

/***************************************
 Group heap
 ***************************************/

/* Functions */
tlsf_create = 0x400003fc;
tlsf_create_with_pool = 0x40000400;
tlsf_get_pool = 0x40000404;
tlsf_add_pool = 0x40000408;
tlsf_remove_pool = 0x4000040c;
tlsf_malloc = 0x40000410;
tlsf_memalign = 0x40000414;
tlsf_memalign_offs = 0x40000418;
tlsf_realloc = 0x4000041c;
tlsf_free = 0x40000420;
tlsf_block_size = 0x40000424;
tlsf_size = 0x40000428;
tlsf_align_size = 0x4000042c;
tlsf_block_size_min = 0x40000430;
tlsf_block_size_max = 0x40000434;
tlsf_pool_overhead = 0x40000438;
tlsf_alloc_overhead = 0x4000043c;
tlsf_walk_pool = 0x40000440;
tlsf_check = 0x40000444;
tlsf_poison_fill_pfunc_set = 0x4000044c;
tlsf_poison_check_pfunc_set = 0x40000450;
multi_heap_get_block_address_impl = 0x40000454;
multi_heap_get_allocated_size_impl = 0x40000458;
multi_heap_register_impl = 0x4000045c;
multi_heap_set_lock = 0x40000460;
multi_heap_mutex_init = 0x40000464;
multi_heap_internal_lock = 0x40000468;
multi_heap_internal_unlock = 0x4000046c;
multi_heap_get_first_block = 0x40000470;
multi_heap_get_next_block = 0x40000474;
multi_heap_is_free = 0x40000478;
multi_heap_malloc_impl = 0x4000047c;
multi_heap_free_impl = 0x40000480;
multi_heap_realloc_impl = 0x40000484;
multi_heap_aligned_alloc_impl_offs = 0x40000488;
multi_heap_aligned_alloc_impl = 0x4000048c;
multi_heap_check = 0x40000490;
multi_heap_dump = 0x40000494;
multi_heap_free_size_impl = 0x40000498;
multi_heap_minimum_free_size_impl = 0x4000049c;
multi_heap_get_info_impl = 0x400004a0;
/* Data (.data, .bss, .rodata) */
heap_tlsf_table_ptr = 0x4087ffd8;

PROVIDE (multi_heap_malloc = multi_heap_malloc_impl);
PROVIDE (multi_heap_free = multi_heap_free_impl);
PROVIDE (multi_heap_realloc = multi_heap_realloc_impl);
PROVIDE (multi_heap_get_allocated_size = multi_heap_get_allocated_size_impl);
PROVIDE (multi_heap_register = multi_heap_register_impl);
PROVIDE (multi_heap_get_info = multi_heap_get_info_impl);
PROVIDE (multi_heap_free_size = multi_heap_free_size_impl);
PROVIDE (multi_heap_minimum_free_size = multi_heap_minimum_free_size_impl);
PROVIDE (multi_heap_get_block_address = multi_heap_get_block_address_impl);
PROVIDE (multi_heap_aligned_alloc = multi_heap_aligned_alloc_impl);
PROVIDE (multi_heap_aligned_free = multi_heap_aligned_free_impl);
PROVIDE (multi_heap_check = multi_heap_check);
PROVIDE (multi_heap_set_lock = multi_heap_set_lock);
PROVIDE (multi_heap_os_funcs_init = multi_heap_mutex_init);
PROVIDE (multi_heap_internal_lock = multi_heap_internal_lock);
PROVIDE (multi_heap_internal_unlock = multi_heap_internal_unlock);

/*
 * SPDX-FileCopyrightText: 2022-2023 Espressif Systems (Shanghai) CO LTD
 *
 * SPDX-License-Identifier: Apache-2.0
 */
/* ROM function interface esp32c6.rom.spiflash.ld for esp32c6
 *
 *
 * Generated from ./target/esp32c6/interface-esp32c6.yml md5sum 06c13e133e0743d09b87aba30d3e213b
 *
 * Compatible with ROM where ECO version equal or greater to 0.
 *
 * THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT.
 */

/***************************************
 Group spi_flash_cache
 ***************************************/

/* Functions */
spi_flash_disable_cache = 0x400001f0;
spi_flash_restore_cache = 0x400001f4;
spi_flash_cache_enabled = 0x400001f8;
esp_enable_cache_flash_wrap = 0x40000200;


/***************************************
 Group spi_flash_mmap
 ***************************************/

/* Functions */
spi_flash_mmap_os_func_set = 0x40000204;
spi_flash_mmap_page_num_init = 0x40000208;
spi_flash_mmap = 0x4000020c;
spi_flash_mmap_pages = 0x40000210;
spi_flash_munmap = 0x40000214;
spi_flash_mmap_dump = 0x40000218;
spi_flash_check_and_flush_cache = 0x4000021c;
spi_flash_mmap_get_free_pages = 0x40000220;
spi_flash_cache2phys = 0x40000224;
spi_flash_phys2cache = 0x40000228;


/***************************************
 Group esp_flash
 ***************************************/

/* Functions */
esp_flash_chip_driver_initialized = 0x4000022c;
esp_flash_read_id = 0x40000230;
esp_flash_get_size = 0x40000234;
esp_flash_erase_chip = 0x40000238;
esp_flash_erase_region = 0x4000023c;
esp_flash_get_chip_write_protect = 0x40000240;
esp_flash_set_chip_write_protect = 0x40000244;
esp_flash_get_protectable_regions = 0x40000248;
esp_flash_get_protected_region = 0x4000024c;
esp_flash_set_protected_region = 0x40000250;
esp_flash_read = 0x40000254;
esp_flash_write = 0x40000258;
esp_flash_write_encrypted = 0x4000025c;
esp_flash_read_encrypted = 0x40000260;
esp_flash_get_io_mode = 0x40000264;
esp_flash_set_io_mode = 0x40000268;
spi_flash_boot_attach = 0x4000026c;
esp_flash_read_chip_id = 0x40000270;
detect_spi_flash_chip = 0x40000274;
/* esp_rom_spiflash_write_disable = 0x40000278; */
esp_flash_suspend_cmd_init = 0x4000027c;
/* Data (.data, .bss, .rodata) */
esp_flash_default_chip = 0x4087ffe8;
esp_flash_api_funcs = 0x4087ffe4;


/***************************************
 Group spi_flash_chips
 ***************************************/

/* Functions */
spi_flash_chip_generic_probe = 0x40000280;
spi_flash_chip_generic_detect_size = 0x40000284;
spi_flash_chip_generic_write = 0x40000288;
spi_flash_chip_generic_write_encrypted = 0x4000028c;
spi_flash_chip_generic_set_write_protect = 0x40000290;
spi_flash_common_write_status_16b_wrsr = 0x40000294;
spi_flash_chip_generic_reset = 0x40000298;
spi_flash_chip_generic_erase_chip = 0x4000029c;
spi_flash_chip_generic_erase_sector = 0x400002a0;
spi_flash_chip_generic_erase_block = 0x400002a4;
spi_flash_chip_generic_page_program = 0x400002a8;
spi_flash_chip_generic_get_write_protect = 0x400002ac;
spi_flash_common_read_status_16b_rdsr_rdsr2 = 0x400002b0;
spi_flash_chip_generic_read_reg = 0x400002b4;
spi_flash_chip_generic_yield = 0x400002b8;
spi_flash_generic_wait_host_idle = 0x400002bc;
spi_flash_chip_generic_wait_idle = 0x400002c0;
spi_flash_chip_generic_config_host_io_mode = 0x400002c4;
spi_flash_chip_generic_read = 0x400002c8;
spi_flash_common_read_status_8b_rdsr2 = 0x400002cc;
spi_flash_chip_generic_get_io_mode = 0x400002d0;
spi_flash_common_read_status_8b_rdsr = 0x400002d4;
spi_flash_common_write_status_8b_wrsr = 0x400002d8;
spi_flash_common_write_status_8b_wrsr2 = 0x400002dc;
spi_flash_common_set_io_mode = 0x400002e0;
spi_flash_chip_generic_set_io_mode = 0x400002e4;
spi_flash_chip_generic_read_unique_id = 0x400002e8;
spi_flash_chip_generic_get_caps = 0x400002ec;
spi_flash_chip_generic_suspend_cmd_conf = 0x400002f0;
spi_flash_chip_gd_get_io_mode = 0x400002f4;
spi_flash_chip_gd_probe = 0x400002f8;
spi_flash_chip_gd_set_io_mode = 0x400002fc;
/* Data (.data, .bss, .rodata) */
spi_flash_chip_generic_config_data = 0x4087ffe0;
spi_flash_encryption = 0x4087ffdc;


/***************************************
 Group memspi_host
 ***************************************/

/* Functions */
memspi_host_read_id_hs = 0x40000300;
memspi_host_read_status_hs = 0x40000304;
memspi_host_flush_cache = 0x40000308;
memspi_host_erase_chip = 0x4000030c;
memspi_host_erase_sector = 0x40000310;
memspi_host_erase_block = 0x40000314;
memspi_host_program_page = 0x40000318;
memspi_host_read = 0x4000031c;
memspi_host_set_write_protect = 0x40000320;
memspi_host_set_max_read_len = 0x40000324;
memspi_host_read_data_slicer = 0x40000328;
memspi_host_write_data_slicer = 0x4000032c;


/***************************************
 Group hal_spiflash
 ***************************************/

/* Functions */
spi_flash_hal_poll_cmd_done = 0x40000330;
spi_flash_hal_device_config = 0x40000334;
spi_flash_hal_configure_host_io_mode = 0x40000338;
spi_flash_hal_common_command = 0x4000033c;
spi_flash_hal_read = 0x40000340;
spi_flash_hal_erase_chip = 0x40000344;
spi_flash_hal_erase_sector = 0x40000348;
spi_flash_hal_erase_block = 0x4000034c;
spi_flash_hal_program_page = 0x40000350;
spi_flash_hal_set_write_protect = 0x40000354;
spi_flash_hal_host_idle = 0x40000358;
spi_flash_hal_check_status = 0x4000035c;
spi_flash_hal_setup_read_suspend = 0x40000360;
spi_flash_hal_setup_auto_suspend_mode = 0x40000364;
spi_flash_hal_setup_auto_resume_mode = 0x40000368;
spi_flash_hal_disable_auto_suspend_mode = 0x4000036c;
spi_flash_hal_disable_auto_resume_mode = 0x40000370;
spi_flash_hal_resume = 0x40000374;
spi_flash_hal_suspend = 0x40000378;
spi_flash_encryption_hal_enable = 0x4000037c;
spi_flash_encryption_hal_disable = 0x40000380;
spi_flash_encryption_hal_prepare = 0x40000384;
spi_flash_encryption_hal_done = 0x40000388;
spi_flash_encryption_hal_destroy = 0x4000038c;
spi_flash_encryption_hal_check = 0x40000390;

/*
 * SPDX-FileCopyrightText: 2024 Espressif Systems (Shanghai) CO LTD
 *
 * SPDX-License-Identifier: Apache-2.0
 */

/***************************************
 Group hal_systimer
 ***************************************/

/* Functions */
/* The following ROM functions are commented out because they're patched in the esp_rom_systimer.c */
/* systimer_hal_init = 0x400003c0; */
/* systimer_hal_deinit = 0x400003c4; */

systimer_hal_set_tick_rate_ops = 0x400003c8;
systimer_hal_get_counter_value = 0x400003cc;
systimer_hal_get_time = 0x400003d0;
systimer_hal_set_alarm_target = 0x400003d4;
systimer_hal_set_alarm_period = 0x400003d8;
systimer_hal_get_alarm_value = 0x400003dc;
systimer_hal_enable_alarm_int = 0x400003e0;
systimer_hal_on_apb_freq_update = 0x400003e4;
systimer_hal_counter_value_advance = 0x400003e8;
systimer_hal_enable_counter = 0x400003ec;
systimer_hal_select_alarm_mode = 0x400003f0;
systimer_hal_connect_alarm_counter = 0x400003f4;
systimer_hal_counter_can_stall_by_cpu = 0x400003f8;

/*
 * SPDX-FileCopyrightText: 2022-2023 Espressif Systems (Shanghai) CO LTD
 *
 * SPDX-License-Identifier: Apache-2.0
 */
/***************************************
 Group hal_wdt
 ***************************************/

/* Functions */

/* Patch init function to set clock source
wdt_hal_init = 0x40000394;
wdt_hal_deinit = 0x40000398;
*/

wdt_hal_config_stage = 0x4000039c;
wdt_hal_write_protect_disable = 0x400003a0;
wdt_hal_write_protect_enable = 0x400003a4;
wdt_hal_enable = 0x400003a8;
wdt_hal_disable = 0x400003ac;
wdt_hal_handle_intr = 0x400003b0;
wdt_hal_feed = 0x400003b4;
wdt_hal_set_flashboot_en = 0x400003b8;
wdt_hal_is_enabled = 0x400003bc;

/*
 * SPDX-FileCopyrightText: 2022 Espressif Systems (Shanghai) CO LTD
 *
 * SPDX-License-Identifier: Apache-2.0
 */
/* ROM version variables for esp32c6
 *
 * These addresses should be compatible with any ROM version for this chip.
 *
 * THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT.
 */
_rom_chip_id = 0x40000010;
_rom_eco_version = 0x40000014;

/*
 * SPDX-FileCopyrightText: 2022 Espressif Systems (Shanghai) CO LTD
 *
 * SPDX-License-Identifier: Apache-2.0
 */
/* ROM function interface esp32c6.rom.rvfp.ld for esp32c6
 *
 *
 * Generated from ./target/esp32c6/interface-esp32c6.yml md5sum 06c13e133e0743d09b87aba30d3e213b
 *
 * Compatible with ROM where ECO version equal or greater to 0.
 *
 * THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT.
 */

/***************************************
 Group rvfplib
 ***************************************/

/* Functions */
__adddf3 = 0x400009f4;
__addsf3 = 0x400009f8;
__eqdf2 = 0x400009fc;
__eqsf2 = 0x40000a00;
__extendsfdf2 = 0x40000a04;
__fixdfdi = 0x40000a08;
__fixdfsi = 0x40000a0c;
__fixsfdi = 0x40000a10;
__fixsfsi = 0x40000a14;
__fixunsdfsi = 0x40000a18;
__fixunssfdi = 0x40000a1c;
__fixunssfsi = 0x40000a20;
__floatdidf = 0x40000a24;
__floatdisf = 0x40000a28;
__floatsidf = 0x40000a2c;
__floatsisf = 0x40000a30;
__floatundidf = 0x40000a34;
__floatundisf = 0x40000a38;
__floatunsidf = 0x40000a3c;
__floatunsisf = 0x40000a40;
__gedf2 = 0x40000a44;
__gesf2 = 0x40000a48;
__gtdf2 = 0x40000a4c;
__gtsf2 = 0x40000a50;
__ledf2 = 0x40000a54;
__lesf2 = 0x40000a58;
__ltdf2 = 0x40000a5c;
__ltsf2 = 0x40000a60;
__muldf3 = 0x40000a64;
__mulsf3 = 0x40000a68;
__nedf2 = 0x40000a6c;
__nesf2 = 0x40000a70;
__subdf3 = 0x40000a74;
__subsf3 = 0x40000a78;
__truncdfsf2 = 0x40000a7c;

/***************************************
 Group libgcc
***************************************/

/* Functions */
__absvdi2 = 0x40000884;
__absvsi2 = 0x40000888;
__addvdi3 = 0x40000894;
__addvsi3 = 0x40000898;
__ashldi3 = 0x4000089c;
__ashrdi3 = 0x400008a0;
__bswapdi2 = 0x400008a4;
__bswapsi2 = 0x400008a8;
__clear_cache = 0x400008ac;
__clrsbdi2 = 0x400008b0;
__clrsbsi2 = 0x400008b4;
__clzdi2 = 0x400008b8;
__clzsi2 = 0x400008bc;
__cmpdi2 = 0x400008c0;
__ctzdi2 = 0x400008c4;
__ctzsi2 = 0x400008c8;
__divdc3 = 0x400008cc;
__divdf3 = 0x400008d0;
__divdi3 = 0x400008d4;
__divsc3 = 0x400008d8;
__divsf3 = 0x400008dc;
__divsi3 = 0x400008e0;
__ffsdi2 = 0x400008f0;
__ffssi2 = 0x400008f4;
__gcc_bcmp = 0x40000934;
__lshrdi3 = 0x40000950;
__moddi3 = 0x4000095c;
__modsi3 = 0x40000960;
__muldc3 = 0x40000964;
__muldi3 = 0x4000096c;
__mulsc3 = 0x40000970;
__mulsi3 = 0x40000978;
__mulvdi3 = 0x4000097c;
__mulvsi3 = 0x40000980;
__negdf2 = 0x40000988;
__negdi2 = 0x4000098c;
__negsf2 = 0x40000990;
__negvdi2 = 0x40000994;
__negvsi2 = 0x40000998;
__paritysi2 = 0x400009a0;
__popcountdi2 = 0x400009a4;
__popcountsi2 = 0x400009a8;
__powidf2 = 0x400009ac;
__powisf2 = 0x400009b0;
__subvdi3 = 0x400009bc;
__subvsi3 = 0x400009c0;
__ucmpdi2 = 0x400009c8;
__udivdi3 = 0x400009cc;
__udivmoddi4 = 0x400009d0;
__udivsi3 = 0x400009d4;
__udiv_w_sdiv = 0x400009d8;
__umoddi3 = 0x400009dc;
__umodsi3 = 0x400009e0;
__unorddf2 = 0x400009e4;
__unordsf2 = 0x400009e8;
__extenddftf2 = 0x400009ec;
__trunctfdf2 = 0x400009f0;

