{ pkgs, ... }: {
  # Allow installation of proprietary software (like Brave browser, etc.)
  nixpkgs.config.allowUnfree = true;

  # Enable modern Nix features (flakes and new CLI commands)
  nix.settings.experimental-features = "nix-command flakes";

  # Set the computer's hostname (what shows up in terminal prompt and network)
  networking.hostName = "sc20";

  # Define the primary user account for this system
  system.primaryUser = "user";

  system.defaults = {
    # macOS Dock configuration
    dock = {
      autohide = true;  # Hide dock when not in use to save screen space
      persistent-apps = [
        "${pkgs.brave}/Applications/Brave Browser.app"  # Pin Brave to dock
        "${pkgs.iterm2}/Applications/iTerm2.app"  # Pin iTerm2 to dock
      ];
      show-recents = false;  # Don't show recently used apps in dock
      tilesize = 48;  # Set dock icon size (default is 64)
      launchanim = false;  # Disable bouncing animation when launching apps
      mru-spaces = false;  # Don't automatically rearrange spaces based on most recent use
    };

    # Finder (file manager) configuration
    finder = {
      AppleShowAllExtensions = true;  # Always show file extensions (.txt, .pdf, etc.)
      FXPreferredViewStyle = "clmv";  # Default to column view in new windows
      FXEnableExtensionChangeWarning = false;  # Don't warn when changing file extensions
      FXRemoveOldTrashItems = true;  # Automatically empty trash after 30 days
      NewWindowTarget = "Home";  # New finder windows open to home directory
      QuitMenuItem = true;  # Allow quitting Finder with Cmd+Q
      ShowStatusBar = true;  # Show status bar at bottom of finder windows
    };

    # Screenshot behavior configuration
    screencapture = {
      location = "~/Pictures/screenshots";  # Save screenshots to this folder
      target = "clipboard";  # Copy screenshots to clipboard by default
      type = "png";  # Save screenshots as PNG files
    };

    # Disable guest user account at login screen
    loginwindow.GuestEnabled = false;

    # Global system preferences that affect all apps
    NSGlobalDomain = {
      ApplePressAndHoldEnabled = false; # Disable press-and-hold for special characters
      AppleICUForce24HourTime = true;  # Use 24-hour time format (14:30 instead of 2:30 PM)
      AppleInterfaceStyle = "Dark";  # Use dark mode system-wide
      AppleShowAllFiles = true;  # Show hidden files in Finder
      KeyRepeat = 3;  # Fast key repeat rate when holding down keys
      InitialKeyRepeat = 15;  # Short delay before key repeat starts
      NSAutomaticCapitalizationEnabled = false;  # Don't auto-capitalize text
      NSDocumentSaveNewDocumentsToCloud = false;  # Don't default to saving to iCloud
      NSWindowShouldDragOnGesture = true;  # Allow dragging windows by clicking anywhere (with modifier)
      "com.apple.mouse.tapBehavior" = 1;  # Enable tap-to-click on trackpad/mouse
    };

    # Trackpad behavior settings
    trackpad = {
      ActuationStrength = 0;  # Light click pressure (0=light, 1=medium, 2=firm)
      Dragging = true;  # Enable drag lock (can drag without holding down)
    };

    # Show battery percentage in menu bar
    controlcenter.BatteryShowPercentage = true;

    # Disable click-on-desktop-to-show-desktop feature
    WindowManager.EnableStandardClickToShowDesktop = false;
  };

  # Keyboard customization settings
  system.keyboard = {
    enableKeyMapping = true;  # Allow custom key mappings
    remapCapsLockToEscape = true;  # Make Caps Lock act as Escape key (useful for vim users)
  };

  # Advanced system preferences that require direct plist manipulation
  system.defaults.CustomUserPreferences = {
    # Enable web developer tools in all WebKit-based apps
    NSGlobalDomain.WebKitDeveloperExtras = true;

    # Additional Finder preferences
    "com.apple.finder" = {
      ShowExternalHardDrivesOnDesktop = false;  # Show external drives on desktop
      ShowHardDrivesOnDesktop = false;  # Show internal drives on desktop
      ShowMountedServersOnDesktop = true;  # Show network drives on desktop
      ShowRemovableMediaOnDesktop = true;  # Show USB drives, etc. on desktop
      _FXSortFoldersFirst = true;  # Show folders before files in list view
      FXDefaultSearchScope = "SCcf";  # Default search scope to current folder
    };

    # Prevent creation of .DS_Store files on network and USB drives
    "com.apple.desktopservices" = {
      DSDontWriteNetworkStores = true;  # Don't create .DS_Store on network drives
      DSDontWriteUSBStores = true;  # Don't create .DS_Store on USB drives
    };

    # Screen saver security settings
    "com.apple.screensaver" = {
      askForPassword = 1;  # Require password after screensaver starts
      askForPasswordDelay = 0;  # Require password immediately (no grace period)
    };

    # Disable inline attachment viewing in Mail (show as icons instead)
    "com.apple.mail".DisableInlineAttachmentViewing = true;

    # Disable personalized advertising from Apple
    "com.apple.AdLib".allowApplePersonalizedAdvertising = false;

    # Automatically quit printer utility after print jobs complete
    "com.apple.print.PrintingPrefs"."Quit When Finished" = true;

    # Software Update automation settings
    "com.apple.SoftwareUpdate" = {
      AutomaticCheckEnabled = true;  # Automatically check for updates
      ScheduleFrequency = 1;  # Check daily (1=daily, 7=weekly)
      AutomaticDownload = 1;  # Automatically download updates
      CriticalUpdateInstall = 1;  # Automatically install critical security updates
    };

    # Don't prompt to use new external drives for Time Machine backups
    "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;

    # Disable automatic opening of Image Capture when connecting cameras/phones
    "com.apple.ImageCapture".disableHotPlug = true;

    # Automatically update App Store apps
    "com.apple.commerce".AutoUpdate = true;
  };

  # Nix-darwin system metadata
  system.configurationRevision = null;  # Git revision of this config (null = not tracked)
  system.stateVersion = 6;  # nix-darwin state version (don't change after initial setup)
  nixpkgs.hostPlatform = "aarch64-darwin";  # Target platform (Apple Silicon Mac)
}
