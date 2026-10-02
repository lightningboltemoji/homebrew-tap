cask "emira" do
  version "0.3.0"
  sha256 "8d415be4a1441d72939de13a0e9bb019bfa2edd4d13004ae7034cc52399b0cda"

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
