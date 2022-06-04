# sai2 is awkward for nix, it needs a device unique license file next to the executable and theres no way around
# so theres 2 options: a) require path to a sai2 install and let the user manage it, b) take in a path to a license file and 
# symlink it into the store. the latter didnt work nicely for me so the former it is

{ makeDesktopItem
, wineWowPackages
, winePackage ? wineWowPackages.stable
, executable ? null
}:

let 
    inherit (builtins) toString;
in makeDesktopItem {
    name = "sai2";
    desktopName = "Paint Tool Sai 2";
    exec = "${winePackage}/bin/wine ${toString executable}";
    categories = [ "Art" "Graphics" ];
    icon = ./sai2.png;
}
