LazyAlchemyLearner = {}

LazyAlchemyLearner.name = "LazyAlchemyLearner"
local basegameCombo = 
{
{77583,77591}, -- Beetle Scuttle & Mudcrab Chitin
{77583,77585}, -- Beetle Scuttle & Butterfly Wing
{77583,30152}, -- Beetle Scuttle & Violet Coprinus
{30157,30153}, -- Blessed Thistle & Namira's Rot
{30148,30154}, -- Blue Entoloma & White Cap
{30148,77585}, -- Blue Entoloma & Butterfly Wing
{30148,30165}, -- Blue Entoloma & Nirnroot
{30160,30154}, -- Bugloss & White Cap
{30164,30160}, -- Columbine & Bugloss
{30164,30159}, -- Columbine & Wormwood
{30164,30157}, -- Columbine & Blessed Thistle
{30161,30154}, -- Corn Flower & White Cap
{30161,30157}, -- Corn Flower & Blessed Thistle
{30162,30149}, -- Dragonthorn & Stinkhorn
{30162,30157}, -- Dragonthorn & Blessed Thistle
{30162,30166}, -- Dragonthorn & Water Hyacinth
{30151,30166}, -- Emetic Russula & Water Hyacinth
{30151,30152}, -- Emetic Russula & Violet Coprinus
{30151,30155}, -- Emetic Russula & Luminous Russula
{77587,77581}, -- Fleshfly Larva & Torchbug Thorax
{77587,77589}, -- Fleshfly Larva & Scrib Jelly
{77587,30156}, -- Fleshfly Larva & Imp Stool
{77587,77590}, -- Fleshfly Larva & Nightshade
{30156,30163}, -- Imp Stool & Mountain Flower
{30156,30165}, -- Imp Stool & Nirnroot
{30158,30152}, -- Lady's Smock & Violet Coprinus
{30158,30161}, -- Lady's Smock & Corn Flower
{30158,30166}, -- Lady's Smock & Water Hyacinth
{30155,30163}, -- Luminous Russula & Mountain Flower
{30155,77584}, -- Luminous Russula & Spider Egg
{30163,30157}, -- Mountain Flower & Blessed Thistle
{77591,77590}, -- Mudcrab Chitin & Nightshade
{77591,30154}, -- Mudcrab Chitin & White Cap
{30153,30159}, -- Namira’s Rot & Wormwood
{30153,30166}, -- Namira’s Rot & Water Hyacinth
{77590,30165}, -- Nightshade & Nirnroot
{30165,77585}, -- Nirnroot & Butterfly Wing
{77589,77584}, -- Scrib Jelly & Spider Egg
{77589,30157}, -- Scrib Jelly & Blessed Thistle
{77589,30154}, -- Scrib Jelly & White Cap
{30159,77584}, -- Wormwood & Spider Egg
{77584,77591}, -- Spider Egg & Mudcrab Chitin
{30149,30151}, -- Stinkhorn & Emetic Russula
{77581,30159}, -- Torchbug Thorax & Wormwood
{77581,30165}, -- Torchbug Thorax & Nirnroot
{77581,30149}, -- Torchbug Thorax & Stinkhorn
{30166,30155}, -- Water Hyacinth & Luminous Russula
{30159,30166}, -- Wormwood & Water Hyacinth
{77585,77584}, -- Butterfly Wing & Spider Egg
{30153,30165}, -- Namira’s Rot & Nirnroot
{77584,30165}, -- Spider Egg & Nirnroot
}

