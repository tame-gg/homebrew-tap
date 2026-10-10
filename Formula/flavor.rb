class Flavor < Formula
  desc "Several Tailscale and Headscale networks side by side"
  homepage "https://github.com/tame-gg/Flavor"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/tame-gg/Flavor/releases/download/v0.1.0-beta.6/flavor-0.1.0-beta.6-darwin-arm64.tar.gz"
    sha256 "ffb3868924f46252ba3654c777bb61dfd9e21cd671441e401894a0dff0876421"
  else
    url "https://github.com/tame-gg/Flavor/releases/download/v0.1.0-beta.6/flavor-0.1.0-beta.6-darwin-amd64.tar.gz"
    sha256 "8daee98efdf672e32c1a3b89036c1bc55dfc0d6a626d62a4d75aa90aa956ea80"
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
