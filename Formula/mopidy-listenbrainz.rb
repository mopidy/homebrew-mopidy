class MopidyListenbrainz < Formula
  include Language::Python::Virtualenv

  desc "ListenBrainz scrobbler for the Mopidy music server"
  homepage "https://github.com/suaviloquence/mopidy-listenbrainz"
  url "https://files.pythonhosted.org/packages/40/98/1c7533ec8782c07aecc8b916f44b4286cbe32aa51ee757e8d1071bd1d795/mopidy_listenbrainz-0.4.2.tar.gz"
  sha256 "4b25dff35968f0c11b9cbd7f838292af149df2aff44c25433244e9e85762735c"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/mopidy/homebrew-mopidy/releases/download/mopidy-listenbrainz-0.4.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "6e5fb4e669e3b81f37a0072a728b385a9f940c9a4e15a7d575b0ab1f5fe3fbf8"
  end

  depends_on "mopidy/mopidy/mopidy"
  # The Python version must match the mopidy formula's.
  depends_on "python@3.14"

  pypi_packages exclude_packages: "mopidy"

  resource "musicbrainzngs" do
    url "https://files.pythonhosted.org/packages/0a/67/3e74ae93d90ceeba72ed1a266dd3ca9abd625f315f0afd35f9b034acedd1/musicbrainzngs-0.7.1.tar.gz"
    sha256 "ab1c0100fd0b305852e65f2ed4113c6de12e68afd55186987b8ed97e0f98e627"
  end

  def install
    virtualenv_install_with_resources

    # Register the extension with the mopidy formula's venv: this .pth file
    # gets linked into HOMEBREW_PREFIX/lib/python3.14/site-packages, which
    # the brewed python processes at startup (also inside mopidy's venv, as
    # it is created with --system-site-packages).
    site_packages = Language::Python.site_packages("python3.14")
    (prefix/site_packages/"homebrew-mopidy-listenbrainz.pth").write \
      "import site; site.addsitedir('#{libexec/site_packages}')\n"
  end

  test do
    mopidy = formula_opt_bin("mopidy/mopidy/mopidy")/"mopidy"
    assert_match "[listenbrainz]", shell_output("#{mopidy} config")
  end
end
