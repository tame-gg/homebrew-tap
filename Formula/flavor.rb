class Flavor < Formula
  desc "Several Tailscale and Headscale networks side by side"
  homepage "https://github.com/tame-gg/Flavor"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/tame-gg/Flavor/releases/download/v0.1.0-beta.7/flavor-0.1.0-beta.7-darwin-arm64.tar.gz"
    sha256 "5947620b14dee493a136a129d0e8c17b16fe1121ebd6ee04d15fedddbaeffc48"
  else
    url "https://github.com/tame-gg/Flavor/releases/download/v0.1.0-beta.7/flavor-0.1.0-beta.7-darwin-amd64.tar.gz"
    sha256 "686cf9854497eaf147f78c9aee8426dbb773e5aca62924a270066fbfbe09dde7"
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
