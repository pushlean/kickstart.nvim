return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    init = function()
      local views = {}
      local restore_enabled
      local group = vim.api.nvim_create_augroup('RenderMarkdownCodeDiff', { clear = true })

      vim.api.nvim_create_autocmd('User', {
        group = group,
        pattern = 'CodeDiffOpen',
        callback = function(event)
          if next(views) == nil then
            local markdown = package.loaded['render-markdown']
            restore_enabled = not markdown or markdown.get()
            if markdown then
              markdown.disable()
            end
          end
          views[event.data.tabpage] = true
          vim.g.render_markdown_codediff_active = true
        end,
      })

      vim.api.nvim_create_autocmd('User', {
        group = group,
        pattern = 'CodeDiffClose',
        callback = function(event)
          views[event.data.tabpage] = nil
          if next(views) ~= nil then
            return
          end
          vim.g.render_markdown_codediff_active = false
          -- CodeDiffClose fires before the diff windows are cleaned up.
          vim.schedule(function()
            local markdown = package.loaded['render-markdown']
            if next(views) == nil and markdown and restore_enabled then
              markdown.enable()
            end
          end)
        end,
      })
    end,
    opts = function()
      return {
        enabled = not vim.g.render_markdown_codediff_active,
        render = { diff = false },
        -- Virtual revision buffers can receive FileType before CodeDiffOpen.
        ignore = function(buf)
          return vim.api.nvim_buf_get_name(buf):match('^codediff://') ~= nil
        end,
      }
    end,
  },
}
