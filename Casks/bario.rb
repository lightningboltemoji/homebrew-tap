cask "bario" do
  version "0.4.1"
  sha256 "c25ba60583542fa94bb4f59b812a7f7593d87ccf0c7ca95bd12b3f20df58dd28"

  url "https://github.com/lightningboltemoji/bario/releases/download/v#{version}/bario-#{version}.zip"
  name "Bario"
  desc "Customizable menu bar overlay"
  homepage "https://github.com/lightningboltemoji/bario"

  livecheck do
    url :url
    strategy :github_latest
  end

  conflicts_with cask: "lightningboltemoji/tap/bario@tip"
  depends_on arch:  :arm64
  depends_on macos: :tahoe

  app "Bario.app"
  binary "#{appdir}/Bario.app/Contents/MacOS/bario"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Bario.app"]
  end

  uninstall quit:       "zip.tanner.bario",
            login_item: "Bario"

  zap trash: [
    "~/.config/bario",
    "~/Library/Preferences/zip.tanner.bario.plist",
    "~/Library/Saved Application State/zip.tanner.bario.savedState",
  ]
end
