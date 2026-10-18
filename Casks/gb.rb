cask "gb" do
  arch arm: "arm64", intel: "amd64"

  version "0.1.3"
  sha256 arm:   "d7a08fedddac962aa26058dd47f27ff43d41cbb24fa3acf659315aa5ed06b012",
         intel: "2e8b91004737e36759a74b7f5ef29f1c0097655f804635defe14a697b0782da4"

  url "https://github.com/GreaseBook/cli/releases/download/v#{version}/gb_#{version}_darwin_#{arch}.tar.gz"
  name "GreaseBook CLI"
  desc "Read your GreaseBook data from the terminal"
  homepage "https://github.com/GreaseBook/cli"

  binary "gb"

  # Temporary until the binary is signed and notarized: without it Gatekeeper blocks the first run. Remove it then.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{staged_path}/gb"]
  end
end
