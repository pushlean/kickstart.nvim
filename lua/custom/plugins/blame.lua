return {
  {
    'FabijanZulj/blame.nvim',
    lazy = false,
    config = function()
      require('blame').setup {}
    end,
    opts = {
      date_format = '%Y.%m.%d',
      merge_consecutive = true,
    },
  },
}
