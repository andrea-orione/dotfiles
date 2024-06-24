local status_ok, comment = pcall(require, "Comment")
if not status_ok then
    vim.notify("Something went wrong loading comment")
    return
end

local U = require("Comment.utils")
local status_utils_ok, utils = pcall(require, "ts_context_commentstring.utils")
local status_internals_ok, internals = pcall(require, "ts_context_commentstring.internals")

if not (status_utils_ok and status_internals_ok) then
    comment.setup()
    return
end

comment.setup({
    pre_hook = function(ctx)
        local location = nil
        if ctx.ctype == U.ctype.block then
            location = utils.get_cursor_location()
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = utils.get_visual_start_location()
        end

        return internals.calculate_commentstring {
            key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
            location = location,
        }
    end,
})
