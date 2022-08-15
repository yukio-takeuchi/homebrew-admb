class Admb < Formula
  desc "AD Model builder"
  homepage "http://admb-project.org"
  url "https://github.com/admb-project/admb/archive/refs/tags/admb-13.0.tar.gz"
  sha256 "d1e3f52baa7dee6c7d9eca2b3946c61e7f5468cf6c07307469162fc5a7acd310"
  license "BSD-3-Clause"
  revision 5
  head "https://github.com/admb-project/admb.git"
  keg_only "cs.h conflicts with cs.h from suitesparse"
  depends_on "flex"
  def install
    # $ clang --version | grep version | sed "s/.*version \([0-9]*\.[0-9]*\).*/\1/"
    # 11.0
    # $ clang  -dM -E -x c   /dev/null |grep clang_major | awk -F " " '{ print $NF }'
    # 11
    #
    # clang++-all:
    # $(MAKE) clang++-dist
    # $(MAKE) clang++-shared
    # $(MAKE) --directory=src CC=clang CXX=clang++ copy
    # clang++-shared:
    # $(MAKE) --directory=src CC=clang CXX=clang++ SHARED=-shared shared
    # $(MAKE) --directory=contrib CC=clang CXX=clang++ SHARED=-shared shared
    # $(MAKE) clang++-dist
    ###############
    # clang
    # clang++: clang++-all
    # clang++-all:
	  # $(MAKE) clang++-dist
	  # $(MAKE) clang++-shared
	  # $(MAKE) --directory=src CC=clang CXX=clang++ copy
    # clang++-dist:
	  # $(MAKE) clang++-contribs
    # clang++-debug:
	  # $(MAKE) clang++-all DEBUG=yes
    # clang++-core:
	  # $(MAKE) --directory=src CC=clang CXX=clang++ all
    # clang++-contribs: clang++-core
	  # $(MAKE) --directory=contrib CC=clang CXX=clang++ all
    # clang++-docs:
	  # $(MAKE) --directory=docs CC=clang CXX=clang++ all
    # clang++-gtests:
	  # $(MAKE) --directory=tests CC=clang CXX=clang++ unit-gtests
    # clang++-coverage:
	  # $(MAKE) --directory=src CC=clang CXX=clang++ SAFE_ONLY=yes dist
	  # $(MAKE) --directory=tests CC=clang CXX=clang++ coverage
    # clang++-verify:
	  # $(MAKE) --directory=tests CC=clang CXX=clang++ verify
    # clang++-shared:
	  # $(MAKE) --directory=src CC=clang CXX=clang++ SHARED=-shared shared
	  # $(MAKE) --directory=contrib CC=clang CXX=clang++ SHARED=-shared shared
    ######## clang++-all:
    system "make", "#{ENV.cxx}-contribs"
    system "make", "#{ENV.cxx}-shared"
    system "make", "--directory=src", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", "copy"
    ######## clang++-debug:
    ######## clang++-all DEBUG=yes 
    system "make", "#{ENV.cxx}-debug"
    system "find", "build/admb", "-type", "d", "-exec", "chmod", "-v", "755", "{}", "\;"
    system "find", "build/admb", "-type", "f", "-exec", "chmod", "-v", "644", "{}", "\;"
    # install
    # Use custom commands
    bin.install Dir["build/admb/bin/*"]
    lib.install Dir["build/admb/lib/*"]
    include.install Dir["build/admb/include/*"]
    prefix.install "build/admb/contrib"
    prefix.install "build/admb/examples"
    prefix.install "build/admb/scripts"
    prefix.install "build/admb/src"
    prefix.install "build/admb/tests"
    prefix.install "build/admb/utilities"
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
    system "false"
    # system "make", "#{ENV.cxx}-test"
    # system "make", "--directory=#{prefix}/tests", "all", "CXX=#{ENV.cxx}"
    # Dir.chdir "#{prefix}" do
    #  system "make", test
    # end
  end
end
