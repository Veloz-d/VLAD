local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vlad = require(ReplicatedStorage.Common.Vlad)

local test = Vlad:Create({
    Name = "test",
    Utility = "Common",
    Client = {}
})

function test:Initialize()
    --Something here
end

function test:FrameworkStarted()
    
end

return test