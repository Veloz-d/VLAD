local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vlad = require(ReplicatedStorage.Common.Vlad)

local Signal = {
    Name = "Signal",
    Utility = "Extension",
    Signals = {}
}

local GoodSignal = require(script:WaitForChild("GoodSignal"))

function Signal:Initialize()
    
end

function Signal:InitializingModule(Module: {any})
    if not Module.SignalsToCreate then
        
    end
end

function Signal:FrameworkStarted()
    
end

return Signal