local api = vim.api
local fn = vim.fn
local opt = vim.o
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

  local swapfile = basename(fn.swapname(fn.bufname(0)))

  local prev_fileignorecase = opt.fileignorecase
  opt.fileignorecase = true

  local possiblities = vim.tbl_filter(function(file)
    -- If you have your swapfile directory set to the current directory
    -- and you are editing a file that starts with a "."
    -- then there is already a swapfile for this new buffer
    -- with a name that would match our glob
    -- and we don't want to show it on the list.
    return #file > 1 and basename(file) ~= swapfile
  end, fn.glob(fn.fnameescape(details.file) .. "*", false, true))

  opt.fileignorecase = prev_fileignorecase

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
