cask "gb" do
  arch arm: "arm64", intel: "amd64"

  version "0.1.7"
  sha256 arm:   "2457784c1749ccbfea554a876a97cb419752fd1e3bc40d15a557fdb5b42e2c92",
         intel: "19fd54e0a62d2c28aa35c71238ac48e2251737f1562c84c64d9ea6bdc9334865"

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
