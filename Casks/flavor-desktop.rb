cask "flavor-desktop" do
  arch arm: "arm64", intel: "amd64"

  version "0.1.0-beta.7"
  sha256 arm:   "5947620b14dee493a136a129d0e8c17b16fe1121ebd6ee04d15fedddbaeffc48",
         intel: "686cf9854497eaf147f78c9aee8426dbb773e5aca62924a270066fbfbe09dde7"

  url "https://github.com/tame-gg/Flavor/releases/download/v#{version}/flavor-#{version}-darwin-#{arch}.tar.gz"
  name "Flavor"
  desc "Desktop app for several Tailscale and Headscale networks side by side"
  homepage "https://github.com/tame-gg/Flavor"

  depends_on formula: "tame-gg/tap/flavor"
  depends_on :macos

  app "flavor-#{version}-darwin-#{arch}/Flavor.app"

  caveats <<~EOS
    Flavor.app is not notarized yet, so macOS blocks the first launch.
    Open it once, then click Open Anyway in System Settings > Privacy & Security.
    Or run:
      xattr -dr com.apple.quarantine "#{appdir}/Flavor.app"

    The app needs the daemon running:
      brew services start flavor
  EOS
end
