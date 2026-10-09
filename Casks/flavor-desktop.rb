cask "flavor-desktop" do
  arch arm: "arm64", intel: "amd64"

  version "0.1.0-beta.5"
  sha256 arm:   "cfc79effd1c15dc76f5ca6bd18cc5bf83fe529cc8c4380dda22674841bbeac2d",
         intel: "b4d5f9ff8273aa4a749ff5471504c8c90900ed6f318589ab56a09c29dbc0c7f7"

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
