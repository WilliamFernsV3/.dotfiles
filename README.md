# My Dotfiles

<!-- TODO: add links -->

Welcome to my dotfiles! Here are all the configurations for tools I use to be more productive. This includes, but aren't limited to:
- [Aerospace]() - tiling window manager for OSX, similar to i3wm.
- [TMUX]() - terminal multiplexer.
- [ZSH]() - terminal shell built-in for OSX.
- [Visual Studio Code]() - the most popular IDE for software development.
- [Espanso]() - helpful shorthand snippets I use for sharing social links, searching, etc.
- [Karabiner Elements]() - remap/customize input devices like your mouse and keyboard (I even created multiple keyboard layouts using this).

> [!NOTE]
> I use OSX, meaning some of these dotfiles are for Darwin only. You can still use most of my configs on most Linux distrobutions. Since I use Homebrew for the setup script, it might not fully work on Linux since they have their own package managers.

## Visual Studio Code

My VSCode setup has a really minimalistic Neovim style look. It utilizes [Whichkey]() extension to have the same style mappings as Neovim. I have TMUX and Lazygit directly inside my IDE, using [this extension]() for Lazygit and [my own extension] for TMUX.

I followed [this video](https://www.youtube.com/watch?v=9_I0bySQoCs&ab_channel=GlennRaya) to inject custom JavaScript and CSS into Visual Studio Code to create the custom command panel, the minimalistic look, etc.

**Theme**: Catppuccin (Frappe). [View Extension](https://github.com/catppuccin/vscode)

**TMUX and Lazygit in VSCode**:

![Visual Studio Code TMUX](docs/assets/vscode-tmux.png)
![Visual Studio Code Lazygit](docs/assets/vscode-lazygit.png)

**Command Palette**:

![Visual Studio Code Command Palette Showcase Image](docs/assets/vscode-command-palette.png)

**Whichkey**:

![Visual Studio Code Whichkey Panel Showcase Image](docs/assets/whichkey-vscode.png)

**Editor**:

![Visual Studio Code Editor Showcase Image](docs/assets/vscode-editor.png)

**All Extensions**:

![Visual Studio Code All Extensions Showcase Gif](docs/assets/vscode-all-extensions.gif)

> [!NOTE]
> I don't use the [Neovim Extension](), I only use the [Vim Extension]().

## Terminal

I use ZSH and TMUX. When I want to use the terminal outside VS Code, I use Alacritty (a terminal application).

**ZSH Prompt**:

I created a custom prompt using [Powerlevel10k](https://github.com/romkatv/powerlevel10k).

![ZSH Prompt Showcase Image](docs/assets/terminal-prompt.png)

**TMUX Theme (Catpuccin Frappe)**:

![TMUX Theme Showcase Image](docs/assets/tmux-theme.png)

## Other

**Active Application Border**:

When I have multiple applications side-by-side, it can be hard to know which one I am focused on. That is why I added a border around the currently focused application.

![Active Application Border Showcase Image](docs/assets/border-active-application.png)

**Tiling Window Manager**:

![Tiling Window Manager Showcase Image](docs/assets/tiling-window-manager.gif)

## Setup

**Clone dotfiles locally and `cd` into it**:

```bash
git clone https://github.com/WilliamFernsV3/.dotfiles && \
cd .dotfiles
```

**Backup**:

> [!WARNING]
> Backup your old config files beforehand, because this could overwrite or modify it. This includes your Visual Studio Code configs, ZSH config, Vimrc, and all the files inside `~/.config`. A better solution would be to move all your configurations that aren't inside `~/.config` to it, then symlink it to the right locations, create a git repository and push it to a private Github repository.

This script will copy all your configurations that could be overwritten to `~/.config.backup`:

```bash
./scrips/backup.sh
```

**After backing everything up, run**:

```bash
./scrips/setup.sh
```

<!-- Add keyboard layout docs here -->
<!-- Add Contribution guide here -->
