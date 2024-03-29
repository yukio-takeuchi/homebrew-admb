class Admb < Formula
  desc "AD Model builder"
  homepage "http://admb-project.org"
  url "https://github.com/admb-project/admb/archive/refs/tags/admb-13.0.tar.gz"
  sha256 "d1e3f52baa7dee6c7d9eca2b3946c61e7f5468cf6c07307469162fc5a7acd310"
  license "BSD-3-Clause"
  revision 7
  head "https://github.com/admb-project/admb.git", branch: "dev-13.1"
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
    if OS.mac?
      system "make", "#{ENV.cxx}-contribs"
      system "make", "#{ENV.cxx}-shared"
      system "make", "--directory=src", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", "copy"
      ######## clang++-debug:
      ######## clang++-all DEBUG=yes
      system "make", "#{ENV.cxx}-debug"
      system "find", "build/admb", "-type", "d", "-exec", "chmod", "-v", "755", "{}", "\;"
      system "find", "build/admb", "-type", "f", "-exec", "chmod", "-v", "644", "{}", "\;"
    end

    # src/GNUmakefile
    # all: dist
    # dist: libs
    #
    # g++: g++-all
    # g++-all:
    # $(MAKE) g++-dist
    # $(MAKE) g++-shared
    # $(MAKE) --directory=src CC=gcc CXX=g++ copy
    # g++-dist:
    # $(MAKE) g++-core
    # $(MAKE) g++-contribs
    # g++-debug:
    # $(MAKE) g++-all DEBUG=yes
    # g++-core:
    # $(MAKE) --directory=src CC=gcc CXX=g++ all
    # g++-contribs: g++-core
    # $(MAKE) --directory=contrib CC=gcc CXX=g++ all
    # g++-docs:
    # $(MAKE) --directory=docs CC=gcc CXX=g++ all
    # g++-gtests:
    # $(MAKE) --directory=tests CC=gcc CXX=g++ unit-gtests
    # g++-coverage:
    # $(MAKE) --directory=src CC=gcc CXX=g++ SAFE_ONLY=yes dist
    # $(MAKE) --directory=tests CC=gcc CXX=g++ coverage
    # g++-verify:
    # $(MAKE) --directory=tests CC=gcc CXX=g++ verify
    # g++-shared:
    # $(MAKE) --directory=src CC=gcc CXX=g++ SHARED=-shared shared
    # $(MAKE) --directory=contrib CC=gcc CXX=g++ SHARED=-shared shared
    # g++-install:
    # $(MAKE) --directory=src CC=gcc CXX=g++ install
    # g++-check:
    # $(MAKE) --directory=src CC=gcc CXX=g++ check
    # g++-clean:
    # $(MAKE) --directory=src CC=gcc CXX=g++ clean
    # $(MAKE) --directory=contrib CC=gcc CXX=g++ clean
    # $(MAKE) --directory=scripts CC=gcc CXX=g++ clean
    # $(MAKE) --directory=tests CC=gcc CXX=g++ clean
    # $(MAKE) --directory=examples CC=gcc CXX=g++ clean
    # g++-zip:
    # $(MAKE) --directory=src CC=gcc CXX=g++ zip
    if OS.linux?
      # g++-all:
      # $(MAKE) g++-dist
      # $(MAKE) g++-shared
      # $(MAKE) --directory=src CC=gcc CXX=g++ copy
      # g++-dist:
      # $(MAKE) g++-core
      # $(MAKE) g++-contribs
      # g++-core:
      #ENV["ADCXXFLAGS"] = \
      #"-D_USE_MATH_DEFINES -fPIC  -O3 -std=c++17 -I../build/admb/include -Wall -Wextra -Wconversion -Wno-unused-parameter"
      #ENV["CXXFLAGS_SAF_LIB"]=" $(USER_CXXFLAGS) $(ADCXXFLAGS))
      #ENV["CXXFLAGS_OPT_LIB"]=\
      #"-Wextra -D_USE_MATH_DEFINES,-DOPT_LIB -D_USE_MATH_DEFINES, #{ENV['CXXFLAGS_SAF_LIB']}"
      #ENV["CXXFLAGS"]="-fPIC  -O3 -std=c++17 -I../build/admb/include -Wall -Wextra -Wconversion -Wno-unused-parameter"
      #system "make", "--directory=src", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", "all", \
      #"ADCXXFLAGS= -fPIC  -O3 -std=c++17 -I../build/admb/include"
      #system "make", "--directory=src", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", "all", \
      #"ADCXXFLAGS= #{ENV['ADCXXFLAGS']}"
      #system "make", "--directory=src", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", "all", \
      #"CXXFLAGS= #{ENV['CXXFLAGS']}"

      # g++-contribs: g++-core
      #system "make", "--directory=contrib", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", "all", \
      #"CXXFLAGS= #{ENV['CXXFLAGS']}"
      # g++-shared:
      #system "make", "--directory=src", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", \
      #"SHARED=-shared", "shared", "CXXFLAGS= #{ENV['CXXFLAGS']}"
      #system "make", "--directory=contrib", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", \
      #"SHARED=-shared", "shared", "CXXFLAGS= #{ENV['CXXFLAGS']}"
      # $(MAKE) --directory=src CC=gcc CXX=g++ copy
      #system "make", "--directory=src", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", "copy"
      # DEBUG build
      #ENV["ADCXXFLAGS"] = \
      #"-g -D_USE_MATH_DEFINES -fPIC  -O3 -std=c++17 -I../build/admb/include -Wall -Wextra -Wconversion -Wno-unused-parameter -DDEBUG"
      #ENV["CXXFLAGS"]="-g -fPIC  -O3 -std=c++17 -I../build/admb/include -Wall -Wextra -Wconversion -Wno-unused-parameter -DDEBUG"
      # g++-core:
      #system "make", "--directory=src", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", "all", \
      #"DEBUG=yes", "CXXFLAGS= #{ENV['CXXFLAGS']}"
      # g++-contribs: g++-core
      #system "make", "--directory=contrib", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", \
      #"all", "DEBUG=yes", "CXXFLAGS= #{ENV['CXXFLAGS']}"
      # g++-shared:
      #system "make", "--directory=src", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", \
      # "SHARED=-shared", "shared", "DEBUG=yes", "CXXFLAGS= #{ENV['CXXFLAGS']}"
      #system "make", "--directory=contrib", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", \
      #"SHARED=-shared", "shared", "DEBUG=yes", "CXXFLAGS= #{ENV['CXXFLAGS']}"
      # $(MAKE) --directory=src CC=gcc CXX=g++ copy
      #system "make", "--directory=src", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", "copy"
      ######
      system "make", "#{ENV.cxx}-contribs"
      system "make", "#{ENV.cxx}-shared"
      system "make", "--directory=src", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}", "copy"
      ######## clang++-debug:
      ######## clang++-all DEBUG=yes
      system "make", "#{ENV.cxx}-debug"
      system "find", "build/admb", "-type", "d", "-exec", "chmod", "-v", "755", "{}", "\;"
      system "find", "build/admb", "-type", "f", "-exec", "chmod", "-v", "644", "{}", "\;"
    end

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
