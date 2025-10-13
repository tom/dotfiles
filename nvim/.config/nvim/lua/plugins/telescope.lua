return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = false,
    keys = {
      {"<C-t>", "<cmd>Telescope find_files<cr>", desc = "Find files"},
      {"<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep"}
    }
}
