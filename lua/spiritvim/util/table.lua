---@class spiritvim.util.table
local M = {}

---Checks if any value in the collection passes the predicate
---@param collection table The collection to iterate over
---@param predicate function The predicate to check
function M.any(collection, predicate)
  for _, value in ipairs(collection) do
    if predicate(value) then
      return true
    end
  end
  return false
end

--- This extends a deeply nested list with a key in a table
--- that is a dot-separated string.
--- The nested list will be created if it does not exist.
---@generic T
---@param t T[]
---@param key string
---@param values T[]
---@return T[]?
function M.extend(t, key, values)
  local keys = vim.split(key, '.', { plain = true })
  for i = 1, #keys do
    local k = keys[i]
    t[k] = t[k] or {}
    if type(t) ~= 'table' then
      return
    end
    t = t[k]
  end
  return vim.list_extend(t, values)
end

return M
