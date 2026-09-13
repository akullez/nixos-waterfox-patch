{ lib, stdenv, fetchurl, buildFHSUserEnv }:

let
  version = "6.5.0";
  
  waterfox-extracted = stdenv.mkDerivation {
    pname = "waterfox-extracted";
    inherit version;
    
    src = fetchurl {
      url = "https://cdn1.waterfox.net/waterfox/releases/${version}/Linux_x86_64/waterfox-${version}.tar.bz2";
      hash = "sha256-JaX+TWnr3clQNY8vj9TC/lAQ1y4DbIQcAtrz8xddcDA=";
    };

    installPhase = ''
      mkdir -p $out/opt/waterfox
      cp -r * $out/opt/waterfox/
    '';
  };
in

buildFHSUserEnv {
  name = "waterfox";
  
  targetPkgs = pkgs: with pkgs; [
    gtk3 # <--- Вернули пропажу
    alsa-lib dbus glib pango nss nspr atk pciutils
    mesa systemd libnotify fontconfig freetype
    libGL libuuid libxkbcommon libdrm wayland cairo gdk-pixbuf ffmpeg
    xorg.libX11 xorg.libxcb xorg.libXcomposite xorg.libXdamage
    xorg.libXext xorg.libXfixes xorg.libXrandr xorg.libXrender xorg.libXtst
  ];

  runScript = "${waterfox-extracted}/opt/waterfox/waterfox";
}
