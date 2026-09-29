cask "fiber" do
  version "0.0.0,0.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/lightningboltemoji/fiber/releases/download/v#{version.csv.first}/Fiber-#{version.csv.first}c#{version.csv.second}.zip"
  name "Fiber"
  desc "Chromium-based web browser"
  homepage "https://github.com/lightningboltemoji/fiber"

  livecheck do
    url :url
    regex(/^Fiber[._-]v?(\d+(?:\.\d+)+)c(\d+(?:\.\d+)+)\.zip$/i)
    strategy :github_latest do |json, regex|
      json["assets"]&.map do |asset|
        match = asset["name"]&.match(regex)
        next if match.blank?

        "#{match[1]},#{match[2]}"
      end
    end
  end

  conflicts_with cask: "lightningboltemoji/tap/fiber@tip"
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
end