local dlcCombos =
{
{139019,77583}, -- Powdered Mother of Pearl & Beetle Scuttle
{139019,77589}, -- Powdered Mother of Pearl & Scrib Jelly
{139020,77591}, -- Clam Gall & Mudcrab Chitin	
{139020,77584}, -- Clam Gall & Spider Egg
{139020,77587}, -- Clam Gall & Fleshfly Larva
{150731,77584}, -- Dragon's Blood & Spider Egg
{150731,150789}, -- Dragon's Blood & Dragon's Bile
{150731,150669}, -- Dragon's Blood & Chaurus Egg
{150671,150789}, -- Dragon Rheum & Dragon's Bile
{150671,77581}, -- Dragon Rheum & Torchbug Thorax
{150671,150670}, -- Dragon Rheum & Vile Coagulant
{150671,30153}, -- Dragon Rheum & Namira’s Rot
{150789,77587}, -- Dragon's Bile & Fleshfly Larva
{150789,77584}, -- Dragon's Bile & Spider Egg
{150670,77590}, -- Vile Coagulant & Nightshade
{150670,150669}, -- Vile Coagulant & Chaurus Egg
{150669,30154}, -- Chaurus Egg & White Cap
{150669,150672}, -- Chaurus Egg & Crimson Nirnroot
{150672,30166}, -- Crimson Nirnroot & Water Hyacinth
{150672,77587}, -- Crimson Nirnroot & Fleshfly Larva
}

local solvents = 
{
75357, -- Grease 3
75358, -- Ichor 10
75359, -- Slime 20
75360, -- Gall 30
75361, -- Terebinthine 40
75362, -- Pitch-Bile cp10
75363, -- Tarblack cp50
75364, -- Night-Oil cp100
75365, -- Alcahest cp150

883, -- Natural Water 3
1187, -- Clear Water 10
4570, -- Pristine Water 20
23265, -- Cleansed Water 30
23266, -- Filtered Water 40
23267, -- Purified Water cp10
23268, -- Cloud Mist cp50
64500, -- Star Dew cp100
64501, -- Lorkhan's Tears cp150
}

-- a static list of all traits of each reagent, will be used to determine what combos still need to be executed
local reagentTraits = 
{
[77583] = {"Breach", "Increase Armor", "Protection", "Vitality"}, -- Beetle Scuttle
[30157] = {"Restore Stamina", "Increase Weapon Power", "Ravage Health", "Speed"}, -- Blessed Thistle
[30148] = {"Ravage Magicka", "Cowardice", "Restore Health", "Invisible"}, -- Blue Entoloma
[30160] = {"Increase Spell Resist", "Restore Health", "Cowardice", "Restore Magicka"}, -- Bugloss
[77585] = {"Restore Health", "Uncertainty", "Lingering Health", "Vitality"}, -- Butterfly Wing
[150669] = {"Timidity", "Ravage Magicka", "Restore Stamina", "Detection"}, -- Chaurus Egg
[139020] = {"Increase Spell Resist", "Hindrance", "Vulnerability", "Defile"}, -- Clam Gall
[30164] = {"Restore Health", "Restore Magicka", "Restore Stamina", "Unstoppable"}, -- Columbine
[30161] = {"Restore Magicka", "Increase Spell Power", "Ravage Health", "Detection"}, -- Corn Flower
[150672] = {"Timidity", "Spell Critical", "Gradual Ravage Health", "Restore Health"}, -- Crimson Nirnroot
[150671] = {"Restore Magicka", "Heroism", "Enervation", "Speed"}, -- Dragon Rheum
[150789] = {"Heroism", "Vulnerability", "Invisible", "Vitality"}, -- Dragon's Bile
[150731] = {"Lingering Health", "Restore Stamina", "Heroism", "Defile"}, -- Dragon's Blood
[30162] = {"Increase Weapon Power", "Restore Stamina", "Fracture", "Weapon Critical"}, -- Dragonthorn
[30151] = {"Ravage Health", "Ravage Magicka", "Ravage Stamina", "Entrapment"}, -- Emetic Russula
[77587] = {"Ravage Stamina", "Vulnerability", "Gradual Ravage Health", "Vitality"}, -- Fleshfly Larva
[30156] = {"Maim", "Ravage Stamina", "Increase Armor", "Enervation"}, -- Imp Stool
[30158] = {"Increase Spell Power", "Restore Magicka", "Breach", "Spell Critical"}, -- Lady's Smock
[30155] = {"Ravage Stamina", "Maim", "Restore Health", "Hindrance"}, -- Luminous Russula
[30163] = {"Increase Armor", "Restore Health", "Maim", "Restore Stamina"}, -- Mountain Flower
[77591] = {"Increase Spell Resist", "Increase Armor", "Protection", "Defile"}, -- Mudcrab Chitin
[30153] = {"Spell Critical", "Speed", "Invisible", "Unstoppable"}, -- Namira's Rot
[77590] = {"Ravage Health", "Protection", "Gradual Ravage Health", "Defile"}, -- Nightshade
[30165] = {"Ravage Health", "Uncertainty", "Enervation", "Invisible"}, -- Nirnroot
[139019] = {"Lingering Health", "Speed", "Vitality", "Protection"}, -- Powdered Mother of Pearl
[77589] = {"Ravage Magicka", "Speed", "Vulnerability", "Lingering Health"}, -- Scrib Jelly
[77584] = {"Hindrance", "Invisible", "Lingering Health", "Defile"}, -- Spider Egg
[30149] = {"Fracture", "Ravage Health", "Increase Weapon Power", "Ravage Stamina"}, -- Stinkhorn
[77581] = {"Fracture", "Enervation", "Detection", "Vitality"}, -- Torchbug Thorax
[150670] = {"Timidity", "Ravage Health", "Restore Magicka", "Protection"}, -- Vile Coagulant
[30152] = {"Breach", "Ravage Health", "Increase Spell Power", "Ravage Magicka"}, -- Violet Coprinus
[30166] = {"Restore Health", "Spell Critical", "Weapon Critical", "Entrapment"}, -- Water Hyacinth
[30154] = {"Cowardice", "Ravage Magicka", "Increase Spell Resist", "Detection"}, -- White Cap
[30159] = {"Weapon Critical", "Hindrance", "Detection", "Unstoppable"}, -- Wormwood
}

