vim.lsp.config('amazon-states-language-service', {
  cmd = {
    'node',
    'aws-toolkit-vscode/packages/core/dist/src/stepFunctions/asl/aslServer.js',
    '--stdio',
  },
  filetypes = { 'yaml.states', 'json.states' },
  root_markers = { '.git' },
  settings = { validate = false },
})
vim.lsp.enable('amazon-states-language-service')
