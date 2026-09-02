class MopidyMpd < Formula
  include Language::Python::Virtualenv

  desc "MPD protocol frontend for the Mopidy music server"
  homepage "https://github.com/mopidy/mopidy-mpd"
  url "https://files.pythonhosted.org/packages/f5/64/45475aea10f31e4bc4f71cbd82206ed6ec124a0b71857adfa96454550764/mopidy_mpd-4.0.1.tar.gz"
  sha256 "89630424725139e537614fa89655a278019058e218488f9115641bdc0184dcdc"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/mopidy/homebrew-mopidy/releases/download/mopidy-mpd-4.0.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "d343a331239be942bbf71d74bded013ccf24b587e608ae636633ddf4ecf5d1c7"
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
    (prefix/site_packages/"homebrew-mopidy-mpd.pth").write \
      "import site; site.addsitedir('#{libexec/site_packages}')\n"
  end

  test do
    mopidy = formula_opt_bin("mopidy/mopidy/mopidy")/"mopidy"
    assert_match "[mpd]", shell_output("#{mopidy} config")
  end
end
