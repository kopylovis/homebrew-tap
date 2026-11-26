class Promptsill < Formula
  desc "Status line for Claude Code and a live terminal panel for Codex"
  homepage "https://github.com/kopylovis/promptsill"
  url "https://github.com/kopylovis/promptsill.git",
      tag:      "v0.11.0",
      revision: "1f4db0fd874bf13dcde8617588f37c58daeb8ded"
  license "MIT"
  head "https://github.com/kopylovis/promptsill.git", branch: "main"

  uses_from_macos "python"

  def install
    bin.install "promptsill"
  end

  def caveats
    <<~EOS
      To turn the status line on in Claude Code, run:
        promptsill install
      To enable the live Codex footer, run `promptsill codex install`.
      For a live Codex panel, run `promptsill codex watch`.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/promptsill --version").strip
    output = pipe_output(bin/"promptsill", '{"context_window":{"used_percentage":42}}', 0)
    assert_match "42%", output
    ENV["CODEX_HOME"] = (testpath/"codex").to_s
    assert_match "Codex", shell_output("#{bin}/promptsill codex")
  end
end
