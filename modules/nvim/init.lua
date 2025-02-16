if vim.g.os ~= nil then
    if vim.fn.has("win64") or vim.fn.has("win32") or vim.fn.has("win16") then
        vim.api.nvim_exec ('language en_US', true)
    end
end


if vim.g.vscode then
    require "vscode"
else
    -- Autocmds
    vim.cmd [[
    augroup CursorLine
        au!
        au VimEnter * setlocal cursorline
        au WinEnter * setlocal cursorline
        au BufWinEnter * setlocal cursorline
        au WinLeave * setlocal nocursorline
    augroup END

    autocmd FileType nix setlocal shiftwidth=4
    ]]

    require "core"

    local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]


    if custom_init_path then
        dofile(custom_init_path)
    end

    require("core.utils").load_mappings()

    local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

    -- bootstrap lazy.nvim!
    if not vim.loop.fs_stat(lazypath) then
        require("core.bootstrap").gen_chadrc_template()
        require("core.bootstrap").lazy(lazypath)
    end

    dofile(vim.g.base46_cache .. "defaults")
    vim.opt.rtp:prepend(lazypath)
    require "plugins"
end

