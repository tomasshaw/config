local present, null_ls = pcall(require, "null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

if not present then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local sources = {

	-- formatting
	formatting.clang_format,
	-- b.formatting.deno_fmt.with {
	--   filetypes = { "json" },
	-- },
	formatting.stylua,
	formatting.prettier,
	-- b.formatting.prettier_eslint,
	formatting.eslint,
	-- b.formatting.stylelint,

	-- diagnostics
	diagnostics.eslint,
	diagnostics.tsc,
	-- b.diagnostics.stylelint,

	-- code_actions
	code_actions.eslint,
}

null_ls.setup({
	debug = true,
	sources = sources,
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ timeout_ms = 5000 })
				end,
			})
		end
	end,
})
