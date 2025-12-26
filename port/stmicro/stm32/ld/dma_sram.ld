/**
 * Adding a buffer for DMA. This buffer need to be in 
 * specific region so that the BuxMatrix can connect DMA and specific RAM
 * We assume that the generated linker have a ram named SRAM connected to DMA
 * Check the list of ram region inside the src/Chip.zig file for your target.
 */

 SECTIONS {
    .dma_buffer (NOLOAD) :
    {
        KEEP(*(.dma_buffer))
    } > SRAM
 }
 INSERT BEFORE .heap;