-- used to store the calculated amount of inventory of each reagent
local reagentAmounts = 
{
}

local essence, potency, aspect =  LibLazyCrafting.getGlyphInfo()

local function getItemLinkFromItemId(itemId)
	return string.format("|H1:item:%d:%d:50:0:0:0:0:0:0:0:0:0:0:0:0:%d:%d:0:0:%d:0|h|h", itemId, 0, ITEMSTYLE_NONE, 0, 10000) 
end

local function GetNumberOfAvailableItems(itemId)
	local bag, bank, craft = GetItemLinkStacks(getItemLinkFromItemId(itemId))
	return bag + bank + craft
end

local function getSolvent(proficiency, startingPosition)
	-- Check solvents
	for i = startingPosition , proficiency + 1 do
		-- poisons
		local availableAmount = GetNumberOfAvailableItems(solvents[i])
		if(availableAmount > 0) then
			return availableAmount, solvents[i], i
		end

		-- potions
		local availableAmount = GetNumberOfAvailableItems(solvents[i+9])
		if(availableAmount > 0) then
			return availableAmount, solvents[i+9], i
		end
	end
	
	return nil, nil, nil
end

-- Function to find matching traits between two reagents
local function GetMatchingTraits(reagent1, reagent2)
    local traits1 = reagentTraits[reagent1]
    local traits2 = reagentTraits[reagent2]
    local matchingTraits = {}

    -- Compare the traits from both reagents
    for _, trait1 in ipairs(traits1) do
        for _, trait2 in ipairs(traits2) do
            if trait1 == trait2 then
                table.insert(matchingTraits, trait1)
            end
        end
    end
    return matchingTraits
end

-- Function to check if a value exists in a table
local function Contains(table, value)
    for _, v in ipairs(table) do
        if v == value then
            return true
        end
    end
    return false
end


