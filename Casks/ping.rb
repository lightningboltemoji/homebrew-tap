cask "ping" do
  version "0.0.1"
  sha256 "6e05e67bb15f3c31c36eeb4b01376c322fb1df299aadc7348e3aa83917eb6249"

  url "https://github.com/lightningboltemoji/Ping/releases/download/v#{version}/Ping-#{version}.zip"
  name "Ping"
  desc "Persistent visualizations for notifications"
  homepage "https://github.com/lightningboltemoji/Ping"

  livecheck do
    url :url
    strategy :github_latest
  end

  conflicts_with cask: "lightningboltemoji/tap/ping@tip"
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
end
