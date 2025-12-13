-- DDPanel.lua

local PANEL_WIDTH = 250
local PANEL_HEIGHT = 150

function DDPositions.CreatePanel()
    local panel = WINDOW_MANAGER:CreateTopLevelWindow("DDPositionsPanel")
    DDPositions.panel = panel
	
	local function UpdateTooltipText(text)
		if DDPositions.panel and DDPositions.panel.tooltipLabel then
			DDPositions.panel.tooltipLabel:SetText(text or "")
		end
	end

    panel:SetDimensions(PANEL_WIDTH, PANEL_HEIGHT)
    
    if DDPositions.savedVars.panelX and DDPositions.savedVars.panelY then
        panel:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, DDPositions.savedVars.panelX, DDPositions.savedVars.panelY)
    else
        panel:SetAnchor(CENTER, GuiRoot, CENTER, 0, 0)
    end
    
    panel:SetMovable(true)
    panel:SetMouseEnabled(true)
    panel:SetClampedToScreen(true)
    panel:SetHidden(true)

    local backdrop = WINDOW_MANAGER:CreateControlFromVirtual(nil, panel, "ZO_DefaultBackdrop")
    backdrop:SetAnchorFill()

    local titleButton = WINDOW_MANAGER:CreateControl(nil, panel, CT_BUTTON)
	titleButton:SetDimensions(150, 30)
	titleButton:SetAnchor(TOPLEFT, panel, TOPLEFT, 49, 2)
	titleButton:SetClickSound("Click")

	local titleLabel = WINDOW_MANAGER:CreateControl(nil, titleButton, CT_LABEL)
	titleLabel:SetFont("ZoFontWinH3")
	titleLabel:SetText("::[DDPositions]::")
	titleLabel:SetAnchorFill()
	titleLabel:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
	titleLabel:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	titleLabel:SetColor(0.6, 0.6, 0.6, 0.5)
	
	titleButton:SetHandler("OnMouseEnter", function()
		UpdateTooltipText("Click to announce that all mechanics will be\n randomly assigned using the addon.")
		titleLabel:SetColor(0.4, 0.4, 0.4, 0.4)
	end)

	titleButton:SetHandler("OnMouseExit", function()
		UpdateTooltipText("")
		titleLabel:SetColor(0.6, 0.6, 0.6, 0.5)
	end)

	titleButton:SetHandler("OnMouseDown", function()
		titleLabel:SetColor(0.3, 0.3, 0.3, 0.3)
	end)

	titleButton:SetHandler("OnMouseUp", function(_, button, inside)
		if inside then
			titleLabel:SetColor(0.4, 0.4, 0.4, 0.4)
		else
			titleLabel:SetColor(0.3, 0.3, 0.3, 0.3)
		end
	end)

	titleButton:SetHandler("OnClicked", function()
		local message = "::[READ]:: All mechanics will be randomly assigned to players using the DDPositions addon. If you receive an assignment, please confirm in chat with '+' and your position. --->>> Failure to do so may result in removal from the group. <<<---"
		StartChatInput(message, CHAT_CHANNEL_PARTY)
	end)

    local top_separator = WINDOW_MANAGER:CreateControl(nil, panel, CT_TEXTURE)
    top_separator:SetDimensions(200, 1)
    top_separator:SetAnchor(TOP, panel, TOP, 0, 30)
    top_separator:SetColor(0.2, 0.2, 0.2, 0.9)

    panel:SetHandler("OnMouseUp", function(self, button, upInside)
        if upInside then
            local left = self:GetLeft()
            local top = self:GetTop()
            DDPositions.savedVars.panelX = left
            DDPositions.savedVars.panelY = top
        end
    end)

    local toggleShuffle = WINDOW_MANAGER:CreateControl(nil, panel, CT_BUTTON)
    toggleShuffle:SetDimensions(35, 35)
    toggleShuffle:SetAnchor(TOPRIGHT, panel, TOPRIGHT, -15, 70)
    toggleShuffle:SetNormalTexture("/esoui/art/inventory/inventory_tabicon_quest_up.dds")
    toggleShuffle:SetMouseOverTexture("/esoui/art/inventory/inventory_tabicon_quest_over.dds")
    toggleShuffle:SetPressedTexture("/esoui/art/inventory/inventory_tabicon_quest_down.dds")
    toggleShuffle:SetClickSound("Click")
	
	local function UpdateShuffleButtonVisual()
		if DDPositions.savedVars.shuffleAssignments then
			toggleShuffle:SetNormalTexture("/esoui/art/inventory/inventory_tabicon_quest_over.dds")
		else
			toggleShuffle:SetNormalTexture("/esoui/art/inventory/inventory_tabicon_quest_up.dds")
		end
	end
	
	UpdateShuffleButtonVisual()
	
	toggleShuffle:SetHandler("OnMouseEnter", function()
		local status = DDPositions.savedVars.shuffleAssignments and "ON" or "OFF"
		if status == "ON" then
			UpdateTooltipText("Shuffle is: ENABLED.\nDD's will be randomly assigned each time.")
		else
			UpdateTooltipText("Shuffle is: DISABLED.\nAssignments will remain static.")
		end
	end)

	toggleShuffle:SetHandler("OnMouseExit", function()
		UpdateTooltipText("")
	end)
	
    toggleShuffle:SetHandler("OnClicked", function()
		DDPositions.savedVars.shuffleAssignments = not DDPositions.savedVars.shuffleAssignments
		local status = DDPositions.savedVars.shuffleAssignments and "ON" or "OFF"
		if status == "ON" then
			UpdateTooltipText("Shuffle is: ENABLED.\nDD's will be randomly assigned each time.")
		else
			UpdateTooltipText("Shuffle is: DISABLED.\nAssignments will remain static.")
		end
		UpdateShuffleButtonVisual()
	end)
	
	local button_separator = WINDOW_MANAGER:CreateControl(nil, panel, CT_TEXTURE)
    button_separator:SetDimensions(200, 1)
    button_separator:SetAnchor(BOTTOM, panel, BOTTOM, 0, -40)
    button_separator:SetColor(0.2, 0.2, 0.2, 0.9)
	
	local tooltipLabel = WINDOW_MANAGER:CreateControl(nil, panel, CT_LABEL)
	tooltipLabel:SetFont("ZoFontGameSmall")
	tooltipLabel:SetDimensions(PANEL_WIDTH - 20, 38)
	tooltipLabel:SetAnchor(BOTTOMLEFT, panel, BOTTOMLEFT, 10, 0)
	tooltipLabel:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
	tooltipLabel:SetVerticalAlignment(TEXT_ALIGN_TOP)
	tooltipLabel:SetColor(1, 1, 0.8, 1)
	tooltipLabel:SetText("")

	DDPositions.panel.tooltipLabel = tooltipLabel
	
end

local function HookSceneVisibility()
    local wasVisible = false
    for sceneName, scene in pairs(SCENE_MANAGER.scenes) do
        if scene and not scene.callbackRegistered then
            scene:RegisterCallback("StateChange", function(oldState, newState)
                if DDPositions.panel then
                    if newState == SCENE_SHOWING then
                        local currentZoneId = GetZoneId(GetUnitZoneIndex("player"))
                        local isValidZone = DDPositions_ControlZones[currentZoneId] ~= nil

                        if sceneName ~= "hud" and sceneName ~= "hudui" then
                            if not DDPositions.panel:IsHidden() then
                                wasVisible = true
                                DDPositions.panel:SetHidden(true)
                            end
                        elseif wasVisible then
                            if isValidZone then
                                DDPositions.panel:SetHidden(false)
                            end
                            wasVisible = false
                        end
                    end
                end
            end)
            scene.callbackRegistered = true
        end
    end
end

HookSceneVisibility()
