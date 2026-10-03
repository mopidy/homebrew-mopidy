class MopidyPibox < Formula
  include Language::Python::Virtualenv

  desc "Party jukebox web client for the Mopidy music server"
  homepage "https://github.com/gbannerman/mopidy-pibox"
  url "https://files.pythonhosted.org/packages/3a/43/81e0159134d4a4479aac958a04ca209546c1928fbaeeb0665a694a22cf22/mopidy_pibox-4.0.2.tar.gz"
  sha256 "e0a64389ba2e83bd9829f6ff6bf8c2a7a28e3883f63fdfd01d3d7875e4061dea"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/mopidy/homebrew-mopidy/releases/download/mopidy-pibox-4.0.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "254f0fd23905f99a423ed7ca0b6ba0b7db1d00dfcd5ffe7281e0df02a22e335d"
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
    (prefix/site_packages/"homebrew-mopidy-pibox.pth").write \
      "import site; site.addsitedir('#{libexec/site_packages}')\n"
  end

  test do
    mopidy = formula_opt_bin("mopidy/mopidy/mopidy")/"mopidy"
    assert_match "[pibox]", shell_output("#{mopidy} config")
  end
end
