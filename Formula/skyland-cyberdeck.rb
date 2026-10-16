# skyland-cyberdeck: cyberpunk HUD pieces for macOS (apps launcher, messages panel,
# notify API, herdr plugin). Built from the tag's source; the release workflow of
# waxdred/skyland-cyberdeck updates url and sha256.
class SkylandCyberdeck < Formula
  desc "Cyberpunk HUD for macOS: apps launcher, messages panel, notify API"
  homepage "https://github.com/waxdred/skyland-cyberdeck"
  url "https://github.com/waxdred/skyland-cyberdeck/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "6207f41cc8639b68db81741f40de38fd96a66dd0cd7e882eaad7b1f39cf54d28"
  license "MIT"

  depends_on macos: :ventura

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/skyland-cyberdeck"
    # now playing of the audio deck (0.3.0+): loaded by /usr/bin/perl, looked up in lib/
    dylib = ".build/release/libMediaRemoteAdapter.dylib"
    lib.install dylib if File.exist?(dylib)
    (share/"skyland-cyberdeck").install "integrations/herdr"
  end

  def caveats
    <<~EOS
      herdr plugin (a message when an agent finishes or needs you):
        herdr plugin link #{opt_share}/skyland-cyberdeck/herdr
    EOS
  end

  test do
    ENV["SKYLAND_CYBERDECK_STORE"] = testpath/"messages.json"
    system bin/"skyland-cyberdeck", "notify", "-t", "test", "--quiet"
    assert_match "test", shell_output("#{bin}/skyland-cyberdeck list --json")
  end
end
