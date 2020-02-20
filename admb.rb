# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/homebrew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Admb < Formula
  desc "AD Model builder"
  homepage "http://admb-project.org"
  url "https://github.com/admb-project/admb/releases/download/admb-12.1/admb-12.1-src.zip"
  sha256 "a5541153ea55707c2a873eddc470906630aeded6d1f79c2a0a1617e8414928d0"
  head "https://github.com/admb-project/admb.git"

  # depends_on "cmake" => :build
  # depends_on :x11 # if your formula requires any X11/XQuartz components

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    # Remove unrecognized options if warned by configure
    #system "./configure", "--disable-debug",
    #                      "--disable-dependency-tracking",
    #                      "--disable-silent-rules",
    #                      "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
    system "make", "c++-all" # if this fails, try separate make/make install steps
    #system "make", "clang++-all" # if this fails, try separate make/make install steps
    # system "cp -r build/dist/* #{prefix}"
    system "make", "c++-install"
    #system "make", "clang++-install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test admb`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    #system "false"
    system "make", "clang++-test"
  end
end
