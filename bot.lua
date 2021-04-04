local discordia = require('discordia')
local client = discordia.Client()
local http = require('coro-http')
local json = require('json')
local config = {
  ['token'] = "Bot ODI4Mjk3MTA4Nzg0MjgzNjQ4.YGnhyw.NKwZsOQpwzcfkBGfRh9kN6AaQao",
  ['api'] = 'AIzaSyDcsRaiS4cdv6yma3l22Qe6eMbM_1h76t0'
}

math.randomseed(os.time())

function gfiscalling(data)
  data.channel:send('Hold on '..data.author.username..', my girlfriend is calling.')  
  return false
end
function Money_f(n)
  if n >= 10^9 then
    return string.format("%.2fB", n / 10^9)
  elseif n >= 10^6 then
    return string.format("%.2fM", n / 10^6)
  elseif n >= 10^3 then
    return string.format("%.2fK", n / 10^3)
  else
      return tostring(n)
  end
end

function string:split(sep)
  local sep, fields = sep or ":", {}
  local pattern = string.format("([^%s]+)", sep)
  self:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end

function GetStatsById(message, id)
  local http = require('coro-http')
  coroutine.wrap(function()
    local url = "https://www.googleapis.com/youtube/v3/channels/?part=snippet,contentDetails,statistics&id="..id.."&key="..config['api']..""
    local method = "GET"
    local res, body = http.request(method, url)
    data = json.decode(body)
    if data.items then
      message:reply {
        embed = {
          title = "Youtube Statistics",
          author = {
            name = data.items[1].snippet.title,
            icon_url = data.items[1].snippet.thumbnails.default.url
          },
          fields = {
            {name = "Video Count", value = Money_f(tonumber(data.items[1].statistics.videoCount)), inline = true},
            {name = "Subscribers", value = Money_f(tonumber(data.items[1].statistics.subscriberCount)), inline = true},
            {name = "View Count", value = Money_f(tonumber(data.items[1].statistics.viewCount)), inline = true},
          },
          footer = {
            text = "This channel was created on "..string.sub(data.items[1].snippet.publishedAt, 1, 10)
          },
          color = 0xab34eb
        }
      }
    else
      message:reply {
        embed = {
          title = "Youtube Statistics",
          author = {
            name = message.author.tag,
            icon_url = message.author.avatarURL
          },
          fields = {
            {name = "Lookup Failed", value = "Invalid id", inline = true},
          },
          footer = {
            text = "Was unable to find anything by search for "..id
          },
          color = 0xab34eb
        }
      }
    end
  end)()
end
function GetStatsByUser(message, username)
  local http = require('coro-http')
  coroutine.wrap(function()
    local url = "https://www.googleapis.com/youtube/v3/search?part=snippet&type=channel&maxResults=1&q="..username.."&key="..config['api']..""
    local method = "GET"
    local res, body = http.request(method, url)
    data = json.decode(body)
    if data.items then
      GetStatsById(message, data.items[1].snippet.channelId)
    end
  end)()
end

client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)

client:on('messageCreate', function(message)
  local content = message.content
  local args = content:split(" ")
  
  if message.author.bot == true then
    return false
  end

  if args[1] == 'Evol.id' or args[1] == 'evol.id' or args[1] == 'Evol.Id' or args[1] == 'evol.Id' or args[1] == 'e.i' or args[1] == 'E.I' or args[1] == 'E.i' or args[1] == 'e.I' or args[1] == 'Evol.ID' or args[1] == 'evol.ID' then   
    if args[2] then
    local roll = math.random(1,5)
      if tonumber(roll) == 5 then
        gfiscalling(message)
      else
      message.channel:send(message.author.username..', fetching statistics....')
      GetStatsById(message, args[2])
      end
    else
      message.channel:send(message.author.username..', you have the wrong command format. Type Evol.Help for more information.')
      return false
    end
  end
if args[1] == 'Evol.user' or args[1] == 'evol.User' or args[1] == 'Evol.User' or args[1] == 'evol.user' or args[1] == 'E.U' or args[1] == 'E.u' or args[1] == 'e.U' or args[1] == 'e.u' then
  if args[2] then
    table.remove(args, 1)
    local str
    local roll = math.random(1,5)
    str = table.concat(args, "_")
    if tonumber(roll) == 5 then
      gfiscalling(message)
    else
      message.channel:send(message.author.username..', fetching statistics....')
      GetStatsByUser(message, str)
    end
  else
    message.channel:send(message.author.username..', you have the wrong command format. Type Evol.Help for more information.')
    return false
  end
end
  if args[1] == 'Evol.help' or args[1] == 'evol.help' or args[1] == 'Evol.Help' or args[1] == 'evol.Help' or args[1] == 'e.h' or args[1] == 'E.H' or args[1] == 'e.H' or args[1] == 'E.h' then
    message:reply {
      embed = {
        title = "Youtube Statistics",
        author = {
          name = message.author.tag,
          icon_url = message.author.avatarURL
        },
        fields = {
          {name = "Evol.id", value = "Example: \n Evol.id UCtcEk5zYxxPQb-vtAL5o_8Q", inline = true},
          {name = "Evol.user", value = "Example: \n Evol.user EvolNutz", inline = true},
          {
            name = "⠀",
            value = "[Source](https://github.com/REDRUM112/EvolNutz-Discord-Bot/blob/main/bot.lua)",
            inline = false
          }
        },
        footer = {
          text = "This bot was made by REDRUM#9269"
        },
        color = 0xab34eb
      }
    }
  end
  if args[1] == "Evol.purge" or args[1] == 'Evol.Purge' or args[1] == 'evol.purge' or args[1] == 'evol.Purge' or args[1] == 'e.p' or args[1] == 'E.P' or args[1] == 'e.P' or args[1] == 'E.p' then
    local isStaff = message.member:hasPermission("administrator")
    if isStaff == true then
      if args[2] then
        if type(tonumber(args[2])) == 'number' then
          MG = message.channel:getMessages(tonumber(args[2]))
          message.channel:bulkDelete(MG)
        else
          message.channel:send(message.author.username..', the second argument is not a number.')
          return false
        end
      else
        message.channel:send(message.author.username..', you are missing the number argument.')
        return false
      end
    else
      message.channel:send(message.author.username..', you have to be GM to do this.')
        return false
    end
  end
end)

client:run(config['token'])
