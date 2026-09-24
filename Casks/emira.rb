cask "emira" do
  version "0.0.20"
  sha256 "d9e50c721034480aa1f2779e1ef481c4fd80ae61ef1f91f48b08df9a2933a894"

  url "https://github.com/lightningboltemoji/emira/releases/download/v#{version}/emira-#{version}.zip"
  name "emira"
  desc "Tiling-scrolling window manager"
  homepage "https://github.com/lightningboltemoji/emira"

  livecheck do
    url :url
    strategy :github_latest
  end

  conflicts_with cask: "lightningboltemoji/tap/emira@tip"
  depends_on arch:  :arm64
  depends_on macos: :tahoe

  app "emira.app"
  binary "#{appdir}/emira.app/Contents/MacOS/emira"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/emira.app"]
  end

  uninstall quit:       "zip.tanner.emira",
            login_item: "emira"

  zap trash: [
    "~/.config/emira",
    "~/Library/Preferences/zip.tanner.emira.plist",
    "~/Library/Saved Application State/zip.tanner.emira.savedState",
  ]
end
