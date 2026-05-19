class Codestrain < Formula
  include Language::Python::Virtualenv

  desc "Your AI coding recovery score, from the terminal"
  homepage "https://codestrain.dev"
  url "https://files.pythonhosted.org/packages/1c/86/dcc5849ec8a1b731f2ff41a98c086336fd1db672ee0ecfb54016095d2bd1/codestrain-0.1.2.tar.gz"
  sha256 "c58e98a043977e4dc2dd9025aa0ab17de29fe32fd6bed8e07bd36694eba6d4b4"
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
