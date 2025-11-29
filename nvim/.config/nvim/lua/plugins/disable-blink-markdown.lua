return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      -- 1. Disable for Markdown explicitly
      opts.enabled = function()
        if vim.bo.filetype == "markdown" then
          return false
        end
        
        -- 2. Keep default behavior for everything else
        return vim.bo.buftype ~= "prompt" and vim.b.completion ~= false
      end
    end,
  },
}
