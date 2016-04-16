--[[
  Automatic Smeltery Control Program
  Version: 1.0
  Designed By: ligerzero459
  Date: 13 April 2016
]]

-- DEPENDENCIES
os.loadAPI("json")

-- LOCAL VARIABLES
local smeltery, smeltery_side, rs, redstone_side, settings

function appSetup()
  settings = json.decodeFromFile("settings.json")

  smeltery_side = settings.smeltery
  redstone_side = settings.redstone

  smeltery = peripheral.wrap(smeltery_side)
end

function pourBlocks()

end

function pourIngots()

end

function
