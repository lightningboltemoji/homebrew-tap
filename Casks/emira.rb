cask "emira" do
  version "0.0.2"
  sha256 "b6b8bc099f100fd09e09542d9feef11d236a876095d81e577a74f9b2ee71a028"

  url "https://github.com/lightningboltemoji/emira/releases/download/v#{version}/emira-#{version}.zip"
  name "emira"
  desc "Tiling, scrolling window manager"
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

  caveats do
    <<~EOS
      emira needs Accessibility and Screen Recording in System Settings → Privacy & Security.
    EOS
  end
end
