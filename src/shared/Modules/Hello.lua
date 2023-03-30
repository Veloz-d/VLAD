local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vlad = require(ReplicatedStorage.Common.Vlad)

local Hello = Vlad:Create({
    Name = "Hello",
    Utility = "Common",

    SignalsToCreate = {
        "TestSignal"
    },

    FoldersToCreate = {
        "TestFolder"
    }
})

local Signal
local States

function Hello:Initialize()
    Signal = Vlad:Get("Signal")
    States = Vlad:Get("States")
end

function Hello:FrameworkStarted()
    Signal:Fire("TestSignal", "test")

    task.spawn(function()
        task.wait()
        self.CreatedFolders.TestFolder:Set("TestState", "yes")
    end)
end

return Hello