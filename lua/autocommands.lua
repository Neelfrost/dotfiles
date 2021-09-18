-- Set current file's dir to cwd
vim.cmd([[autocmd BufEnter * silent! lcd %:p:h]])

-- Remove trailing whitespace and newlines
vim.cmd([[autocmd BufWritePre * silent! lua perform_cleanup()]])

-- Highlight on yank
vim.cmd(
	[[autocmd TextYankPost * lua vim.highlight.on_yank { higroup = 'Visual', timeout = 500, on_visual = true, on_macro = true }]]
)

-- Automatically reload the file if it is changed outside of nvim
vim.cmd([[
    augroup AUTO_READ
        autocmd!
        autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
        autocmd FileChangedShellPost * echohl WarningMsg | redraw | echo 'File changed on disk. Buffer reloaded!' | echohl None
    augroup END
]])

-- Set window title
vim.cmd([[
    augroup UPDATE_WINDOW_TITLE
        autocmd!
        autocmd BufEnter *.* :set title | let &titlestring = expand('%') !=# '' ? expand('%') : 'Neovim'
    augroup END
]])

-- Save and restore folds
-- Also resumes edit position
vim.cmd([[
    augroup SAVE_VIEW
        autocmd!
        autocmd BufWinLeave *.* if expand('%') != '' | mkview | endif
        autocmd BufWinEnter *.* if expand('%') != '' | silent! loadview | endif
    augroup END
]])

vim.cmd([[
    augroup RESTORE_WIN_VIEW
        autocmd!
        autocmd BufLeave * lua auto_save_win_view()
        autocmd BufEnter * lua auto_restore_win_view()
    augroup END
]])

-- Lualine Lsp Progress
vim.cmd([[
    augroup UPDATE_STATUS_LINE
        autocmd!
        autocmd User LspProgressUpdate let &ro = &ro
    augroup END
]])

-- Force disable inserting comment leader after hitting o or O
-- Force disable inserting comment leader after hitting <Enter> in insert mode
vim.cmd([[
    augroup FORCE_FORMAT_OPTIONS
        autocmd!
        autocmd BufEnter * setlocal formatoptions-=r formatoptions-=o
    augroup END
]])

-- Setup neovim-remote
vim.cmd([[
    augroup SETUP_NVR
        autocmd!
        autocmd VimEnter * lua set_servername()
    augroup END
]])

-- vim.cmd([[
--     augroup TERM_POWERSHELL
--         let &shell = has('win32') ? 'powershell' : 'pwsh'
--         let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
--         let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
--         let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
--         set shellquote= shellxquote=
--     augroup END
-- ]])
