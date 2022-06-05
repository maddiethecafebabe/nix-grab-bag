{ stdenv
, fetchFromGitHub
, lib
}:
let
    src = fetchFromGitHub {
        owner = "DavidBuchanan314";
        repo = "fusee-nano";
        rev = "dde24921b215a30216f83fa5f2b9d373f1bd12dc";
        sha256 = "sha256-s0asKHODiGSfPo1nrC/0JQ6/mhmPfi2Cn7qD2uMW/bU=";
    };
in stdenv.mkDerivation rec {
    pname = "fusee-nano";
    version = "0.1.0";

    inherit src;

    patches = [ ./set-intermezzo-path.patch ];

    makeFlags = [ "INTERMEZZO=${src}/files/intermezzo.bin" ];

    installPhase = ''
        mkdir -p $out/bin
        cp fusee-nano $out/bin/
    '';

    meta = with lib; {
        description = " A minimalist re-implementation of the Fusée Gelée exploit";
        homepage = "https://github.com/DavidBuchanan314/fusee-nano";
        license = [ licenses.mit ];
        platforms = platforms.linux;
        maintainers = [ ];
    };
}
