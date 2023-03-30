local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vlad = require(ReplicatedStorage.Common.Vlad)

local Test = Vlad:Create({
    Name = "Test",
    Utility = "Common",
    ConnectFunctions = {}
})

local Signal
local States

function Test:Initialize()
    Signal = Vlad:Get("Signal")
    States = Vlad:Get("States")
end

function Test:FrameworkStarted()
    local Folder = States:GetFolder("TestFolder")
    
    Signal:ConnectTo(Folder:GetSignalUUIDs().StateChanged, function(...)
        print("State Changed", ...)
    end)
end

function Test.ConnectFunctions:TestSignal(...)
    print(...)
end

return Test