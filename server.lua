-- Config
Config = {}
Config.DiscordLink  = 'https://discord.gg/' -- Your Discord server invite link.

-- ADD USERS TO WHITELIST HERE!
-- NO CAPITALS!
Config.Whitelist    = {
    --"steam:110000141b8695a", -- Example Steam Hex
    --"license:95d50a3a6f47d51fde3ebf64909e3d4e872b92b5", -- Example FiveM License
}

AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    -- Locals
    local player = source
    local identifiers = GetPlayerIdentifiers(player)
    local identifiersNum = #GetPlayerIdentifiers(player)
    local allowed = false
    local newInfo = ""
    local oldInfo = ""

    -- Stopping user from joining
    deferrals.defer()
    Wait(100) 
    deferrals.update('Please wait...')
    Wait(100) 

    -- Check Whitelist
    for k1, v in pairs(identifiers) do
        for k2, i in ipairs(Config.Whitelist) do
            if string.match(v, i) then
                allowed = true
                break
            end
        end
    end

    if allowed then
        deferrals.done()
    else
        for k1, v in pairs(identifiers) do
            oldInfo = newInfo
            newInfo = string.format("%s\n%s", oldInfo, v)
        end
        deferrals.done('You\'re not whitelisted.\nTo get whitelisted join our Discord server at '..Config.DiscordLink..'\n\nHere is your info:'..newInfo)
    end
end)
