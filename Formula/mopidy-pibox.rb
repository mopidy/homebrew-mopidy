class MopidyPibox < Formula
  include Language::Python::Virtualenv

  desc "Party jukebox web client for the Mopidy music server"
  homepage "https://github.com/gbannerman/mopidy-pibox"
  url "https://files.pythonhosted.org/packages/e1/73/a652d6a5fbc4173dec82f1e296c18257299679188da192acbfab7926a9cc/mopidy_pibox-4.0.1.tar.gz"
  sha256 "e6f4c84096214fe3acae13c54ef9f4688b7b1dd5f237d44adaf533074b79c7c4"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/mopidy/homebrew-mopidy/releases/download/mopidy-pibox-4.0.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "f52a456d07b1c95f8d8ce5febd82ff93a70d7e18458daaeee4ddebc0ca20b262"
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
