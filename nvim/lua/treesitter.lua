vim.api.nvim_create_autocmd("FileType", {
  group    = vim.api.nvim_create_augroup("Treesitter", { clear = true }),
  pattern  = { "typst", "lua", "vim" },
  callback = function()
    local ok = pcall(vim.treesitter.start)
    if not ok then return end

    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr   = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldenable = false 
  end,
})
