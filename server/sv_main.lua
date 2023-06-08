local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('rr-cocaine:server:prepcoke')
AddEventHandler('rr-cocaine:server:prepcoke', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cokeleafItem = Player.Functions.GetItemByName(CONFIG.CokeLeafItem)

    if cokeleafItem ~= nil and cokeleafItem.amount >= CONFIG.CokeLeafsNeeded then
        Player.Functions.RemoveItem(CONFIG.CokeLeafItem, CONFIG.CokeLeafsNeeded)
        Player.Functions.AddItem(CONFIG.ProcessedCokeItem, CONFIG.ProcessedCokeGiven)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[CONFIG.CokeLeafItem], "add")
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[CONFIG.ProcessedCokeItem], "remove")
    else
        TriggerClientEvent('rr-cocaine:cline:nocokeleaf', src)
    end
end)

RegisterServerEvent('rr-cocaine:server:bagcoke')
AddEventHandler('rr-cocaine:server:bagcoke', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local processedCokeItem = Player.Functions.GetItemByName(CONFIG.ProcessedCokeItem)

    if processedCokeItem ~= nil and processedCokeItem.amount >= CONFIG.ProcessedCokeNeeded then
        Player.Functions.RemoveItem(CONFIG.ProcessedCokeItem, CONFIG.ProcessedCokeNeeded)
        Player.Functions.AddItem(CONFIG.BaggedCokeItem, CONFIG.CokeBaggyGiven)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[CONFIG.ProcessedCokeItem], "remove")
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[CONFIG.BaggedCokeItem], "add")
    else
        TriggerClientEvent('rr-cocaine:cline:noprocessedcoke', src)
    end
end)

RegisterServerEvent('rr-cocaine:server:packcoke')
AddEventHandler('rr-cocaine:server:packcoke', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local baggedCoke = Player.Functions.GetItemByName(CONFIG.BaggedCokeItem)

    if baggedCoke ~= nil and baggedCoke.amount >= CONFIG.ProcessedCokeNeeded then
        Player.Functions.RemoveItem(CONFIG.BaggedCokeItem, CONFIG.CokeBagsNeeded)
        Player.Functions.AddItem(CONFIG.PackedCokeItem, CONFIG.CokePackagesGiven)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[CONFIG.BaggedCokeItem], "remove")
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[CONFIG.PackedCokeItem], "add")
    else
        TriggerClientEvent('rr-cocaine:cline:nopackagedcoke', src)
    end
end)