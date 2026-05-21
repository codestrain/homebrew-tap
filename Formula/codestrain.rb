class Codestrain < Formula
  desc "Your AI coding recovery score, from the terminal"
  homepage "https://codestrain.dev"
  url "https://files.pythonhosted.org/packages/1d/d3/5717997f3a49f271a24175a68b739c66ade63db6dbb5c0e2bf8dd7b2f344/codestrain-0.1.8.tar.gz"
  sha256 "976f10091ff6ad5c753bb56b8732637d5b0f7f9faf8d83fa4594e5e68689a14e"
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
