return {
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   lazy = false,
  --   version = false, -- set this to "*" if you want to always pull the latest change, false to update on release
  --   opts = {
  --     provider = "copilot",
  --     auto_suggestions_provider = "copilot",
  --     copilot = { model = "claude-3.7-sonnet" },
  --     mappings = {
  --       suggestion = { -- disable suggestions mappings
  --         accept = "",
  --         next = "",
  --         prev = "",
  --         dismiss = "",
  --       },
  --       --- @class AvanteConflictMappings
  --       diff = {
  --         ours = "co",
  --         theirs = "ct",
  --         all_theirs = "ca",
  --         both = "acb", -- cb conflicts with
  --         cursor = "cc",
  --         next = "]x",
  --         prev = "[x",
  --       },
  --       jump = {
  --         next = "]]",
  --         prev = "[[",
  --       },
  --       submit = {
  --         normal = "<CR>",
  --         insert = "<C-s>",
  --       },
  --       sidebar = {
  --         apply_all = "A",
  --         apply_cursor = "a",
  --         switch_windows = "<Tab>",
  --         reverse_switch_windows = "<S-Tab>",
  --       },
  --     },
  --     behaviour = {
  --       auto_suggestions = false, -- Experimental stage
  --     },
  --     --- @class AvanteFileSelectorConfig
  --     file_selector = {
  --       --- @alias FileSelectorProvider "native" | "fzf" | "mini.pick" | "snacks" | "telescope" | string | fun(params: avante.file_selector.IParams|nil): nil
  --       provider = "telescope",
  --       -- Options override for custom providers
  --       provider_opts = {},
  --     },
  --     highlights = {
  --       diff = {
  --         current = "Normal",
  --         incoming = "Normal",
  --       },
  --     },
  --   },
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   build = "make",
  --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  --   dependencies = {
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "echasnovski/mini.icons",
  --     "zbirenbaum/copilot.lua", -- for providers='copilot'
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  --   init = function()
  --     -- add which key info: <leader>a is [a]vante
  --     require("which-key").add({
  --       { "<leader>a", name = "[a]vante" },
  --     })
  --   end,
  -- },
  -- {
  --   "https://github.com/github/copilot.vim.git",
  -- },
}
