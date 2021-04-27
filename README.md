# dans_methvans
A Meth Van script for players to cook on the go.
Utilises the Journey Van for that Breaking Bad experience.

## Requirements
- A working server running ESX v1 final
- MythicNotify
- ProgressBars

## Getting Started
Drag and drop the script into your resources folder and add 'start dans_methvans'

When in game, players need to be seated in the backseat of the vehicle. 
Once they are there and possess all the required items, pressing 'G' will start the cooking process.

Items that are added are listed below.
- Meth Recipe: This item can be used to see the required items.
- Ammonia: Needed for cooking.
- Methylamine: Needed for cooking.
- Empty Baggies: Needed for cooking.
- Water: Needed for cooking.
- Beer: Needed for cooking.
- Matchbox: Needed for cooking.
- Meth Bag: Reward for cooking.

The amounts that are needed can be found through the Meth Recipe item.

## Configuring the Script
All the files are commented as best as I possibly could make them.

To change all timers and amounts of items needed to create the meth, as well has how many meth bags the player gets, check the config.lua
Changing the actual items required is a bit more tricky and not recommended for people who are unsure of what they are doing. (It's possible though)

There is a section commented in client/main.lua where you can add an event for alerting the police. This has not been added in this version, but there is a marked spot to add this in.

## Server Owners

To make it a smoother transition to install the script, below is some information that may come in handy.

### Items and their IDs
Items listed below are in the format of ItemDisplayName : ItemSpawnCode.

- Matchbox : match_box
- VB : beer
- Water Bottle : water
- Ammonia : ammonia
- Methylamine : methylamine
- Empty Baggie : empty_baggie
- Meth Bag : methbag
- Meth Recipe : methrecipe

As a quick note, in regards to water and beer, so long as there are items that exist with these Item codes, the script *Should* take these items.
If you already have any of these items on your server, adjust the items.sql as you see fit.

### Changing the Meth Item Output
If you already have a Meth / Drug script, and want to use the items they have for ease of access, navigate to the below code and swap the marked point out.

server/main.lua | line 95 | sourcePlayer.addInventoryItem('**CHANGE ME**', amount)

### Quickstart Guide to Getting Players Cooking
After starting the resource and adding the items to your database, a few steps can be taken to get players cooking as quick as possible.

- Add items into stores to make them purchasable.
- If you have a drug dealer, add the Meth Recipe item to the shop.

Not too many steps, but it'll get them going :)
