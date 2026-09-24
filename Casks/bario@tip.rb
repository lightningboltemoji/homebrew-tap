cask "bario@tip" do
  version :latest
  sha256 :no_check

  url "https://github.com/lightningboltemoji/bario/releases/download/tip/bario-tip.zip"
  name "Bario"
  desc "Customizable menu bar overlay (tip)"
  homepage "https://github.com/lightningboltemoji/bario"

  conflicts_with cask: "lightningboltemoji/tap/bario"
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

  caveats do
    <<~EOS
      the tip build may be unstable. versioned release is suggested.
    EOS
  end
end
