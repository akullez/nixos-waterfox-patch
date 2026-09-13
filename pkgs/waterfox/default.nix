{ stdenv, lib, fetchurl, autoPatchelfHook, makeWrapper,
  xorg, gtk3, alsa-lib, dbus, glib, pango, nss, nspr, atk, pciutils, 
  mesa, systemd, libnotify, fontconfig, freetype,
  libGL, libuuid
}:

stdenv.mkDerivation rec {
  pname = "waterfox";
  version = "6.7.3";

  src = fetchurl {
    url = "https://cdn1.waterfox.net/waterfox/releases/${version}/Linux_x86_64/waterfox-${version}.tar.bz2";
    hash = "sha256-2Pd9NDlHZDWLSsNlRzOJtGuArvWRVr+eD3K59hys0i8=";
  };

  nativeBuildInputs = [ autoPatchelfHook makeWrapper ];

  buildInputs = [
    stdenv.cc.cc.lib 
    gtk3 alsa-lib dbus glib pango nss nspr atk pciutils libuuid
    mesa systemd libnotify fontconfig freetype libGL
    xorg.libX11 xorg.libxcb xorg.libXcomposite xorg.libXdamage
    xorg.libXext xorg.libXfixes xorg.libXrandr xorg.libXrender xorg.libXtst
  ];

  installPhase = ''
    mkdir -p $out/bin $out/opt/waterfox

    cp -r * $out/opt/waterfox/

    makeWrapper $out/opt/waterfox/waterfox $out/bin/waterfox \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath buildInputs}"
  '';
}
