-- Defining ESX and its neccesary components
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('dans_methlabs:server:goodToCook', function(source, cb) -- Registers the Callback to verify the Cook has all items
    local sourcePlayer = ESX.GetPlayerFromId(source) -- Getting the cook
    local methRecipe = sourcePlayer.getInventoryItem('methrecipe').count -- Gets the item from the Cooks inventory
    local Matchbox = sourcePlayer.getInventoryItem('match_box').count -- Gets the item from the Cooks inventory
    local Ammonia = sourcePlayer.getInventoryItem('ammonia').count -- Gets the item from the Cooks inventory
    local Water = sourcePlayer.getInventoryItem('water').count -- Gets the item from the Cooks inventory
    local Beer = sourcePlayer.getInventoryItem('beer').count -- Gets the item from the Cooks inventory
    local Methyl = sourcePlayer.getInventoryItem('methylamine').count -- Gets the item from the Cooks inventory
    local Baggie = sourcePlayer.getInventoryItem('empty_baggie').count -- Gets the item from the Cooks inventory

    -- Defining the variables to send Bools to Client
    local hasRecipe = false
    local hasMatches = false
    local hasAmmonia = false
    local hasWater = false
    local hasBeer = false
    local hasMethyl = false
    local hasBaggie = false

    if methRecipe >= 1 then -- Checks if the Cook has a Meth Recipe | Amount is (1)
        hasRecipe = true
    else
        hasRecipe = false
    end

    if Matchbox >= Config.Items.MatchesRequired.Matches then -- Checks if the Cook has a Matchbox | Amount is specified in the config
        hasMatches = true
    else
        hasMatches = false
    end
    
    if Ammonia >= Config.Items.AmmoniaRequired.Ammonia then -- Checks if the Cook has a Bottle of Ammonia | Amount is specified in the config
        hasAmmonia = true
    else
        hasAmmonia = false
    end

    if Water >= Config.Items.WaterRequired.Water then -- Checks if the Cook has a Bottle of Water | Amount is specified in the config
        hasWater = true
    else
        hasWater = false
    end

    if Beer >= Config.Items.BeerRequired.Beer then -- Checks if the Cook has a Bottle of Beer | Amount is specified in the config
        hasBeer = true
    else
        hasBeer = false
    end

    if Methyl >= Config.Items.MethylRequired.Methyl then -- Checks if the Cook has a Bottle of Methylamine | Amount is specified in the config
        hasMethyl = true
    else
        hasMethyl = false
    end

    if Baggie >= Config.Items.BaggiesRequired.Baggies then -- Checks if the Cook has a Baggie | Amount is specified in the config
        hasBaggie = true
    else
        hasBaggie = false
    end

    cb(hasRecipe, hasMatches, hasAmmonia, hasWater, hasBeer, hasMethyl, hasBaggie) -- Sends variables to the Client
end)

RegisterNetEvent('dans_methlabs:server:removeItems')
AddEventHandler('dans_methlabs:server:removeItems', function(item) -- Registers the Callback to remove the Cooking Ingredients from the Cook
    local sourcePlayer = ESX.GetPlayerFromId(source) -- Gets the Cook

    if (item == 'match_box') then
        sourcePlayer.removeInventoryItem(item, Config.Items.MatchesRequired.Matches) -- Removes the Ingredient from the Cook
    elseif (item == 'ammonia') then
        sourcePlayer.removeInventoryItem(item, Config.Items.AmmoniaRequired.Ammonia) -- Removes the Ingredient from the Cook
    elseif (item == 'water') then
        sourcePlayer.removeInventoryItem(item, Config.Items.WaterRequired.Water) -- Removes the Ingredient from the Cook
    elseif (item == 'beer') then
        sourcePlayer.removeInventoryItem(item, Config.Items.BeerRequired.Beer) -- Removes the Ingredient from the Cook
    elseif (item == 'methylamine') then
        sourcePlayer.removeInventoryItem(item, Config.Items.MethylRequired.Methyl) -- Removes the Ingredient from the Cook
    elseif (item == 'empty_baggie') then
        sourcePlayer.removeInventoryItem(item, Config.Items.BaggiesRequired.Baggies) -- Removes the Ingredient from the Cook
    else
        print('wtf') -- Error Message just in case
    end
end)

RegisterNetEvent('dans_methlabs:server:getMethBags') -- Registers the Event that gives the Cook his Meth Bags once the cooking session has concluded
AddEventHandler('dans_methlabs:server:getMethBags', function(amount) -- Adds the Event Handler, grabbing the amount from the Client script | client/main.lua - line 95
    local sourcePlayer = ESX.GetPlayerFromId(source) -- Gets the Cook

    sourcePlayer.addInventoryItem('methbag', amount) -- Adds the specified amount of Meth Bags to the Cooks inventory
end)

ESX.RegisterUsableItem('methrecipe', function(source) -- Registers the Meth Recipe item to allow it to be opened
    local sourcePlayer = ESX.GetPlayerFromId(source) -- Gets the Cook
    TriggerClientEvent('dans_methlabs:client:OpenRecipe', source) -- Opens the Meth Recipe once the item is used
end)