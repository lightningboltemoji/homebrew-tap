cask "ping@tip" do
  version :latest
  sha256 :no_check

  url "https://github.com/lightningboltemoji/Ping/releases/download/tip/Ping-tip.zip"
  name "Ping"
  desc "Persistent visualizations for notifications"
  homepage "https://github.com/lightningboltemoji/Ping"

  conflicts_with cask: "lightningboltemoji/tap/ping"
  depends_on macos: :tahoe
  depends_on arch:  :arm64

  app "Ping.app"
  binary "#{appdir}/Ping.app/Contents/MacOS/ping-dot-app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Ping.app"]
  end

  uninstall quit:       "zip.tanner.ping",
            login_item: "Ping"

  zap trash: [
    "~/.config/ping",
    "~/Library/Preferences/zip.tanner.ping.plist",
    "~/Library/Saved Application State/zip.tanner.ping.savedState",
  ]

  caveats do
    <<~EOS
      the tip build may be unstable. versioned release is suggested.
    EOS
  end
end
