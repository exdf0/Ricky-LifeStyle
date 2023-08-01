local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('ricky-server:lifeStyleChoose')
AddEventHandler('ricky-server:lifeStyleChoose', function(id, item)
  local src = source
  local xPlayer =  QBCore.Functions.GetPlayer(src)

  for k,v in pairs(item) do 
    xPlayer.Functions.AddItem(v.name, v.quantity)
  end


    MySQL.Sync.execute("UPDATE players SET lifeStyle = @lifeStyle WHERE citizenid = @citizenid", {
        ['@citizenid'] = xPlayer.PlayerData.citizenid,
        ['@lifeStyle'] = id
    })
end)

GetLifeStyle = function(source)
  local xPlayer = QBCore.Functions.GetPlayer(src)
  if xPlayer == nil then return end 

  local result = MySQL.Sync.fetchAll("SELECT lifeStyle FROM players WHERE citizenid = @citizenid", {
    ['@citizenid'] = xPlayer.PlayerData.citizenid
  })

  if result[1] ~= nil then 
    return result[1].lifeStyle
  else 
    return nil
  end
end

exports('GetLifeStyle', GetLifeStyle)

QBCore.Functions.CreateCallback('ricky-server:getLifeStyle', function(source, cb, id)
  if id == nil then 
    id = source 
  end
  cb(GetLifeStyle(source))
end)
