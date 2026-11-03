class Mnrh < Formula
  desc "Personal macOS utilities for development machines and Claude Code"
  homepage "https://github.com/kopylovis/mnrh-utils"
  url "https://github.com/kopylovis/mnrh-utils.git",
      tag:      "v1.34.0",
      revision: "00f483bc2d3970d53c984622fb0e8205ff8a4c61"
  head "https://github.com/kopylovis/mnrh-utils.git", branch: "master"

  depends_on "kopylovis/tap/claudemeister" # mnrh claude, todo, shot, deps
  depends_on "kopylovis/tap/promptsill"
  depends_on :macos

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/mnrh"
  end

  def caveats
    <<~EOS
      To add /restart, hooks and the claudemeister MCP server to Claude Code, run:
        claudemeister setup
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/mnrh --version").strip
  end
end
