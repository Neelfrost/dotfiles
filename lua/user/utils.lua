-- https://www.reddit.com/r/neovim/comments/rw4imi/what_is_the_most_interesting_part_of_your_lua/
function _G.each(z)
    return (function(x)
        return x(x)
    end)(function(x)
        return function(...)
            z(...)
            return x(x)
        end
    end)
end

--- Trim newline at eof, trailing whitespace.
function _G.perform_cleanup()
    local pos = vim.api.nvim_win_get_cursor(0)

    do
        each(vim.cmd)(
            -- remove leading empty lines
            [[keeppatterns %s/\%^\n//e]]
        )( -- remove trailing empty lines
            [[keeppatterns %s/$\n\+\%$//e]]
        )( -- remove trailing spaces
            [[keeppatterns %s/\s\+$//e]]
        )( -- remove trailing "\r"
            [[keeppatterns %s/\r\+//e]]
        )
    end
    if require("user.plugins.config.lualine.components").mixed_indent() ~= "" then
        vim.cmd([[keeppatterns %s/\v\t/    /e]])
    end

    local end_row = vim.api.nvim_buf_line_count(0)

    if pos[1] > end_row then
        pos[1] = end_row
    end

    vim.api.nvim_win_set_cursor(0, pos)
end

--- Launch external program
--- @param prog string program to run
--- @vararg string args for program
function _G.launch_ext_prog(prog, ...)
    vim.fn.system(prog .. " " .. table.concat({ ... }, " "))
end

function _G.open_url(url, prefix)
    launch_ext_prog("start", (prefix or "") .. url)
end

-- Reloading lua modules using Telescope
-- taken and modified from:
-- https://ustrajunior.com/posts/reloading-neovim-config-with-telescope/
function _G.verbose_print(...)
    local objects = {}
    for i = 1, select("#", ...) do
        local v = select(i, ...)
        table.insert(objects, vim.inspect(v))
    end

    print(table.concat(objects, "\n"))
    return ...
end

if pcall(require, "plenary") then
    local reload = require("plenary.reload").reload_module
    --- Reload module using plenary
    --- @param name string module
    function _G.plenary_reload(name)
        reload(name)
    end
end

--- Get module from file path
--- @param file_path string path to file e.g., "C:\Users\Neel\AppData\Local\nvim\user\lua\user\plugins\custom\telescope.lua"
--- @return string module_name module representation of file "user.plugins.custom.telescope"
function _G.get_module_name(file_path)
    -- Path to the lua folder
    local path_to_lua = CONFIG_PATH .. "\\lua\\"
    local module_name = file_path:gsub(path_to_lua, "")

    -- In the case that current file is not within "lua" folder
    if module_name == file_path then
        vim.notify(("Not a valid module (%s)"):format(module_name), vim.log.levels.WARN)
        return
    end

    module_name = module_name:gsub("%.lua", "")
    module_name = module_name:gsub("\\", ".")
    module_name = module_name:gsub("%.init", "")
    return module_name
end

--- Save and reload a module
function _G.save_reload_module()
    local file_path = vim.fn.expand("%:p")

    -- Handle lowercase drive names
    file_path = file_path:gsub("^%l", string.upper)

    -- Handle weird behavior (multiple separators)
    if string.match(file_path, "\\\\") then
        file_path = file_path:gsub("\\\\", "\\")
    end

    -- Reload (source) vim files
    if file_path:find("%.vim$") then
        file_path = vim.fn.fnameescape(file_path)
        -- Save
        vim.cmd("update!")
        -- Source
        vim.cmd(("source %s"):format(file_path))
        -- Print
        vim.notify(("%s Sourced."):format(file_path), vim.log.levels.INFO)
        return
    end

    -- Reload lua files
    -- Get module
    local module = get_module_name(file_path)

    -- Only reload if current file is a valid module
    if module then
        -- Save
        vim.cmd("update!")
        -- Reload
        plenary_reload(module)
        -- Print
        vim.notify(("%s Reloaded."):format(module), vim.log.levels.INFO)
    end
end

--- Set window title
function _G.set_title()
    local file = vim.fn.expand("%:p:t")
    local cwd = vim.fn.split(vim.fn.expand("%:p:h"):gsub("/", "\\"), "\\")
    local is_plugin = require("user.plugins.config.lualine.components").buffer_is_plugin()

    if file ~= "" and not is_plugin then
        vim.opt.titlestring = cwd[#cwd] .. "/" .. file
    else
        vim.opt.titlestring = "Neovim"
    end
end

--- Quickfix toggle
--- https://vim.fandom.com/wiki/Toggle_to_open_or_close_the_quickfix_window
vim.api.nvim_create_user_command("QFix", function(bang)
    if vim.fn.getqflist({ winid = 0 }).winid ~= 0 and bang then
        vim.cmd("cclose")
    else
        vim.cmd("copen 10")
    end
end, {
    nargs = "?",
    bang = true,
    force = true,
})
