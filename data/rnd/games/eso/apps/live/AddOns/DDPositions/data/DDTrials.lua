-- DDTrials.lua

local ControlZones = {
    [725] = {  -- Maw of Lorkhaj
        order = {"Runners"},
        Runners = {
            positions = {"Left", "Middle", "Right"}
        }
    },
    [1000] = {  -- Asylum Sanctorium
        order = {"Positions"},
        Positions = {
            positions = {"1", "2", "3", "4", "5", "6", "7", "8"}
        }
    },
    [1051] = {  -- Cloudrest
        order = {"Portals"},
        Portals = {
            positions = {"P1", "P1", "P2", "P2", "Orbs"}
        }
    },
    [1121] = {  -- Sunspire
        order = {"Tombs", "Stacks", "Portals"},
        Tombs = {
            positions = {"T1", "T2", "T3"}
        },
        Stacks = {
            positions = {"Head", "Head", "Head", "Head", "Wing", "Wing", "Wing", "Wing"}
        },
        Portals = {
            positions = {"Left", "Middle", "Right"}
        }
    },
    [1196] = {  -- Kyne's Aegis
        order = {"Boat", "Line"},
        Boat = {
            positions = {"Boat"}
        },
        Line = {
            positions = {"1", "2", "3", "4", "5"}
        }
    },
    [1263] = {  -- Rockgrove
        order = {"Kite"},
        Kite = {
            positions = {"Kite DD"}
        }
    },
    [1344] = {  -- Dreadsail Reef
        order = {"Interrupts", "Reefs", "Bridges"},
        Interrupts = {
            positions = {"Exit.R & Swap", "Exit.L & Swap", "Entrance.R", "Entrance.L"}
        },
        Reefs = {
            positions = {"12-5-8", "3-6-9", "4-7-10"}
        },
        Bridges = {
            positions = {"B1", "B1", "B2", "B2", "B3", "B3"}
        }
    },
    [1427] = {  -- Sanity's Edge
        order = {"Portals", "Stacks", "Maze"},
        Portals = {
            positions = {"P1", "P1", "P1", "P1", "P2", "P2", "P2", "P2"}
        },
        Stacks = {
            positions = {"Left(1)", "Left(2)", "Left(3)", "Left(4)", "Right(1)", "Right(2)", "Right(3)", "Right(4)"}
        },
        Maze = {
            positions = {"Portal", "Portal", "Portal"}
        }
    },
    [1478] = {  -- Lucent Citadel
        order = {"Groups", "Mirrors"},
        Groups = {
            positions = {"Dark", "Dark", "Dark", "Dark", "White", "White", "White", "White"}
        },
        Mirrors = {
            positions = {"N", "S", "E", "W", "NE", "SE", "SW", "NW"}
        }
    },
    [1548] = {  -- Ossein Cage
        order = {"Portal", "Stacks"},
		Portal = {
            positions = {"Portal", "Portal", "Portal"}
        },
        Stacks = {
            positions = {"Left", "Left", "Left", "Left", "Right", "Right", "Right", "Right"}
        }
    }
}

DDPositions_ControlZones = ControlZones
