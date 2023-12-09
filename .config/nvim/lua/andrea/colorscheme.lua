-- Choose between `oxocarbon` `carbonfox` `tokyonight` `night-owl` `nightfox` `duskfox`
local colorscheme = "carbonfox"

local status_ok, _ = pcall(function() vim.cmd("colorscheme " .. colorscheme) end)
if not status_ok then
  vim.notify("Something went wrong loading the " .. colorscheme .. " colorscheme")
  return
end
