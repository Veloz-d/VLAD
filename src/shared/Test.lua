local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vlad = require(ReplicatedStorage.Common.Vlad)

local Test = {
    Name = "Test",
    Utility = "Common",
    ConnectFunctions = {}
}

function Test:Initialize()
    --Something here
end

function Test:FrameworkStarted()
    
end

function Test.ConnectFunctions:Fart()
    print(self.Utility)
end

return Test