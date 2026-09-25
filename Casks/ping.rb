cask "ping" do
  version "0.1.0"
  sha256 "d49152dac4b98ee05e0d786b983c82c454d4f75fadb2cdf2d6ea79a3dd78c896"

  url "https://github.com/lightningboltemoji/Ping/releases/download/v#{version}/Ping-#{version}.zip"
  name "Ping"
  desc "Persistent visualizations for notifications"
  homepage "https://github.com/lightningboltemoji/Ping"

  livecheck do
    url :url
    strategy :github_latest
  end

  conflicts_with cask: "lightningboltemoji/tap/ping@tip"
  depends_on arch:  :arm64
  depends_on macos: :tahoe

  app "Ping.app"
  binary "#{appdir}/Ping.app/Contents/MacOS/ping-dot-app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Ping.app"]
  end

  uninstall quit:       "zip.tanner.ping",
            login_item: "Ping"

  zap trash: [
    "~/.config/ping",
    "~/Library/Preferences/zip.tanner.ping.plist",
    "~/Library/Saved Application State/zip.tanner.ping.savedState",
  ]
end
