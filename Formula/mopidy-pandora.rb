class MopidyPandora < Formula
  include Language::Python::Virtualenv

  desc "Pandora backend for the Mopidy music server"
  homepage "https://github.com/mopidy/mopidy-pandora"
  url "https://files.pythonhosted.org/packages/00/b1/47f12290243b2dc54ec0b9ed54d3ed56d93a44a48df3f1f699ffd2327392/mopidy_pandora-2.0.0.tar.gz"
  sha256 "9cf6b643b860eb083c35693dcb086e3698b8664305a0e8563f577ee52399a254"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/mopidy/homebrew-mopidy/releases/download/mopidy-pandora-2.0.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "7cb35aa65f3f2910cd52feeb312763a1d611e562893666c9de8dc7cb573228a1"
  end

  depends_on "mopidy/mopidy/mopidy"
  # The Python version must match the mopidy formula's.
  depends_on "python@3.14"

  pypi_packages exclude_packages: "mopidy"

  resource "blowfish" do
    url "https://files.pythonhosted.org/packages/ca/06/6008f79f3df714da4eeb6d7daf5e417e072c69923d22ede09171e74d69f8/blowfish-0.6.1.tar.bz2"
    sha256 "1626d96d2672a6cf021d9b66a5013b6e594865403b4a06d75034e0a9ff1cbdc6"
  end

  resource "cachetools" do
    url "https://files.pythonhosted.org/packages/70/d2/47e8bc06fe2a06d3f5bdf20f1126ab66c4e99dc48d940e7ba873f7ac7131/cachetools-7.1.7.tar.gz"
    sha256 "a3e2a00b14d8f8a6b70c1dae7b4685e7ad3bc965c5b42124a2d6ce895da6cf50"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/a3/c2/24167ea9858356b47a87a50d39908bfdb72ceeefe0041586e704e5376b3a/certifi-2026.7.22.tar.gz"
    sha256 "741e2c3b351ddf169a738da9f2c048608ff7f2c5cc02f1ebc6b118bb090d5d55"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/e5/3f/143b048436775b0f76ac3eec145c019e8173ccc2885c8f20319b996d5e83/charset_normalizer-3.5.1.tar.gz"
    sha256 "6117b84ea48435e5356dc737f5121485c30920ba43375fa7b434fd753df0eac3"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/5f/f7/abb373e5757eaec4b922b92f97ec8d6d7e057cf06778247604fbc4e7c3f3/idna-3.19.tar.gz"
    sha256 "5e0811a4383b21dc5838069f801c4fb62113b7447663d2530d2bd6e77b49bf15"
  end

  resource "pydora" do
    url "https://files.pythonhosted.org/packages/15/61/18be073cbbb904fc24b9e4a171805af006bea9937fdee31cec89a1b401c2/pydora-2.3.1.tar.gz"
    sha256 "d1075c45927ae99f985aefa0dcc4674a1d454081e5acb96c9b6032c8376a45a6"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/ac/c3/e2a2b89f2d3e2179abd6d00ebd70bff6273f37fb3e0cc209f48b39d00cbf/requests-2.34.2.tar.gz"
    sha256 "f288924cae4e29463698d6d60bc6a4da69c89185ad1e0bcc4104f584e960b9ed"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/53/0c/06f8b233b8fd13b9e5ee11424ef85419ba0d8ba0b3138bf360be2ff56953/urllib3-2.7.0.tar.gz"
    sha256 "231e0ec3b63ceb14667c67be60f2f2c40a518cb38b03af60abc813da26505f4c"
  end

  def install
    virtualenv_install_with_resources

    # Register the extension with the mopidy formula's venv: this .pth file
    # gets linked into HOMEBREW_PREFIX/lib/python3.14/site-packages, which
    # the brewed python processes at startup (also inside mopidy's venv, as
    # it is created with --system-site-packages).
    site_packages = Language::Python.site_packages("python3.14")
    (prefix/site_packages/"homebrew-mopidy-pandora.pth").write \
      "import site; site.addsitedir('#{libexec/site_packages}')\n"
  end

  test do
    mopidy = formula_opt_bin("mopidy/mopidy/mopidy")/"mopidy"
    assert_match "[pandora]", shell_output("#{mopidy} config")
  end
end
