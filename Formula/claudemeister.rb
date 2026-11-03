class Claudemeister < Formula
  desc "Claude Code kit for macOS: sessions, restart, per-session proxy, MCP tools"
  homepage "https://github.com/kopylovis/claudemeister"
  url "https://github.com/kopylovis/claudemeister.git",
      tag:      "v1.1.0",
      revision: "5b8e2681e8554115ebf5957ec44e76a7c6ef2ae2"
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
