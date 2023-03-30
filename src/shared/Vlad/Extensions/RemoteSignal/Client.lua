local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Vlad = require(ReplicatedStorage.Common.Vlad)

local RemoteSignal = {
    Name = "RemoteSignal",
    Utility = "Extension",
    ServerModules = {},
    RemoteSignals = {}
}

--[[
    1 - Call
    2 - Respond
    3 - RequestInformation
]]

local Remote = require(script.Parent:WaitForChild("RemoteSignal"))

function RemoteSignal:Initialize()
    --Something here
end

function RemoteSignal:FrameworkStarted()
    local Connection

    for _, Remote in ReplicatedStorage.Remotes:GetChildren() do
        self:AddSignal(Remote.Name, Remote)
    end

    Connection = self:Call("FrameworkSignal", 3):ConnectTo(function(SignalType, ModuleInfo)
        if SignalType == 3 then
            self:Prepare(ModuleInfo)
            Connection:Disconnect()
        end
    end)
end

        --[[
            Nested -

            Main {
                Module {
                    (array)
                    Number = MethodName
                }
            }
        ]]


function RemoteSignal:Prepare(ModuleList)
    for ModuleName, Module in pairs(ModuleList) do
        for FunctionNumber, FunctionName in Module do
            self.ServerModules[ModuleName] = function()
                
            end
        end
    end
end

function RemoteSignal:AddSignal(SignalName, Event)
    self.RemoteSignals[SignalName] = Remote.New(Event)
end

function RemoteSignal:Get(SignalName, ...)
    return self.RemoteSignals[SignalName]
end

function RemoteSignal:Call(SignalName, ...)
    return self.RemoteSignals[SignalName]:Call(...)
end

function RemoteSignal:GetRemoteMethodsFrom(Name)
    
end

return RemoteSignal