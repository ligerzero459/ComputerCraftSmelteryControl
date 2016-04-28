--[[
  Automatic Smeltery Control Program
  Version: 1.0.2
  Designed By: ligerzero459
  Date: 13 April 2016
]]

-- DEPENDENCIES
os.loadAPI(shell.resolve("json"))
os.loadAPI(shell.resolve("color"))

-- LOCAL VARIABLES
local smeltery, smeltery_side, rs, redstone_side, settings, drains, liquid_name
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

function cutRedstonePulses()
  os.sleep(1)
  redstone.setBundledOutput(redstone_side, 0)
  os.sleep(1)
end

function pourBlocks(blocksToPour)
  
  while blocksToPour ~= 0 do
    print ("Blocks to pour: "..blocksToPour)
    
    if liquid_name ~= smeltery.getInfo().contents.rawName then
      print("Liquid swapped. Pausing for 10 seconds...")
      os.sleep(10)
      return
    end
    
    if blocksToPour % table.getn(blocks) ~= 0 then
      for i=1,(blocksToPour % table.getn(blocks)) do
        redstone.setBundledOutput(redstone_side, blocks[i])
        blocksToPour = blocksToPour - 1
        cutRedstonePulses()
      end
    else
      for i=1,table.getn(blocks) do
        redstone.setBundledOutput(redstone_side, blocks[i])
        blocksToPour = blocksToPour - 1
        cutRedstonePulses()
      end
    end
    
    os.sleep(14)
    
  end
  
end

function pourIngots(ingotsToPour)
  
  while ingotsToPour ~= 0 do
    print ("Ingots to pour: "..ingotsToPour)
    
    if liquid_name ~= smeltery.getInfo().contents.rawName then
      print("Liquid swapped. Pausing for 10 seconds...")
      os.sleep(10)
      return
    end
    
    if ingotsToPour % table.getn(ingots) ~= 0 then
      for i=1,(ingotsToPour % table.getn(ingots)) do
        redstone.setBundledOutput(redstone_side, ingots[i])
        ingotsToPour = ingotsToPour - 1
        cutRedstonePulses()
      end
    else
      for i=1,table.getn(ingots) do
        redstone.setBundledOutput(redstone_side, ingots[i])
        ingotsToPour = ingotsToPour - 1
        cutRedstonePulses()
      end
    end
    
    os.sleep(6)
    
  end
  
end

-- MAIN START

appSetup()
print("Initilization complete...")
print("Monitoring in 5 seconds...")
os.sleep(6)

while true do
  
  if smeltery.getInfo().contents ~= nil then
    
    liquid_name = smeltery.getInfo().contents.rawName
    
    if (smeltery.getInfo().contents.amount == smeltery.getInfo().capacity) then
      print("Smeltery full. Pouring portion of blocks: " .. liquid_name)
      pourBlocks(math.floor(((smeltery.getInfo().contents.amount / 144) / 9) / 4))
    elseif (smeltery.getInfo().contents.amount / 144) % 9 > 0 then
      print("Pouring ingots: " .. liquid_name)
      pourIngots((smeltery.getInfo().contents.amount / 144) % 9)
    elseif (smeltery.getInfo().contents.amount / 144) % 9 == 0 then
      print("Pouring blocks: " .. liquid_name)
      pourBlocks((smeltery.getInfo().contents.amount / 144) / 9)
    end
    
  end
  
  os.sleep(3)
  
end
