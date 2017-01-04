class Mopidy < Formula
  desc "Extensible music server written in Python"
  homepage "http://www.mopidy.com/"
  url "https://files.pythonhosted.org/packages/60/76/427ad1fbe879034e34cf9898310ba5a9cc42cd36b08898059be06066fa38/Mopidy-2.1.0.tar.gz"
  sha256 "297369a34ebd584b2fe25a7184f68fe876a149256549b03b503a55ede3f13f6a"
  head "https://github.com/mopidy/mopidy.git"

  depends_on :python
  depends_on "gst-plugins-base" => [
    "with-libogg",
    "with-libvorbis",
    "with-opus",
    "with-theora"
  ]
  depends_on "gst-plugins-good" => [
    "with-flac",
    "with-libshout",
    "with-speex",
    "with-taglib"
  ]
  depends_on "gst-plugins-bad" => [
    "with-faad2",
    "with-libmms",
    "with-opus"
  ]
  depends_on "gst-plugins-ugly" => [
    "with-flac",
    "with-lame",
    "with-libmms",
    "with-libvorbis",
    "with-mad",
    "with-libshout",
    "with-theora",
    "with-two-lame"
  ]
  depends_on "gst-python"
  depends_on "mopidy/mopidy/python-pykka"
  depends_on "mopidy/mopidy/python-tornado"
  depends_on "mopidy/mopidy/python-requests"

  def install
    system "python", *Language::Python.setup_install_args(prefix)
  end

  test do
    system "python", "-c", "import mopidy"
  end

  plist_options :manual => "mopidy"

  def plist_name
    "homebrew.mopidy." + name
  end

  def plist; <<-EOS.undent
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
end
