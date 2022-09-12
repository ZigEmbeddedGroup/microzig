{ stdenv
, zig
, pkg-config
, scdoc
, libxml2
}:

stdenv.mkDerivation rec {
  pname = "libflightplan";
  version = "0.1.0";

  src = ./..;

  nativeBuildInputs = [ zig scdoc pkg-config ];

  buildInputs = [
    libxml2
  ];

  dontConfigure = true;

  preBuild = ''
    export HOME=$TMPDIR
  '';

  installPhase = ''
    runHook preInstall
    zig build -Drelease-safe -Dman-pages --prefix $out install
    runHook postInstall
  '';
}
