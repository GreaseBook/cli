<p align="center">
  <img src="https://www.greasebook.com/assets/images/greasebook-logo.svg" alt="GreaseBook" width="260">
</p>

# gb — the GreaseBook CLI

Read your GreaseBook data from a terminal, a script, or an AI assistant such as Claude Code, with exactly the
permissions you have on the GreaseBook site. Build your own reports and dashboards on top of it.

- **Read-only.** `gb` never changes anything in GreaseBook.
- **Your permissions, nothing more.** Execs see their whole company, pumpers see the facilities assigned to them.
- **Made for scripts and AI.** Every command prints a table, JSON or CSV.

Latest version: **0.1.3** · [All releases](https://github.com/GreaseBook/cli/releases)

## Contents

- [Install](#install): [macOS](#macos) · [Windows](#windows) · [Linux](#linux)
- [Sign in](#sign-in)
- [Commands](#commands)
- [Data for reports and dashboards](#data-for-reports-and-dashboards)
- [Output formats](#output-formats)
- [Using gb with Claude Code and other AI assistants](#using-gb-with-claude-code-and-other-ai-assistants)
- [Limits](#limits)
- [Security](#security)
- [Update and uninstall](#update-and-uninstall)
- [Troubleshooting](#troubleshooting)

## Install

### macOS

With [Homebrew](https://brew.sh):

```bash
brew tap greasebook/cli https://github.com/GreaseBook/cli
brew trust greasebook/cli
brew install --cask gb
gb --version
```

`brew trust` is required by Homebrew 7 for any tap outside Homebrew's own ([Tap Trust](https://docs.brew.sh/Tap-Trust)).
Installed `gb` 0.1.0 as a formula? Switch with `brew uninstall gb && brew update && brew install --cask gb`.

### Windows

1. Download **`gb_0.1.3_windows_amd64.msi`** from the [latest release](https://github.com/GreaseBook/cli/releases/latest).
2. Double-click it. If Windows SmartScreen says it protected your PC, choose **More info**, then **Run anyway**.
3. Follow the installer. It installs to `C:\Program Files\GreaseBook CLI` and adds that folder to your `PATH`.
4. Open a **new** PowerShell, Windows Terminal or Command Prompt window (windows that were already open do not see the
   new `PATH`) and check it:

```powershell
gb --version
```

**Windows on ARM:** download `gb_0.1.3_windows_arm64.zip`, extract `gb.exe` to a folder such as
`%LOCALAPPDATA%\Programs\gb`, and add that folder to your user `PATH` (**Settings > System > About > Advanced system
settings > Environment Variables**).

### Linux

```bash
# x86_64; use linux_arm64 on ARM
curl -fsSLO https://github.com/GreaseBook/cli/releases/latest/download/gb_0.1.3_linux_amd64.tar.gz
tar -xzf gb_0.1.3_linux_amd64.tar.gz gb
sudo install -m 0755 gb /usr/local/bin/gb
gb --version
```

### Check a download

Every release has a `checksums.txt`. Compare it with the file you downloaded:

```bash
shasum -a 256 gb_0.1.3_linux_amd64.tar.gz       # macOS and Linux
```

```powershell
Get-FileHash .\gb_0.1.3_windows_amd64.msi -Algorithm SHA256   # Windows
```

## Sign in

Your company must have the CLI turned on. If you do not see **Personal tokens** in GreaseBook, ask GreaseBook support.

1. Sign in to GreaseBook in your browser.
2. Open your name menu (top right) and choose **Personal tokens**.
3. Choose **Create token** and copy it. It is shown only once.
4. In your terminal, run `gb login` and paste the token. What you type is hidden.

```bash
gb login
gb whoami
```

You stay signed in until you sign out or the token ends (see [Security](#security)).

## Commands

| Command | What it does |
|---|---|
| `gb login` | Signs in with a personal token. Also reads the token from stdin: `gb login < token.txt`. |
| `gb whoami` | Shows your user, role and company. |
| `gb datasets` | Lists the data you can read; `gb datasets <name>` shows its columns and units. |
| `gb data <name>` | Reads a dataset; see [Data for reports and dashboards](#data-for-reports-and-dashboards). |
| `gb facilities` | Lists the facilities you can see. `--active` keeps only active ones. |
| `gb logout` | Ends your token on every computer and removes it from this one. |
| `gb --help` | Help for every command; `gb <command> --help` for one. |
| `gb --version` | The installed version. |

Options that work on every command:

| Option | What it does |
|---|---|
| `--format table\|json\|csv` | Output format. `table` is the default. |
| `--company <id>` | GreaseBook staff only: read another company. |

## Data for reports and dashboards

`gb data` returns plain tables you can load into Excel, Power BI, a database or an AI assistant: one row per fact,
the same columns every time, and units in the column names (`oilBbl`, `gasMcf`). Each row matches what the
GreaseBook site shows.

| Dataset | One row per | What is in it |
|---|---|---|
| `facilities` | facility | id, name, identifier, type, active, state, county |
| `wells` | well | id, name, API number, facility, county, field, active |
| `production` | facility per day | oil, gas and water produced, oil sold, oil in stock |
| `well-production` | well per day | the same production, per well |
| `water` | facility per day | water produced, hauled, disposed, injected, transferred, from source wells, in stock |

```bash
gb datasets production                                                   # columns and units
gb data wells --format csv > wells.csv
gb data production --start 2026-09-01 --end 2026-09-30 --format csv > production.csv
gb data well-production --start 2026-09-01 --end 2026-09-30 --facility 412 --format csv > wells-production.csv
gb data water --start 2026-09-01 --end 2026-09-30 --facility 412 --facility 413
```

- `production`, `well-production` and `water` need `--start` and `--end` (yyyy-mm-dd), **at most 92 days** per
  request, and allow **one request per minute** each. Leave out `--facility` to get every facility you can see in that
  one request; `well-production` reads at most 20 facilities per request, so pick them with `--facility`.
- Past days can still change: the field corrects readings and enters late data, so refresh the period you report on.
- A collection point's rows already include the facilities assigned to it; filter on `facilityType` so you do not
  count them twice.
- Need a longer period? Ask for it in 92-day pieces, one per minute.

## Output formats

```bash
gb facilities                 # aligned table, for reading
gb facilities --format json   # for scripts and AI assistants
gb facilities --format csv > facilities.csv   # for Excel and Google Sheets
```

Results go to stdout and errors to stderr, so you can pipe and redirect safely.

Exit codes, for scripts:

| Code | Meaning |
|---|---|
| `0` | Success |
| `1` | Anything else (bad input, server error, too many requests) |
| `3` | Not signed in, or your token is no longer valid: run `gb login` |
| `4` | Your user is not allowed to see this |
| `5` | Not found |

## Using gb with Claude Code and other AI assistants

Install `gb`, sign in once, then ask in plain words:

> Using the `gb` command, list my active facilities and build a CSV with their names and counties.

Tips for good results:

- Tell the assistant to use `--format json`: it reads JSON more reliably than a table.
- Run `gb --help` in the conversation first so it learns the commands.
- The assistant sees only what you can see in GreaseBook; it uses your token.

## Limits

To keep GreaseBook fast for everyone, requests are rate-limited per computer and per token. If you go over, `gb`
prints `too many requests (429)`; wait a few seconds and try again.

## Security

- **Your token is a password.** It is saved in `~/.greasebook/credentials.json` (`%USERPROFILE%\.greasebook` on
  Windows), readable only by you. Set `GB_CREDENTIALS` to keep it somewhere else. Never paste it into a shared chat,
  a ticket or a repository.
- **It does not expire, but it ends when** you choose **Renew** under **Personal tokens**, run `gb logout`, or change
  your password, or when your user is disabled or your company's access changes.
- **Lost a computer or leaked a token?** Choose **Renew** under **Personal tokens**: the old token stops working
  everywhere at once.
- `gb` only talks to GreaseBook over HTTPS and never follows redirects, so your token goes nowhere else.

## Update and uninstall

| | Update | Uninstall |
|---|---|---|
| macOS | `brew update && brew upgrade --cask gb` | `brew uninstall --cask gb` |
| Windows | Run the newer `.msi`; it replaces the old version | **Settings > Apps > Installed apps > GreaseBook CLI > Uninstall** |
| Linux | Repeat the [install](#linux) steps | `sudo rm /usr/local/bin/gb` |

To also remove your saved token, run `gb logout` before uninstalling.

## Troubleshooting

| Problem | Fix |
|---|---|
| `gb: command not found` (Windows: `'gb' is not recognized`) | Open a new terminal window. On Windows, check that `C:\Program Files\GreaseBook CLI` is in your `PATH`. |
| `session rejected (401): run gb login` | Your token ended. Create a new one under **Personal tokens** and run `gb login`. |
| `that is not a personal token` | You pasted something else. Copy the token again from **Personal tokens**; it starts with `gbcli_`. |
| `forbidden (403)` | Your user cannot see that data in GreaseBook either. |
| `too many requests (429)` | Wait the time it says and run it again; `production` and `water` allow one request per minute. |
| `The range can be at most 92 days` | Split the period into pieces of 92 days or less. |
| No **Personal tokens** in your name menu | Your company does not have the CLI turned on yet; ask GreaseBook support. |
| macOS: "gb cannot be opened because the developer cannot be verified" | Reinstall with `brew reinstall --cask gb`. |
