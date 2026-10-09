cask "flavor-desktop" do
  arch arm: "arm64", intel: "amd64"

  version "0.1.0-beta.4"
  sha256 arm:   "8c946d0a697a5f5179eecdeec2f8264c2d95f2aa7af0456cbdd7669d1e18f453",
         intel: "bf88d9920ee5a39471f8d93c720e48e9484aec4f64a8d2f0b1e4dad0ffe4a1a9"

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
