return {
  "akinsho/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local flutter = require("flutter-tools")
    flutter.setup({
      fvm = true,
      dev_log = {
        filter = function(line)
          return line
            and not line:match(
              "handleWindowFocusChanged mWindowFocusChanged false mUpcomingWindowFocus true mAdded true"
            )
        end,
        open_cmd = "vsplit equalalways", -- command to use to open the log buffer
      },
    })
    local telescope = require("telescope")
    local whichKey = require("which-key")

    whichKey.add({
      { "<leader>F", name = "[F]lutter" },
    })

    vim.keymap.set(
      "n",
      "<leader>Fc",
      telescope.extensions.flutter.commands,
      { desc = "Display available flutter commands", noremap = true }
    )
    vim.keymap.set("n", "<leader>Fr", ":FlutterReload<CR>", { desc = "Flutter hot [r]eload", noremap = true })
    vim.keymap.set("n", "<leader>FR", ":FlutterRestart<CR>", { desc = "Flutter hot [R]estart", noremap = true })
    vim.keymap.set("n", "<leader>Fq", ":FlutterQuit<CR>", { desc = "Flutter [q]uit", noremap = true })
  end,
}
