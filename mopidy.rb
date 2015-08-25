class Mopidy < Formula
  homepage 'http://www.mopidy.com/'
  url 'https://pypi.python.org/packages/source/M/Mopidy/Mopidy-1.1.0.tar.gz'
  sha1 '2c8b8dbe6b291aa77598fbc095641012af296979'
  head 'https://github.com/mopidy/mopidy.git'

  depends_on :python
  depends_on 'homebrew/versions/gst-plugins-base010' => [
    'with-libogg',
    'with-libvorbis',
    'with-theora',
  ]
  depends_on 'homebrew/versions/gst-plugins-good010' => [
    'with-flac',
    'with-jpeg',
    'with-libshout',
    'with-libsoup',
    'with-speex',
    'with-taglib',
  ]
  depends_on 'homebrew/versions/gst-plugins-bad010' => [
    'with-faad2',
    'with-libmms',
    'with-libsndfile',
  ]
  depends_on 'homebrew/versions/gst-plugins-ugly010' => [
    'with-flac',
    'with-lame',
    'with-libmms',
    'with-libvorbis',
    'with-mad',
    'with-theora',
    'with-two-lame',
  ]
  depends_on 'homebrew/versions/gst-python010'
  depends_on 'mopidy/mopidy/pykka'
  depends_on 'mopidy/mopidy/python-tornado'
  depends_on 'mopidy/mopidy/requests'

  def install
    system "python", *Language::Python.setup_install_args(prefix)
  end

  def test
    system "python", "-c", "import mopidy"
  end

  plist_options :manual => 'mopidy'

  def plist_name
    'homebrew.mopidy.' + name
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
