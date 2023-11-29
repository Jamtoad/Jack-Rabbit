local Root = {}
local function GetConfiguration(Instance, Async_3f)
  return Instance[((Async_3f and "FindFirstChild") or "WaitForChild")](Instance, "Configuration")
end
local function GetAttribute(Configuration, Attribute)
  return Configuration:GetAttribute(Attribute)
end
local function GetAttributes(Configuration)
  return Configuration:GetAttributes()
end
local function GetSignal(Configuration, Attribute)
  return Configuration:GetAttributeChangedSignal(Attribute)
end
local function GetAnySignal(Configuration)
  return Configuration.AttributeChanged
end
local function SetAttribute(Configuration, Attribute, Value)
  Configuration:SetAttribute(Attribute, Value)
  return GetAttribute(Configuration, Attribute)
end
local function SetCallback(Signal, Callback, Configuration, Attribute)
  local PreviousValue = {}
  local function _1_(...)
    local Attribute0 = (Attribute or ...)
    local CurrentValue = GetAttribute(Configuration, Attribute0)
    Callback(CurrentValue, PreviousValue[Attribute0], ...)
    do end (PreviousValue)[Attribute0] = CurrentValue
    return nil
  end
  return Signal:Connect(_1_)
end
local function SetName(Configuration)
  Configuration.Name = "Configuration"
  return Configuration
end
local function SetParent(Configuration, Parent)
  Configuration.Parent = Parent
  return Configuration
end
Root.New = function(Instance, Template)
  local _2_ = ((Template and Template:Clone()) or Instance.new("Configuration"))
  if (nil ~= _2_) then
    local _3_ = SetName(_2_)
    if (nil ~= _3_) then
      return SetParent(_3_, Instance)
    else
      return _3_
    end
  else
    return _2_
  end
end
Root.Set = function(Instance, Attribute, Value)
  local _6_ = GetConfiguration(Instance)
  if (nil ~= _6_) then
    return SetAttribute(_6_, Attribute, Value)
  else
    return _6_
  end
end
Root.Get = function(Instance, Attribute, Async_3f)
  local _8_ = GetConfiguration(Instance, Async_3f)
  if (nil ~= _8_) then
    return GetAttribute(_8_, Attribute)
  else
    return _8_
  end
end
Root.GetAll = function(Instance)
  local _10_ = GetConfiguration(Instance)
  if (nil ~= _10_) then
    return GetAttributes(_10_)
  else
    return _10_
  end
end
Root.Connect = function(Instance, Attribute, Callback)
  local Configuration = GetConfiguration(Instance)
  local function _12_()
    local _13_ = GetSignal(Configuration, Attribute)
    if (nil ~= _13_) then
      return SetCallback(_13_, Callback, Configuration, Attribute)
    else
      return _13_
    end
  end
  return (Configuration and _12_())
end
Root.ConnectAny = function(Instance, Callback)
  local Configuration = GetConfiguration(Instance)
  local function _15_()
    return SetCallback(GetAnySignal(Configuration), Callback, Configuration)
  end
  return (Configuration and _15_())
end
return Root
