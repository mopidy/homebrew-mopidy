class MopidyTunein < Formula
  include Language::Python::Virtualenv

  desc "TuneIn backend for the Mopidy music server"
  homepage "https://github.com/mopidy/mopidy-tunein"
  url "https://files.pythonhosted.org/packages/09/dc/de365d2853799de5fde818bdef77d4bdfc4fd0d518d7ba3b3af612a6c4a2/mopidy_tunein-2.0.0.tar.gz"
  sha256 "f74683ca63c7d59852f24b3661afa31303fdbdc1af5d115529fc4003e4fd47a3"
  license "Apache-2.0"

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
    (prefix/site_packages/"homebrew-mopidy-tunein.pth").write \
      "import site; site.addsitedir('#{libexec/site_packages}')\n"
  end

  test do
    mopidy = formula_opt_bin("mopidy/mopidy/mopidy")/"mopidy"
    assert_match "[tunein]", shell_output("#{mopidy} config")
  end
end
