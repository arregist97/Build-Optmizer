--column functions
local columns = {}


function columns.avg(values)
    if type(values) ~= "table" then
        error("Input must be of type table")
    end
    local num_values = 0
    local sum = 0
    for _,value in pairs(values) do
        num_values = num_values + 1
        sum = sum + value
    end
    if num_values == 0 then
        return 0
    end
    return sum / num_values
end


function columns.drop(table, drop_val)
    if type(table) ~= "table" then
        error("Input must be of type table")
    end
    cleaned = {}
    for key, value in pairs(table) do
        if value ~= drop_val then
            cleaned[key] = value
        end
    end
    return cleaned
end


function columns.scale(table, factor)
    if type(table) ~= "table" then
        error("Input must be of type table")
    end
    local scaled_col = {}
    for key, value in pairs(table) do
        local scaled_val = value * factor
        scaled_col[key] = scaled_val
    end
    return scaled_col
end


function columns.divide(dividend_column, divisor_column)
    if type(dividend_column) ~= "table" or type(divisor_column) ~= "table" then
        error("Inputs must be of type table")
    end
    local quotient_table = {}
    for key, value in pairs(divisor_column) do
        if divisor_column[key] == 0 then
            error("Cannot divide by zero")
        end
        local quotient = dividend_column[key] / divisor_column[key]
        table.insert(quotient_table,quotient)
    end
    return quotient_table
end


function columns.combine(columns)
    if type(columns) ~= "table" then
        error("Input must be of type table")
    end
    local combined = {}
    for i, value in ipairs(columns) do
        for key, value in pairs(columns[i]) do
            if combined[key] == nil then
                combined[key] = 0
            end
            combined[key] = combined[key] + value
        end
    end
    return combined
end


function columns.print(table)
    if type(table) ~= "table" then
        error("Input must be of type table")
    end
    for key, value in pairs(table) do
        print(key, value)
    end
end


function get_col_num(stats_frame, stat)
    local col_num = 0
    for i=1, #stats_frame[1] do
        if stats_frame[1][i] == stat then
            col_num = i
            break 
        end
    end
    if col_num == 0 then
        error("Stat "..stat.." not found")
    end
    if col_num == 1 then
        error("Name column cannot be operated on")
    end
    return col_num
end


function columns.create(stats_frame, stat)
    if type(stats_frame) ~= "table" then
        error("Input must be of type table")
    end
    local col_num = get_col_num(stats_frame, stat)
    local stat_column = {}
    for i=2, #stats_frame do
        if type(stats_frame[i]) ~= "table" then
            error("Expected type table instead of"..type(stats_frame[i]))
        end
        if #stats_frame[i] < col_num then
            error("Column index out of bounds")
        end
        stat_column[stats_frame[i][1]] = stats_frame[i][col_num]
    end
    return stat_column
end


return columns