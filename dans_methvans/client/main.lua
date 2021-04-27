-- Defining ESX and its neccesary components
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

-- Defining the Meth Recipe and if its opened or not
isUiOpen = false
-- Defining the variables to recieve Bools from Server
local hasRecipe_c = false
local hasMatches_c = false
local hasAmmonia_c = false
local hasWater_c = false
local hasBeer_c = false
local hasMethyl_c = false
local hasBaggie_c = false
-- Defining the variables to recieve bools once steps have been completed
local stoveHeated = false
local beerStilled = false
local waterPoured = false
local ammoniaPoured = false
local methylPoured = false
local productsMixed = false
local crystalsCooled = false
local methBagged = false 


Citizen.CreateThread(function() -- Function that controls the whole meth cooking
    while true do
        local timer = nil
        local playerPed = PlayerPedId() -- Get the Cook

        local int veh = GetVehiclePedIsIn(PlayerPedId(), false) -- Get the vehicle
        local int model = GetEntityModel(veh) -- Get the vehicle Model

        if (IsPedInAnyVehicle(PlayerPedId(), false)) then -- Checks if Cook is in vehicle
            timer = 0
            if ( model == -120287622) then -- Checks if Cook is in the 'journey' vehicle
                timer = 0
                if GetPedInVehicleSeat(veh, 1) == playerPed then -- Checks if Cook is in the correct seat (-1: Drivers, 0: Passenger, etc) | 1 is the first back seat
                    timer = 0
                    if GetEntitySpeed(veh) < 1 then -- Checks if vehicle is driving
                        timer = 0
                        if IsControlJustReleased(0, Config.Control) then -- Checks if the 'G' key is pressed, init the rest of the script
                            timer = 0
                            ESX.TriggerServerCallback('dans_methlabs:server:goodToCook', function(hasRecipe, hasMatches, hasAmmonia, hasWater, hasBeer, hasMethyl, hasBaggie) -- Calls the init Callback to check if the Cook has all required items
                                if hasRecipe == true then -- Checks if cook has the Meth Recipe
                                    hasRecipe_c = true
                                else
                                    hasRecipe_c = false
                                end

                                if hasMatches == true then -- Checks if cook has a Box of Matches
                                    hasMatches_c = true
                                else
                                    hasMatches_c = false
                                end

                                if hasAmmonia == true then -- Checks if cook has Ammonia
                                    hasAmmonia_c = true
                                else
                                    hasAmmonia_c = false
                                end

                                if hasWater == true then -- Checks if cook has Water
                                    hasWater_c = true
                                else
                                    hasWater_c = false
                                end

                                if hasBeer == true then -- Checks if cook has Beer
                                    hasBeer_c = true
                                else
                                    hasBeer_c = false
                                end

                                if hasMethyl == true then -- Checks if cook has Methylamine
                                    hasMethyl_c = true
                                else
                                    hasMethyl_c = false
                                end

                                if hasBaggie == true then -- Checks if cook has Baggies
                                    hasBaggie_c = true
                                else
                                    hasBaggie_c = false
                                end
                            end)
                            Citizen.Wait(500) -- Gives the server a quick second to update data

                            -- Heating the Stove
                            if (stoveHeated == false and hasRecipe_c == true and hasMatches_c == true) then -- Checks if the stove has already been heated, if the Cook has the Meth Recipe and Matches
                                exports['progressBars']:startUI(Config.Timers.StoveHeating.Time, "Heating Stove..") -- Starts the Progress Bar for designated amount of time in ms
                                local itemNeeded = 'match_box'
                                TriggerServerEvent('dans_methlabs:server:removeItems', itemNeeded)
                                Citizen.Wait(Config.Timers.StoveHeating.Time) -- Disables the Cook from starting another step for the amount of time in ms
                                stoveHeated = true -- Sets the stoveHeated Var to true, allowing the Cook to continue
                                exports['mythic_notify']:SendAlert('error', 'Stove Heated, Press (G) to continue') -- Sends the Cook a prompt to signify success

                            -- Stilling the Beer
                            elseif (stoveHeated == true and beerStilled == false and waterPoured == false and hasRecipe_c == true and hasBeer_c == true) then -- Checks if the Beer hasn't been stilled yet, and checks if the Cook has a bottle of Beer and the Recipe to go ahead
                                exports['progressBars']:startUI(Config.Timers.BeerStilling.Time, "Stilling Beer..") -- Starts the Progress Bar for designated amount of time in ms
                                local itemNeeded = 'beer'
                                TriggerServerEvent('dans_methlabs:server:removeItems', itemNeeded)
                                Citizen.Wait(Config.Timers.BeerStilling.Time) -- Disables the Cook from starting another step for the amount of time in ms
                                beerStilled = true -- Sets the beerStilled Var to true, allowing the Cook to continue
                                exports['mythic_notify']:SendAlert('error', 'Beer Stilled, Press (G) to continue') -- Sends the Cook a prompt to signify success

                            -- Pouring the Water
                            elseif (beerStilled == true and waterPoured == false and ammoniaPoured == false and hasRecipe_c == true and hasWater_c == true) then -- Checks if the Water hasn't been poured yet, and checks if the Cook has a bottle of Water and the Recipe to go ahead
                                exports['progressBars']:startUI(Config.Timers.WaterPouring.Time, "Pouring Water..") -- Starts the Progress Bar for designated amount of time in ms
                                local itemNeeded = 'water'
                                TriggerServerEvent('dans_methlabs:server:removeItems', itemNeeded)
                                Citizen.Wait(Config.Timers.WaterPouring.Time) -- Disables the Cook from starting another step for the amount of time in ms
                                waterPoured = true -- Sets the waterPoured Var to true, allowing the Cook to continue
                                exports['mythic_notify']:SendAlert('error', 'Water Poured, Press (G) to continue') -- Sends the Cook a prompt to signify success

                            -- Pouring the Ammonia
                            elseif (waterPoured == true and ammoniaPoured == false and methylPoured == false and hasRecipe_c == true and hasAmmonia_c == true) then -- Checks if the Ammonia hasn't been poured yet, and checks if the Cook has a bottle of Ammonia and the Recipe to go ahead
                                exports['progressBars']:startUI(Config.Timers.AmmoniaPouring.Time, "Pouring Ammonia..") -- Starts the Progress Bar for designated amount of time in ms
                                local itemNeeded = 'ammonia'
                                TriggerServerEvent('dans_methlabs:server:removeItems', itemNeeded)
                                Citizen.Wait(Config.Timers.AmmoniaPouring.Time) -- Disables the Cook from starting another step for the amount of time in ms
                                ammoniaPoured = true -- Sets the ammoniaPoured Var to true, allowing the Cook to continue
                                exports['mythic_notify']:SendAlert('error', 'Ammonia Poured, Press (G) to continue') -- Sends the Cook a prompt to signify success

                            -- Pouring the Methylamine
                            elseif (ammoniaPoured == true and methylPoured == false and productsMixed == false and hasRecipe_c == true and hasMethyl_c == true) then -- Checks if the Methylamine hasn't been poured yet, and checks if the Cook has a bottle of Methylamine and the Recipe to go ahead
                                exports['progressBars']:startUI(Config.Timers.MethylPouring.Time, "Pouring Methylamine..") -- Starts the Progress Bar for designated amount of time in ms
                                local itemNeeded = 'methylamine'
                                TriggerServerEvent('dans_methlabs:server:removeItems', itemNeeded)
                                Citizen.Wait(Config.Timers.MethylPouring.Time) -- Disables the Cook from starting another step for the amount of time in ms
                                methylPoured = true -- Sets the methylPoured Var to true, allowing the Cook to continue
                                exports['mythic_notify']:SendAlert('error', 'Methylamine Poured, Press (G) to continue') -- Sends the Cook a prompt to signify success

                            -- Mixing all Ingredients
                            elseif (methylPoured == true and productsMixed == false and crystalsCooled == false) then -- Checks if all products have been poured, and the ingredients haven't been mixed
                                exports['progressBars']:startUI(Config.Timers.ProductMixing.Time, "Mixing Products..") -- Starts the Progress Bar for designated amount of time in ms
                                Citizen.Wait(Config.Timers.ProductMixing.Time) -- Disables the Cook from starting another step for the amount of time in ms
                                productsMixed = true -- Sets the productsMixed Var to true, allowing the Cook to continue
                                exports['mythic_notify']:SendAlert('error', 'Products Mixed, Press (G) to continue') -- Sends the Cook a prompt to signify success

                            -- Cooling Meth Crystals
                            elseif (productsMixed == true and crystalsCooled == false and methBagged == false) then -- Checks if products have been Melted, and the crystals have not been cooled
                                exports['progressBars']:startUI(Config.Timers.CrystalCooling.Time, "Cooling Crystals..") -- Starts the Progress Bar for designated amount of time in ms
                                Citizen.Wait(Config.Timers.CrystalCooling.Time) -- Disables the Cook from starting another step for the amount of time in ms
                                crystalsCooled = true -- Sets the crystalsCooled Var to true, allowing the Cook to continue
                                exports['mythic_notify']:SendAlert('error', 'Crystals Cooled, Press (G) to continue') -- Sends the Cook a prompt to signify success

                            -- Bagging up Meth
                            elseif (crystalsCooled == true and methBagged == false and hasRecipe_c == true and hasBaggie_c == true) then -- Checks if the crystals have been cooled and the Cook has baggies, allowing the Cook to bag up the Meth
                                exports['progressBars']:startUI(Config.Timers.MethBagging.Time, "Bagging Meth..") -- Starts the Progress Bar for designated amount of time in ms
                                local itemNeeded = 'empty_baggie'
                                TriggerServerEvent('dans_methlabs:server:removeItems', itemNeeded)
                                Citizen.Wait(Config.Timers.MethBagging.Time) -- Disables the Cook from starting another step for the amount of time in ms
                                methBagged = true -- Sets the methBagged Var to true, allowing the Cook to continue
                                exports['mythic_notify']:SendAlert('error', 'Meth Bagged, Press (G) to continue') -- Sends the Cook a prompt to signify success

                            -- Collecting the Meth
                            elseif (methBagged == true) then -- Checks if the meth has been bagged up, for the Cook to recieve their Meth
                                exports['progressBars']:startUI(Config.Timers.MethPackaging.Time, "Picking up Meth..") -- Starts the Progress Bar for designated amount of time in ms
                                Citizen.Wait(Config.Timers.MethPackaging.Time) -- Disables the Cook from starting another step for the amount of time in ms
                                TriggerServerEvent('dans_methlabs:server:getMethBags', Config.Items.MethBagReward.Reward) -- Triggers a server event to give the Cook the specified amount of Meth Bags
                                stoveHeated = false -- Sets the stoveHeated Var to false, allowing the Cook to restart
                                beerStilled = false -- Sets the beerStilled Var to false, allowing the Cook to restart
                                waterPoured = false -- Sets the waterPoured Var to false, allowing the Cook to restart
                                ammoniaPoured = false -- Sets the ammoniaPoured Var to false, allowing the Cook to restart
                                methylPoured = false -- Sets the methylPoured Var to false, allowing the Cook to restart
                                productsMixed = false -- Sets the productsMixed Var to false, allowing the Cook to restart
                                crystalsCooled = false -- Sets the crystalsCooled Var to false, allowing the Cook to restart
                                methBagged = false -- Sets the methBagged Var to false, allowing the Cook to restart
                                exports['mythic_notify']:SendAlert('error', 'Meth Collected. Press (G) to Cook Again') -- Sends the Cook a prompt to signify success

                                -- EXTRA SPACE TO ADD AN ALERT FOR POLICE IF REQUIRED.
                            else
                                exports['mythic_notify']:SendAlert('error', 'You Do Not Possess the Correct Items!') -- This is here to show the Cook that something hasn't gone right
                            end
                        end
                    else
                        timer = 1000
                    end
                else
                    timer = 2000
                end
            else
                timer = 5000
            end
        else
            timer = 2000
        end
        Citizen.Wait(timer)
    end
end)

