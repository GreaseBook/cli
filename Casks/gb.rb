cask "gb" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.2"
  sha256 arm:   "e0febce6b2d1a9db27bc7d238862f309f11750f1c1dc7f89496933ea15303b6c",
         intel: "5eab2ee29d2f5ae058285e467684e7d0c91a95602c4278ca8ed243f1a0bba2c0"

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
