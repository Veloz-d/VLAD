local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vlad = require(ReplicatedStorage.Common.Vlad)

Vlad:AddModules(script)

Vlad:Start(function()
    print("Server Started")
end)