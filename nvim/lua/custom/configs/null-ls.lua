local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- formatting
  b.formatting.clang_format,
  -- b.formatting.deno_fmt.with {
  --   filetypes = { "json" },
  -- },
  b.formatting.stylua,
  b.formatting.prettier,
  -- b.formatting.prettier_eslint,
  b.formatting.eslint,
  -- b.formatting.stylelint,

  -- diagnostics
  b.diagnostics.eslint,
  b.diagnostics.tsc,
  -- b.diagnostics.stylelint,

  -- code_actions
  b.code_actions.eslint,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
