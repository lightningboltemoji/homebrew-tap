cask "emira@tip" do
  version :latest
  sha256 :no_check

  url "https://github.com/lightningboltemoji/emira/releases/download/tip/emira-tip.zip"
  name "emira"
  desc "Tiling, scrolling window manager (rolling build of main)"
  homepage "https://github.com/lightningboltemoji/emira"

  conflicts_with cask: "lightningboltemoji/tap/emira"
  depends_on macos: :tahoe
  depends_on arch:  :arm64

  app "emira.app"
  binary "#{appdir}/emira.app/Contents/MacOS/emira"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/emira.app"]
  end

  uninstall quit:       "zip.tanner.emira",
            login_item: "emira"

  zap trash: [
    "~/.config/emira",
    "~/Library/Preferences/zip.tanner.emira.plist",
    "~/Library/Saved Application State/zip.tanner.emira.savedState",
  ]

  caveats do
    <<~EOS
      emira needs Accessibility and Screen Recording in System Settings → Privacy & Security.

      the tip build is created with every push to main -- may have breakage.
    EOS
  end
end
