# macOS Dotfiles Bootstrap

A modular macOS bootstrap repo for Homebrew, Oh My Zsh, Git (work/personal split + GPG), and Node via nvm.

## Highlights
- Homebrew installs most tools via `Brewfile`
- Oh My Zsh with `zsh-syntax-highlighting` and `zsh-autosuggestions`
- Git configs split by directory (work vs personal)
- GPG initialization for signed commits
- Node via nvm + global packages (yarn, pnpm)

## Quick Start
1. Clone this repo (recommended path: `~/.dotfiles`).
2. Put your Oh My Zsh template at `templates/omz/.zshrc` or set `OMZ_TEMPLATE`.
3. Run:

```bash
./install.sh
```

## Directory Layout
- `install.sh`: entry script that runs each module in order
- `modules/`: setup steps with clear console separators
- `utils/`: shared shell helpers
- `snippets/`: zsh snippets appended to your `.zshrc`
- `templates/`: your Oh My Zsh template file
- `gitconfig/`: base/work/personal git configs

## Configuration Notes
### Oh My Zsh Template
- Default template path: `templates/omz/.zshrc`
- Override via environment variable:

```bash
OMZ_TEMPLATE=/path/to/your/.zshrc ./install.sh
```

### Git Work/Personal Split
The base config is installed at `~/.config/git/config` and includes:
- `~/.gitconfig-work` for work repos
- `~/.gitconfig-personal` for personal/open-source repos

Defaults:
- Work dir: `~/work/`
- Personal dir: `~/code/`

Override with env vars:

```bash
GIT_WORK_DIR=~/company/ GIT_PERSONAL_DIR=~/oss/ ./install.sh
```

Update `user.name` and `user.email` in:
- `~/.config/git/config`
- `~/.gitconfig-work`
- `~/.gitconfig-personal`

### GPG Signing
The GPG module will:
- Install/configure GPG (requires Homebrew `gnupg`)
- Offer to generate a key
- Ask for a key ID to configure git signing

### Node via nvm
The Node module will:
- Install latest Node (`nvm install node`)
- Set the default alias
- Install `yarn` and `pnpm` globally

## Modules Order
1. `00-prereq.sh` (Xcode tools + Homebrew)
2. `10-brew.sh` (Brewfile packages)
3. `20-omz.sh` (Oh My Zsh)
4. `30-zshrc.sh` (template + snippets)
5. `40-git.sh` (work/personal configs)
6. `50-gpg.sh` (GPG key + git signing)
7. `60-nvm-node.sh` (Node + global packages)

## Notes
- Uses Homebrew wherever possible.
- Designed for macOS only.
- Each module prints a clear separator in the console.
