-- http://lua-users.org/wiki/FileInputOutput
local frames = {}

-- see if the file exists
function file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
  end
  
-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
function lines_from(file)
  if not file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end


function split_line(inputstr, sep)
    sep=sep or '%s'
    local t={}
    for field in string.gmatch(inputstr, "([^"..sep.."]*)("..sep.."?)") do
        table.insert(t,field)
    end
    return t
end


function fillna(table, fill_val)
    fill_val = fill_val or 0

    for i, value in ipairs(table) do
        if #value == 0 then
            table[i] = fill_val
        end
    end
    return table
end


function frames.from_csv(filename)
  local stats_frame = {}
  local lines = lines_from(filename)
  local split = {}
  for i, value in ipairs(lines) do
      split = split_line(value, ",")
      split = fillna(split)
      if i > 1 then
          for j = 2, #split do
              if type(split[j]) == "string" then
                  split[j] = tonumber(split[j])
              end
          end
      end
      table.insert(stats_frame, split)
  end
  return stats_frame
end


return frames
  