class Codestrain < Formula
  desc "Your AI coding recovery score, from the terminal"
  homepage "https://codestrain.dev"
  url "https://files.pythonhosted.org/packages/0a/b6/1687892c1383e269c42ed10f3bb45a6f13e77406dfc065575d8843535a21/codestrain-0.1.5.tar.gz"
  sha256 "a0d400c7b90adb9e816190c49244e7b2d8a2d8f84295a8738971554d5790a3cf"
  license "MIT"

  # codestrain is a single-file stdlib-only script — no pip resources, no
  # native compilation. Pin a recent Python so the CLI is insulated from
  # system-Python churn, but skip Language::Python::Virtualenv entirely
  # (that mixin would pull in Xcode Command Line Tools as a build-time
  # dependency, which is overkill for a copy-one-file install).
  depends_on "python@3.12"

  def install
    # Drop the script into bin/ under its public name and rewrite the
    # shebang to use the keg's Python explicitly — no PATH guesswork.
    bin.install "codestrain_cli.py" => "codestrain"
    inreplace bin/"codestrain", /\A#!.+/, "#!#{Formula["python@3.12"].opt_bin}/python3.12"
  end

  test do
    output = shell_output("#{bin}/codestrain --logo none --no-color --no-breakdown --path /nonexistent-path 2>&1", 1)
    assert_match "No Claude Code data found", output
    assert_match "codestrain", shell_output("#{bin}/codestrain --help")
  end
end
