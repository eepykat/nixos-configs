{ config, pkgs, lib, ... }:

let
  xmm7360-patched = config.boot.kernelPackages.callPackage ({ stdenv, fetchFromGitHub, kernel }: 
    stdenv.mkDerivation rec {
      pname = "xmm7360-pci";
      version = "1.0.0";

      src = fetchFromGitHub {
        owner = "xmm7360";
        repo = "xmm7360-pci";
        rev = "master";
        sha256 = "sha256-wwm9ELALiJrC54azyJ95Rm3pcGLYzhxEe9mcCUvSVKk="; 
      };

      sourceRoot = "${src.name}";
      hardeningDisable = [ "pic" ];
      nativeBuildInputs = kernel.moduleBuildDependencies;

      postPatch = ''
        substituteInPlace xmm7360.c \
          --replace-fail "static int xmm7360_tty_write" "static ssize_t xmm7360_tty_write" \
          --replace-fail "const unsigned char *buf" "const u8 *buf" \
          --replace-fail "int count" "size_t count"
      '';

      makeFlags = [
        "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
      ];

      installPhase = ''
        runHook preInstall
        mkdir -p $out/lib/modules/${kernel.modDirVersion}/misc
        cp xmm7360.ko $out/lib/modules/${kernel.modDirVersion}/misc/
        runHook postInstall
      '';

      meta = with lib; {
        description = "PCI driver for Fibocom L850-GL";
        homepage = "https://github.com/xmm7360/xmm7360-pci";
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