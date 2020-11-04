class Mopidy < Formula
  desc "Extensible music server written in Python"
  homepage "https://mopidy.com/"
  url "https://files.pythonhosted.org/packages/b0/6f/eaadbe67c5b99215bfa247257fc20cb997674f5ecf3765230ae92d456a74/Mopidy-3.0.2.tar.gz"
  sha256 "60b6f48e53069ac280e8271e89f50161d8a3e0c9bee83ac4d862174b3e38cedb"
  head "https://github.com/mopidy/mopidy.git"
  revision 2

  depends_on "python@3.9"
  depends_on "gst-plugins-base"
  depends_on "gst-plugins-good"
  depends_on "gst-plugins-bad"
  depends_on "gst-plugins-ugly"
  depends_on "gst-python"

  resource "certifi" do
    # Required by requests
    url "https://files.pythonhosted.org/packages/41/bf/9d214a5af07debc6acf7f3f257265618f1db242a3f8e49a9b516f24523a6/certifi-2019.11.28.tar.gz"
    sha256 "25b64c7da4cd7479594d035c08c2d809eb4aab3a26e5a990ea98cc450c320f1f"
  end

  resource "chardet" do
    # Required by requests
    url "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz"
    sha256 "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae"
  end

  resource "idna" do
    # Required by requests
    url "https://files.pythonhosted.org/packages/ad/13/eb56951b6f7950cadb579ca166e448ba77f9d24efc03edd7e55fa57d04b7/idna-2.8.tar.gz"
    sha256 "c357b3f628cf53ae2c4c05627ecc484553142ca23264e593d327bcde5e9c3407"
  end

  resource "Pykka" do
    # Required by Mopidy
    url "https://files.pythonhosted.org/packages/8c/25/26af8b333bbc6b00bd03a95c058c50e6161af50680030a30cbdf053c4354/Pykka-2.0.2.tar.gz"
    sha256 "895cc2ed8779b65dd14a90ba3f4b8cb0f7904c7bf0710fe96a923019f8e82a39"
  end

  resource "requests" do
    # Required by Mopidy
    url "https://files.pythonhosted.org/packages/01/62/ddcf76d1d19885e8579acb1b1df26a852b03472c0e46d2b959a714c90608/requests-2.22.0.tar.gz"
    sha256 "11e007a8a2aa0323f5a921e9e6a2d7e4e67d9877e85773fba9ba6419025cbeb4"
  end

  resource "tornado" do
    # Required by Mopidy
    url "https://files.pythonhosted.org/packages/30/78/2d2823598496127b21423baffaa186b668f73cd91887fcef78b6eade136b/tornado-6.0.3.tar.gz"
    sha256 "c845db36ba616912074c5b1ee897f8e0124df269468f25e4fe21fe72f6edd7a9"
  end

  resource "urllib3" do
    # Required by requests
    url "https://files.pythonhosted.org/packages/ad/fc/54d62fa4fc6e675678f9519e677dfc29b8964278d75333cf142892caf015/urllib3-1.25.7.tar.gz"
    sha256 "f3c5fd51747d450d4dcf6f923c81f78f811aab8205fda64b0aba34a4e48b0745"
  end

  def install
    python3 = Formula["python@3.9"].opt_bin/"python3"

    resources.each do |r|
      r.stage do
        system python3, *Language::Python.setup_install_args(libexec)
      end
    end

    system python3, *Language::Python.setup_install_args(libexec)

    xy = Language::Python.major_minor_version python3
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy.pth").write pth_contents

    bin.install Dir[libexec/"bin/*"]
  end

  plist_options :manual => "mopidy"
  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{opt_bin}/mopidy</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>KeepAlive</key>
      <true/>
    </dict>
    </plist>
    EOS
  end

  test do
    python3 = Formula["python@3.9"].opt_bin/"python3"
    system python3, "-c", "import mopidy"
  end

  def plist_name
    "homebrew.mopidy." + name
  end
end
