local Vlad = {
    ModulesToStart = {},
    StartedModules = {},
}

function Vlad:AddModule(Module: ModuleScript): nil
    table.insert(self.ModulesToStart, {
        Module = Module,
        Utility = require(Module).Utility
    })
end

function Vlad:Start(AfterStarted: nil | () -> nil): nil
    self:StartCoreExtensions()

    for Index, ModuleInformation in self.ModulesToStart do
        local RequiredModule = require(ModuleInformation.Module)

        for _, ModuleInformation in self.StartedModules do
            if ModuleInformation.Utility == "Extension" and ModuleInformation.Module.InitializingModule then
                ModuleInformation.Module:InitializingModule(RequiredModule)
            end
        end

        if RequiredModule.Initialize then
            RequiredModule:Initialize()
        end

        self.StartedModules[RequiredModule.Name] = {
            Utility = ModuleInformation.Utility,
            Module = RequiredModule
        }
        self.ModulesToStart[Index] = nil
    end

    local LateList = {}

    for _, ModuleInformation in self.StartedModules do
        if ModuleInformation.Module.FrameworkStarted then
            if ModuleInformation.Utility == "Extension" then
                ModuleInformation.Module:FrameworkStarted()
            else
                table.insert(LateList, ModuleInformation)
            end
        end
    end

    for _, ModuleInformation in LateList do
        ModuleInformation.Module:FrameworkStarted()
    end

    if AfterStarted then
        AfterStarted()
    end
end

function Vlad:StartCoreExtensions()
    for _, Module in script.Extensions:GetChildren() do
        local RequiredModule = require(Module)

        if RequiredModule.Initialize then
            RequiredModule:Initialize()
        end

        self.StartedModules[RequiredModule.Name] = {
            Utility = "Extension",
            Module = RequiredModule
        }
    end

    for _, ModuleInformation in self.StartedModules do
        if ModuleInformation.Utility == "Extension" and ModuleInformation.Module.ExtensionsStarted then
            ModuleInformation.Module:ExtensionsStarted()
        end
    end
end

function Vlad:Get(Name: string): {any}
    local ToReturn = self.StartedModules[Name]

    if not ToReturn then
        warn("No such module", Name)
        return
    else
        return ToReturn.Module
    end
end

return Vlad