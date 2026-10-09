class Flavor < Formula
  desc "Several Tailscale and Headscale networks side by side"
  homepage "https://github.com/tame-gg/Flavor"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/tame-gg/Flavor/releases/download/v0.1.0-beta.5/flavor-0.1.0-beta.5-darwin-arm64.tar.gz"
    sha256 "cfc79effd1c15dc76f5ca6bd18cc5bf83fe529cc8c4380dda22674841bbeac2d"
  else
    url "https://github.com/tame-gg/Flavor/releases/download/v0.1.0-beta.5/flavor-0.1.0-beta.5-darwin-amd64.tar.gz"
    sha256 "b4d5f9ff8273aa4a749ff5471504c8c90900ed6f318589ab56a09c29dbc0c7f7"
  end

  depends_on :macos

  def install
    bin.install "bin/flavord", "bin/flavorctl"
  end

  def caveats
    <<~EOS
      Start the daemon now and at login:
        brew services start flavor

      If you installed the LaunchAgent from the release tarball, remove it first:
        launchctl bootout gui/$(id -u)/dev.lunarlabs.flavor.flavord
        rm ~/Library/LaunchAgents/dev.lunarlabs.flavor.flavord.plist

      For the desktop app:
        brew install --cask tame-gg/tap/flavor-desktop
    EOS
  end

  service do
    run opt_bin/"flavord"
    keep_alive successful_exit: false
    log_path var/"log/flavord.log"
    error_log_path var/"log/flavord.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/flavorctl --version")
  end
end
