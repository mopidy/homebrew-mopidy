class MopidyPodcast < Formula
  include Language::Python::Virtualenv

  desc "Podcast backend for the Mopidy music server"
  homepage "https://github.com/tkem/mopidy-podcast"
  url "https://files.pythonhosted.org/packages/3a/a4/721407fcc49340fbb0e3e77f4f95b575434a9833e218b88d6cd388e5b772/mopidy_podcast-4.0.0.tar.gz"
  sha256 "12714c12125e56386bc0e02981e53dd96cd8646ada0454c09ed994b1ce36dfea"
  license "Apache-2.0"

  depends_on "mopidy/mopidy/mopidy"
  # The Python version must match the mopidy formula's.
  depends_on "python@3.14"

  resource "cachetools" do
    url "https://files.pythonhosted.org/packages/70/d2/47e8bc06fe2a06d3f5bdf20f1126ab66c4e99dc48d940e7ba873f7ac7131/cachetools-7.1.7.tar.gz"
    sha256 "a3e2a00b14d8f8a6b70c1dae7b4685e7ad3bc965c5b42124a2d6ce895da6cf50"
  end

  resource "uritools" do
    url "https://files.pythonhosted.org/packages/a3/0d/20d02264b6682f07e92cbf7ee43e5e803670d101a03ef204ba18368c321f/uritools-6.1.3.tar.gz"
    sha256 "3a498e7e85ef3249343d5710618d641a414da0fbae6d23053ada7976ee83ea5f"
  end

  def install
    virtualenv_install_with_resources

    # Register the extension with the mopidy formula's venv: this .pth file
    # gets linked into HOMEBREW_PREFIX/lib/python3.14/site-packages, which
    # the brewed python processes at startup (also inside mopidy's venv, as
    # it is created with --system-site-packages).
    site_packages = Language::Python.site_packages("python3.14")
    (prefix/site_packages/"homebrew-mopidy-podcast.pth").write \
      "import site; site.addsitedir('#{libexec/site_packages}')\n"
  end

  test do
    mopidy = formula_opt_bin("mopidy/mopidy/mopidy")/"mopidy"
    assert_match "[podcast]", shell_output("#{mopidy} config")
  end
end
