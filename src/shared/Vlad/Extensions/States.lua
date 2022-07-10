local ReplicatedStorage = game:GetService("ReplicatedStorage")

local States = {
    Name = "States"
}

local Vlad = require(ReplicatedStorage.Common.Vlad)

function States:Initialize()
    print("Initializing")
end

function States:ExtensionsStarted()
    print("Extensions started")
end

function States:InitializingModule(Module: {any})
    print("Initializing Module", Module)
end

function States:FrameworkStarted()
    print("Framework started")
end

return States