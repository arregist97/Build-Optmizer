Columns = require("columns")

--stats_frame functions
local builds = {}


function builds.print(table)
    if type(table) ~= "table" then
        error("Input must be of type table")
    end
    for key, value in pairs(table) do
        print(key, value)
    end
end


function create_build(stat_column)
    local keys = {}
    for key, _ in pairs(stat_column) do
        table.insert(keys, key)
    end
    table.sort(keys, function(keyLhs, keyRhs) return stat_column[keyLhs] > stat_column[keyRhs] end)

    local build = table.move(keys, 1, 6, 1, {})
    return build
end


function builds.optimize_for_stat(stats_frame, stat)
    if stat == "Name" then
        error("Cannot optimize for Name")
    end 
    local stat_column = Columns.create(stats_frame, stat)
    local build = create_build(stat_column)
    return build
end


function builds.optimize_multiple_stats(stats_frame, stats)
    local columns = {}
    table.insert(columns, Columns.create(stats_frame, "Price"))
    for _, stat in pairs(stats) do
        if stat == "Name" then
            error("Cannot optimize for Name")
        end
        table.insert(columns, Columns.create(stats_frame, stat))
    end

    local scaled_cols = {}
    for i=2,#columns do
        local cleaned_column = Columns.drop(columns[i], 0)
        local rate_column = Columns.divide(columns[1], cleaned_column)
        local avg_rate = Columns.avg(rate_column)
        local scaled_column = Columns.scale(columns[i], avg_rate)
        table.insert(scaled_cols, scaled_column)
    end
    local combined_col = Columns.combine(scaled_cols)
    local build = create_build(combined_col)
    return build
end


return builds