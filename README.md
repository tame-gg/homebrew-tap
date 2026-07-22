# tame-gg Homebrew tap

Homebrew formulae and casks for [tame-gg](https://github.com/tame-gg) apps.

## Tap

```bash
brew tap tame-gg/tap
```

Homebrew maps the GitHub repo [`tame-gg/homebrew-tap`](https://github.com/tame-gg/homebrew-tap) to the tap name **`tame-gg/tap`**.

On Homebrew 6+, third-party taps must be trusted before casks will load:

```bash
brew trust tame-gg/tap
```

## Install Powerflow

[Powerflow](https://github.com/tame-gg/powerflow) is a menu-bar Mac power / charging monitor (fork with macOS 27 fixes).

```bash
brew tap tame-gg/tap
brew trust tame-gg/tap   # Homebrew 6+
brew install --cask powerflow
```

Or in one shot after tapping and trusting:

```bash
brew install --cask tame-gg/tap/powerflow
```

Apple Silicon (arm64) only for the current release asset.

### Gatekeeper / “damaged” app

Release builds are **not** signed with an Apple Developer ID and are **not** notarized. On first open, macOS Gatekeeper may quarantine the download and show:

> “Powerflow.app” is damaged and can’t be opened.

The cask’s `postflight` clears quarantine with `xattr -cr` and applies an ad-hoc `codesign`. That is usually enough.

If you still hit the warning, clear quarantine manually:

```bash
xattr -cr /Applications/Powerflow.app
open /Applications/Powerflow.app
```

### Upgrade / uninstall

```bash
brew upgrade --cask powerflow
brew uninstall --cask powerflow
```

### Links

- App repo: https://github.com/tame-gg/powerflow
- Releases: https://github.com/tame-gg/powerflow/releases
- Latest cask target: [v0.2.3-macos27](https://github.com/tame-gg/powerflow/releases/tag/v0.2.3-macos27)

## License

Cask definitions in this tap are provided for convenience. Application licenses remain with their respective projects (Powerflow is MIT).
