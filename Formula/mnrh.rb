class Mnrh < Formula
  desc "Personal macOS utilities for development machines and Claude Code"
  homepage "https://github.com/kopylovis/mnrh-utils"
  url "https://github.com/kopylovis/mnrh-utils.git",
      tag:      "v1.10.1",
      revision: "eedd92ee5e0eafd2a0bf3c493ebadb333abbc732"
  head "https://github.com/kopylovis/mnrh-utils.git", branch: "master"

  depends_on :macos

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
