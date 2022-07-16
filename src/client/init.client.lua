local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vlad = require(ReplicatedStorage.Common.Vlad)

Vlad:AddModule(ReplicatedStorage.Common.Hello)
Vlad:AddModule(ReplicatedStorage.Common.Test)

Vlad:Start(function()
    print("Started")
end)