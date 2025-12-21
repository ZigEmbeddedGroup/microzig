/*
** ###################################################################
**     Processors:          MCXN947VAB_cm33_core0
**                          MCXN947VDF_cm33_core0
**                          MCXN947VKL_cm33_core0
**                          MCXN947VNL_cm33_core0
**                          MCXN947VPB_cm33_core0
**
**     Compiler:            GNU C Compiler
**     Reference manual:    MCXNx4x Reference Manual
**     Version:             rev. 1.0, 2021-08-03
**     Build:               b250703
**
**     Abstract:
**         Linker file for the GNU C Compiler
**
**     Copyright 2016 Freescale Semiconductor, Inc.
**     Copyright 2016-2025 NXP
**     SPDX-License-Identifier: BSD-3-Clause
**
**     http:                 www.nxp.com
**     mail:                 support@nxp.com
**
** ###################################################################
*/



/* Entry Point */
ENTRY(_start)

HEAP_SIZE  = 0x0400;
STACK_SIZE = 0x0800;

TEXT_START = 0x00000000;
TEXT_SIZE = 0x000C0000;

/* Specify the memory areas */
MEMORY
{
  m_interrupts          (RX)  : ORIGIN = TEXT_START, LENGTH = 0x00000400
  m_text                (RX)  : ORIGIN = TEXT_START + 0x00000400, LENGTH = TEXT_SIZE - 0x00000400
  m_core1_image         (RX)  : ORIGIN = 0x000C0000, LENGTH = 0x00040000
  m_data                (RW)  : ORIGIN = 0x20000000, LENGTH = 0x0004E000
  m_flash1              (RX)  : ORIGIN = 0x00100000, LENGTH = 0x00100000
  m_sramx               (RW)  : ORIGIN = 0x04000000, LENGTH = 0x00018000
  m_flash_config        (RX)  : ORIGIN = 0x80000400, LENGTH = 0x00000400
  m_usb_sram            (RW)  : ORIGIN = 0x400BA000, LENGTH = 0x00001000
}

/* Define output sections */
SECTIONS
{
  /* section for storing the secondary core image */

  /* The startup code goes first into internal flash */
  .interrupts :
  {
    . = ALIGN(4);
    KEEP(*(microzig_flash_start))     /* Startup code */
    . = ALIGN(4);
  } > m_interrupts

  /* The program code and other data goes into internal flash */
  .text :
  {
    . = ALIGN(4);
    *(.text)                 /* .text sections (code) */
    *(.text*)                /* .text* sections (code) */
    *(.rodata)               /* .rodata sections (constants, strings, etc.) */
    *(.rodata*)              /* .rodata* sections (constants, strings, etc.) */
    *(.glue_7)               /* glue arm to thumb code */
    *(.glue_7t)              /* glue thumb to arm code */
    *(.eh_frame)
    KEEP (*(.init))
    KEEP (*(.fini))
    . = ALIGN(4);
  } > m_text

  .ARM.extab :
  {
    *(.ARM.extab* .gnu.linkonce.armextab.*)
  } > m_text

  .ARM :
  {
    __exidx_start = .;
    *(.ARM.exidx*)
    __exidx_end = .;
  } > m_text

  __etext = .;    /* define a global symbol at end of code */
  __DATA_ROM = .; /* Symbol is used by startup for data initialization */

  .data : AT(__DATA_ROM)
  {
    . = ALIGN(4);
    __DATA_RAM = .;
    __data_start__ = .;      /* create a global symbol at data start */
	microzig_data_start = .;
    *(.ramfunc*)             /* for functions in ram */
    *(.data)                 /* .data sections */
    *(.data*)                /* .data* sections */
    *(NonCacheable.init)     /* NonCacheable init section */
    *(NonCacheable)          /* NonCacheable section */
    *(CodeQuickAccess)       /* quick access code section */
    *(DataQuickAccess)       /* quick access data section */
    KEEP(*(.jcr*))
    . = ALIGN(4);
    __data_end__ = .;        /* define a global symbol at data end */
	microzig_data_end = .;
  } > m_data

  __DATA_END = __DATA_ROM + (__data_end__ - __data_start__);
  text_end = ORIGIN(m_text) + LENGTH(m_text);
  ASSERT(__DATA_END <= text_end, "region m_text overflowed with text and data")

  /* Uninitialized data section */
  .bss :
  {
    /* This is used by the startup in order to initialize the .bss section */
    . = ALIGN(4);
	microzig_bss_start = .;
    __START_BSS = .;
    __bss_start__ = .;
    *(.bss)
    *(.bss*)
    *(COMMON)
    . = ALIGN(4);
    __bss_end__ = .;
    __END_BSS = .;
	microzig_bss_end = .;
  } > m_data

  .heap :
  {
    . = ALIGN(8);
    __end__ = .;
	microzig_heap_start = .;
    PROVIDE(end = .);
    __HeapBase = .;
    . += HEAP_SIZE;
    __HeapLimit = .;
    __heap_limit = .; /* Add for _sbrk */
	microzig_heap_end = .;
  } > m_data

  .stack :
  {
    . = ALIGN(8);
    . += STACK_SIZE;
  } > m_data


  /* Initializes stack on the end of block */
  __StackTop   = ORIGIN(m_data) + LENGTH(m_data);
  end_of_stack = ORIGIN(m_data) + LENGTH(m_data);
  __StackLimit = __StackTop - STACK_SIZE;
  PROVIDE(__stack = __StackTop);

  .ARM.attributes 0 : { *(.ARM.attributes) }

  microzig_data_load_start = LOADADDR(.data);

  ASSERT(__StackLimit >= __HeapLimit, "region m_data overflowed with stack and heap")
}


