{
  lib,
  unstick,
  quartus-prime-lite,
  withQuesta ? true,
  supportedDevices ? [
    "Arria II"
    "Arria V"
    "Arria V GZ"
    "Arria 10"
    "Cyclone V"
    "Cyclone IV"
    "Cyclone 10 LP"
    "MAX II/V"
    "MAX 10 FPGA"
    "Stratix IV"
    "Stratix V"
  ],
  # leaves enabled: quartus, devinfo
  disabledComponents ? [
    "quartus_help"
    "quartus_update"
    "questa_fe"
  ],
}:

(quartus-prime-lite.unwrapped.override {
  inherit
    unstick
    supportedDevices
    withQuesta
    disabledComponents
    ;
}).overrideAttrs
  (
    finalAttrs: prevAttrs: {
      pname = "quartus-prime-standard-unwrapped";
      version = "25.1std.0.1129";
      passthru = prevAttrs.passthru // {
        variant = "standard";
        deviceIds = {
          "Arria II" = "arria";
          "Arria V" = "arriav";
          "Arria V GZ" = "arriavgz";
          "Arria 10" = "arria10";
          "Cyclone V" = "cyclonev";
          "Cyclone IV" = "cyclone";
          "Cyclone 10 LP" = "cyclone10lp";
          "MAX II/V" = "max";
          "MAX 10 FPGA" = "max10";
          "Stratix IV" = "stratixiv";
          "Stratix V" = "stratixv";
        };
        components = {
          arria = "sha256-BNfOuJ7e4s3hVNx6J6+UEh4NWW+5z0Muz6Ty7NfVkf0=";
          arria10 = "sha256-v3cfAu7qX4uerHH0uJWsi4uK+sSMfdyprqXyWThrYzY=";
          arriav = "sha256-WpQAJE6OrGcQhxINkLYJt6KP1zn/LmU6KkDklCl8vSU=";
          arriavgz = "sha256-1jgeM3u/tdjwh5k38UblHq2a/Y/iwT8qI3pOA12RIPg=";
          cyclone = "sha256-lKOYy61BHxY4OyonxADg6d7IGwckGX8zu0x6dpGB5Lo=";
          cyclone10lp = "sha256-lurSlhCuE6i2ULKNFvlWNtk6rqdvVwREC607HbMSH2I=";
          cyclonev = "sha256-1uSE/RsKR3hbyLzTGOQn1Ml5j5J26e+SmFI1hl9ry28=";
          max = "sha256-jY/b906fJKgJOL3h5nWR5RQdvAJ3U9of6y4VopGo2z0=";
          max10 = "sha256-gFeESwuRwrp+8rN7GYbRmOxPGDHMm+ClLRjl/rTBnOk=";
          stratixiv = "sha256-DalqBhE/97sAt015o4hUmo93NBKGSFJPPZO49YcoSMM=";
          stratixv = "sha256-UJbBk6UQ/DKm1Uvl5o3FUPYDvai95t8Obb/c1It0fjg=";
        };
        installers = {
          "QuartusSetup-${finalAttrs.version}-linux.run" =
            "sha256-b++VtYqGBXW+yYEMddMjk8bwH0oiLmjb143Of6QDoog=";
        }
        // lib.optionalAttrs withQuesta {
          "QuestaSetup-${finalAttrs.version}-linux.run" =
            "sha256-0F7psE+jTimCoy+UVJRgxNC6GEVdY/PJu49hf+D7T3U=";
        };
        mainInstaller = "QuartusSetup-${finalAttrs.version}-linux.run";
      };

      meta = prevAttrs.meta // {
        homepage = "https://www.altera.com/downloads/fpga-development-tools/quartus-prime-standard-current";
      };
    }
  )
