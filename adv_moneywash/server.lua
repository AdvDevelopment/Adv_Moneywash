RegisterNetEvent("adv:clearmoney", function(data, percentage)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local amount = tonumber(data.amount)
    local valore = amount * percentage / 100

    if valore and valore > 0 then
        local moneyBlack = exports.ox_inventory:GetItem(_source, 'black_money')


        if moneyBlack and moneyBlack.count >= valore then
            local successRemove = exports.ox_inventory:RemoveItem(_source, 'black_money', amount)
            local successAdd = exports.ox_inventory:AddItem(_source, 'money', valore)

            if successRemove and successAdd then
                xPlayer.showNotification("You have cleaned $" .. amount .. " in money, with percentage of: " .. percentage .. "%")


                local webhookURL = Config.Webhook
                local playerName = GetPlayerName(_source)

                PerformHttpRequest(webhookURL, function(err, text, headers)
 
                end, 'POST', json.encode({
                    username = "Log",
                    embeds = {
                        {
                            title = "Log Adv_MoneyWash",
                            color = 3066993,
                            thumbnail = {
                                url = "https://cdn.discordapp.com/attachments/1167883291601408050/1322253083794997308/ADV.png?ex=677033a5&is=676ee225&hm=3c679d6fb8c2302dfcf71fd9a008ce56c9facb6b0743192b2d2d3d52a674f0e7&" 
                            },
                            fields = {
                                { name = "Player Name", value = playerName, inline = true },
                                { name = "Player ID", value = tostring(_source), inline = true },
                                { name = "Amount Cleaned", value = "$" .. amount, inline = true },
                                { name = "Percentage", value = tostring(percentage) .. "%", inline = true }
                            },
                            footer = { text = "Adv Development" },
                            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ") 
                        }
                    }
                }), { ['Content-Type'] = 'application/json' })

            end
        else
            xPlayer.showNotification("You don't have enough dirty money.")
        end
    end
end)
