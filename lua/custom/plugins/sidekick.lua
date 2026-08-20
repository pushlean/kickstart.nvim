return {
  {
    'folke/sidekick.nvim',
    opts = {
      nes = { enabled = false },
      copilot = {
        status = { enabled = false },
      },
    },
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
