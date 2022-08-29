local api = vim.api
local fn = vim.fn

return {
  setup = function()
    local augroup = api.nvim_create_augroup('actually-au', {clear = true})

    api.nvim_create_autocmd("BufNewFile", {
      buffer = 0,
      callback = function(details)
        if fn.filereadable(details.file) == 1 then
          -- Another BufNewFile event might have handled this already.
          -- Per https://github.com/EinfachToll/DidYouMean
          return
        else
          local swapfile = fn.swapname(api.nvim_buf_get_name(0))
          local possibles = {}
          for _, file in ipairs(vim.split(fn.glob(details.file .. "*"), "\n")) do
            -- In case you have a swapfile in the same directory,
            -- with the same name but ending in .swp
            if file ~= swapfile and #file > 1 then
              table.insert(possibles, file)
            end
          end

          if #possibles > 0 then
            local chose = vim.ui.select(possibles, {
              prompt = 'Actually! You probably meant:',
              format_item = function(item)
                local parts = vim.split(item, "/")
                return parts[#parts]

              end
            }, function(choice)
              if choice then vim.cmd("edit " .. choice) end

            end)
          end
        end
      end,

      group = augroup
    })
  end
}
