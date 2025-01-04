return {              -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VeryLazy', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()

    -- Document existing key chains
    require('which-key').add {
      { '<leader>c', name = '[C]ode',      hidden = true },
      { '<leader>d', name = '[D]ocument',  hidden = true },
      { '<leader>s', name = '[S]earch' },
      { '<leader>w', name = '[W]orkspace', hidden = true },
      { '<leader>t', name = '[T]oggle' },
      { '<leader>h', name = 'Git [H]unk' },
      { '<leader>N', name = '[N]eotree',   hidden = true },
      {
        { mode = 'v' },
        { '<leader>h', name = 'Git [H]unk' },
      },
    }
  end,
}
