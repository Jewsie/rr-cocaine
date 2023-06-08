local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('rr-cocaine:server:pickupcoke')
AddEventHandler('rr-cocaine:server:pickupcoke', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem(CONFIG.CokeLeafItem, CONFIG.CokePicked)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[CONFIG.CokeLeafItem], "add")
end)