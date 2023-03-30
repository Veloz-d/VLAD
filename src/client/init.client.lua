local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vlad = require(ReplicatedStorage.Common.Vlad)

Vlad:AddModules(ReplicatedStorage.Common.Modules)

Vlad:Start(function()
    print("Started")
end)