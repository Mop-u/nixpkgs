{
  callPackage,
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
      # quartus-prime-standard requires a license to run synthesis so we can't run tests here :(
      passthru = prevAttrs.passthru // {
        tests = { };
      };
    }
  )
