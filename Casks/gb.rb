cask "gb" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.3"
  sha256 arm:   "290ed9bb9f79c9a4e81a71e44ffeac3e53e6d97e3c394751df85337a4cf0a1eb",
         intel: "903c90bd72883829365716f4ab1fef9dbdc67c762524504433e0eb4baa465e16"

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
