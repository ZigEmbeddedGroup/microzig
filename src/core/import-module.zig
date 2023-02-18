//! This file is meant as a dependency for the "app" package.
//! It will only re-export all symbols from "root" under the name "microzig"
//! So we have a flattened and simplified dependency tree.
//!
//! Each config/module of microzig will also just depend on this file, so we can use
//! the same benefits there.

pub usingnamespace @import("root");
