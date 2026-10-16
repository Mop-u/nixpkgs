{
  lib,
  unstick,
  quartus-prime-lite,
  withQuesta ? true,
  supportedDevices ? [
    "Agilex common files"
    "Agilex 3"
    "Agilex 5"
    "Agilex 7"
    "Stratix 10"
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
      pname = "quartus-prime-pro-unwrapped";
      version = "26.1.1.130";
      passthru = prevAttrs.passthru // {
        variant = "pro";
        deviceIds = {
          # Quartus Prime Pro has bundled device support for Cyclone 10 GX and Arria 10
          # see: https://www.altera.com/developers/software/device-support
          "Agilex common files" = "agilex_common";
          "Agilex 3" = "agilex3";
          "Agilex 5" = "agilex5";
          "Agilex 7" = "agilex7";
          "Stratix 10" = "stratix10";
        };
        components = {
          agilex3 = "sha256-F/ULFL6zQFuAguZoXDj3RCYEDf2aBMO1IJ6urUSZbpI=";
          agilex5 = "sha256-jl/E8RAd0BKphuXc0z8V4FxMH/t0uz3xcUevWkVD0Yg=";
          agilex7 = "sha256-vpl7xsoJTCwgVjp5P0BiI7TYbX0AB544oI5m7IApvgQ=";
          agilex_common = "sha256-u+WKS7akL5PiaidGAqai18FZ3fs7/XYMmVQHpFUQQkw=";
          stratix10 = "sha256-scqx+yQpxkjdcoAFIAyiWu2L0sJZMzgMQ+yq/kSgNEI=";
        };
        installers = {
          "QuartusProSetup-${finalAttrs.version}-linux.run" =
            "sha256-mGOUMi34xj3ihTyvI+mfXzyN6Kr88nkY2BGW1SyYxsI=";
        }
        // lib.optionalAttrs withQuesta {
          "QuestaSetup-${finalAttrs.version}-linux.run" =
            "sha256-7ByofPkbCSCsNGlH+qI1oNODg4qodZ4N8VHzumyr9do=";
        };
        installerParts = {
          "QuartusProSetup-part2-${finalAttrs.version}.qdz" =
            "sha256-NOuEh43L79wmJSAUqIItIa9YRrpCVxcgTnxbvdOEpAM=";
        };
        mainInstaller = "QuartusProSetup-${finalAttrs.version}-linux.run";
      };
      meta = prevAttrs.meta // {
        homepage = "https://www.altera.com/downloads/fpga-development-tools/quartus-prime-pro-current";
      };
    }
  )
