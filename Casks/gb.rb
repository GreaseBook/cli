cask "gb" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.6"
  sha256 arm:   "a2158df4489ec165914feda8d362b264423516c169909943fe40a792a8944128",
         intel: "66e9377998d1a778349faf79fb60680e089cbcd75103ba16e51fcd47d1c27fc1"

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
