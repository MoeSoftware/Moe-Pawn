local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback("trust-pawn:server:checkItems",function(source, cb, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Items = Player.Functions.GetItemByName(item)
    cb(Items.amount)
end)

RegisterNetEvent("trust-pawn:server:sellItems", function(item, amount, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem(item, amount) then
        TriggerClientEvent('QBCore:Notify', src, 'Congratulations, you sold ' .. amount .. " " .. item .. " for " .. price * amount,'success')
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'remove', amount)
        Player.Functions.AddMoney("cash", price * amount)
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have " .. amount .. " of " .. item,'error')
    end

end)