pub const GPIO = extern struct {
    reserved: [321]u32,
    /// (@ 0x00000504) Write GPIO port                                            
    out: u32,
    /// (@ 0x00000508) Set individual bits in GPIO port                           
    outset: u32,
    /// (@ 0x0000050C) Clear individual bits in GPIO port                         
    outclr: u32,
    /// (@ 0x00000510) Read GPIO port                                             
    in: u32,
    /// (@ 0x00000514) Direction of GPIO pins                                     
    dir: u32,
    /// (@ 0x00000518) DIR set register                                           
    dirset: u32,
    /// (@ 0x0000051C) DIR clear register                                         
    dirclr: u32,

    /// Latch register indicating what GPIO pins that
    /// have met the criteria set in the PIN_CNF[n].SENSE
    /// registers
    latch: u32,

    /// (@ 0x00000524) Select between default DETECT signal behaviour and LDETECT mode      
    detectmode: u32,

    reserved1: [118]u32,
    /// (@ 0x00000700) Description collection: Configuration of GPIO
    pin_cnf: [32]u32,
};

pub const gpio_p0 = @intToPtr(*volatile GPIO, 0x50000000);
pub const gpio_p1 = @intToPtr(*volatile GPIO, 0x50000300);
