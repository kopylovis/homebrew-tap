class Promptsill < Formula
  desc "Status line for Claude Code with limit pace, dev servers, ports and memory"
  homepage "https://github.com/kopylovis/promptsill"
  url "https://github.com/kopylovis/promptsill.git",
      tag:      "v0.1.0",
      revision: "082a2e88e6373d1dff06a25715674fed0efb8d5a"
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
