local M = {}

-- Random helper snippets. Add/remove/edit the items below by hand.
-- To add a new category, copy the `sql` block and give it its own key:
--  1. Add a table here (e.g. `git = { label = "Git", items = {...} }`)
--  2. Add a keymap in lua/plugins-keymaps/helpers-keymaps.lua
M.helpers = {
    sql = {
        label = "SQL",
        items = {
            "SELECT name FROM sys.procedures ORDER BY name;",
            "EXEC sp_helptext 'dbo.NombreProcedimiento';",
        },
    },
}

return M
