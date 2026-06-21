{ config, pkgs, lib, ... }:

let
  xmm7360-patched = config.boot.kernelPackages.callPackage ({ stdenv, fetchFromGitHub, kernel }: 
    stdenv.mkDerivation rec {
      pname = "xmm7360-pci";
      version = "xmm7360-pci-master";

      src = fetchFromGitHub {
        owner = "xmm7360";
        repo = "xmm7360-pci";
        rev = "master";
        sha256 = "sha256-RIn0ZlyDpx28Y7Zp+45I5lE+30eI+S8r7yQd7bU81rQ="; 
      };

      sourceRoot = "${src.name}";
      hardeningDisable = [ "pic" ];
      nativeBuildInputs = kernel.moduleBuildDependencies;

      patchPhase = ''
        substituteInPlace xmm7360.c \
          --replace "pci_set_dma_mask" "dma_set_mask"
      '';

      makeFlags = [
        "KERNELRELEASE=${kernel.modDirVersion}"
        "KERNELDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
        "INSTALL_MOD_PATH=$(out)"
      ];

      meta = with lib; {
        description = "PCI driver for Fibocom L850-GL";
        homepage = "https://github.com";
        license = licenses.gpl2Only;
        platforms = platforms.linux;
      };
    }) {};

  xmm7360-tools = pkgs.python3.withPackages (ps: [
    ps.pyroute2
    ps.configargparse
  ]);

in {
  boot.extraModulePackages = [ xmm7360-patched ];
  boot.kernelModules = [ "xmm7360" ];

  environment.systemPackages = [ xmm7360-tools pkgs.minicom ];

  systemd.services.xmm7360 = {
    description = "Initialize Fibocom L850-GL LTE Modem RPC Channel";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    
    script = ''
      # ${xmm7360-tools}/bin/python3
    '';
    
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };
}
