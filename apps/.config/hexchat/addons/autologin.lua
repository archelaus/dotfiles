
-- User information
local username = ""
local password = ""
local iRCKey = ""
-- Script information
local name = "autologin"
local version = "1.3"
local description = "This script will auto login on filelist channel"
-- Hook Variables
local hookChannelMG
local hookInvited

-- Initialize script
hexchat.register(name, version, description)

-- Callback function for ChannelMG text event
local function OnChannelMG(event)
   local serverName = hexchat.get_info("server" )
   if serverName == "irc.filelist.io" then
       if event[2] == "+" and event[3] == "x" then
           hexchat.command("msg NickServ IDENTIFY "..password)
       elseif event[2] == "+" and event[3] == "R" then
           hexchat.command("msg System invite "..iRCKey)
       end
   end
end

-- Callback function for Invited text event
local function OnInvited(event)
   local serverName = hexchat.get_info("server" )
   if serverName == "irc.filelist.io" then
       hexchat.command("join #filelist" )
   end
end


-- Hook the events with its appropriate callback function
hookChannelMG = hexchat.hook_print("Channel Mode Generic", OnChannelMG)
hookInvited = hexchat.hook_print("Invited", OnInvited)
