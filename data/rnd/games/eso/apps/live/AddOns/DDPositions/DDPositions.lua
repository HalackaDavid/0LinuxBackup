-- DDPositions.lua

DDPositions = DDPositions or {}
DDPositions.panel = nil

function GetDPSPlayers()
	local players = {}
	for i = 1, GetGroupSize() do
		local unitTag = GetGroupUnitTagByIndex(i)
		if DoesUnitExist(unitTag) and IsUnitOnline(unitTag) then
			local role = GetGroupMemberAssignedRole(unitTag)
			if role == LFG_ROLE_DPS then
				table.insert(players, GetUnitDisplayName(unitTag))
			end
		end
	end
	return players
end

function DDPositions.CreateZoneButtons()
	local panel = DDPositions.panel
	if not panel then return end

	if panel.zoneButtons then
		for _, btn in ipairs(panel.zoneButtons) do
			btn:SetHidden(true)
			btn:SetParent(nil)
		end
	end

	panel.zoneButtons = {}
	if panel.zoneHeading then
		panel.zoneHeading:SetHidden(true)
		panel.zoneHeading:SetParent(nil)
		panel.zoneHeading = nil
	end

	local zoneId = GetZoneId(GetUnitZoneIndex("player"))
	local zoneData = DDPositions_ControlZones[zoneId]
	if not zoneData then return end

	local btnHeight = 30
	local btnWidth = 100
	local spacing = -7
	local offsetY = 30
	local groupOrder = zoneData.order or {}

	for _, groupName in ipairs(groupOrder) do
		local btn = WINDOW_MANAGER:CreateControl(nil, panel, CT_BUTTON)
		btn:SetDimensions(btnWidth, btnHeight)
		btn:SetAnchor(TOPLEFT, panel, TOPLEFT, 20, offsetY)

		local label = WINDOW_MANAGER:CreateControl(nil, btn, CT_LABEL)
		label:SetFont("ZoFontGame")
		label:SetAnchorFill(btn)
		label:SetText(" • " .. groupName)
		label:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
		label:SetVerticalAlignment(TEXT_ALIGN_CENTER)
		label:SetColor(1, 1, 1, 1)
		btn.label = label

		btn:SetNormalFontColor(1, 1, 1, 1)
		btn:SetMouseEnabled(true)

		btn:SetHandler("OnMouseEnter", function(self)
			self.label:SetColor(0.8, 0.8, 0.8, 0.8)
			self:SetAlpha(0.8)

			if DDPositions.panel and DDPositions.panel.tooltipLabel then
				DDPositions.panel.tooltipLabel:SetText("Right-click to assign manually.\nLeft-click to auto-assign.")
			end
		end)

		btn:SetHandler("OnMouseExit", function(self)
			self.label:SetColor(1, 1, 1, 1)
			self:SetAlpha(1)

			if DDPositions.panel and DDPositions.panel.tooltipLabel then
				DDPositions.panel.tooltipLabel:SetText("")
			end
		end)

		btn:SetHandler("OnMouseDown", function(self)
			self.label:SetColor(0.4, 0.4, 0.4, 0.4)
		end)

		btn:SetHandler("OnMouseUp", function(buttonControl, mouseButton, upInside)
			if not (upInside and mouseButton == MOUSE_BUTTON_INDEX_RIGHT) then
				buttonControl.label:SetColor(0.8, 0.8, 0.8, 0.8)
				return
			end

			local anchorControl = buttonControl
			local positions = zoneData[groupName].positions or {}
			local zoneId = GetZoneId(GetUnitZoneIndex("player"))

			function ShowDPSSubMenu(index, label)
				zo_callLater(function()
					ClearMenu()

					local assigned = DDPositions.savedVars.assignments[zoneId]
						and DDPositions.savedVars.assignments[zoneId][groupName] or {}

					local dpsPlayers = GetDPSPlayers()
					if #dpsPlayers == 0 then
						AddMenuItem("No DPS found", function() end, true)
					else
						for _, playerName in ipairs(dpsPlayers) do
							local isTaken = false
							for _, a in pairs(assigned) do
								if a.name == playerName then
									isTaken = true
									break
								end
							end

							if not isTaken then
								AddMenuItem(playerName, function()
									local Assign = _G["DDPositions_Assignments"]
									if Assign and Assign.AssignPositionToPlayer then
										Assign.AssignPositionToPlayer(groupName, index, playerName, label)
										zo_callLater(ShowPositionMenu, 50)
									end
								end, false)
							end
						end

						for _, playerName in ipairs(dpsPlayers) do
							for _, a in pairs(assigned) do
								if a.name == playerName then
									AddMenuItem("|c888888" .. playerName .. " (assigned)|r", function() end, true)
									break
								end
							end
						end
					end

					AddMenuItem(" ", function() end, false)
					AddMenuItem("::[ < ]::", function()
						zo_callLater(ShowPositionMenu, 10)
					end, false)
					AddMenuItem("|cFF0000::[ X ]::|r", function()
						ClearMenu()
					end, false)

					ShowMenu(anchorControl)
				end, 10)
			end

			function ShowPositionMenu()
				ClearMenu()
				local saved = DDPositions.savedVars.assignments[zoneId] and DDPositions.savedVars.assignments[zoneId][groupName] or {}

				for i, label in ipairs(positions) do
					local entry = saved[i]
					local assignedName = entry and entry.name
					local text = assignedName and string.format("• %s  (%s)", label, assignedName) or ("• " .. label)

					AddMenuItem(text, function()
						ShowDPSSubMenu(i, label)
					end, false)
				end

				AddMenuItem(" ", function() end, false)
				local hasAssignments = false
				for _, entry in pairs(saved) do
					if entry and entry.name then
						hasAssignments = true break
					end
				end

				if hasAssignments then
					AddMenuItem("::[ - ]::", function()
						local allAssignments = DDPositions.savedVars.assignments or {}
						allAssignments[zoneId] = nil
					end, false)
				end
				
				AddMenuItem("::[Send Assignment(s)]::", function()
				local saved = DDPositions.savedVars.assignments[zoneId] and DDPositions.savedVars.assignments[zoneId][groupName] or {}
				local positions = zoneData[groupName].positions or {}

				local messages = {}
				for i, label in ipairs(positions) do
					local entry = saved[i]
					local name = (entry and entry.name) or "@MISSING"
					table.insert(messages, string.format("::[%s -> %s]::", name, label))
				end

				local message = "::[" .. groupName .. " Assignment(s)]:: " .. table.concat(messages, "  ")
				StartChatInput(message, CHAT_CHANNEL_PARTY)
				ClearMenu()
			end, false)
				
				AddMenuItem("|cFF0000::[ X ]::|r", function() ClearMenu() end, false)
				ShowMenu(anchorControl)
			end

			ShowPositionMenu()
		end)

		btn:SetHandler("OnClicked", function()
			btn:SetClickSound("Click")
			if DDPositions_Assignments and DDPositions_Assignments.AssignPositions then
				DDPositions_Assignments.AssignPositions(groupName)
			end
		end)

		table.insert(panel.zoneButtons, btn)
		offsetY = offsetY + btnHeight + spacing
	end
