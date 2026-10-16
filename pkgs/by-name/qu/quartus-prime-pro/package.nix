{
  callPackage,
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
  unwrapped ? callPackage ./quartus.nix {
    inherit
      unstick
      supportedDevices
      withQuesta
      quartus-prime-lite
      ;
  },
  extraProfile ? "",
}:
(quartus-prime-lite.override {
  inherit
    withQuesta
    supportedDevices
    unwrapped
    extraProfile
    ;
}).overrideAttrs
  (
    finalAttrs: prevAttrs: {
      passthru = prevAttrs.passthru // {
        # No encrypted models to test in questa_fse/intel/verilog/src
        # Hangs on the buildSof test (due to issues with faketime?)
        tests = { };
      };
    }
  )
