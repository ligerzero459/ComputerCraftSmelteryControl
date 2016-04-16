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
  
  -- Setup peripheral sides
  smeltery_side = settings.smeltery
  redstone_side = settings.redstone
  
  smeltery = peripheral.wrap(smeltery_side)
  
  -- Setup drains. Multiple drains of multiple types allowed
  -- Examples in settings.json
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

function pourBlocks(blocksToPour)
  
  while blocksToPour ~= 0 do
    
    if blocksToPour % table.getn(blocks) ~= 0 then
      for i=1,(blocksToPour % table.getn(blocks)) do
        redstone.setBundledOutput(redstone_side, blocks[i])
        redstone.setBundledOutput(redstone_side, 0)
        blocksToPour = blocksToPour - 1
      end
    else
      for i=1,table.getn(blocks) do
        redstone.setBundledOutput(redstone_side, blocks[i])
        redstone.setBundledOutput(redstone_side, 0)
        blocksToPour = blocksToPour - 1
      end
    end
    
    os.sleep(17)
    
  end
  
end

function pourIngots(ingotsToPour)
  
  while ingotsToPour ~= 0 do
    
    if ingotsToPour % table.getn(ingots) ~= 0 then
      for i=1,(ingotsToPour % table.getn(ingots)) do
        redstone.setBundledOutput(redstone_side, ingots[i])
        redstone.setBundledOutput(redstone_side, 0)
        ingotsToPour = ingotsToPour - 1
      end
    else
      for i=1,table.getn(ingots) do
        redstone.setBundledOutput(redstone_side, ingots[i])
        redstone.setBundledOutput(redstone_side, 0)
        ingotsToPour = ingotsToPour - 1
      end
    end
    
    os.sleep(6)
    
  end
  
end

appSetup()

while true do
  
  if smeltery.getInfo().contents ~= nil then
    
    if (smeltery.getInfo().contents / 144) % 9 > 0 then
      pourIngots((smeltery.getInfo().contents / 144) % 9)
    elseif (smeltery.getInfo().contents / 144) % 9 == 0 then
      pourBlocks((smeltery.getInfo().contents / 144) / 9)
    end
    
  end
  
  sleep(3)
  
end
