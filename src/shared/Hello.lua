local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vlad = require(ReplicatedStorage.Common.Vlad)

local Hello = {
    Name = "Hello",
    Utility = "Component"
}

function Hello:Initialize()
    --Something here
end

function Hello:FrameworkStarted()
    
end

return Hello