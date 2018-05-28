class PythonCertifi < Formula
  desc "Python package for providing Mozilla's CA Bundle"
  homepage "https://pypi.python.org/pypi/certifi"
  url "https://pypi.python.org/packages/41/bf/88a3269c7c95fc94a2c581c4b1b3d3ec21af7a268d6a3a4e54578adccfd6/certifi-2016.8.8.tar.gz"
  sha256 "99864ed602d8a9d212e339b15ffa438895002eda7b7db20dca5309dac9605ae9"
  head "https://github.com/certifi/python-certifi.git"

  depends_on "python" => :recommended
  depends_on "python3" => :optional

  def install
    Language::Python.each_python(build) do |python, _version|
      system python, *Language::Python.setup_install_args(prefix)
    end
  end

  test do
    Language::Python.each_python(build) do |python, _version|
      system python, "-c", "import certifi"
    end
  end
end
