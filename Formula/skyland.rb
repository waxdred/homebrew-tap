# skyland: a Hyprland-like tiling window manager for macOS (AeroSpace fork).
# The release zip holds the repo and its prebuilt binaries (Skyland.app, CLI, tools);
# `skyland install` then trusts the sketchybar tap, installs the rest of the
# dependencies, signs the app with a local identity (keeps the Accessibility
# permission across upgrades), copies the default config and starts it.
class Skyland < Formula
  desc "Hyprland-like tiling window manager for macOS (AeroSpace fork)"
  homepage "https://github.com/waxdred/skyland"
  url "https://github.com/waxdred/skyland/releases/download/v0.1.6/skyland-v0.1.6.zip"
  sha256 "afe86df9800458f99643b5c7f2db642a7ef41bffb097e06e67eb1f2a14a25b86"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  def install
    libexec.install Dir["*"], ".build", ".swift-version"
    bin.install_symlink libexec/"bin/skyland"
  end

  def caveats
    <<~EOS
      Finish the setup once (dependencies, signing, config, start):
        skyland install

      Then allow Skyland in System Settings > Privacy & Security > Accessibility
      (and Screen Recording), and check everything with:
        skyland doctor

      After `brew upgrade skyland`, restart it with:
        skyland env

      Window effects (corners, animations) need SIP partially disabled, see
      https://github.com/waxdred/skyland#full-effects-sip-partially-off
    EOS
  end

  test do
    assert_match "skyland CLI", shell_output("#{bin}/skyland help")
  end
end
