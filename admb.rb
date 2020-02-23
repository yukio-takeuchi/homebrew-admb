# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/homebrew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Admb < Formula
  desc "AD Model builder"
  homepage "http://admb-project.org"
  url "https://github.com/admb-project/admb/releases/download/admb-12.1/admb-12.1-src.zip"
  sha256 "a5541153ea55707c2a873eddc470906630aeded6d1f79c2a0a1617e8414928d0"
  # head "https://github.com/admb-project/admb.git"
  # For testing use foled repo
  head "https://github.com/yukio-takeuchi/admb.git"

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
    #system "make", "c++-all"  #,"-j4" # if this fails, try separate make/make install steps
    # separate make steps
    
    system "make", "--directory=src", "CC=cc", "CXX=c++", "all"  # make c++-core
    system "make", "--directory=contrib", "-j1", "CC=cc", "CXX=c++", "all" # make c++-contribs
    #system "make", "c++-dist"
    #system "make", "c++-shared"
    # Contentof  of make c++shared
    #system "make", "--directory=src", "CC=cc", "CXX=c++", "SHARED=-shared", "shared"
    #system "make", "--directory=contrib", "-j1", "CC=cc", "CXX=c++", "SHARED=-shared","shared"
    #####
    system "make", "--directory=src", "CC=cc", "CXX=c++", "copy"
    #system "make", "clang++-all" # if this fails, try separate make/make install steps
    # system "cp -r build/dist/* #{prefix}"
    #system "make", "c++-install", "INSTALL_DIR=#{prefix}/"
    # For the time being manually put commands in "make insta;;"
    #system "make", "clang++-install"
    #  make --directory=src CC=cc CXX=c++ install
    system "echo $(pwd)"
    #system "cd","src"    
    #system "echo $(pwd)"
    system "find", "build/admb", "-type", "d", "-exec", "chmod", "755", "{}", "\;"
	  system "find", "build/admb", "-type", "f", "-exec", "chmod", "644", "{}", "\;"
    system "chmod", "a+rx", "build/admb/bin/admb"
	  system "chmod", "a+rx", "build/admb/bin/adlink"
	  system "chmod", "a+rx", "build/admb/bin/adcomp"
	  system "chmod", "a+rx", "build/admb/bin/tpl2cpp"
	  system "chmod", "a+rx", "build/admb/bin/tpl2rem"
	  system "chmod", "a+rx", "build/admb/contrib"
    #system "chmod　a+r　build/admb/bin/sed*"
    system "find", "build/admb", "-name", "sed*" , "-exec", "chmod", "a+r", "{}", "\;"
    #system "chmod　a+r　build/admb/include/*.*"
    system "find", "build/admb/include", "-name", "*.*" , "-exec", "chmod", "a+r", "{}", "\;"
    #system "chmod　a+r　build/admb/include/contrib/*.*"
    system "find", "build/admb/include/contrib", "-name", "*.*" , "-exec", "chmod", "a+r", "{}", "\;"
    system "echo $(pwd)"
    #system "cd","src"
    #system "echo $(pwd)"
    #system "cp", "-Rvf", "../build/admb", "$(INSTALL_DIR)admb"
    system "echo PREFIX is"
    system "echo","#{prefix}"
    #system "cp", "-Rvf", "build/admb/", "#{prefix}"
    #system "install build/admb/* #{prefix}"
    system "cd build/admb && find -f . . -type d -exec install -v -d #{prefix}/{} \\;"
    system "cd build/admb && find -f . . -type f -exec install -v {}  #{prefix}/{} \\;"
    #system "cd build/admb && find -f . . -type f -print0 -exec cp -Rvf {} #{prefix}/ \\;" 
    #system "ls build/admb/ | cp -Rvf #{prefix}"
    #system "ln", "-svf", "$(INSTALL_DIR)admb/bin/admb", "$(INSTALL_DIR)bin/admb"
    #system "ln", "-svf", "$(INSTALL_DIR)bin/admb", "$(INSTALL_DIR)bin/admb"
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
    system "make", "c++-test"
  end
end
