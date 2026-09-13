# Modelled after LibreFox expression
{
  stdenv,
  lib,
  callPackage,
  buildMozillaMach,
  fetchFromGitHub
}:

let
in

(buildMozillaMach rec {
  pname = "waterfox";
  applicationName = "Waterfox";
  binaryName = "waterfox";
  version = "6.5.6";

  src = fetchFromGitHub {
    owner = "BrowserWorks";
    repo = "waterfox";
    rev = "refs/tags/${version}";
    hash = "sha256-MTlA/6R7opP7iPGlS67xmHCT+ZPyHBCBklGp6oYAzg8=";
  };

  requireSigning = false;

  allowAddonSideload = true;

  branding = "waterfox/browser/branding";

  extraConfigureFlags = [
      "--with-app-name=${pname}"
      "--with-app-basename=${applicationName}"
      "--with-unsigned-addon-scopes=app,system"
      "--disable-bootstrap"
    ];

    meta = {
      # ...
    };
  }).override {
    crashreporterSupport = false;
    enableOfficialBranding = false;
  }
).overrideAttrs (old: {
  preConfigure = (old.preConfigure or "") + ''
    echo "ac_add_options --disable-bootstrap" >> .mozconfig
  '';
})
