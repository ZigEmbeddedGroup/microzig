# Package testing

This is a bare minimum example for boxzer, and the purpose is to validate that
what it packages is compatible with the Zig compiler.

We have 3 packages:

```
A -> B -> C
```

`A` is the piece of software that we're working on. `B` and `C` are packages in
a monorepo that are mature. `A` depends on `B` and `B` depends on `C`. `A` uses
a url to specify where `B` is, and in the `build.zig.zon` it depends on `C` with
a path.

Boxzer patches the `build.zig.zon` for packaging, and outputs the package
tarballs. A local server is run to serve them over http, and `A` adds `B` as a
dependency. The real test is to see that the hash for `C` from the `B` package
matches what the Zig compilers sees.
