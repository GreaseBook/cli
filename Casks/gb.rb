cask "gb" do
  arch arm: "arm64", intel: "amd64"

  version "0.1.2"
  sha256 arm:   "47d70b80805ea3b9a771790cf36e6d8be5791fcfdd8bbe1c73e278e90b656fa8",
         intel: "bd96947a0392acfc7068e08136ae1b81b36dc7701d9d14263b7a57d82be31c52"

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
