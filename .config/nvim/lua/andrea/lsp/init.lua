local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  vim.notify("Something went wrong loading lspconfig")
  return
end

require "andrea.lsp.mason"
require("andrea.lsp.handlers").setup()
require "andrea.lsp.null-ls"
