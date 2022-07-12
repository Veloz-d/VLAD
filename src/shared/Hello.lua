local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vlad = require(ReplicatedStorage.Common.Vlad)

local Hello = {
    Name = "Hello",
    Utility = "Common",
    SignalsToCreate = {
        "Fart"
    }
}

local Signal

function Hello:Initialize()
    Signal = Vlad:Get("Signal")
end

function Hello:FrameworkStarted()
    Signal:Fire("Fart")
end

return Hello