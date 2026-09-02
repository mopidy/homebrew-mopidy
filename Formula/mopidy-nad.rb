class MopidyNad < Formula
  include Language::Python::Virtualenv

  desc "NAD amplifier control for the Mopidy music server"
  homepage "https://github.com/mopidy/mopidy-nad"
  url "https://files.pythonhosted.org/packages/4f/fc/e4ec50920c40b199519541be6fb01e5eecc5746f5be4772081147ab66b3a/mopidy_nad-4.0.0.tar.gz"
  sha256 "641dabb84c99f1345a6a771299ea91d8aefc7b5810425c686e7a402fec40f305"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/mopidy/homebrew-mopidy/releases/download/mopidy-nad-4.0.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "0ba12fa6577725d6566089e3012d724e3446909d8a80e32d91885744fabfb075"
  end

  depends_on "mopidy/mopidy/mopidy"
  # The Python version must match the mopidy formula's.
  depends_on "python@3.14"

  pypi_packages exclude_packages: "mopidy"

  resource "pyserial" do
    url "https://files.pythonhosted.org/packages/1e/7d/ae3f0a63f41e4d2f6cb66a5b57197850f919f59e558159a4dd3a818f5082/pyserial-3.5.tar.gz"
    sha256 "3c77e014170dfffbd816e6ffc205e9842efb10be9f58ec16d3e8675b4925cddb"
  end

  def install
    virtualenv_install_with_resources

    # Register the extension with the mopidy formula's venv: this .pth file
    # gets linked into HOMEBREW_PREFIX/lib/python3.14/site-packages, which
    # the brewed python processes at startup (also inside mopidy's venv, as
    # it is created with --system-site-packages).
    site_packages = Language::Python.site_packages("python3.14")
    (prefix/site_packages/"homebrew-mopidy-nad.pth").write \
      "import site; site.addsitedir('#{libexec/site_packages}')\n"
  end

  test do
    mopidy = formula_opt_bin("mopidy/mopidy/mopidy")/"mopidy"
    assert_match "[nad]", shell_output("#{mopidy} config")
  end
end
