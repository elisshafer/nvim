require'lspconfig'.gopls.setup{}
require'lspconfig'.golangci_lint_ls.setup{}
require'lspconfig'.pyre.setup{}
require'lspconfig'.eslint.setup{}
require'lspconfig'.graphql.setup{}
require('lspconfig').yamlls.setup{}

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.jsonls.setup {
  capabilities = capabilities,
}

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
  capabilities = capabilities,
}
