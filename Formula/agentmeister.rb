class Agentmeister < Formula
  desc "Project picker, session tools and per-session proxy for Claude Code and Codex"
  homepage "https://github.com/kopylovis/agentmeister"
  url "https://github.com/kopylovis/agentmeister.git",
      tag:      "v1.24.1",
      revision: "de2b91e7ce79f3f3a40eea335964b804c0598a17"
  head "https://github.com/kopylovis/agentmeister.git", branch: "main"

  depends_on :macos
  depends_on "mihomo" # agentmeister -x: a session through your own proxy server

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/agentmeister"
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
    assert_equal version.to_s, shell_output("#{bin}/am --version").strip
  end
end
