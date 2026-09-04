//! Stands in for the `esp-wifi-driver` import on chips whose radio blobs are not wired up yet.
//!
//! Building the real driver means running translate-c over the esp-wifi-sys headers for that
//! chip, which needs a chip specific libc shim. Until that is done for a chip, its hal gets this
//! module instead so that everything except `hal.radio` still builds.

comptime {
    @compileError("the esp radio driver is not ported to this chip yet");
}
