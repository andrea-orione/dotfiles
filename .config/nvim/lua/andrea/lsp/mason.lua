local servers = {
	"lua_ls",
  "clangd",
	-- "cssls",
	-- "html",
	-- "tsserver",
	"pyright",
	-- "bashls",
	"jsonls",
	-- "yamlls",
  "rust_analyzer",
  "texlab"
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  vim.notify("Something went wrong loading lspconfig")
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("andrea.lsp.handlers").on_attach,
		capabilities = require("andrea.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "andrea.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end
  if not require_ok then
    vim.notify("Something went wrong loading the config file for the " .. server .. " server")
  end

	local lspconfig_setup_status, _ = pcall(function() lspconfig[server].setup(opts) end)
  if not lspconfig_setup_status then
    vim.notify("Default config for " .. server .. " not found")
  end
end
