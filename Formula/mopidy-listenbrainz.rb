class MopidyListenbrainz < Formula
  include Language::Python::Virtualenv

  desc "ListenBrainz scrobbler for the Mopidy music server"
  homepage "https://github.com/suaviloquence/mopidy-listenbrainz"
  url "https://files.pythonhosted.org/packages/b7/ca/b10a11ccb7807b325aca5a673d26d8c6fadc99aa40570a7506703c7055ab/mopidy_listenbrainz-0.4.1.tar.gz"
  sha256 "deefea8131f668469ddb24bdabeeb03b4b6ca97232fa12248363f88d14b05da4"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/mopidy/homebrew-mopidy/releases/download/mopidy-listenbrainz-0.4.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "0c190c56e07db57cadcb48311f18961e3abe397baa9efc4ed04ca58b17081751"
  end

  depends_on "mopidy/mopidy/mopidy"
  # The Python version must match the mopidy formula's.
  depends_on "python@3.14"

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
