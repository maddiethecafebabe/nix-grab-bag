{ lib, ... }:
let
    inherit (lib) genAttrs;
    
    supportedSystems = [ "x86_64-linux" ];
in {
    foreachSystem = genAttrs supportedSystems;
}
