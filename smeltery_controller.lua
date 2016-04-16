--[[
  Automatic Smeltery Control Program
  Version: 1.0
  Designed By: ligerzero459
  Date: 13 April 2016
]]

-- DEPENDENCIES
os.loadAPI(shell.resolve("json"))
os.loadAPI(shell.resolve("color"))

-- LOCAL VARIABLES
local smeltery, smeltery_side, rs, redstone_side, settings, drains
local ingots, blocks

function appSetup()
  settings = json.decodeFromFile(shell.resolve("settings.json"))

  smeltery_side = settings.smeltery
  redstone_side = settings.redstone

  smeltery = peripheral.wrap(smeltery_side)

  drains = settings.drains
  ingots = {}
  blocks = {}

  for index, value in pairs(drains) do
    if value.type == "ingot" then
      table.insert(ingots, color.getColor(value.color))
    elseif value.type == "block" then
      table.insert(blocks, color.getColor(value.color))
    end
  end
end

function pourBlocks()

end

function pourIngots()

end

appSetup()
