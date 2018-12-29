class Mopidy < Formula
  desc "Extensible music server written in Python"
  homepage "https://www.mopidy.com/"
  url "https://files.pythonhosted.org/packages/01/20/e692e4bc7b84c61b2af10f2f7c233f7cec833d7b34f03bdbbec26fbe723b/Mopidy-2.2.2.tar.gz"
  sha256 "b41f5ab1e83c5e5f74fdb792c8fd5ba63b7fd227d04df266dba5189bc552a93d"
  head "https://github.com/mopidy/mopidy.git"

  depends_on "python@2" if MacOS.version <= :snow_leopard
  depends_on "gst-plugins-base" => [
    "with-libogg",
    "with-libvorbis",
    "with-opus",
    "with-theora",
  ]
  depends_on "gst-plugins-good" => [
    "with-flac",
    "with-libshout",
    "with-speex",
    "with-taglib",
  ]
  depends_on "gst-plugins-bad" => [
    "with-faad2",
    "with-libmms",
    "with-opus",
  ]
  depends_on "gst-plugins-ugly" => [
    "with-flac",
    "with-lame",
    "with-libmms",
    "with-libvorbis",
    "with-mad",
    "with-libshout",
    "with-theora",
    "with-two-lame",
  ]
  depends_on "gst-python" => [
    "without-python",
    "with-python@2",
  ]

  resource "backports_abc" do
    # Required by tornado
    url "https://files.pythonhosted.org/packages/68/3c/1317a9113c377d1e33711ca8de1e80afbaf4a3c950dd0edfaf61f9bfe6d8/backports_abc-0.5.tar.gz"
    sha256 "033be54514a03e255df75c5aee8f9e672f663f93abb723444caec8fe43437bde"
  end

  resource "certifi" do
    # Required by requests
    url "https://files.pythonhosted.org/packages/55/54/3ce77783acba5979ce16674fc98b1920d00b01d337cfaaf5db22543505ed/certifi-2018.11.29.tar.gz"
    sha256 "47f9c83ef4c0c621eaef743f133f09fa8a74a9b75f037e8624f83bd1b6626cb7"
  end

  resource "chardet" do
    # Required by requests
    url "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz"
    sha256 "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae"
  end

  resource "futures" do
    # Required by tornado
    url "https://files.pythonhosted.org/packages/1f/9e/7b2ff7e965fc654592269f2906ade1c7d705f1bf25b7d469fa153f7d19eb/futures-3.2.0.tar.gz"
    sha256 "9ec02aa7d674acb8618afb127e27fde7fc68994c0437ad759fa094a574adb265"
  end

  resource "idna" do
    # Required by requests
    url "https://files.pythonhosted.org/packages/ad/13/eb56951b6f7950cadb579ca166e448ba77f9d24efc03edd7e55fa57d04b7/idna-2.8.tar.gz"
    sha256 "c357b3f628cf53ae2c4c05627ecc484553142ca23264e593d327bcde5e9c3407"
  end

  resource "Pykka" do
    # Required by Mopidy
    url "https://files.pythonhosted.org/packages/70/f7/bb8fc78fc52a50f66dda4260f8726c62267f568066c71e2264b883b70755/Pykka-1.2.1.tar.gz"
    sha256 "e847ffeadee49b563426ab803e8eee67264d773e38ca14763fdcda56411e3c11"
  end

  resource "requests" do
    # Required by Mopidy
    url "https://files.pythonhosted.org/packages/52/2c/514e4ac25da2b08ca5a464c50463682126385c4272c18193876e91f4bc38/requests-2.21.0.tar.gz"
    sha256 "502a824f31acdacb3a35b6690b5fbf0bc41d63a24a45c4004352b0242707598e"
  end

  resource "singledispatch" do
    # Required by tornado
    url "https://files.pythonhosted.org/packages/d9/e9/513ad8dc17210db12cb14f2d4d190d618fb87dd38814203ea71c87ba5b68/singledispatch-3.4.0.3.tar.gz"
    sha256 "5b06af87df13818d14f08a028e42f566640aef80805c3b50c5056b086e3c2b9c"
  end

  resource "six" do
    # Required by singledispatch, which is required by tornado
    url "https://files.pythonhosted.org/packages/dd/bf/4138e7bfb757de47d1f4b6994648ec67a51efe58fa907c1e11e350cddfca/six-1.12.0.tar.gz"
    sha256 "d16a0141ec1a18405cd4ce8b4613101da75da0e9a7aec5bdd4fa804d0e0eba73"
  end

  resource "tornado" do
    # Required by Mopidy
    url "https://files.pythonhosted.org/packages/e3/7b/e29ab3d51c8df66922fea216e2bddfcb6430fb29620e5165b16a216e0d3c/tornado-4.5.3.tar.gz"
    sha256 "6d14e47eab0e15799cf3cdcc86b0b98279da68522caace2bd7ce644287685f0a"
  end

  resource "urllib3" do
    # Required by requests
    url "https://files.pythonhosted.org/packages/b1/53/37d82ab391393565f2f831b8eedbffd57db5a718216f82f1a8b4d381a1c1/urllib3-1.24.1.tar.gz"
    sha256 "de9529817c93f27c8ccbfead6985011db27bd0ddfcdb2d86f3f663385c6a9c22"
  end

  def install
    resources.each do |r|
      r.stage do
        system "python", *Language::Python.setup_install_args(libexec)
      end
    end

    system "python", *Language::Python.setup_install_args(libexec)

    site_packages = "lib/python2.7/site-packages"
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
    system "python", "-c", "import mopidy"
  end

  def plist_name
    "homebrew.mopidy." + name
  end
end
