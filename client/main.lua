local QBCore = exports['qb-core']:GetCoreObject()
local pedSpawned = false
local ShopPed = {}
local currentItems = {}

-- Functions
local function createBlips()
    for store, _ in pairs(Config.SellShops) do
        if Config.SellShops[store]["showblip"] then
            local StoreBlip = AddBlipForCoord(Config.SellShops[store]["coords"]["x"], Config.SellShops[store]["coords"]["y"], Config.SellShops[store]["coords"]["z"])
            SetBlipSprite(StoreBlip, Config.SellShops[store]["blipsprite"])
            SetBlipScale(StoreBlip, 0.6)
            SetBlipDisplay(StoreBlip, 4)
            SetBlipColour(StoreBlip, Config.SellShops[store]["blipcolor"])
            SetBlipAsShortRange(StoreBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.SellShops[store]["label"])
            EndTextCommandSetBlipName(StoreBlip)
        end
    end
end

local function deletePeds()
    if pedSpawned then
        for _, v in pairs(ShopPed) do
            DeletePed(v)
        end
    end
end

local function openShop(shop, data)
    currentItems = {}
    for k, v in pairs(data['products']) do 
        if not table.contains(currentItems, v.name) then
            if QBCore.Functions.HasItem(v.name) then
                currentItems[#currentItems + 1] = v
            end
        end
    end

    local list = {}
	list[#list+1] = {isMenuHeader = true,header = data['targetLabel'], txt = data["description"]}

	for k, v in pairs(currentItems) do
        local price = math.random(v.pricemin, v.pricemax)
		if QBCore.Functions.HasItem(v.name) then
			list[#list+1] = {header = QBCore.Shared.Items[v.name]['label'], txt = "Sell Price: " .. price , params = { event = "trust-pawn:client:openInput", args = {item = v, shop = data, price = price} } }
		end
	end
	list[#list+1] = { icon = "fas fa-circle-xmark", header = "", txt = "Close ❌ ", params = { event = "trust-pawn:client:closemenu"}, }
	exports["qb-menu"]:openMenu(list)
end

local function createPeds()
    if pedSpawned then return end
    for k, v in pairs(Config.SellShops) do
        if not ShopPed[k] then ShopPed[k] = {} end
        local current = v["ped"]
        current = type(current) == 'string' and joaat(current) or current
        RequestModel(current)

        while not HasModelLoaded(current) do
            Wait(0)
        end
        ShopPed[k] = CreatePed(0, current, v["coords"].x, v["coords"].y, v["coords"].z-1, v["coords"].w, false, false)
        TaskStartScenarioInPlace(ShopPed[k], v["scenario"], true)
        FreezeEntityPosition(ShopPed[k], true)
        SetEntityInvincible(ShopPed[k], true)
        SetBlockingOfNonTemporaryEvents(ShopPed[k], true)

        exports['qb-target']:AddTargetEntity(ShopPed[k], {
            options = {
                {
                    label = v["targetLabel"],
                    icon = v["targetIcon"],
                    item = v["item"],
                    action = function()
                        openShop(k, Config.SellShops[k])
                    end,
                    job = v["job"],
                    gang = v["gang"],
                }
            },
            distance = 2.0
        })
    end
    pedSpawned = true
end


function table.contains(table, element)
	for _, value in pairs(table) do
	  if value == element then
		return true
	  end
	end
	return false
end
--Events
RegisterNetEvent("trust-pawn:client:closemenu", function()
    exports['qb-menu']:closeMenu()
    list = {}
end)

RegisterNetEvent("trust-pawn:client:openInput", function(data)
    QBCore.Functions.TriggerCallback("trust-pawn:server:checkItems", function(amount)
        local sellingItem = exports['qb-input']:ShowInput({
            header = 'Sell ' .. QBCore.Shared.Items[data.item.name]['label'],
            submitText = 'Sell',
            inputs = {
                {
                    type = 'number',
                    isRequired = false,
                    name = 'amount',
                    text = "Max: " .. amount
                }
            }
        })

        if sellingItem then
            if not sellingItem.amount then
                return
            end
    
            if tonumber(sellingItem.amount) > 0 then
                TriggerServerEvent('trust-pawn:server:sellItems', data.item.name, sellingItem.amount, data.price)
            else
                QBCore.Functions.Notify("You've entered a negative number", 'error')
            end
        end
    end, data.item.name)
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    createBlips()
    createPeds()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        createBlips()
        createPeds()
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    deletePeds()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        deletePeds()
    end
end)