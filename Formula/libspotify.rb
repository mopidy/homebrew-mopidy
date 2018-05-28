class Libspotify < Formula
  desc "C interface to Spotify"
  homepage "https://mopidy.github.io/libspotify-archive/"
  url "https://mopidy.github.io/libspotify-archive/libspotify-12.1.51-Darwin-universal.zip"
  sha256 "80053f0779f6192a8052732904d88b91acc62a350831f6b585a3c6ac10cb8fbd"

  def install
    (include+"libspotify").install "libspotify.framework/Versions/12.1.51/Headers/api.h"
    lib.install "libspotify.framework/Versions/12.1.51/libspotify" => "libspotify.12.1.51.dylib"
    doc.install Dir["docs/*"]
    doc.install %w[ChangeLog README LICENSE licenses.xhtml examples]
    man3.install Dir["man3/*"]
    lib.install_symlink "libspotify.12.1.51.dylib" => "libspotify.dylib"
    lib.install_symlink "libspotify.12.1.51.dylib" => "libspotify.12.dylib"
    (lib+"pkgconfig/libspotify.pc").write pc_file

    # XXX See https://github.com/mopidy/pyspotify/issues/130
    lib.install_symlink "libspotify.12.1.51.dylib" => "libspotify"
  end

  def pc_file; <<~EOS
    prefix=#{opt_prefix}
    exec_prefix=${prefix}
    libdir=${exec_prefix}/lib
    includedir=${prefix}/include

    Name: libspotify
    Description: Spotify client library
    Version: #{version}
    Libs: -L${libdir} -lspotify
    Cflags: -I${includedir}
    EOS
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <string.h>
      #include <libspotify/api.h>

      int main()
      {
        return strcmp(sp_error_message(SP_ERROR_OK), "No error");
      }
    EOS
    system ENV.cc, "test.c", "-lspotify", "-o", "test"
    system "./test"
  end
end
