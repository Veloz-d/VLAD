local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vlad = require(ReplicatedStorage.Common.Vlad)

local Signal = {
    Name = "Signal",
    Utility = "Extension",
    Signals = {},
    FunctionsToConnect = {}
}

local GoodSignal = require(script:WaitForChild("GoodSignal"))

local function GenerateUUID()
    local Template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"

    return string.gsub(Template, '[xy]', function(c)
        local RNG = Random.new(os.clock())
        local v = (c == 'x') and RNG:NextInteger(0, 0xf) or RNG:NextInteger(8, 0xb)
        return string.format('%x', v)
    end)
end

-- function Signal:Initialize()
    
-- end

function Signal:InitializingModule(Module: {any})
    if Module.SignalsToCreate then
        for Index, EventName in Module.SignalsToCreate do
            self:Add(EventName)
        end
    end

    if Module.ConnectFunctions then
        for EventName, Function in Module.ConnectFunctions do
            if not self.FunctionsToConnect[EventName] then
                self.FunctionsToConnect[EventName] = {{ParentModule = Module, Function = Function}}
            else
                table.insert(self.FunctionsToConnect, {
                    ParentModule = Module,
                    Function = Function
                })
            end
        end
    end
end

function Signal:FrameworkStarted()
    for EventName, BindList in self.FunctionsToConnect do
        for _, FunctionInformation in BindList do
            self:ConnectTo(EventName, function(...)
                FunctionInformation.Function(FunctionInformation.ParentModule, ...)
            end)
        end
    end
end

function Signal:Add(Name: string?)
    if not Name then
        local UUID = GenerateUUID()
        local NewSignal = GoodSignal.new()
        self.Signals[UUID] = NewSignal

        return NewSignal, UUID
    end

    if self.Signals[Name] then
        return self.Signals[Name]
    else
        local NewSignal = GoodSignal.new()
        self.Signals[Name] = NewSignal

        return NewSignal
    end
end

function Signal:ConnectTo(Name, Function)
    if self.Signals[Name] then
        self.Signals[Name]:Connect(Function)
    end
end

function Signal:Fire(Name, ...)
    if self.Signals[Name] then
        self.Signals[Name]:Fire(...)
    end
end

function Signal:Get(Name)
    if self.Signals[Name] then
        return self.Signals[Name]
    end
end

function Signal:Once(Name, Function)
    if self.Signals[Name] then
        local Connection

        Connection = self.Signals[Name]:Connect(function(...)
            Function(...)
            Connection:Disconnect()
        end)
    end
end

return Signal