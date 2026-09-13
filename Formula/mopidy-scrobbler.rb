class MopidyScrobbler < Formula
  include Language::Python::Virtualenv

  desc "Last.fm scrobbler for the Mopidy music server"
  homepage "https://github.com/mopidy/mopidy-scrobbler"
  url "https://files.pythonhosted.org/packages/8f/5f/1fff221adf0c7d1b378896ae1ba472efde736ccdae2febec3b4fcac9b0ed/mopidy_scrobbler-3.1.1.tar.gz"
  sha256 "03af6d203784627e85ced3ad0670e45ff0a4b07a2ba51da0b8d105c1b845b78f"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/mopidy/homebrew-mopidy/releases/download/mopidy-scrobbler-3.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "5318fba6e032eba63213cb01ea43cd55c42ac84511eb515748a36698d9a28bb2"
  end

  depends_on "mopidy/mopidy/mopidy"
  # The Python version must match the mopidy formula's.
  depends_on "python@3.14"

  pypi_packages exclude_packages: "mopidy"

  resource "httpcore2" do
    url "https://files.pythonhosted.org/packages/be/ad/f4f0e57345f1870f3e8cb624e058d7eca6e5a27d33bcc3311d9b618734cd/httpcore2-2.12.0.tar.gz"
    sha256 "9293522bba0aa7c4c8e9e3f040c16575bd8868e155a77fa30c7a9085a5eae648"
  end

  resource "httpx2" do
    url "https://files.pythonhosted.org/packages/7f/f8/579a8b51e42e38ee32647df9f08aa25643ae788e275cc625b199829c4671/httpx2-2.12.0.tar.gz"
    sha256 "7631fe9887a8a2275f4a2540e053aa670fcc50742864a9ae7c66e609fdcf12cf"
  end

  resource "pylast" do
    url "https://files.pythonhosted.org/packages/5e/1d/aaf99f82be962381ac07331106c72ff201ad98da9f18e74c0ee5f74e5a41/pylast-7.1.0.tar.gz"
    sha256 "0c1fc381d649f256842c665ede52591d3b32789e281cd9b5601c01d2dc3a2d88"
  end

  resource "truststore" do
    url "https://files.pythonhosted.org/packages/53/a3/1585216310e344e8102c22482f6060c7a6ea0322b63e026372e6dcefcfd6/truststore-0.10.4.tar.gz"
    sha256 "9d91bd436463ad5e4ee4aba766628dd6cd7010cf3e2461756b3303710eebc301"
  end

  def install
    virtualenv_install_with_resources

    # Register the extension with the mopidy formula's venv: this .pth file
    # gets linked into HOMEBREW_PREFIX/lib/python3.14/site-packages, which
    # the brewed python processes at startup (also inside mopidy's venv, as
    # it is created with --system-site-packages).
    site_packages = Language::Python.site_packages("python3.14")
    (prefix/site_packages/"homebrew-mopidy-scrobbler.pth").write \
      "import site; site.addsitedir('#{libexec/site_packages}')\n"
  end

  test do
    mopidy = formula_opt_bin("mopidy/mopidy/mopidy")/"mopidy"
    assert_match "[scrobbler]", shell_output("#{mopidy} config")
  end
end
