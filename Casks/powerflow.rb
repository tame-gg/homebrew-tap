cask "powerflow" do
  version "0.2.4-macos27"
  sha256 "36d623cfc0afcd7f2f3d2dd8116bbb4a2eb4035d1f597b0b4d74f8b1455e3af9"

  url "https://github.com/tame-gg/powerflow/releases/download/v#{version}/Powerflow-macos27-aarch64.zip"
  name "Powerflow"
  desc "Menu bar power usage and charging monitor"
  homepage "https://github.com/tame-gg/powerflow"

  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "Powerflow.app"

  # Unsigned / non–Developer ID build: clear Gatekeeper quarantine so macOS
  # does not report the app as "damaged" and refuse to open it.
  postflight do
    app_path = "#{appdir}/Powerflow.app"
    system_command "/usr/bin/xattr", args: ["-cr", app_path]
    # Ad-hoc sign so local Gatekeeper checks are less noisy on fresh installs.
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", app_path],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/Powerflow",
    "~/Library/Caches/Powerflow",
    "~/Library/Logs/Powerflow",
    "~/Library/Preferences/Powerflow.plist",
    "~/Library/WebKit/Powerflow",
  ]

  caveats <<~EOS
    Powerflow is distributed as an unsigned build (no Apple Developer ID /
    notarization). After install, this cask clears Gatekeeper quarantine and
    applies an ad-hoc signature.

    If macOS still says the app is "damaged" and cannot be opened, run:

      xattr -cr "#{appdir}/Powerflow.app"

    Then open Powerflow from Applications (or Spotlight).

    Project: https://github.com/tame-gg/powerflow
    Release: https://github.com/tame-gg/powerflow/releases/tag/v#{version}
  EOS
end
