# r-zsh-theme

Simple yet informative zsh theme. Tested on MacOS in Alacritty with Oh My Zsh installed.

<img width="1047" height="313" alt="r-zsh-theme" src="https://github.com/user-attachments/assets/f7faa31d-8dbf-4e6e-b104-c3efe456d01d" />

## Features

r-zsh-theme displays the following at the prompt:

- User name and host name
- Current working directory
- Git branch and status
- Active Python virtual environment

By default, r-zsh-theme displays the following after command execution:

- Execution time -> Completion time
- Execution duration
- Exit code

**TIP:** Disable command execution information by setting `DURATION=0`

## Installation

Download and apply r-zsh-theme and its dependencies.

### Install dependencies

Install and apply a Nerd Font for your terminal. Nerd Fonts are required to display icons used in the theme.

1. Install Nerd Fonts. See [Nerd Fonts GitHub](<https://github.com/ryanoasis/nerd-fonts>).  
   **Example:** Install Fire Code Nerd Font with `brew install --cask font-fira-code-nerd-font`
2. Apply the installed Nerd Font for your terminal.

### Install r-zsh-theme

Download the r-zsh-theme file and apply it in `.zshrc`.

1. Download r-zsh-theme by running:

   ```sh
   curl -o ~/.oh-my-zsh/custom/themes/r.zsh-theme https://raw.githubusercontent.com/rafalkaron/r-zsh-theme/main/r.zsh-theme
   ```

2. In `.zshrc`, set the theme by adding `ZSH_THEME="r"`
3. (optional) To disable command execution information, add `DURATION=0` in `.zshrc`.
4. Restart your terminal or run `source ~/.zshrc`
