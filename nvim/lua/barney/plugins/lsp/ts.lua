vim.lsp.config('ts_ls', {
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
  on_attach = function(client, bufnr)
    -- require('twoslash-queries').attach(client, bufnr) -- todo install and setup
    client.server_capabilities.documentFormattingProvider = false
  end,
})
vim.lsp.enable('ts_ls')
