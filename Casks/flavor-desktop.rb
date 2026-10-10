cask "flavor-desktop" do
  arch arm: "arm64", intel: "amd64"

  version "0.1.0-beta.6"
  sha256 arm:   "ffb3868924f46252ba3654c777bb61dfd9e21cd671441e401894a0dff0876421",
         intel: "8daee98efdf672e32c1a3b89036c1bc55dfc0d6a626d62a4d75aa90aa956ea80"

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
