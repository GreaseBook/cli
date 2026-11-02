cask "gb" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.1"
  sha256 arm:   "e115cffbf0cd3ba63fcd3bf8dfbdb8ad312d4056ba2217028ba086433a5f2cca",
         intel: "e7b8f45d0d4add8dfd4ed1250eb44695bc48e0a70c3e639eeaef0b6bd36385fd"

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
