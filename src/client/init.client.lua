local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vlad = require(ReplicatedStorage.Common.Vlad)

Vlad:AddModule(ReplicatedStorage.Common.Hello, "Common")
Vlad:AddModule(ReplicatedStorage.Common.Test, "Common")

Vlad:Start(function()
    print("Started")
end)