-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
vim.keymap.set('n', '<leader><Tab>', '<C-^>', { desc = 'Go to alternate buffer' })
vim.keymap.set('n', '<leader>fs', ':w<CR>', { desc = '[F]ile [S]ave buffer' })
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { desc = '[B]uffer [D]elete' })

return {
  -- 'github/copilot.vim',
  'ThePrimeagen/vim-be-good',
  'ryanoasis/vim-devicons',
}
