cask "bario" do
  version "0.4.0"
  sha256 "702fa95bd7d7d0dcee8216d0a47cd059925489d4aadb810bf869819477889312"

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
