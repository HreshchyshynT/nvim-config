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
      widget_guides = {
        enabled = true,
      },
      dev_log = {
        filter = function(line)
          return line
            and not line:match(
              "handleWindowFocusChanged mWindowFocusChanged false mUpcomingWindowFocus true mAdded true"
            )
        end,
        open_cmd = "vsplit equalalways", -- command to use to open the log buffer
      },
      lsp = {
        color = {
          virtual_text = true, -- show the highlight using virtual text
          virtual_text_str = "■", -- the virtual text character to highlight
        },
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          enableSnippets = true,
          updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
        },
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
