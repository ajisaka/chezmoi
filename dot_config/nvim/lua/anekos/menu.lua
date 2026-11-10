local M = { collected = {} }

function M.collect(name)
  return function(items)
    if not M.collected[name] then
      M.collected[name] = {}
    end

    for _, item in ipairs(items) do
      if type(item) == 'string' then
        table.insert(M.collected[name], { display = item, value = item })
      else
        table.insert(M.collected[name], item)
      end
    end
    return items
  end
end

return M
