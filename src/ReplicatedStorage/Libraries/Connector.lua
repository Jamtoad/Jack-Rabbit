local function _1_(Host, Event, Callback, ...)
  local Event0 = (Host[Event] or Event)
  if Event0 then
    local Arguments = {...}
    local function _2_(...)
      for _, Argument in ... do
        table.insert(Arguments, Argument)
      end
      return Callback(table.unpack(Arguments))
    end
    return Event0:Connect(_2_)
  else
    return warn(("Event is not a valid member of " .. Host))
  end
end
return _1_
