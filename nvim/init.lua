-- vim print hello
vim.print('hello from nix')
-- colorscheme tokyonight
vim.cmd.colorscheme('tokyonight-storm')

require('image').setup {
  processor = 'magick_cli',
  max_height_window_percentage = 95,
  window_overlap_clear_enabled = true,
}
