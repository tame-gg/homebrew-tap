cask "powerflow" do
  version "0.2.3-macos27"
  sha256 "af0c1b0bffe70536c9b45dde6154f8c480c6c4e65e08c3ab68b5179a65732884"

  url "https://github.com/tame-gg/powerflow/releases/download/v#{version}/Powerflow-macos27-aarch64.zip"
  name "Powerflow"
  desc "Menu bar Mac power usage and charging monitor"
  homepage "https://github.com/tame-gg/powerflow"

  depends_on macos: ">= :sonoma"
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
