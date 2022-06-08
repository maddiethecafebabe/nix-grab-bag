{ stdenv
, lib
, fetchurl
, fetchFromGitHub
, linuxPackages
, kernel ? linuxPackages.kernel
}:

let
  arm_hdr = fetchurl {
    url = "https://github.com/GaryOderNichts/udpih/releases/download/v1/arm_kernel.bin.h";
    sha256 = "sha256-MZRHHOsQdXRn/N8QAzyIy1qBsZ+H4csgfVBPTpoFyIU=";
  };
in stdenv.mkDerivation rec {
  version = "v1";
  name = "udpih-${version}-module-${kernel.modDirVersion}";

  src = fetchFromGitHub {
      owner = "GaryOderNichts";
      repo = "udpih";
      rev = "3c0cdd68ed890c4013c9cb617cb441286c356cb8";
      sha256 = "sha256-ztAff0BPXO3YJhAp6+lC4MWXx8smLkdqNmxaq/OClbw=";
  };

  nativeBuildInputs = [
      kernel.moduleBuildDependencies
  ];

  patches = [ ./add-install-target.patch ];

  postPatch = ''
    cp ${arm_hdr} arm_kernel/arm_kernel.bin.h
    pushd linux
  '';
  
  postInstall = ''
    popd
  '';

  makeFlags = kernel.makeFlags ++ [
    "KERNELRELEASE=${kernel.modDirVersion}"
    "KERNEL_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "INSTALL_MOD_PATH=$(out)"
  ];

  meta = with lib; {
    description = "Exploit for the Wii U's USB Host Stack";
    license = [ licenses.unfree ];
    homepage = "https://github.com/GaryOderNichts/udpih";
    maintainers = [  ];
    platforms = platforms.linux;
  };
}
