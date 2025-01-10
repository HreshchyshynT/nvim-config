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
      vim.keymap.set("n", "<leader>O", function()
        local oil = require("oil")
        local buf = vim.api.nvim_get_current_buf()
        local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
        if filetype == "oil" then
          oil.close()
        else
          oil.open()
        end
      end, { desc = "[O]il" })
    end,
  },
}
