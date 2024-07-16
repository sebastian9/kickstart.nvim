-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
vim.keymap.set('n', '<leader>n', ':NERDTreeFocus<CR>', { desc = 'Open [N]ERDTreeFocus' })

return {
  'github/copilot.vim',
  'ThePrimeagen/vim-be-good',
  'ryanoasis/vim-devicons',
  'preservim/nerdtree',
}
