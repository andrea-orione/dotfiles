local status_ok, impatient = pcall(require, "impatient")
if not status_ok then
  vim.notify("Something went wrong loading impatient")
  return
end

impatient.enable_profile()
