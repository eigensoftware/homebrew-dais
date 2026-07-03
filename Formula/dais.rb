class Dais < Formula
  desc "Control panel for an autonomous multi-agent software company"
  homepage "https://github.com/eigensoftware/dais"
  url "https://github.com/eigensoftware/dais/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "d832c6a970cf8bd0b6bc0ca146f05c5996ded4a1e9716fdb8d6df27e523d9df2"
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
      Dais runs headless Claude Code agents — install that CLI separately (not on Homebrew):
        https://docs.claude.com/en/docs/claude-code

      Create a workspace to operate on:
        dais init ~/my-company
      Point dais at it via ~/.dais/config (home=…) or the DAIS_HOME environment variable.
    EOS
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/dais version")
  end
end
