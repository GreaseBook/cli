cask "gb" do
  arch arm: "arm64", intel: "amd64"

  version "0.1.1"
  sha256 arm:   "40c61cf5ff41d5335a5ec91b353b0167608acc76176751d2cfa7519bbc059621",
         intel: "3cb22060239c113756f09392f87584b0992c4d1bac4cc668e2d6afde0e42bfed"

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
