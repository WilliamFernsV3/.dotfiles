# Dotfiles

## Installation

1. Install [homebrew](https://brew.sh/) and follow terminal output commands

2. Install Alacritty
```bash
brew install --cask alacritty
```
Go to security settings and allow to open Alicritty. If confused, watch [this section](https://www.youtube.com/watch?v=uOnL4fEnldA&t=29s)

3. Install git
```bash
brew install git
```

4. Install tmux
```bash
brew install tmux
```

5. Install nerd font
```bash
brew install font-meslo-lg-nerd-font
```
7. Install oh my zsh
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

8. Install p10k 
```bash 
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

9. Install TPM (tmux plugins manager)
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

10. Install all tmux plugins by pressing `<ctr> + <space> + <shift> + i`

11. Install github cli:
```bash
brew install gh
```

12. Install commitizen:
```bash
brew install commitizen
```

13. Install zshell autosuggestions:
```bash
brew install zsh-autosuggestions
echo "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
```

14. Setup zshell syntax highlighting:
```bash
brew install zsh-syntax-highlighting
echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
```

15. Setup a better 'ls' command
```bash
brew install eza
```

16. Setup a better 'cd' command
```bash
brew install zoxide
```

16. Install newest version of bash
```bash
brew install bash
```

17. Install raycast
```bash
brew install --cask raycast
```

18. Small Accessibility changes
- The start of this video talks about some system settings configuration. [Reference Video](https://www.youtube.com/watch?v=k94qImbFKWE)
- Use as reference - [Brothers Dotfiles](https://github.com/AdonisCodes/dotfiles)

19. Install yabai
Use the same reference video outlined above as a guideline. Can use [this blog post](https://www.josean.com/posts/yabai-setup) as well.
```bash
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
```
Start yabai service
```bash 
yabai --start-service
```

Start skhd service
```bash
skhd --start-service
```

20. Install espanso
```bash
brew install espanso
```

21. Install sketchybar
```bash
brew tap FelixKratz/formulae
brew install sketchybar
```

22. Install better touch tool
```bash
brew install --cask bettertouchtool
```

23. Install borders
```bash
brew tap FelixKratz/formulae
brew install borders
```
