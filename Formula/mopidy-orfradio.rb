class MopidyOrfradio < Formula
  include Language::Python::Virtualenv

  desc "ORF Austrian radio backend for the Mopidy music server"
  homepage "https://github.com/mopidy/mopidy-orfradio"
  url "https://files.pythonhosted.org/packages/5a/45/27a944f7681bb7283700ab4d623f1d4894f6b593cb25426f859ba668fb42/mopidy_orfradio-3.0.0.tar.gz"
  sha256 "0bed6b5d226cf268bbd0e69eea430fd4dacee87afe4d1239791cab923bde2958"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/mopidy/homebrew-mopidy/releases/download/mopidy-orfradio-3.0.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "df8605d0910d756eafd15edd2203616d55e74ce0ba27721665bccbbdff67ebbc"
  end

  depends_on "mopidy/mopidy/mopidy"
  # The Python version must match the mopidy formula's.
  depends_on "python@3.14"

  pypi_packages exclude_packages: "mopidy"

  resource "beaker" do
    url "https://files.pythonhosted.org/packages/83/6b/3cd3dcf40417e3be31a3a2257957144b0c058ffaf9ca32d2c83c85567cb6/beaker-1.14.1.tar.gz"
    sha256 "886f52a51810703fdbc0a3e54fca40886288ff530b2070582edce72bf1945447"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/66/c0/0c8b6ad9f17a802ee498c46e004a0eb49bc148f2fd230864601a86dcf6db/python-dateutil-2.9.0.post0.tar.gz"
    sha256 "37dd54208da7e1cd875388217d5e00ebd4179249f90fb72437e91a35459a0ad3"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/94/e7/b2c673351809dca68a0e064b6af791aa332cf192da575fd474ed7d6f16a2/six-1.17.0.tar.gz"
    sha256 "ff70335d468e7eb6ec65b95b99d3a2836546063f63acc5171de367e834932a81"
  end

  def install
    virtualenv_install_with_resources

    # Register the extension with the mopidy formula's venv: this .pth file
    # gets linked into HOMEBREW_PREFIX/lib/python3.14/site-packages, which
    # the brewed python processes at startup (also inside mopidy's venv, as
    # it is created with --system-site-packages).
    site_packages = Language::Python.site_packages("python3.14")
    (prefix/site_packages/"homebrew-mopidy-orfradio.pth").write \
      "import site; site.addsitedir('#{libexec/site_packages}')\n"
  end

  test do
    mopidy = formula_opt_bin("mopidy/mopidy/mopidy")/"mopidy"
    assert_match "[orfradio]", shell_output("#{mopidy} config")
  end
end
