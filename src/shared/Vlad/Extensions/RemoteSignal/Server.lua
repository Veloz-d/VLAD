local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vlad = require(ReplicatedStorage.Common.Vlad)

local RemoteSignal = {
    Name = "RemoteSignal",
    Utility = "Extension",
    FrameworkCommunication = {},
    NumberToString = {}
}

local States

local FrameworkSignal

local function CreateRemoteSignal(Name, Parent)
    local NewSignal = Instance.new("RemoteEvent")
    NewSignal.Name = Name
    NewSignal.Parent = Parent

    return NewSignal
end

function RemoteSignal:Initialize()
    local NewFolder

    if not ReplicatedStorage:FindFirstChild("Remotes") then
        NewFolder = Instance.new("Folder")
        NewFolder.Name = "Remotes"
        NewFolder.Parent = ReplicatedStorage
    else
        NewFolder = ReplicatedStorage.Remotes
    end

    FrameworkSignal = CreateRemoteSignal("FrameworkSignal", NewFolder)

    FrameworkSignal.OnServerEvent:Connect(function(...)
        print("Received", ...)
    end)
end

function RemoteSignal:ExtensionsStarted()
    States = Vlad:Get("States")
end

function RemoteSignal:InitializingModule(Module: {any})
    if Module.Client then
        local NumberToString = {}

        for Index, Value in Module.Client do
            if typeof(Value) == "function" then
                NumberToString[#NumberToString+1] = Index
            end
        end

        self.NumberToString[Module.Name] = NumberToString

        local Signal = CreateRemoteSignal(Module.Name, ReplicatedStorage.Remotes)

        Signal.OnServerEvent:Connect(function(Player, ...)
            self:IncomingMethodCall(Player, Signal, ...)
        end)
    end
end

function RemoteSignal:FrameworkCommunicationCalled(Player, MethodName, ...)
    print("Received")
    if self.FrameworkCommunication[MethodName] then
        self.FrameworkCommunication[MethodName](self, Player, ...)
    end
end

function RemoteSignal.FrameworkCommunication:RequestInformation(Player, ...)
    
end

function RemoteSignal:FrameworkStarted()
    print(self.NumberToString)
end

function RemoteSignal:IncomingMethodCall(Player, Signal, Number)
    print("Incoming method call")
end

--[[
    Client:

    local Methods = RemoteSignal:GetRemoteMethodsFrom("ModuleName")

    Methods:MethodName(...):OnResponse(function(...)
        print(...)
    end)

    (done)

    Server:

    function ModuleName.Client:MethodName(Player, ...)
        -- whatever here

        return ... -- sends back to client
    end
]]

return RemoteSignal