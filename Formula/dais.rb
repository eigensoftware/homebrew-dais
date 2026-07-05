class Dais < Formula
  desc "Control panel for an autonomous multi-agent software company"
  homepage "https://github.com/eigensoftware/dais"
  url "https://github.com/eigensoftware/dais/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "e5fe1af4fe6d8ee025ade43baa75c1d0fd3386141c6c12db4ba8f5f704c8d67c"
  license "MIT"
  head "https://github.com/eigensoftware/dais.git", branch: "main"

  # No formula dependencies: the harness is pure Python stdlib and runs on macOS's system
  # python3 (which Homebrew's Command Line Tools requirement guarantees); git and sqlite3 ship
  # with macOS. The one real runtime dep — the Claude Code CLI — is not on Homebrew (see caveats).

  def install
    # The `dais` launcher sources harness/lib.sh, so the script and harness/ must stay siblings.
    # libexec preserves that layout; the bin symlink is resolved back to it at runtime.
    libexec.install "dais", "harness", "design", "README.md", "LICENSE"
    (libexec/"VERSION").write "v#{version}"
    bin.install_symlink libexec/"dais"
  end

  def caveats
    <<~EOS
      Dais runs headless coding agents — install the provider CLI(s) separately:
        Claude Code (default provider):   https://docs.claude.com/en/docs/claude-code
        codex (optional, provider: openai): https://developers.openai.com/codex/cli

      Create a workspace to operate on:
        dais init ~/my-company
      Point dais at it via ~/.dais/config (home=…) or the DAIS_HOME environment variable.
    EOS
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/dais version")
  end
end
