class Claudemeister < Formula
  desc "Claude Code kit for macOS: sessions, restart, per-session proxy, MCP tools"
  homepage "https://github.com/kopylovis/claudemeister"
  url "https://github.com/kopylovis/claudemeister.git",
      tag:      "v1.6.0",
      revision: "efaf1f78d61bd888d2ae8952cb5b87c4cbd16e3d"
  head "https://github.com/kopylovis/claudemeister.git", branch: "main"

  depends_on :macos
  depends_on "mihomo" # claudemeister -x: a session through your own proxy server

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/claudemeister"
  end

  def caveats
    <<~EOS
      To add /restart, hooks and the claudemeister MCP server to Claude Code, run:
        claudemeister setup
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/claudemeister --version").strip
  end
end
