# ohmyzsh-config

_Shareable configuration for [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)_

## Setup

Clone this repository in your `custom` zsh folder:

```bash
# Keep a backup of the existing folder
mv "$ZSH_CUSTOM" "${ZSH_CUSTOM}_bak"
rm -rf "$ZSH_CUSTOM"
git clone git@github.com:kael89/ohmyzsh-config.git "$ZSH_CUSTOM"

# ⚠️ Use this if you are sure you don't need the backup:
rm -rf "${ZSH_CUSTOM}_bak"
```

## Local maintenance

This repository includes references to zsh themes, installed as [git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules). To keep them up to date:

1. `cd` in each folder under `themes`
2. `git fetch && git pull`
3. `cd ..` and commit your changes

## Overrides

You can override the aliases and functions defined in this package by using a `zz_overrides.zsh` file. This is not committed in source control, so it's a good place to define custom functionality.

> Why the `zz_` prefix? `oh-my-zsh` seems to load config files alphabetically, so using this prefix means that this file will by loaded last.
