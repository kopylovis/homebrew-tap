class Mnrh < Formula
  desc "Personal macOS utilities for development machines and Claude Code"
  homepage "https://github.com/kopylovis/mnrh-utils"
  url "https://github.com/kopylovis/mnrh-utils.git",
      tag:      "v1.33.1",
      revision: "e36647b5ea69bc54b7ca306bc5f1aa8fd8e14d1f"
  head "https://github.com/kopylovis/mnrh-utils.git", branch: "master"

  depends_on "kopylovis/tap/promptsill"
  depends_on :macos
  depends_on "mihomo" # mnrh claude -x: a session through your own proxy server

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/mnrh"
  end

  def caveats
    <<~EOS
      To add the /restart command and the mnrh MCP server to Claude Code, run:
        mnrh claude setup
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/mnrh --version").strip
  end
end
