class Codestrain < Formula
  include Language::Python::Virtualenv

  desc "Your AI coding recovery score, from the terminal"
  homepage "https://codestrain.dev"
  url "https://files.pythonhosted.org/packages/e2/d5/d0a24cff691bcab88c76f0613a42a28c4232810a169478336456c37a4aa9/codestrain-0.1.1.tar.gz"
  sha256 "3f25d64b546ba569589762c5dddd4cde72cf402e5ede228396d9b4d123647d46"
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
