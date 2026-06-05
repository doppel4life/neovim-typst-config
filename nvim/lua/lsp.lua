-- ── Global defaults ───────────────────────────────────────────────────────────
vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      semanticTokens = { multilineTokenSupport = true },
    },
  },
  root_markers = { ".git", "typst.toml", "main.typ" },
})

-- ── Diagnostics ───────────────────────────────────────────────────────────────
vim.diagnostic.config({
  virtual_lines    = { only_current_line = true },
  virtual_text     = false,
  signs            = true,
  underline        = true,
  update_in_insert = false,
  severity_sort    = true,
  float = {
    border = "single",
    source = true,  -- show which LSP the diagnostic is from
  },
})

-- ── tinymist (Typst) ──────────────────────────────────────────────────────────
vim.lsp.config("tinymist", {
  cmd       = { "tinymist" },
  filetypes = { "typst" },
  root_markers = { "typst.toml", "main.typ", ".git" },
  settings = {
    formatterMode  = "typstyle",
    exportPdf      = "onSave",
    semanticTokens = "enable",
  },
})

vim.lsp.enable({ "tinymist" })

-- ── LspAttach callbacks ───────────────────────────────────────────────────────
local lsp_group = vim.api.nvim_create_augroup("UserLsp", { clear = true })

-- Native completion
vim.api.nvim_create_autocmd("LspAttach", {
  group    = lsp_group,
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end
  end,
})

-- Keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  group    = lsp_group,
  callback = function(event)
    local map = function(keys, fn, desc)
      vim.keymap.set("n", keys, fn, { buffer = event.buf, silent = true, desc = desc })
    end

    -- Navigation
    map("gd",  vim.lsp.buf.definition,     "LSP: Go to definition")
    map("gD",  vim.lsp.buf.declaration,    "LSP: Go to declaration")
    map("gr",  vim.lsp.buf.references,     "LSP: References")
    map("gi",  vim.lsp.buf.implementation, "LSP: Implementation")
    map("K",   vim.lsp.buf.hover,          "LSP: Hover docs")

    -- Diagnostics
    map("[d",        vim.diagnostic.goto_prev,  "Diagnostic: previous")
    map("]d",        vim.diagnostic.goto_next,  "Diagnostic: next")
    map("<leader>e", vim.diagnostic.open_float, "Diagnostic: float")
    map("<leader>q", vim.diagnostic.setloclist, "Diagnostic: to loclist")

    -- Actions
    map("<leader>rn", vim.lsp.buf.rename,      "LSP: Rename")
    map("<leader>ca", vim.lsp.buf.code_action, "LSP: Code action")
    map("<leader>f",  function()
      vim.lsp.buf.format({ async = true })
    end, "LSP: Format file")

    -- Typst: pin / unpin the main file for tinymist
    map("<leader>tp", function()
      vim.lsp.buf.execute_command({
        command   = "tinymist.pinMain",
        arguments = { vim.api.nvim_buf_get_name(0) },
      })
      vim.notify("tinymist: pinned " .. vim.fn.expand("%:t"), vim.log.levels.INFO)
    end, "Typst: Pin main file")

    map("<leader>tu", function()
      vim.lsp.buf.execute_command({
        command   = "tinymist.pinMain",
        arguments = { vim.v.null },
      })
      vim.notify("tinymist: unpinned", vim.log.levels.INFO)
    end, "Typst: Unpin main file")
  end,
})
