vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("orion-lsp-attach", { clear = true }),
	callback = function(event)
		local status_ok_teleb, telescope_b = pcall(require, "telescope.builtin")
		if not status_ok_teleb then
			vim.notify("Something went wrong loading telescope builtin")
			return
		end

		local keymap = function(keys, func, description)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = description, noremap = true, silent = true })
		end

		keymap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		keymap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
		keymap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
		keymap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")

		keymap("<leader>lD", telescope_b.lsp_type_definitions, "Type [D]efinition")
		keymap("<leader>lds", telescope_b.lsp_document_symbols, "[D]ocument [S]ymbols")
		keymap("<leader>lws", telescope_b.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

		keymap("K", vim.lsp.buf.hover, "Hover Documentation")

		keymap("<leader>lf", function()
			vim.lsp.buf.format({ async = true })
		end, "[L]SP [F]ormat")
		keymap("<leader>li", "<cmd>LspInfo<cr>", "[I]nfo")
		keymap("<leader>lI", "<cmd>LspInstallInfo<cr>", "[I]nstall info")
		keymap("<leader>la", vim.lsp.buf.code_action, "code [A]ction")
		keymap("<leader>lr", vim.lsp.buf.rename, "[R]ename")
		keymap("<leader>ls", vim.lsp.buf.signature_help, "[S]ignature help")
		keymap("<leader>lq", vim.diagnostic.setloclist, "[S]et local list")

		keymap("<leader>lf", function()
			vim.lsp.buf.format({ async = true })
		end, "[F]ormat")
		keymap("<leader>ll", vim.lsp.codelens.run, "CodeLens Action")

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
			keymap("<leader>lh", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
			end, "[L]SP toggle inlay [H]ints")
		end

		local illuminate_status_ok, illuminate = pcall(require, "illuminate")
		if not illuminate_status_ok then
			vim.notify("Something went wrong loading illuminate")
			return
		end
		illuminate.on_attach(client)
	end,
})
