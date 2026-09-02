class MopidySomafm < Formula
  include Language::Python::Virtualenv

  desc "SomaFM backend for the Mopidy music server"
  homepage "https://github.com/AlexandrePTJ/mopidy-somafm"
  url "https://files.pythonhosted.org/packages/c2/f0/10f14a661cce539d0d46611b2c283e38530591c2a811eab7fc954fb9e9bf/mopidy_somafm-2.1.0.tar.gz"
  sha256 "77bcabde36d9dbc4a3e48d3a8b7e31bf166d5e7ca75b97faf887a6e6543a119e"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/mopidy/homebrew-mopidy/releases/download/mopidy-somafm-2.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "4915179deebfe24a500d1d9c3c338b078a650b875394e335a2abfaf14998787c"
  end

  depends_on "mopidy/mopidy/mopidy"
  # The Python version must match the mopidy formula's.
  depends_on "python@3.14"

  pypi_packages exclude_packages: "mopidy"

  def install
    virtualenv_install_with_resources

    # Register the extension with the mopidy formula's venv: this .pth file
    # gets linked into HOMEBREW_PREFIX/lib/python3.14/site-packages, which
    # the brewed python processes at startup (also inside mopidy's venv, as
    # it is created with --system-site-packages).
    site_packages = Language::Python.site_packages("python3.14")
    (prefix/site_packages/"homebrew-mopidy-somafm.pth").write \
      "import site; site.addsitedir('#{libexec/site_packages}')\n"
  end

  test do
    mopidy = formula_opt_bin("mopidy/mopidy/mopidy")/"mopidy"
    assert_match "[somafm]", shell_output("#{mopidy} config")
  end
end
