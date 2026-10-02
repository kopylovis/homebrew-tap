class Mnrh < Formula
  desc "Personal macOS utilities for development machines and Claude Code"
  homepage "https://github.com/kopylovis/mnrh-utils"
  url "https://github.com/kopylovis/mnrh-utils.git",
      tag:      "v1.20.0",
      revision: "75550fc4377a6a1583d69657075a1e043c8e025c"
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
