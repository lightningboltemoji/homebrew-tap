cask "fiber@tip" do
  version :latest
  sha256 :no_check

  url "https://github.com/lightningboltemoji/fiber/releases/download/tip/Fiber-tip.zip"
  name "Fiber"
  desc "Chromium-based web browser (tip)"
  homepage "https://github.com/lightningboltemoji/fiber"

  conflicts_with cask: "lightningboltemoji/tap/fiber"
  depends_on arch:  :arm64
  depends_on macos: :tahoe

  app "Fiber.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Fiber.app"]
  end

  uninstall quit: "com.o11.fiber"

  zap trash: [
    "~/Library/Application Support/Fiber",
    "~/Library/Caches/Fiber",
    "~/Library/Preferences/com.o11.fiber.plist",
    "~/Library/Saved Application State/com.o11.fiber.savedState",
  ]

  caveats do
    <<~EOS
      the tip build may be unstable. versioned release is suggested.
    EOS
  end
end
