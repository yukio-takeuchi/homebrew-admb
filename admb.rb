#
class Admb < Formula
  desc "AD Model builder"
  homepage "http://admb-project.org"
  #url "https://github.com/admb-project/admb/releases/download/admb-12.1/admb-12.1-src.zip"
  #url "https://github.com/admb-project/admb/archive/admb-12.2pre.tar.gz"
  #url "https://github.com/admb-project/admb/archive/admb-12.2.tar.gz"
  #sha256 "a5541153ea55707c2a873eddc470906630aeded6d1f79c2a0a1617e8414928d0"
  #sha256 "56832c09f0e5155cba6f38cfcfa7acae24b825a994de59c9ae880becce92ab65"
  #sha256 "cd1338df213a98f4d5134c8b317a48571ccdda53bc9ac17e29a41682ba9f34fb"
  #url "https://github.com/admb-project/admb/archive/admb-12.3pre2.tar.gz"
  #sha256 "b89a616c6ad495ecf834a0b6ecf0f5118dfd4540ec8a86dcd94bf4513b3356b1"
  #version "12.3pre2"
  url "https://github.com/admb-project/admb/archive/admb-12.3.tar.gz"
  sha256 "b6b049221a311885b008a8f634b730eb5ca399381df4c1cc453dbbbe0925287d"
  #head "https://github.com/admb-project/admb.git" , :branch => "issue157" 
  head "https://github.com/admb-project/admb.git"
  # For testing use folked repo
  # head "https://github.com/yukio-takeuchi/admb.git"
  #revision 2     # update github repo to original one
  def install
    # $ clang --version | grep version | sed "s/.*version \([0-9]*\.[0-9]*\).*/\1/"
    # 11.0
    # $ clang  -dM -E -x c   /dev/null |grep clang_major | awk -F " " '{ print $NF }'
    # 11 
    # ENV.deparallelize   if your formula fails when building in parallel

    # separate make steps
    
    system "make", "--directory=src", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", "CXXFLAGS=-DUSE_PTR_INIT_PARAMS", "all"  # make c++-core
    system "make", "--directory=contrib",  "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", "CXXFLAGS=-DUSE_PTR_INIT_PARAMS","all" # make c++-contribs
    #system "make", "c++-dist"
    #system "make", "c++-shared"
    # Contentof  of make c++shared
    system "make", "--directory=src", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", "CXXFLAGS=-DUSE_PTR_INIT_PARAMS","SHARED=-shared", "shared"
    system "make", "--directory=contrib",  "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", "CXXFLAGS=-DUSE_PTR_INIT_PARAMS","SHARED=-shared","shared"
    #####
    system "make", "--directory=src", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", "CXXFLAGS=-DUSE_PTR_INIT_PARAMS","copy"
    #system "make", "clang++-all" 
    # system "cp -r build/dist/* #{prefix}"
    #system "make", "c++-install", "INSTALL_DIR=#{prefix}/"
    # For the time being manually put commands in "make insta;;"
    #system "make", "clang++-install"
    #  make --directory=src CC=cc CXX=c++ install
    system "echo $(pwd)"
    #system "cd","src"    
    #system "echo PWD is $(pwd)"
    system "find", "build/admb", "-type", "d", "-exec", "chmod", "755", "{}", "\;"
	  system "find", "build/admb", "-type", "f", "-exec", "chmod", "644", "{}", "\;"
    #system "chmod", "a+rx", "build/admb/bin/admb"
    #chmod "a+rx","build/admb/bin/admb"
    #system "chmod", "a+rx", "build/admb/bin/adlink"
    #chmod "a+rx", "build/admb/bin/adlink"
	  #system "chmod", "a+rx", "build/admb/bin/adcomp"
    #chmod "a+rx", "build/admb/bin/adcomp"
    #system "chmod", "a+rx", "build/admb/bin/tpl2cpp"
    #chmod "a+rx", "build/admb/bin/tpl2cpp"
	  #system "chmod", "a+rx", "build/admb/bin/tpl2rem"
    #system "chmod", "a+rx", "build/admb/contrib"
    #chmod "a+rx", %w(build/admb/bin/admb, \
    #  build/admb/bin/adlink, \
    #  build/admb/bin/adcomp, \
    #  build/admb/bin/tpl2cpp, \
    #  build/admb/bin/tpl2rem, \
    #  build/admb/contrib )
    #system "chmod　a+r　build/admb/bin/sed*"
    system "find", "build/admb", "-name", "sed*" , "-exec", "chmod", "a+r", "{}", "\;"
    #system "chmod　a+r　build/admb/include/*.*"
    system "find", "build/admb/include", "-name", "*.*" , "-exec", "chmod", "a+r", "{}", "\;"
    #system "chmod　a+r　build/admb/include/contrib/*.*"
    system "find", "build/admb/include/contrib", "-name", "*.*" , "-exec", "chmod", "a+r", "{}", "\;"
    #system "cp", "-Rvf", "../build/admb", "$(INSTALL_DIR)admb"
    #system "cp", "-Rvf", "build/admb/", "#{prefix}"
    system "cd build/admb && find -f . . -type d -exec install -v -d #{prefix}/{} \\;"
    system "cd build/admb && find -f . . -type f -exec install -v {}  #{prefix}/{} \\;"
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
    #system "make", "c++-test"
    system "make", "--directory=#{prefix}/tests", "all", "CXX=clang++"
  end
end
