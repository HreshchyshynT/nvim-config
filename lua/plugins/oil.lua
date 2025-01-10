return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      delete_to_trash = true,
    },
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    init = function()
      vim.keymap.set("n", "<leader>O", ":Oil<CR>", { desc = "[O]il" })
    end,
  },
}
