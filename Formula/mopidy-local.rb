class MopidyLocal < Formula
  include Language::Python::Virtualenv

  desc "Local music library backend for the Mopidy music server"
  homepage "https://github.com/mopidy/mopidy-local"
  url "https://files.pythonhosted.org/packages/6f/09/7fb58d8dda7701b22438b09538054fed31f4ca7d9a1db6280d87660f44fd/mopidy_local-4.0.1.tar.gz"
  sha256 "0becc68bcd637f39a8e89f62cda489feb76354279065c3673d1fbf6a0beb5708"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/mopidy/homebrew-mopidy/releases/download/mopidy-local-4.0.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "001e2b8cb1faab3cf56c89a1ac74763023620bc4d00d2aa855594b51524f697c"
  end

  depends_on "mopidy/mopidy/mopidy"
  # The Python version must match the mopidy formula's.
  depends_on "python@3.14"

  pypi_packages exclude_packages: "mopidy"

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
    (prefix/site_packages/"homebrew-mopidy-local.pth").write \
      "import site; site.addsitedir('#{libexec/site_packages}')\n"
  end

  test do
    mopidy = formula_opt_bin("mopidy/mopidy/mopidy")/"mopidy"
    assert_match "[local]", shell_output("#{mopidy} config")
  end
end
