--[=[
    @class Cooldown
    Basic stateful class for managing cooldowns.
]=]

local Cooldown = {}
Cooldown.__index = Cooldown

--[=[
    @within Cooldown
    @param cooldownTime number
    @return Cooldown

    ```lua
    local cooldown = Cooldown.new(5)
    ```
]=]
function Cooldown.new(cooldownTime: number)
    local self = setmetatable({}, Cooldown)

    self.CooldownTime = cooldownTime
    self.LastTime = 0

    return self
end

--[=[
    @within Cooldown
    @return boolean
    Returns whether the cooldown has elapsed since the last time it was polled.

    ```lua
    if cooldown:Peek() then
        -- do something
    end
    ```
]=]
function Cooldown:Peek()
    local elapsedTime = os.clock() - self.LastTime
    return elapsedTime >= self.CooldownTime
end

--[=[
    @within Cooldown
    Resets the cooldown.
]=]

function Cooldown:Reset()
    self.LastTime = os.clock()
end

--[=[
    @within Cooldown
    @return boolean
    Returns whether the cooldown has elapsed since the last time it was polled, and resets the cooldown if it has.


    ```lua
    if cooldown:Poll() then
        -- do something
    end

    -- Equivalent to
    if cooldown:Peek() then
        cooldown:Reset()
        -- do something
    end
    ```
]=]
function Cooldown:Poll()
    if not self:Peek() then
        return false
    end

    self:Reset()
    return true
end

return Cooldown