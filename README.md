### Currently broken? I don't have the supplementary knowledge of the Nix Firefox packaging quirks or have the time to put towards figuring out what Nix wants. Please feel free to fix it if you know. ^_^
###### This likely isn't the only issue:
>  ERROR: HTTPSConnectionPool(host='firefox-ci-tc.services.mozilla.com', port=443): Max retries exceeded with url: /api/index/v1/task/gecko.cache.level-3.toolchains.v3.linux64-clang-18.hash.739adb1b538eaf1e6de1ce977094fe0616e0f81aa2df1cb7d8cec7f20cefe82f (Caused by NewConnectionError('<urllib3.connection.HTTPSConnection object at 0x7ffff0bdecd0>: Failed to establish a new connection: [Errno -3] Temporary failure in name resolution'))
>  ERROR: If you can't fix the above, retry with --disable-bootstrap.

If you'd like an alternative to Waterfox as flake, there is a Flatpak.

<br>

# Waterfox | Nix Flake
This is a flake to install the [Waterfox](https://www.waterfox.net/) browser on systems using the Nix package manager.

###### (Only tested on x86_64)

## Usage

### Run directly
```sh
nix run github:sammypanda/nixos-waterfox
```
###### if you get an error about "experimental features" do instead:
```sh
nix run github:sammypanda/nixos-waterfox --extra-experimental-features flakes --extra-experimental-features nix-command
```

### Or install to your system

Add the following in your flake inputs:

```nix
{
    inputs = {
        # the rest of your inputs here

        waterfox = {
            url = "github:sammypanda/nixos-waterfox";
            inputs.nixpkgs.follows = "nixpkgs";
        }
    };

    # ...
```

...and in outputs you can overlay and add to system or user packages as ``pkgs.waterfox``. Or instead just add ``waterfox.packages.YOURPLATFORM.default`` to system or user packages without overlaying.

```nix
    # ...

    outputs = { waterfox, ... } @ inputs:
    let
        pkgs = import nixpkgs {
            overlays = [self.overlays.default];
        }
    in {
        overlays.default = final: prev: {
            waterfox = inputs.waterfox.packages.YOURPLATFORM.default;
            # OR 
            # waterfox = inputs.waterfox.packages."${system}".default;
        }
    }

    # ...
}
```
