cask "gb" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.7"
  sha256 arm:   "17ba022fb4fb005652cd4ffdf3a4a72cbb8e3baf55f0e206bd1befa4ccb5da42",
         intel: "b640e825f6242a5f5cc42bec405f39fbae1e20082e5a0d282952367ce0387711"

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
