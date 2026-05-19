class Codestrain < Formula
  include Language::Python::Virtualenv

  desc "Your AI coding recovery score, from the terminal"
  homepage "https://codestrain.dev"
  url "https://files.pythonhosted.org/packages/e4/2e/e91f1b24c8c9435e4e6d29a29925aabb27deea141becb4904b3ce1e165dd/codestrain-0.1.3.tar.gz"
  sha256 "2fb7623468272130782f5680972cf05832cf7c6236900a7ee3c145b84b15f06f"
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
