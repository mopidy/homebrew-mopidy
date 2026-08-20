class MopidyPibox < Formula
  include Language::Python::Virtualenv

  desc "Party jukebox web client for the Mopidy music server"
  homepage "https://github.com/gbannerman/mopidy-pibox"
  url "https://files.pythonhosted.org/packages/e8/79/cacb2cf37f53c4d93071301112cfbc6e038cb05f25b8126394a746da71b6/mopidy_pibox-4.0.0.tar.gz"
  sha256 "bceed8e270538a0bf286e9e19b13582c0795fb852af62f26028b96ea5a0ab761"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/mopidy/homebrew-mopidy/releases/download/mopidy-pibox-4.0.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "abaead601c6456a5d259b9b2b0ebdadeaa76f0289c63748843869e644d5a63e2"
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
    (prefix/site_packages/"homebrew-mopidy-pibox.pth").write \
      "import site; site.addsitedir('#{libexec/site_packages}')\n"
  end

  test do
    mopidy = formula_opt_bin("mopidy/mopidy/mopidy")/"mopidy"
    assert_match "[pibox]", shell_output("#{mopidy} config")
  end
end
