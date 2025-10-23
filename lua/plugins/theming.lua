return {
  {
    "dressing.nvim",
  },
  {
    "mtdl9/vim-log-highlighting",
  },
  {
    "chrisbra/Colorizer",
    config = function()
      -- Auto-colorize log files
      vim.g.colorizer_auto_filetype = "log"
      vim.g.colorizer_disable_bufleave = 1
    end,
  },
}
