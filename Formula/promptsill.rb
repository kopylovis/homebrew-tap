class Promptsill < Formula
  desc "Status line for Claude Code with limit pace, dev servers, ports and memory"
  homepage "https://github.com/kopylovis/promptsill"
  url "https://github.com/kopylovis/promptsill.git",
      tag:      "v0.3.0",
      revision: "970b05b4e21705eda4bbf176ff55b76ac40c195e"
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
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/promptsill --version").strip
    output = pipe_output("#{bin}/promptsill", '{"context_window":{"used_percentage":42}}', 0)
    assert_match "42%", output
  end
end
