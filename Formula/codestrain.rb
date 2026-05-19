class Codestrain < Formula
  include Language::Python::Virtualenv

  desc "Your AI coding recovery score, from the terminal"
  homepage "https://codestrain.dev"
  url "https://files.pythonhosted.org/packages/55/62/34b8d91ca9a13dfa875059e07920693ae9b552d8262f1ec6502756d151bd/codestrain-0.1.4.tar.gz"
  sha256 "50f70f02418845ed530ed11efb8272798b23cc9757894c4533261aefce913396"
  license "MIT"

  # Stdlib-only — no Python dependencies. Pin a recent Python to keep the
  # CLI insulated from system-Python churn.
  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    # --logo none + --no-color keeps the test output deterministic.
    output = shell_output("#{bin}/codestrain --logo none --no-color --no-breakdown --path /nonexistent-path 2>&1", 1)
    assert_match "No Claude Code data found", output
    # --help should also work without error
    assert_match "codestrain", shell_output("#{bin}/codestrain --help")
  end
end
