cask "ping" do
  version "0.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/lightningboltemoji/Ping/releases/download/v#{version}/Ping-#{version}.zip"
  name "Ping"
  desc "Surfaces Dock notification badges with screen-edge effects"
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
