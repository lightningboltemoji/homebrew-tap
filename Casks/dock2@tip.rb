cask "dock2@tip" do
  version :latest
  sha256 :no_check

  url "https://github.com/lightningboltemoji/dock2/releases/download/tip/dock2-tip.zip"
  name "dock2"
  desc "Dock replacement (tip)"
  homepage "https://github.com/lightningboltemoji/dock2"

  conflicts_with cask: "lightningboltemoji/tap/dock2"
  depends_on arch:  :arm64
  depends_on macos: :tahoe

  app "Dock2.app"
  binary "#{appdir}/Dock2.app/Contents/MacOS/dock2"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Dock2.app"]
  end

  # Quitting gives the system Dock back; `--restore` then gives back whatever a dock2 that died left.
  uninstall quit:       "zip.tanner.dock2",
            login_item: "dock2",
            script:     {
              executable:   "#{appdir}/Dock2.app/Contents/MacOS/dock2",
              args:         ["--restore"],
              must_succeed: false,
            }

  zap trash: [
    "~/Library/Application Support/dock2",
    "~/Library/Logs/dock2",
    "~/Library/Preferences/zip.tanner.dock2.plist",
  ]

  caveats do
    <<~EOS
      the tip build may be unstable. versioned release is suggested.
    EOS
  end
end