RegisterNetEvent('dans_methlabs:client:OpenRecipe') -- Registers the OpenRecipe Event
AddEventHandler('dans_methlabs:client:OpenRecipe', function() -- Registers the Event Handler for the OpenRecipe Event
    if not isUiOpen then -- If the Menu isn't open already, open it
        OpenMethRecipe() -- Inits the OpenMethRecipe function
    end
end)

function OpenMethRecipe() -- The Meth Recipe Viewing function
    local elements = {} -- Creates the elements var

        table.insert(elements, {label = "1 Matchbox"}) -- Adds to the elements var | 1 insert = 1 new line in the menu
        table.insert(elements, {label = "1 Bottle of Water"}) -- Adds to the elements var | 1 insert = 1 new line in the menu 
        table.insert(elements, {label = "2 Bottle of Beer"}) -- Adds to the elements var | 1 insert = 1 new line in the menu 
        table.insert(elements, {label = "2 Bottle of Ammonia"}) -- Adds to the elements var | 1 insert = 1 new line in the menu 
        table.insert(elements, {label = "2 Bottle of Methylamine"}) -- Adds to the elements var | 1 insert = 1 new line in the menu
        table.insert(elements, {label = "2 Empty Baggies"}) -- Adds to the elements var | 1 insert = 1 new line in the menu  
        table.insert(elements, {label = "Gets you a couple Meth Bags"}) -- Adds to the elements var | 1 insert = 1 new line in the menu 

        ESX.UI.Menu.CloseAll() -- Close extra menus that may be open

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'recipeMethO', {
            title = "Meth Recipe", -- Menu title
            align = 'top-left', -- Menu alignment
            elements = elements -- Gets elements from top of function and calls them now
        }, function(data, menu)
        end, function(data, menu)
            menu.close()
    end)
end
