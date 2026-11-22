class Agentmeister < Formula
  desc "Project picker, session tools and per-session proxy for Claude Code and Codex"
  homepage "https://github.com/kopylovis/agentmeister"
  url "https://github.com/kopylovis/agentmeister.git",
      tag:      "v1.15.0",
      revision: "9f3b40850ec8cda56746637d6e9c09a3bbe5680e"
  head "https://github.com/kopylovis/agentmeister.git", branch: "main"

  depends_on :macos
  depends_on "mihomo" # claudemeister -x: a session through your own proxy server

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/agentmeister"
    bin.install_symlink libexec/"bin/agentmeister" => "claudemeister"
    bin.install_symlink libexec/"bin/agentmeister" => "am"
  end

  def caveats
    <<~EOS
      To set up Claude Code, run `agentmeister setup`.
      To set up Codex, run `agentmeister --harness codex setup`.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/agentmeister --version").strip
    assert_equal version.to_s, shell_output("#{bin}/claudemeister --version").strip
    assert_equal version.to_s, shell_output("#{bin}/am --version").strip
  end
end
