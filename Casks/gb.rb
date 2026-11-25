cask "gb" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.11"
  sha256 arm:   "1956f7adc32c9bc697d6cbb2df41468fe0c98cb38a00d8f0d2f32b04490c9c5a",
         intel: "b7c0ec0a0e300d09ef74ce2879cf6a50da0b50d078f047e0de70e03fc2cf955b"

  url "https://github.com/GreaseBook/cli/releases/download/v#{version}/gb_#{version}_darwin_#{arch}.tar.gz"
  name "GreaseBook CLI"
  desc "Read your GreaseBook data from the terminal"
  homepage "https://cli.greasebook.com"

  binary "gb"
  bash_completion "completions/gb.bash"
  zsh_completion "completions/_gb"
  fish_completion "completions/gb.fish"

  # Temporary until the binary is signed and notarized: without it Gatekeeper blocks the first run. Remove it then.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{staged_path}/gb"]
  end
end
