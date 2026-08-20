class MopidyApiExplorer < Formula
  include Language::Python::Virtualenv

  desc "HTTP API explorer for the Mopidy music server"
  homepage "https://github.com/mopidy/mopidy-api-explorer"
  url "https://files.pythonhosted.org/packages/a8/74/d48ed5cd37cf712e308d25bd85e75b2009e63990c5e6cb6ebfdd590274bc/mopidy_api_explorer-2.0.0.tar.gz"
  sha256 "a5ea4170aaee7a4fe015e0201745eb3436e05358511dc0dc18d525a40b360ded"
  license "MIT"

  bottle do
    root_url "https://github.com/mopidy/homebrew-mopidy/releases/download/mopidy-api-explorer-2.0.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "161d2a47765913ac2f2855394466a7c48e745abda7eed26a12da304aaa5aa337"
  end

  depends_on "mopidy/mopidy/mopidy"
  # The Python version must match the mopidy formula's.
  depends_on "python@3.14"

  def install
    virtualenv_install_with_resources

    # Register the extension with the mopidy formula's venv: this .pth file
    # gets linked into HOMEBREW_PREFIX/lib/python3.14/site-packages, which
    # the brewed python processes at startup (also inside mopidy's venv, as
    # it is created with --system-site-packages).
    site_packages = Language::Python.site_packages("python3.14")
    (prefix/site_packages/"homebrew-mopidy-api-explorer.pth").write \
      "import site; site.addsitedir('#{libexec/site_packages}')\n"
  end

  test do
    mopidy = formula_opt_bin("mopidy/mopidy/mopidy")/"mopidy"
    assert_match "[api_explorer]", shell_output("#{mopidy} config")
  end
end
