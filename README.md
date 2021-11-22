<p align="center">Just another visually appealing, opinionated Neovim IDE.</p>
<p align="center">Currently supports LaTeX, Python, Lua, and C#.</p>

# Table of Contents <!-- omit in toc -->

- [Screenshots 📷](#screenshots-)
- [Installation ⚡](#installation-)
  - [LaTeX](#latex)
    - [Auto Format](#auto-format)
    - [Pdf Preview](#pdf-preview)
    - [Inverse Search](#inverse-search)
  - [Language Servers](#language-servers)
    - [Python (pyright)](#python-pyright)
    - [Lua (sumneko_lua)](#lua-sumneko_lua)
    - [C# (omnisharp)](#c-omnisharp)
- [Update 🚀](#update-)
- [Features 📃](#features-)
  - [General](#general)
  - [LaTeX](#latex-1)
  - [Plugins Used ⚓](#plugins-used-)
    - [LSP](#lsp)
    - [File navigation, explorer](#file-navigation-explorer)
    - [Code completion](#code-completion)
    - [LaTeX](#latex-2)
    - [Looks](#looks)
    - [Buffer, Status](#buffer-status)
    - [QOL](#qol)
  - [Mappings ⌨](#mappings-)
- [Todo ✔](#todo-)

# Screenshots 📷

Using [Neovide](https://github.com/neovide/neovide) + [Gruvbox Material](https://github.com/sainnhe/gruvbox-material) + [Caskaydia Cove NF](https://www.nerdfonts.com/font-downloads)

![start](https://raw.githubusercontent.com/Neelfrost/github-assets/main/dotfiles/start.png "Dashboard Start Screen")
![file explorer](https://raw.githubusercontent.com/Neelfrost/github-assets/main/dotfiles/explorer.png "NvimTree File Explorer")
![file navigation](https://raw.githubusercontent.com/Neelfrost/github-assets/main/dotfiles/finder.png "Telescope Fuzzy Finder")
![statusline](https://raw.githubusercontent.com/Neelfrost/github-assets/main/dotfiles/statusline.png "Lualine statusline")

> From left to right: Mode, Wrap, Paste, File Name, Language Server, File Encoding, File Format, Mixed Indent, Line, Column Number, Total Lines, Git Branch

![latex](https://raw.githubusercontent.com/Neelfrost/github-assets/main/dotfiles/tex.png "LaTeX Preview")
![python](https://raw.githubusercontent.com/Neelfrost/github-assets/main/dotfiles/py.png "Python Preview")

# Installation ⚡

The following instructions are for Windows (powershell). **An admin prompt is required.**

1. Install chocolatey.

    ```powershell
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    ```

2. Install dependencies.

    ```powershell
    choco install git.install --params "/GitAndUnixToolsOnPath /NoGitLfs /SChannel /NoShellIntegration" -y;
    choco install neovim python universal-ctags sumatrapdf.install miktex.install which strawberryperl make -y; RefreshEnv.cmd; exit
    ```

3. Configure python.

    ```powershell
    pip install pynvim neovim-remote
    # Optionally, for python linting and formatting:
    pip install flake8 black
    ```

4. Clone the repository and open nvim-qt or nvim.

    ```powershell
    rm "$HOME\Appdata\Local\nvim" -Recurse; git clone https://github.com/Neelfrost/dotfiles.git "$HOME\Appdata\Local\nvim"; nvim-qt.exe
    ```

## LaTeX

### Auto Format

For auto format, install [latexindent](https://github.com/cmhughes/latexindent.pl).

1. cd into install directory. _Example:_

    ```powershell
    cd C:\tools\latexindent
    ```

2. Get latexindent.exe.

    ```powershell
    curl.exe -LO $(curl.exe -s https://api.github.com/repos/cmhughes/latexindent.pl/releases/latest | findstr.exe "browser_" | %{"$($_.Split('"')[3])"})
    ```

3. Set environment paths.

    ```powershell
    Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name path -Value $((Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name path).path + ";" + "C:\tools\latexindent" + ";"); RefreshEnv.cmd; exit
    ```

### Pdf Preview

To launch sumatrapdf using VimTeX (<kbd>\lv</kbd>), ensure `sumatrapdf.exe` is added to environment path.

```powershell
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name path -Value $((Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name path).path + ";" + "$HOME\AppData\Local\SumatraPDF" + ";"); RefreshEnv.cmd; exit
```

### Inverse Search

For inverse search, open sumatrapdf then go to Settings -> Options and set inverse search command-line to:

```cmd
nvim --headless -c "PackerLoad vimtex" -c "VimtexInverseSearch %l '%f'"
```

Use `:checkhealth` to check for errors if any.

## Language Servers

### Python ([pyright](https://github.com/microsoft/pyright))

1. Install npm.

    ```powershell
    choco install nodejs.install -y; RefreshEnv.cmd; exit
    ```

2. Install pyright.

    ```powershell
    npm install -g pyright
    ```

3. Use `:checkhealth` to check for errors if any.

### Lua ([sumneko_lua](https://github.com/sumneko/lua-language-server))

1. Install dependencies.

    ```powershell
    choco install 7zip.install -y; RefreshEnv.cmd; exit
    ```

2. cd into install directory. _Example:_

    ```powershell
    cd C:\tools
    ```

3. Install sumneko lua-language-server.

    ```powershell
    curl.exe -L $(curl.exe -s https://api.github.com/repos/sumneko/vscode-lua/releases/latest | findstr.exe "browser_" | %{"$($_.Split('"')[3])"}) -o lua.vsix; 7z.exe x .\lua.vsix; rm '.\`[Content_Types`].xml'; rm .\extension.vsixmanifest; rm .\lua.vsix; mv .\extension\server\ .; rm .\extension\ -Recurse; Rename-Item .\server\ lua-language-server; Get-ChildItem -Path ./lua-language-server/bin/Windows -Recurse | mv -Destination ./lua-language-server/bin; rm ./lua-language-server/bin/Windows; rm ./lua-language-server/bin/Linux -Recurse; rm ./lua-language-server/bin/macOS -Recurse
    ```

4. Use `:checkhealth` to check for errors if any.

### C# ([omnisharp](https://github.com/omnisharp/omnisharp-roslyn))

1. Install dependencies.

    ```powershell
    choco install omnisharp; RefreshEnv.cmd; exit
    ```

2. Use `:checkhealth` to check for errors if any.

# Update 🚀

1. Pull changes.

    ```powershell
    cd "$HOME\Appdata\Local\nvim"; git pull
    ```

2. Open nvim-qt or nvim and update plugins:

    ```
    :PackerSync
    ```

# Features 📃

## General

-   Clean folds.
-   Smart display line movement.
-   Resume cursor position when re-opening a file.
-   Auto update file if changed outside of neovim.
-   Fix mixed indents (tabs are converted to spaces).
-   Persistent cursor positions when switching buffers.
-   Ability to load/delete sessions using telescope.nvim.
-   Ability to search custom directories in telescope.nvim.
-   Ability to reload specific modules using telescope.nvim.
-   Automatically trim trailing whitespaces and newlines on save.
-   Open windows terminal, vscode, explorer at current directory using <kbd>\\\\t</kbd>, <kbd>\\\\c</kbd>, <kbd>\\\\e</kbd> respectively.

## LaTeX

-   Extensive snippets for LaTeX.
-   Better auxiliary file cleaner.
-   Sectional folding.
-   Null-ls latexindent support.
-   Automatically substitute `\` in imports (include, input) with `/` on save.
-   Start newline with \item (or \task) if inside a list environment when pressing <kbd>Enter</kbd>, <kbd>o</kbd> or <kbd>O</kbd>.

> Note: nvim-cmp's omni source is broken, use <kbd>Ctrl O</kbd> to trigger completion of ref, cite, figure etc.

## Plugins Used ⚓

-   Plugin manager: [packer.nvim](https://github.com/wbthomason/packer.nvim)

### LSP

-   LSP: [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
    -   Diagnostics, formatting LSP: [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)
    -   Python language server: [pyright](https://github.com/microsoft/pyright)
    -   C# language server: [omnisharp](https://github.com/omnisharp/omnisharp-roslyn)
    -   Lua language server: [sumneko_lua](https://github.com/sumneko/lua-language-server)
    -   Function signature when typing: [lsp_signature.nvim](https://github.com/ray-x/lsp_signature.nvim)
    -   Extract variable: [vim-extract-variable](https://github.com/fvictorio/vim-extract-variable)

### File navigation, explorer

-   File explorer: [nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)
-   Fuzzy finder: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
    -   Telescope frecency picker: [telescope-frecency.nvim](https://github.com/nvim-telescope/telescope-frecency.nvim)
    -   Telescope fzf sorter: [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
    -   Telescope ultisnips viewer: [telescope-ultisnips.nvim](https://github.com/fhill2/telescope-ultisnips.nvim)

### Code completion

-   Code completion: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
    -   Ultisnips source: [cmp-nvim-ultisnips](https://github.com/quangnguyen30192/cmp-nvim-ultisnips)
    -   LSP source: [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
    -   Buffer source: [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)

### LaTeX

-   LaTeX support: [vimtex](https://github.com/lervag/vimtex)
-   Snippet engine: [ultisnips](https://github.com/SirVer/ultisnips)
-   Tag management: [vim-gutentags](https://github.com/ludovicchabant/vim-gutentags)

### Looks

-   Gruvbox theme: [gruvbox-material](https://github.com/sainnhe/gruvbox-material)
-   Indent lines: [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
-   Icons support: [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)
-   Syntax highlighting: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
-   Colored matching brackets: [nvim-ts-rainbow](https://github.com/p00f/nvim-ts-rainbow)
-   Colorizer: [nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua)

### Buffer, Status

-   Bufferline: [cokeline.nvim](https://github.com/noib3/cokeline.nvim)
-   Statusline: [lualine.nvim](https://github.com/shadmansaleh/lualine.nvim)

### QOL

-   Repeat actions: [vim-repeat](https://github.com/tpope/vim-repeat)
-   Faster navigation: [hop.nvim](https://github.com/phaazon/hop.nvim)
-   Better quickfix: [nvim-pqf](https://gitlab.com/yorickpeterse/nvim-pqf)
-   Aligning: [vim-easy-align](https://github.com/junegunn/vim-easy-align)
-   Commenting: [nvim-comment](https://github.com/terrortylor/nvim-comment)
-   Title Case: [vim-titlecase](https://github.com/christoomey/vim-titlecase)
-   Start screen: [alpha-nvim](goolord/alpha-nvim)
-   Auto pair brackets: [auto-pairs](https://github.com/jiangmiao/auto-pairs)
-   Bracket operations: [vim-surround](https://github.com/tpope/vim-surround)
-   Startup time: [vim-startuptime](https://github.com/dstein64/vim-startuptime)
-   Open URLs and more: [vim-open-url](https://github.com/dhruvasagar/vim-open-url)
-   Fix cursorhold autocmd: [FixCursorHold.nvim](https://github.com/antoinemadec/FixCursorHold.nvim)
-   Fast expr folds: [FastFold](https://github.com/antoinemadec/Konfekt/FastFold)
-   Markdown preview: [nvim-markdown-preview](https://github.com/davidgranstrom/nvim-markdown-preview)
-   Run commands asynchronously: [asyncrun.vim](https://github.com/skywind3000/asyncrun.vim), [asyncrun.extra](https://github.com/skywind3000/asyncrun.extra)
-   Snippet collection: [vim-snippets](https://github.com/honza/vim-snippets) _(disabled by default)_

## Mappings ⌨

| Shortcut                  | Mode                 | Description                                        |
| ------------------------- | -------------------- | -------------------------------------------------- |
| <kbd>F2</kbd>             | Normal               | Replace word under cursor                          |
| <kbd>F2</kbd>             | Visual               | Rename selection                                   |
| <kbd>F5</kbd>             | Normal               | Open telescope.nvim module reloader                |
| <kbd>F10</kbd>            | Normal               | Toggle spellcheck                                  |
| <kbd>F11</kbd>            | Normal               | Toggle warp                                        |
| <kbd>F12</kbd>            | Normal               | Toggle paste mode                                  |
| <kbd>\\\\t</kbd>          | Normal               | Open windows terminal at cwd                       |
| <kbd>\\\\e</kbd>          | Normal               | Open explorer at cwd                               |
| <kbd>\\\\c</kbd>          | Normal               | Open current file in VSCode                        |
| <kbd>\\\\n</kbd>          | Normal               | Open current file in notepad                       |
| <kbd>tf</kbd>             | Normal               | Open telescope.nvim find files                     |
| <kbd>tr</kbd>             | Normal               | Open telescope.nvim recent files                   |
| <kbd>ts</kbd>             | Normal               | Open telescope.nvim session browser                |
| <kbd>\q</kbd>             | Normal               | Toggle quickfix                                    |
| <kbd>\h</kbd>             | Normal               | Disable search highlight                           |
| <kbd>\v</kbd>             | Normal/Insert        | Paste from system clipboard in **paste** mode      |
| <kbd>\w</kbd>             | Normal               | Close buffer _(will discard changes if not saved)_ |
| <kbd>\u</kbd>             | Normal               | Open URL under cursor in browser                   |
| <kbd>\s</kbd>             | Normal               | Search word under cursor in browser                |
| <kbd>\n</kbd>             | Normal               | Open dashboard                                     |
| <kbd>f</kbd>              | Normal               | Search buffer using 1 chars                        |
| <kbd>S</kbd>              | Normal               | Search buffer using 2 chars                        |
| <kbd>Tab</kbd>            | Normal               | Move to next buffer                                |
| <kbd>Shift Tab</kbd>      | Normal               | Move to previous buffer                            |
| <kbd>Tab</kbd>            | Insert               | Expand trigger or jump to next tab stop            |
| <kbd>Shift Tab</kbd>      | Insert               | Jump to previous tab stop                          |
| <kbd>Ctrl j(k)</kbd>      | Command              | Move between completion items                      |
| <kbd>Ctrl j(k)</kbd>      | Insert               | Move between completion items                      |
| <kbd>Alt d</kbd>          | Normal               | Duplicate current line below                       |
| <kbd>Alt j(k)</kbd>       | Normal/Visual        | Move line (block) up or down                       |
| <kbd>Alt ]</kbd>          | Normal               | Increase indent                                    |
| <kbd>Alt [</kbd>          | Normal               | Decrease indent                                    |
| <kbd>Ctrl /</kbd>         | Normal/Visual/Insert | Comment current (selected) line(s)                 |
| <kbd>Enter</kbd>          | Insert               | Select completion item                             |
| <kbd>Ctrl Space</kbd>     | Insert               | Force completion menu to open                      |
| <kbd>Ctrl c</kbd>         | Insert               | Force completion menu to close                     |
| <kbd>Ctrl e</kbd>         | Insert               | Select first completion item                       |
| <kbd>Ctrl t</kbd>         | Insert               | Open omni-func completion                          |
| <kbd>Ctrl Backspace</kbd> | Insert               | Delete previous word                               |
| <kbd>Ctrl Delete</kbd>    | Insert               | Delete next word                                   |
| <kbd>Ctrl b</kbd>         | Normal               | Toggle nvim-tree                                   |
| <kbd>Ctrl f</kbd>         | Normal               | Format document                                    |
| <kbd>Ctrl h(jkl)</kbd>    | Normal               | Move to window to the left (down, up, right)       |
| <kbd>Ctrl s</kbd>         | Normal               | Save current file                                  |
| <kbd>Ctrl Shift s</kbd>   | Normal               | Save and reload module (current file)              |
| <kbd>Ctrl v</kbd>         | Insert               | Paste from system clipboard                        |
| <kbd>Ctrl z</kbd>         | Insert               | Correct preceding misspelt word                    |
| <kbd>Ctrl z</kbd>         | Normal               | Correct misspelt word under cursor                 |
| <kbd>gD</kbd>             | Normal               | LSP: Goto function declaration                     |
| <kbd>gi</kbd>             | Normal               | LSP: Goto function implementation                  |
| <kbd>gh</kbd>             | Normal               | LSP: Preview documentation                         |
| <kbd>gd</kbd>             | Normal               | LSP: Preview function definition                   |
| <kbd>gs</kbd>             | Normal               | LSP: Preview signature help                        |
| <kbd>gr</kbd>             | Normal               | LSP: Rename instance                               |
| <kbd>gl</kbd>             | Normal               | LSP: Show line diagnostic                          |
| <kbd>gR</kbd>             | Normal               | LSP: Show references                               |
| <kbd>ga</kbd>             | Normal               | LSP: Trigger code action                           |
| <kbd>\li</kbd>            | Normal               | VimTeX: Info                                       |
| <kbd>\lT</kbd>            | Normal               | VimTeX: TOC toggle                                 |
| <kbd>\lq</kbd>            | Normal               | VimTeX: Log                                        |
| <kbd>\lv</kbd>            | Normal               | VimTeX: View pdf                                   |
| <kbd>\lr</kbd>            | Normal               | VimTeX: Reverse search                             |
| <kbd>\ll</kbd>            | Normal               | VimTeX: Compile                                    |
| <kbd>\lk</kbd>            | Normal               | VimTeX: Stop                                       |
| <kbd>\le</kbd>            | Normal               | VimTeX: Errors                                     |
| <kbd>\lC</kbd>            | Normal               | VimTeX: Clean full                                 |
| <kbd>\lx</kbd>            | Normal               | VimTeX: Reload                                     |
| <kbd>\lX</kbd>            | Normal               | VimTeX: Reload state                               |
| <kbd>\t</kbd>             | Normal               | Python, Lua, C#: Run code in external terminal     |
| <kbd>\r</kbd>             | Normal               | Python, Lua: Run code without terminal output      |
| <kbd>\lt</kbd>            | Normal               | Lua (LÖVE2D): Run game in external terminal        |
| <kbd>\lr</kbd>            | Normal               | Lua (LÖVE2D): Run game without terminal output     |

# Todo ✔

-   [ ] Improve mappings table
-   [ ] Document snippets
-   [ ] Automatic install script
-   [ ] Create video to showcase snippets
