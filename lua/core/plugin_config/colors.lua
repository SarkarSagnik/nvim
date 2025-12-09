-- Function to set up the color scheme and remove background highlights
function ColorMyPencils(color)
  color = color or "nord"
  vim.cmd.colorscheme(color)
  -- Remove background highlight for Normal and NormalFloat
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
end

-- Call the function to apply the color scheme
ColorMyPencils()
