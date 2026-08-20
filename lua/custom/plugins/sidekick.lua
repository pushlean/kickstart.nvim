return {
  {
    'folke/sidekick.nvim',
    dependencies = {
      {
        'folke/snacks.nvim',
        opts = {
          picker = {
            kinds = {
              sidekick_prompt = {
                matcher = { sort_empty = true },
                transform = function(item)
                  item.prompt_priority = item.name == 'line' and 0 or 1
                end,
                sort = { fields = { 'score:desc', 'prompt_priority', 'idx' } },
              },
            },
          },
        },
      },
    },
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
        '<C-.>',
        function()
          require('sidekick.cli').toggle { name = 'codex' }
        end,
        desc = 'Toggle Codex',
      },
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
