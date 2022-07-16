local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Folder = {
    SignalUUIDs = {},
    States = {},
}
Folder.__index = Folder

local Vlad = require(ReplicatedStorage.Common.Vlad)
local Signal = Vlad:Get("Signal")

function Folder.New(StarterTable)
    local NewMetatable = setmetatable(StarterTable or {}, Folder)
    NewMetatable:Initialize()
    return NewMetatable
end

function Folder:Initialize()
    local _, UUID = Signal:Add(nil)

    self.SignalUUIDs.StateChanged = UUID
end

function Folder:Set(Name, Value)
    if not Name then
        error("No name specified")
    end

    self.States[Name] = Value
    Signal:Fire(self.SignalUUIDs.StateChanged, Name, Value)
end

function Folder:Get(Name)
    if not Name then
        error("No name specified")
    end

    return self.States[Name]
end

function Folder:GetSignalUUIDs()
    return self.SignalUUIDs
end

return Folder