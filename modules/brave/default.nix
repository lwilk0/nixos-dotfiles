{...}: {
  environment.etc."brave/policies/managed/policies.json".text = builtins.toJSON {
    BraveRewardsDisabled = true;
    BraveWalletDisabled = true;
    BraveVPNDisabled = true;
    BraveAIChatEnabled = false;
    BraveNewsDisabled = true;
    CloudReportingEnabled = false;
    MetricsReportingEnabled = false;
    PasswordManagerEnabled = true;
    BraveTalkDisabled = true;
    BraveSpeedreaderEnabled = true;
    BraveStatsPingEnabled = false;
    BravePlaylistEnabled = false;
    BraveWaybackMachineEnabled = false;
    BraveSyncEnabled = false;
    BraveExperimentalAdblockEnabled = true;
    HardwareAccelerationModeEnabled = true;
    MemorySaverEnabled = true;
    BackgroundModeEnabled = false;
    BrowserGuestModeEnabled = false;
    BrowserSignin = 0;
    BuiltInDnsClientEnabled = false;
    SpellcheckEnabled = true;
    SpellcheckLanguage = ["en-GB"];
  };
}
