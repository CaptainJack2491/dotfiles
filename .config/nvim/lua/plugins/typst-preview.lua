return {
  'chomosuke/typst-preview.nvim',
  ft = 'typst',
  version = '1.*',
  opts = {
    -- invert_colors='always',
    -- open_cmd = 'qutebrowser --target window %s'
    open_cmd = 'chromium --app=%s'
  }, -- lazy.nvim will implicitly calls `setup {}`
}
