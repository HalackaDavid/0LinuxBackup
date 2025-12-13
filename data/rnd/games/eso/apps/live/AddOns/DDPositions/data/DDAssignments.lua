-- DDAssignments.lua

local DDAssignments = {}

local function IsDPS(unitTag)
    return GetGroupMemberSelectedRole(unitTag) == LFG_ROLE_DPS
end

function DDAssignments.AssignPositions(groupName)
    local zoneId = GetZoneId(GetUnitZoneIndex("player"))
    local zoneData = DDPositions_ControlZones[zoneId]
    if not zoneData or not zoneData[groupName] then
        d("::[DDPositions]:: No group data found for: " .. tostring(groupName))
        return
    end

    local positions = ZO_ShallowTableCopy(zoneData[groupName].positions or {})
    if #positions == 0 then
        d("::[DDPositions]:: No positions defined for: " .. groupName)
        return
    end

    local orderedDPS = {}
    for i = 1, GetGroupSize() do
        local unitTag = "group" .. i
        if IsDPS(unitTag) then
            local name = GetUnitDisplayName(unitTag) or "@Unknown"
            table.insert(orderedDPS, name)
        end
    end

    DDPositions.savedVars.assignments = DDPositions.savedVars.assignments or {}
    DDPositions.savedVars.assignments[zoneId] = DDPositions.savedVars.assignments[zoneId] or {}
    local savedAssignments = DDPositions.savedVars.assignments[zoneId][groupName] or {}
    local isFirstAssignment = next(savedAssignments) == nil

    if isFirstAssignment or DDPositions.savedVars.shuffleAssignments then
        savedAssignments = {}
        DDPositions.savedVars.assignments[zoneId][groupName] = savedAssignments

        for i = #orderedDPS, 2, -1 do
            local j = math.random(1, i)
            orderedDPS[i], orderedDPS[j] = orderedDPS[j], orderedDPS[i]
        end
    end

    local finalDPS = ZO_ShallowTableCopy(orderedDPS)
    for _, entry in pairs(savedAssignments) do
        local assignedName = entry.name
        for i = #finalDPS, 1, -1 do
            if finalDPS[i] == assignedName then
                table.remove(finalDPS, i)
                break
            end
        end
    end

    for index, posLabel in ipairs(positions) do
        if not savedAssignments[index] then
            savedAssignments[index] = {
                name = table.remove(finalDPS, 1) or "@MISSING",
                label = posLabel
            }
        end
    end

    local messages = {}
    for index, pos in ipairs(positions) do
        local entry = savedAssignments[index]
        local player = entry and entry.name or "@MISSING"
        local label = entry and entry.label or pos
        table.insert(messages, string.format("::[%s -> %s]::", player, label))
    end

    local fullMessage = table.concat(messages, "  ")
    StartChatInput("::[" .. groupName .. " Assignment(s)]:: " .. fullMessage, CHAT_CHANNEL_PARTY)
end



function DDAssignments.AssignPositionToPlayer(groupName, positionIndex, playerName, label)
	local zoneId = GetZoneId(GetUnitZoneIndex("player"))
	DDPositions.savedVars.assignments = DDPositions.savedVars.assignments or {}
	DDPositions.savedVars.assignments[zoneId] = DDPositions.savedVars.assignments[zoneId] or {}
	DDPositions.savedVars.assignments[zoneId][groupName] = DDPositions.savedVars.assignments[zoneId][groupName] or {}

	DDPositions.savedVars.assignments[zoneId][groupName][positionIndex] = {
		name = playerName,
		label = label
	}
end
DDPositions_Assignments = DDAssignments