local function alchemyQueuer(combos)
	local LLC = LazyAlchemyLearner.LLC
	local remainingSolvent = 0
	local solvent
	local position = 1
	local queued = 0
	local missingMaterialReagents = {}
	-- Clear queue in case there's any already queued
	LLC:cancelItem(CRAFTING_TYPE_ALCHEMY)
	--I am adding a solvent check here to see if the player has any solvent at all, no need to process anything if nothing will be queued anyway
	remainingSolvent, solvent, position = getSolvent(GetNonCombatBonus(NON_COMBAT_BONUS_ALCHEMY_LEVEL), position)
	
	if(remainingSolvent == nil) then
		d("You need solvents to craft potions")
		return queued
	end
	
	for i = 1, #combos do
		local known = true

		local reagentItemId1 = combos[i][1]
		local reagentItemId2 = combos[i][2]

		-- we check what traits between the two reagents are matching
		local theoreticalMatchingTraits = GetMatchingTraits(reagentItemId1, combos[i][2])
		local amountMatchingReagant1 = 0
		local amountMatchingReagant2 = 0
		for j = 1, 4 do
		
			--[[
				k = known status of the reagant's trait {true/false}
				n = name of the trait, currently the name wil be nil if the trait is unknown
			--]]
			local k1, n1 = GetItemLinkReagentTraitInfo(getItemLinkFromItemId(reagentItemId1), j)
			local k2, n2 = GetItemLinkReagentTraitInfo(getItemLinkFromItemId(combos[i][2]), j)

			-- as a precaution, we'll set the name of the trait to nil if it's not known, since this is the behaviour we expect in the next step
			if not k1 then
				n1 = nil
			end

			if not k2 then
				n2 = nil
			end
			
			--we count the amount of known matching traits of each reagant
			if Contains(theoreticalMatchingTraits, n1) then
				amountMatchingReagant1 = amountMatchingReagant1 + 1
			end
			
			if Contains(theoreticalMatchingTraits, n2) then
				amountMatchingReagant2 = amountMatchingReagant2 + 1
			end
		end
		
		-- if the amount of actual known, matching traits is not the same as the theoretical amount of matching traits known will be false
		known = amountMatchingReagant1 == #theoreticalMatchingTraits and amountMatchingReagant2 == #theoreticalMatchingTraits
		
		--Leaving this here for debug purposes for now
		 local reagantName1 = GetItemLinkName(getItemLinkFromItemId(reagentItemId1))
		 local reagantName2 = GetItemLinkName(getItemLinkFromItemId(combos[i][2]))
		
		--if unknown traits detected we will attempt to queue a potion
		if not known then
			local canCraftPotion = true
			-- we check if there are any solvents left of the currently selected solvent, if not we automatically get the next best solvent
			if remainingSolvent and (remainingSolvent == 0) then
				--decide the solvent we are going to use
				remainingSolvent, solvent, position = getSolvent(GetNonCombatBonus(NON_COMBAT_BONUS_ALCHEMY_LEVEL), position)
	
				if(remainingSolvent == nil) then
					missingMaterialReagents["Solvents"] = "Solvents"
					canCraftPotion = false
				end
			elseif not remainingSolvent then
				-- ran out of solvent on a prior loop
				canCraftPotion = false
			end
		
			-- we reduce the amount of available solvents
			remainingSolvent = remainingSolvent - 1
			
			-- check availability of reagant 1
			if not reagentAmounts[reagentItemId1] then
				reagentAmounts[reagentItemId1]  = GetNumberOfAvailableItems(reagentItemId1)
			end
			
			-- check availability of reagant 2
			if not reagentAmounts[reagentItemId2] then
				reagentAmounts[reagentItemId2]  = GetNumberOfAvailableItems(reagentItemId2)
			end

			if reagentAmounts[reagentItemId1] == 0 then
				--skip this potion
				missingMaterialReagents[reagentItemId1] = reagantName1
				canCraftPotion = false
			end
			if reagentAmounts[reagentItemId2] == 0 then
				--skip this potion
				canCraftPotion = false
				missingMaterialReagents[reagentItemId2] = reagantName2
			end
			
			if(canCraftPotion) then
				reagentAmounts[reagentItemId1] = reagentAmounts[reagentItemId1] - 1
				reagentAmounts[reagentItemId2] = reagentAmounts[reagentItemId2] - 1
				queued = queued + 1

				LLC:CraftAlchemyItemId(solvent, reagentItemId1, reagentItemId2, nil, 1, true,'1')
				d("Lazy Alchemy Learner: Queued " .. getItemLinkFromItemId(solvent) .. " with " .. getItemLinkFromItemId(reagentItemId1) .. " and " .. getItemLinkFromItemId(reagentItemId2) .. ".")
			end
		end
	end
	for itemId, itemName in pairs(missingMaterialReagents) do
		if type(itemId) == "number" then
			d(zo_strformat("Lazy Alchemy Learner: You do not have enough <<1:s>> to craft all potions", getItemLinkFromItemId(itemId)))
		end
	end
	if missingMaterialReagents["Solvents"] then
		d("Lazy Alchemy Learner: You do not have any solvents, which are required for crafting potions")
	end
	return queued
	
