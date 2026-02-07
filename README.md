# dotfiles

Modular macOS bootstrap dotfiles for Homebrew, Oh My Zsh, Zsh config, and Git work/personal split.

## Highlights

- Homebrew installs core tools via `modules/brew/brewfile`
- Oh My Zsh + common plugins
- Git configs split by directory (work vs personal) with automatic includeIf
- Work git `user.name` and `user.email` are prompted on first install

## Quick Start

1. Clone this repo (recommended path: `~/.dotfiles`).
2. Put your Oh My Zsh template at `templates/.zshrc` or set `OMZ_TEMPLATE`.
3. Run:

```bash
./install.sh
```

## Directory Layout

- `install.sh`: entry script that runs each module in order
- `modules/`: setup steps with clear console separators
- `utils/`: shared shell helpers
- `templates/`: templates for Zsh, Git, and Rime
- `templates/git/`: git config templates (base/work/personal)
- `templates/rime-config/`: Rime input method config templates

## Configuration Notes

### Oh My Zsh Template

- Default template path: `templates/.zshrc`
- Override via environment variable:

```bash
OMZ_TEMPLATE=/path/to/your/.zshrc ./install.sh
```

### Git Work/Personal Split

The base config is installed at `~/.config/git/config` and includes:

- `~/.config/git/config-work` for work repos
- `~/.config/git/config-personal` for personal/open-source repos

Defaults:

- Work dir: `~/Developer/work`
- Personal dir: `~/Developer/personal`

First install will prompt for work `user.name` and `user.email`.

Update `user.name` and `user.email` in:

- `~/.config/git/config-work`
- `~/.config/git/config-personal`

### Rime Configuration

Rime config files are installed from `templates/rime-config/` to `~/Library/Rime/`.

After installation, deploy the configuration by:

- Clicking the Squirrel icon in the menu bar → Select "Deploy"
- Or run: `killall Squirrel && open -a Squirrel`

## Libraries & Tools Links

- [Xcode Command Line Tools](https://developer.apple.com/downloads/)
- [Homebrew](https://brew.sh/)
- [Oh My Zsh](https://ohmyz.sh/)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [git](https://git-scm.com/)
- [gnupg](https://gnupg.org/)
- [wget](https://www.gnu.org/software/wget/)
- [curl](https://curl.se/)
- [jq](https://jqlang.github.io/jq/)
- [yq](https://mikefarah.gitbook.io/yq/)
- [fzf](https://github.com/junegunn/fzf)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)
- [bat](https://github.com/sharkdp/bat)
- [eza](https://github.com/eza-community/eza)
- [tree](https://linux.die.net/man/1/tree)
- [Rime](https://rime.im/)
- [Rime Ice](https://dvel.me/posts/rime-ice/)
- [FiraCode](https://github.com/tonsky/FiraCode)

## Modules

- `modules/prereq/run.sh` (Xcode tools + Homebrew bootstrap)
- `modules/brew/run.sh` (Brewfile packages)
- `modules/omz/run.sh` (Oh My Zsh)
- `modules/zshrc/run.sh` (template applied to `~/.zshrc`)
- `modules/git/run.sh` (work/personal configs)
- `modules/rime/run.sh` (Rime/Squirrel input method config)

## Notes

- Uses Homebrew wherever possible.
- Designed for macOS only.
- Each module prints a clear separator in the console.
