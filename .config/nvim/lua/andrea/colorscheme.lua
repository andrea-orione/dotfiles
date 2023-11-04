local colorscheme = "tokyonight"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("Something went wrong loading the " .. colorscheme .. " colorscheme")
  return
end
