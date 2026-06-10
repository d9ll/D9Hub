-- D9Hub Loader
-- GitHub: https://github.com/твой_аккаунт/D9Hub

local function fetch(module)
    return game:HttpGet("https://raw.githubusercontent.com/d9ll/D9Hub/main/" .. module)
end

local core = loadstring(fetch("Core.lua"))()
-- core уже содержит всё меню
