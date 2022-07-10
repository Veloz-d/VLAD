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

        if RequiredModule.Utility and RequiredModule.Utility ~= "Common" then
            local PreparationModule = require(script.ModuleTypes[RequiredModule.Utility])
            PreparationModule:Prepare(RequiredModule)
        end

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

    for _, ModuleInformation in self.StartedModules do
        if ModuleInformation.Module.FrameworkStarted then
            ModuleInformation.Module:FrameworkStarted()
        end
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
    end

    return ToReturn
end

return Vlad