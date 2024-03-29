local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local States = {
    Name = "States",
    States = {},
    StateFolders = {}
}

local Vlad = require(ReplicatedStorage.Common.Vlad)
local Signal
local FolderTemplate

local function GenerateUUID()
    local Template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"

    return string.gsub(Template, '[xy]', function(c)
        local RNG = Random.new(os.clock())
        local v = (c == 'x') and RNG:NextInteger(0, 0xf) or RNG:NextInteger(8, 0xb)
        return string.format('%x', v)
    end)
end

function States:Initialize()
    print("Initializing")
end

function States:ExtensionsStarted()
    FolderTemplate = require(script.Folder)
    Signal = Vlad:Get("Signal")
    Signal:Add("StateChanged")

    if RunService:IsServer() then
        Players.PlayerAdded:Connect(function(Player)
            self:CreateFolder(Player.Name)
        end)

        Players.PlayerRemoving:Connect(function(Player)
            self:RemoveFolder(Player.Name)
        end)
    end
end

function States:InitializingModule(Module: {any})
    if Module.FoldersToCreate then
        local CreatedFolders = {}
        
        for Index, FolderName in Module.FoldersToCreate do
            CreatedFolders[FolderName] = self:CreateFolder(FolderName)
        end

        Module.CreatedFolders = CreatedFolders
        Module.FoldersToCreate = nil
    end
end

function States:Set(Name, Value)
    if not Name then
        error("No name specified")
    end

    self.States[Name] = Value
    Signal:Fire("StateChanged", Name, Value)
end

function States:Get(Name)
    if not Name then
        error("No name specified")
    end

    return self.States[Name]
end

function States:CreateFolder(Name: string?, StarterTable)
    local NewFolder = FolderTemplate.New(StarterTable)

    if Name then
        self.StateFolders[Name] = NewFolder
        return NewFolder
    else
        local UUID = GenerateUUID()

        self.StateFolders[UUID] = NewFolder
        return NewFolder, UUID
    end
end

function States:GetFolder(Name)
    return self.StateFolders[Name]
end

function States:RemoveFolder(Name)
    if not Name then
        error("No name specified")
    end

    self.StateFolders[Name] = nil
end

return States
