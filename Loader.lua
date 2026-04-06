--[[
    ___       __          __ __     __ 
   / _ \__ __/ /  __ __  / // /_ __/ / 
  / , _/ // / _ \/ // / / _  / // / _ \
 /_/|_|\_,_/_.__/\_, / /_//_/\_,_/_.__/
                /___/                  

    Loader  |  2026-04-05  |  Roblox Script Hub
    
    
    Author: Ruby Hub
    Github: https://github.com/aymarko/RubyHub
    Website: https://rubyhub.net
    Discord: https://discord.gg/rubyhub
]]

local gameId = game.PlaceId

if gameId == 1224212277 then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/aymarko/RubyHub/main/MadCity/Chapter2/Main.lua'))()
    
elseif gameId == 91282350711571 then
    _G.AutorobIn = "public"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/aymarko/RubyHub/main/MadCity/Chapter1/Autorob.lua"))()


elseif gameId == 10930070681 then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/aymarko/RubyHub/refs/heads/main/Zombie%20Tycoon/Zombie%20Tycoon.lua'))()

else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/aymarko/RubyHub/main/MadCity/Chapter2/Modules/Notify.lua", true))()
    task.wait(0.5)
    _G.CustomNotify({{Text = "his game is not supported by Ruby Hub!", Delay = 5}})
end