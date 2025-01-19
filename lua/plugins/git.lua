local function toggle_blame()
  local found = false
  local total_windows = vim.api.nvim_tabpage_list_wins(0) -- Get all windows in the current tab

  for _, win in ipairs(total_windows) do
    local buf = vim.api.nvim_win_get_buf(win)
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
    if filetype == "fugitiveblame" then
      vim.api.nvim_win_close(win, true) -- Close the window
      found = true
    end
  end

  if not found then
    local current_window = vim.api.nvim_get_current_win()
    local current_view = vim.fn.winsaveview() -- Save the current scroll and cursor position

    vim.cmd("Git blame")

    vim.api.nvim_set_current_win(current_window)
    vim.fn.winrestview(current_view) -- Restore the scroll and cursor position
  end
end

local function git_diff_to_quick_fix()
  local output = vim.fn.systemlist("Git diff --name-only --diff-filter=U --relative")
  if #output == 0 then
    print("No unmerged files")
  else
    local pathsArg = table.concat(output, " ")
    vim.cmd("vimgrep /<<<<< HEAD/ " .. pathsArg)
    vim.cmd("copen")
  end
end

return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, { desc = "Jump to next git [c]hange" })

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, { desc = "Jump to previous git [c]hange" })

        -- Actions
        -- visual mode
        map("v", "<leader>hs", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "stage git hunk" })
        map("v", "<leader>hr", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "reset git hunk" })
        -- normal mode
        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "git [s]tage hunk" })
        map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "git [r]eset hunk" })
        map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "git [S]tage buffer" })
        map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "git [u]ndo stage hunk" })
        map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "git [R]eset buffer" })
        map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "git [p]review hunk" })
        map("n", "<leader>hb", gitsigns.blame_line, { desc = "git [b]lame line" })
        map("n", "<leader>hd", gitsigns.diffthis, { desc = "git [d]iff against index" })
        map("n", "<leader>hD", function()
          gitsigns.diffthis("@")
        end, { desc = "git [D]iff against last commit" })
        -- Toggles
        map("n", "<leader>tD", gitsigns.toggle_deleted, { desc = "[T]oggle git show [D]eleted" })
      end,
    },
  },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>tb", toggle_blame, { desc = "[T]oggle git show [b]lame line" })
      vim.keymap.set("n", "<leader>Gd", git_diff_to_quick_fix, { desc = "Git [D]iff to quickfix" })
    end,
  },
}
