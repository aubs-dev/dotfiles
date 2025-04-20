-- Load all LSP configs & enable them
local lspConfigs = {}
for _, file in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
    local serverName = vim.fn.fnamemodify(file, ":t:r")
    table.insert(lspConfigs, serverName)
end

vim.lsp.enable(lspConfigs)
