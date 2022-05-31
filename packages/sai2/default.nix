# sai2 is awkward for nix, it needs a device unique license file next to the executable and theres no way around
# so theres 2 options: a) require path to a sai2 install and let the user manage it, b) take in a path to a license file and 
# symlink it into the store. the latter didnt work nicely for me so the former it is

{ lib
, makeDesktopItem
, wineWowPackages
, winePackage ? wineWowPackages.stable
, symlinkJoin
, executable ? null
}:

let 
    pname = "sai2";
    version = "0.01";

    desktop = makeDesktopItem {
        name = "sai2";
        desktopName = "Paint Tool Sai 2";
        exec = "${winePackage}/bin/wine ${executable}";
        categories = [ "Art" "Graphics" ];
        icon = ./sai2.png;
    };
in symlinkJoin {
    name = pname;
    paths = [ desktop ];
}