end

function DDPositions.TogglePanel()
	local currentZoneId = GetZoneId(GetUnitZoneIndex("player"))
	local isValidZone = DDPositions_ControlZones[currentZoneId] ~= nil

	if not isValidZone then d("::[DDPositions]:: This zone is not supported.")
		return
	end

	if not DDPositions.panel then
		DDPositions.CreatePanel()
	end

	local isHidden = DDPositions.panel:IsHidden()
	DDPositions.panel:SetHidden(not isHidden)

	if isHidden then
		DDPositions.CreateZoneButtons()
	end
end

function OnAddonLoaded(_, addonName)
	if addonName ~= "DDPositions" then return end

	DDPositions.savedVars = ZO_SavedVars:NewAccountWide("DDPositionsSavedVars", 1, nil, {
		panelX = nil,
		panelY = nil,
		shuffleAssignments = false,
		assignments = {}
	})

	ZO_CreateStringId("SI_BINDING_NAME_DDPOSITIONS_KEYBIND", "Toggle Panel")
	d("DDPositions loaded!")
end
EVENT_MANAGER:RegisterForEvent("DDPositions", EVENT_ADD_ON_LOADED, OnAddonLoaded)

local function OnPlayerActivated()
	local currentZoneId = GetZoneId(GetUnitZoneIndex("player"))
	local allAssignments = DDPositions.savedVars.assignments or {}

	for zoneId in pairs(allAssignments) do
		if zoneId ~= currentZoneId then
			allAssignments[zoneId] = nil
		end
	end

	DDPositions.savedVars.assignments = allAssignments
	
	if DDPositions.panel and not DDPositions.panel:IsHidden() then
		DDPositions.CreateZoneButtons()
	end
end
EVENT_MANAGER:RegisterForEvent("DDPositions_Activated", EVENT_PLAYER_ACTIVATED, OnPlayerActivated)

