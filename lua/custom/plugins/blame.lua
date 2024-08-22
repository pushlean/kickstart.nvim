return {
  {
    'FabijanZulj/blame.nvim',
    cmd = { 'BlameToggle' },
    config = function()
      require('blame').setup {
        date_format = '%Y.%m.%d',
      }
    end,
  },
}
