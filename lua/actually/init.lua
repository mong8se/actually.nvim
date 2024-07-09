local api = vim.api
local fn = vim.fn
local basename = vim.fs.basename

function OpenActual(choice)
  if choice then
    local empty_bufnr = api.nvim_win_get_buf(0)
    vim.cmd.edit(fn.fnameescape(choice))
    api.nvim_buf_delete(empty_bufnr, {})
  end
end

function Actually(details)
  -- Another BufNewFile event might have handled this already.
  -- Per https://github.com/EinfachToll/DidYouMean
  if fn.filereadable(details.file) == 1 then return end

  local swapfile = basename(fn.swapname(api.nvim_buf_get_name(0)))
  local possiblities = vim.tbl_filter(function(file)
    -- In case you have a swapfile in the same directory,
    -- with the same name but ending in .swp
    return #file > 1 and basename(file) ~= swapfile
  end, fn.glob(details.file .. "*", false, true))

  if #possiblities > 0 then
    vim.ui.select(possiblities, {
      prompt = 'Actually! You probably meant:',
      format_item = basename
    }, OpenActual)
  end
end

return {
  setup = function()
    local augroup = api.nvim_create_augroup('actually-au', {clear = true})

    api.nvim_create_autocmd("BufNewFile", {
      pattern = "*",
      callback = Actually,
      group = augroup
    })
  end
}
