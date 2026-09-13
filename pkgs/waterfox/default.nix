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
    mainProgram = "waterfox";
    description = "A privacy-focused, performance-oriented browser based on Firefox";
    homepage = "https://www.waterfox.net/";
    platforms = lib.platforms.unix;
    badPlatforms = lib.platforms.darwin;
    broken = stdenv.buildPlatform.is32bit;
    # since Firefox 60, build on 32-bit platforms fails with "out of memory".
    # not in `badPlatforms` because cross-compilation on 64-bit machine might work.
    maxSilent = 14400; # 4h, double the default of 7200s (c.f. #129212, #129115)
    license = lib.licenses.mpl20;
  };
}).override {
  crashreporterSupport = false;
  enableOfficialBranding = false;
}
