class Gb < Formula
  desc "GreaseBook CLI: read your GreaseBook data from the terminal"
  homepage "https://github.com/GreaseBook/cli"
  version "0.1.0"

  on_macos do
    on_arm do
      url "https://github.com/GreaseBook/cli/releases/download/v0.1.0/gb_0.1.0_darwin_arm64.tar.gz"
      sha256 "28df329203eae2760da7569f22f161a2d81b08fe2e279a84168763dc4ffbfd27"
    end
    on_intel do
      url "https://github.com/GreaseBook/cli/releases/download/v0.1.0/gb_0.1.0_darwin_amd64.tar.gz"
      sha256 "e905fc72bfa90f225a5d09afa99a1fb640d565d8a9a75837a9a16e7b702a1afb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/GreaseBook/cli/releases/download/v0.1.0/gb_0.1.0_linux_arm64.tar.gz"
      sha256 "6e648798b9fc7edff408144bd394b7c6614f5273e5d51b10aa2642430f49e1d1"
    end
    on_intel do
      url "https://github.com/GreaseBook/cli/releases/download/v0.1.0/gb_0.1.0_linux_amd64.tar.gz"
      sha256 "24d503febe9820d4bbd006e6179fdc27956d07e5059eecdbb813d9da76856487"
    end
  end

  def install
    bin.install "gb"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gb --version")
  end
end
