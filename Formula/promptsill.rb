class Promptsill < Formula
  desc "Status line for Claude Code and terminal snapshots for Codex"
  homepage "https://github.com/kopylovis/promptsill"
  url "https://github.com/kopylovis/promptsill.git",
      tag:      "v0.7.0",
      revision: "002ba73014bd93c4a83e8679471b1a0c813b1c07"
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
      For a Codex snapshot, run `promptsill codex`.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/promptsill --version").strip
    output = pipe_output("#{bin}/promptsill", '{"context_window":{"used_percentage":42}}', 0)
    assert_match "42%", output
    ENV["CODEX_HOME"] = (testpath/"codex").to_s
    assert_match "Codex", shell_output("#{bin}/promptsill codex")
  end
end
