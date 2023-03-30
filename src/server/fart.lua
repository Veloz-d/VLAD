local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vlad = require(ReplicatedStorage.Common.Vlad)

local fart = Vlad:Create({
    Name = "fart",
    Utility = "Common",
    Client = {}
})

function fart:Initialize()
    --Something here
end

function fart:FrameworkStarted()
    
end

function fart.Client:TestMethod()
    print("called from client")

    return "something"
end

return fart