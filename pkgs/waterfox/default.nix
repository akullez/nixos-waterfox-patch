{ stdenv, fetchurl, autoPatchelfHook, wrapGAppsHook,
  xorg, gtk3, alsa-lib, dbus, dbus-glib, glib, pango, nss, nspr, atk, pciutils, 
  libglvnd, mesa, systemd, libnotify, fontconfig, freetype }:

stdenv.mkDerivation rec {
  pname = "waterfox-bin";
  version = "6.7.3";

  src = fetchurl {
    url = "https://cdn1.waterfox.net/waterfox/releases/${version}/Linux_x86_64/waterfox-${version}.tar.bz2";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  nativeBuildInputs = [ autoPatchelfHook wrapGAppsHook ];

  buildInputs = [
    gtk3 alsa-lib dbus dbus-glib glib pango nss nspr atk pciutils
    libglvnd mesa systemd libnotify fontconfig freetype
    xorg.libX11 xorg.libxcb xorg.libXcomposite xorg.libXdamage
    xorg.libXext xorg.libXfixes xorg.libXrandr xorg.libXrender xorg.libXtst
  ];

  installPhase = ''
    mkdir -p $out/bin $out/opt/waterfox

    cp -r * $out/opt/waterfox/

    ln -s $out/opt/waterfox/waterfox $out/bin/waterfox
  '';
}
