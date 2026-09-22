local M = {}

local function split_row(line)
    local cells = {}
    local current = {}
    local backslashes = 0

    for i = 1, #line do
        local char = line:sub(i, i)

        if char == "|" and backslashes % 2 == 0 then
            table.insert(cells, table.concat(current))
            current = {}
            backslashes = 0
        else
            table.insert(current, char)
            if char == "\\" then
                backslashes = backslashes + 1
            else
                backslashes = 0
            end
        end
    end

    table.insert(cells, table.concat(current))

    if line:match("^%s*|") then
        table.remove(cells, 1)
    end

    if line:match("|%s*$") and vim.trim(cells[#cells] or "") == "" then
        table.remove(cells, #cells)
    end

    for i, cell in ipairs(cells) do
        cells[i] = vim.trim(cell)
    end

    return cells
end

local function is_delimiter_cell(cell)
    cell = vim.trim(cell)
    return cell:match("^:?-+:?$") ~= nil
end

local function is_delimiter_row(cells)
    if #cells == 0 then
        return false
    end

    for _, cell in ipairs(cells) do
        if not is_delimiter_cell(cell) then
            return false
        end
    end

    return true
end

local function is_table_candidate(line)
    return line ~= nil and not line:match("^%s*$") and line:find("|", 1, true) ~= nil
end

local function strip_blockquote_prefix(line)
    local stripped = line

    while true do
        local prefix = stripped:match("^(%s*>%s*)")
        if prefix == nil then
            break
        end
        stripped = stripped:sub(#prefix + 1)
    end

    return stripped
end

local function is_fence_opening(line)
    local stripped = strip_blockquote_prefix(line):match("^%s*(.-)%s*$") or ""
    local marker = stripped:match("^([`~][`~][`~]+)")

    if marker == nil then
        return nil
    end

    if marker:match("^```+") then
        return "`", #marker
    end

    if marker:match("^~~~+") then
        return "~", #marker
    end

    return nil
end

local function is_fence_closing(line, fence_char, fence_length)
    local stripped = strip_blockquote_prefix(line):match("^%s*(.-)%s*$") or ""
    local marker = stripped:match("^([`~][`~][`~]+)%s*$")

    return marker ~= nil and marker:sub(1, 1) == fence_char and #marker >= fence_length
end

local function is_inside_fenced_code_block(lines, row)
    local fence_char = nil
    local fence_length = 0

    for i = 1, row do
        if fence_char == nil then
            fence_char, fence_length = is_fence_opening(lines[i])
        elseif is_fence_closing(lines[i], fence_char, fence_length) then
            fence_char = nil
            fence_length = 0
        end
    end

    return fence_char ~= nil
end

local function split_row_prefix(line)
    local prefix = line:match("^%s*") or ""
    local content = line:sub(#prefix + 1)

    while true do
        local blockquote = content:match("^(>%s*)")
        if blockquote == nil then
            break
        end
        prefix = prefix .. blockquote
        content = content:sub(#blockquote + 1)
    end

    local list_marker = content:match("^([%-%+%*]%s+)")
    if list_marker ~= nil and content:sub(#list_marker + 1, #list_marker + 1) == "|" then
        prefix = prefix .. list_marker
        content = content:sub(#list_marker + 1)
    else
        list_marker = content:match("^(%d+[.)]%s+)")
        if list_marker ~= nil and content:sub(#list_marker + 1, #list_marker + 1) == "|" then
            prefix = prefix .. list_marker
            content = content:sub(#list_marker + 1)
        end
    end

    return prefix, content
end

local function build_separator(cell, width)
    local left_aligned = cell:sub(1, 1) == ":"
    local right_aligned = cell:sub(-1) == ":"

    if left_aligned and right_aligned then
        return ":" .. string.rep("-", math.max(width - 2, 1)) .. ":"
    end

    if left_aligned then
        return ":" .. string.rep("-", math.max(width - 1, 2))
    end

    if right_aligned then
        return string.rep("-", math.max(width - 1, 2)) .. ":"
    end

    return string.rep("-", math.max(width, 3))
end

local function pad_cell(cell, width)
    return cell .. string.rep(" ", width - vim.fn.strdisplaywidth(cell))
end

local function format_table_under_cursor()
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row = cursor[1]
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local current_line = lines[row]

    if not is_table_candidate(current_line) or is_inside_fenced_code_block(lines, row) then
        return false
    end

    local start_row = row
    while start_row > 1 and is_table_candidate(lines[start_row - 1]) do
        start_row = start_row - 1
    end

    local end_row = row
    while end_row < #lines and is_table_candidate(lines[end_row + 1]) do
        end_row = end_row + 1
    end

    local parsed_rows = {}
    local delimiter_index = nil

    for i = start_row, end_row do
        local prefix, content = split_row_prefix(lines[i])
        parsed_rows[#parsed_rows + 1] = {
            prefix = prefix,
            cells = split_row(content),
        }
        if delimiter_index == nil and is_delimiter_row(parsed_rows[#parsed_rows].cells) then
            delimiter_index = #parsed_rows
        end
    end

    if delimiter_index == nil or delimiter_index == 1 then
        return false
    end

    local column_count = 0
    for _, row_data in ipairs(parsed_rows) do
        column_count = math.max(column_count, #row_data.cells)
    end

    local widths = {}
    for column = 1, column_count do
        widths[column] = 3
    end

    for index, row_data in ipairs(parsed_rows) do
        local cells = row_data.cells
        for column = 1, column_count do
            cells[column] = cells[column] or ""
            if index ~= delimiter_index then
                widths[column] = math.max(widths[column], vim.fn.strdisplaywidth(cells[column]))
            end
        end
    end

    local formatted_lines = {}

    for index, row_data in ipairs(parsed_rows) do
        local cells = row_data.cells
        local formatted_cells = {}
        for column = 1, column_count do
            if index == delimiter_index then
                formatted_cells[column] = build_separator(cells[column], widths[column])
            else
                formatted_cells[column] = pad_cell(cells[column], widths[column])
            end
        end

        formatted_lines[index] = row_data.prefix .. "| " .. table.concat(formatted_cells, " | ") .. " |"
    end

    vim.api.nvim_buf_set_lines(bufnr, start_row - 1, end_row, false, formatted_lines)

    return true
end

return {
    dir = vim.fn.stdpath("config"),
    name = "format-md-table",
    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "markdown",
            callback = function(args)
                vim.keymap.set("n", "<leader>tt", format_table_under_cursor, {
                    buffer = args.buf,
                    noremap = true,
                    silent = true,
                    desc = "Format markdown table",
                })
            end,
        })
    end,
}
