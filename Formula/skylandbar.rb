# skylandbar: a status bar for macOS in Liquid Glass, the bar of skyland, a drop-in for
# SketchyBar configs. Built from the tag's source; the release workflow of
# waxdred/skylandBar updates url and sha256.
class Skylandbar < Formula
  desc "Status bar for macOS in Liquid Glass, the bar of skyland, SketchyBar compatible"
  homepage "https://github.com/waxdred/skylandBar"
  url "https://github.com/waxdred/skylandBar/archive/refs/tags/v0.13.1.tar.gz"
  sha256 "782493a71cc30532230332ce5bee4c8de4b8ea25c1f29082b8164b6ecc957457"
  license "MIT"

  depends_on macos: :sonoma

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/skylandbar"
    pkgshare.install "themes", "examples"
  end

  def caveats
    <<~EOS
      A config to start from (the Liquid Glass theme):
        mkdir -p ~/.config/skylandbar/themes
        cp #{opt_pkgshare}/themes/liquid-glass.toml ~/.config/skylandbar/themes/
        cp #{opt_pkgshare}/examples/liquid-glass.toml ~/.config/skylandbar/skylandbar.toml

      Start it now and at every login (skyland starts it by itself):
        skylandbar --service install

      For the refractive glass, allow skylandbar in System Settings >
      Privacy & Security > Screen Recording, then restart it.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skylandbar --version")
  end
end
