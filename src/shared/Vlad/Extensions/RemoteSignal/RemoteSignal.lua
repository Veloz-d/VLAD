local module = {}
module.__index = module
function module:__call(self, ...)
    self:Call(1, ...)
end

function module.New(Signal)
    return setmetatable({
        Signal = Signal
    }, module)
end

--[[
    1 - Call
    2 - Respond
    3 - RequestInformation
]]

function module:Call(SignalType: number, ...)
    self.Signal:FireServer(SignalType, ...)
    return self
end

function module:OnResponse(Function) -- Once
    local Connection

    Connection = self.Signal.OnClientEvent:Connect(function(CallType: number, ...)
        if CallType == 2 then
            Function(...)
            Connection:Disconnect()
        end
    end)
end

function module:ConnectTo(Function)
    return self.Signal.OnClientEvent:Connect(function(CallType: number, ...)
        if CallType == 2 then
            Function(...)
        end
    end)
end

return module