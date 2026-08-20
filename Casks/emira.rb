cask "emira" do
  version "0.0.11"
  sha256 "4da8efcd0d6f751c1c3f5de87e743b68194765f3c3784d16e809a41049f12894"

  url "https://github.com/lightningboltemoji/emira/releases/download/v#{version}/emira-#{version}.zip"
  name "emira"
  desc "Tiling-scrolling window manager"
  homepage "https://github.com/lightningboltemoji/emira"

  livecheck do
    url :url
    strategy :github_latest
  end

  conflicts_with cask: "lightningboltemoji/tap/emira@tip"
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
end
