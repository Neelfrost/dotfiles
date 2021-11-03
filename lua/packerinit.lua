-- Install packer in "start" folder aka. not lazy loaded
local install_path = PACKER_PATH .. "\\start\\packer.nvim"

local present, packer = pcall(require, "packer")
-- Check if packer is installed, if not install packer
if not present then
    -- Cleaner float highlight
    vim.cmd([[
        highlight Normalfloat guibg=NONE
        highlight Floatborder guibg=NONE
        redraw!
    ]])

    -- Install packer
    print("Installing packer.nvim.")
    vim.fn.delete(CONFIG_PATH .. "\\plugin", "rf")
    vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })

    -- Check for installation sucess
    vim.cmd([[packadd packer.nvim]])
    present, packer = pcall(require, "packer")

    if present then
        print("Installation complete.\nStarting plugin installation.")
    else
        error("Packer installation failed")
    end
end

-- Initialize packer
packer.init({
    -- compile_path = vim.fn.stdpath("config") .. "\\lua\\packer_compiled.lua",
    -- Use float window
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "single" })
        end,
        prompt_border = "single",
        working_sym = "",
        error_sym = "",
        done_sym = "",
    },
    auto_clean = true, -- During sync(), remove unused plugins
    compile_on_sync = true,
    max_jobs = 5,
})

return packer
