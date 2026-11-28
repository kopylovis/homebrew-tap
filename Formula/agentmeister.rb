class Agentmeister < Formula
  desc "Project picker, session tools and per-session proxy for Claude Code and Codex"
  homepage "https://github.com/kopylovis/agentmeister"
  url "https://github.com/kopylovis/agentmeister.git",
      tag:      "v1.32.1",
      revision: "19037cd10c1e4577222c8f50d5c3d78af12ff5cd"
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
