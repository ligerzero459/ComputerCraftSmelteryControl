--[[
  Automatic Smeltery Control Program
  Version: 1.0
  Designed By: ligerzero459
  Date: 13 April 2016
]]

-- DEPENDENCIES
os.loadAPI("json")

-- LOADED SETTINGS
local settings_json = fs.open("settings.json")
local settings = json.decode(settings_json:read("*all"))

local smeltery_side = settings.smeltery
local redstone_size = settings.redstone

-- LOCAL VARIABLES
local smeltery

function getSmeltery()
  smeltery = peripheral.wrap(smeltery_side)
end

function 
