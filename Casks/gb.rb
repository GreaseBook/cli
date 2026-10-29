cask "gb" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.0"
  sha256 arm:   "dfcbfd09f8ea970f9b52d36fb03fbaf75ea24f6007afac129b7ae0e2f7bc3e31",
         intel: "b2ac5052815ed833e76ba8cdc17b87a18030a8175f9579b5671bde958dab16a1"

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
