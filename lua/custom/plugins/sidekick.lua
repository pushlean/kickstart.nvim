return {
  {
    'folke/sidekick.nvim',
    opts = {
      nes = { enabled = false },
      copilot = {
        status = { enabled = false },
      },
      cli = {
        mux = { enabled = false },
      },
    },
    config = function(_, opts)
      require('sidekick').setup(opts)

      -- Sidekick discovers existing tmux panes even when mux is disabled.
      -- Remove that backend so they do not appear in the CLI tool picker.
      local sessions = require 'sidekick.cli.session'
      sessions.setup()
      sessions.backends.tmux = nil
    end,
    keys = {
      {
        '<leader>aa',
        function()
          require('sidekick.cli').toggle { name = 'codex' }
        end,
        desc = 'Toggle Codex',
      },
    },
  },
}