end

-- |H1:item:75362:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h
local function queueLearningAlchemy(includeDlc)
	local queued = alchemyQueuer(basegameCombo)
	if includeDlc then
		queued = alchemyQueuer(dlcCombos) + queued
	end
	
	d("Lazy Alchemy Learner: "..queued.." potions queued to craft")
end

local function queueLearningEnchanting(includeDlc)
	d("Not implemented yet")
end

function LazyAlchemyLearner.Initialize()
	LazyAlchemyLearner.LLC = LibLazyCrafting:AddRequestingAddon(LazyAlchemyLearner.name,true, function()end)
end

function LazyAlchemyLearner.OnAddOnLoaded(event, addonName)
	if addonName == LazyAlchemyLearner.name then
		LazyAlchemyLearner.Initialize()
	end
end

EVENT_MANAGER:RegisterForEvent(LazyAlchemyLearner.name, EVENT_ADD_ON_LOADED, LazyAlchemyLearner.OnAddOnLoaded)

local function genericSlashCommand(args)
	local searchResult = { string.match(args,"^(%S*)%s*(.-)$") }
	if searchResult[1] == 'alchemy' then
		queueLearningAlchemy(searchResult[2] == 'all')
		if searchResult[2] == 'all' then
			d("DLC + Base game alchemy traits queued")
		else
			d("Base game alchemy traits queued. Type /lazylearn alchemy all to also learn DLC traits")
		end
		
	elseif searchResult[1] == 'enchant' then
		queueLearningEnchanting(searchResult[2] == 'all')
	elseif searchResult[1] == 'both' then
		queueLearningEnchanting(searchResult[2] == 'all')
		queueLearningAlchemy(searchResult[2] == 'all')
	else
		d("Possible values:")
		d("/lazylearn alchemy --> learn all cheap alchemy traits")
		d("/lazylearn enchant --> learn all base game runes (excludes Kuta)")
		d("/lazylearn both --> learn all base game alchemy traits and runes (excludes Kuta")
		d("/lazylearn alchemy all --> learn all alchemy traits, including non base game traits")
		d("/lazylearn enchant all  --> learn all enchanting runes, including non base game and Kuta")
		d("/lazylearn both all --> learn everything")
	end
end

SLASH_COMMANDS['/lazylearn'] = genericSlashCommand
SLASH_COMMANDS["/learnalchemytraits"] = function(arg)
    -- Call the queueLearningAlchemy function with the parsed argument
    queueLearningAlchemy(arg == "all")
    if arg == 'all' then
		d("DLC + Base game alchemy traits queued")
	else
		d("Base game alchemy traits queued. Type /learnalchemytraits all to also learn DLC traits")
	end
end
-- SLASH_COMMANDS["/learnenchantrunes"] = queueLearningAlchemy
