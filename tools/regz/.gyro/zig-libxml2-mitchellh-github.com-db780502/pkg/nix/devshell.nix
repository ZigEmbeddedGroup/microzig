{ mkShell

, pkg-config
, scdoc
, zig
}: mkShell rec {
  name = "libxml2";

  nativeBuildInputs = [
    pkg-config
    scdoc
    zig
  ];
}
