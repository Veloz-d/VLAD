local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vlad = require(ReplicatedStorage.Common.Vlad)

local module = {
    Name = "module",
    Utility = "Common"
}

function module:Initialize()
    print("Initializing module")
end

function module:FrameworkStarted()
    -- Something here
end

return module