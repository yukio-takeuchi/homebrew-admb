#
class Admb < Formula
  desc "AD Model builder"
  homepage "http://admb-project.org"
  url "https://github.com/admb-project/admb/archive/refs/tags/admb-13.0.tar.gz"
  sha256 "d1e3f52baa7dee6c7d9eca2b3946c61e7f5468cf6c07307469162fc5a7acd310"
  #head "https://github.com/admb-project/admb.git" , :branch => "issue157" 
  head "https://github.com/admb-project/admb.git" 
  revision 4
  depends_on "flex"
  keg_only "cs.h conflicts with cs.h from suitesparse"
  license ""
  def install
    # $ clang --version | grep version | sed "s/.*version \([0-9]*\.[0-9]*\).*/\1/"
    # 11.0
    # $ clang  -dM -E -x c   /dev/null |grep clang_major | awk -F " " '{ print $NF }'
    # 11 
    # ENV.deparallelize   if your formula fails when building in parallel
    # separate make steps
    # 
    # clang++-all:
	  # $(MAKE) clang++-dist
	  # $(MAKE) clang++-shared
	  # $(MAKE) --directory=src CC=clang CXX=clang++ copy
    # clang++-shared:
	  # $(MAKE) --directory=src CC=clang CXX=clang++ SHARED=-shared shared
	  # $(MAKE) --directory=contrib CC=clang CXX=clang++ SHARED=-shared shared
    # $(MAKE) clang++-dist

    system "make", "#{ENV.cxx}-contribs"
    system "make", "#{ENV.cxx}-shared"
    system "make", "--directory=src", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", "copy"
    # clang++-shared:
    system "make", "--directory=src", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", "SHARED=-shared", "shared"
    system "make", "--directory=contrib", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", "SHARED=-shared", "shared"
    system "make", "--directory=src", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", "copy"
    # 
    #clang++-install:
	  # $(MAKE) --directory=src CC=clang CXX=clang++ install
    #system "make", "--directory=src", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", "install"
    #
    system "echo $(pwd)"
    system "find", "build/admb", "-type", "d", "-exec", "chmod", "-v", "755", "{}", "\;"
	  #system "find", "build/admb", "-type", "f", "-exec", "chmod", "644", "{}", "\;"
    system "echo $(pwd)"
    system "find", "build/admb", "-type", "f", "-exec", "chmod", "-v", "644", "{}", "\;"
    # cp -Rvf ../build/$(ADMB_VER) $(INSTALL_DIR)
    system "echo $(pwd)"
    # system ":chdir", "build/admb", "find",  ".", "-type", "d", "-exec", "install", "-v", "-d", "#{prefix}/{}", "\\;"
    #spawn "find . -type d -exec install -v -d #{prefix}/{} \\; " , :chdir=>"build/admb"
    #Dir.chdir "build/admb" do
    #  system "find . -type d -exec install -v -d #{prefix}/{} \\; "
    #  system "find . -type f -exec install -vC {} #{prefix}/{} \\; "
    #end
    bin.install Dir["build/admb/bin/*"]
    lib.install Dir["build/admb/lib/*"]
    include.install Dir["build/admb/include/*"]
    prefix.install  Dir["build/admb/contrib"]
    prefix.install Dir["build/admb/examples"]
    prefix.install Dir["build/admb/scripts"]
    prefix.install Dir["build/admb/src"]
    prefix.install Dir["build/admb/tests"]
    prefix.install Dir["build/admb/utilities"]
    prefix.install "Makefile" 
    prefix.install Dir["*.txt"]
    prefix.install Dir["*.md"]
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
    #system "make", "#{ENV.cxx}-test"
    system "make", "--directory=#{prefix}/tests", "all", "CXX=#{ENV.cxx}"
    Dir.chdir "#{prefix}" do
      system "make", test
    end 
  end
end
