cask "gb" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.5"
  sha256 arm:   "27161eaca168154a012f8111e2247cfb1a4c991a04a5c8ed8be57eb4f6aef970",
         intel: "958dfa0103923a500d79fbb1f35fb4ac7f3a3f6c0376c2da9ebc0eba2e81a3b7"

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
