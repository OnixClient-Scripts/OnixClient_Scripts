name = "Hive Chat Friend List"
description = "Shows your friends in chat"

commandTrigger = client.settings.addNamelessTextbox("Trigger Command", "/f")

client.settings.addCategory("Display Settings", 2)
isCompactModeEnabled = client.settings.addNamelessBool("Compact Mode", true)
showOffline = client.settings.addNamelessBool("Show Offline", false)
client.settings.addCategory("Miscellaneous Settings", 2)
isEnabledOnFriendItem = client.settings.addNamelessBool("Enable on friend item", false)
isEnabledOnPartyItem = client.settings.addNamelessBool("Enable on party item", false)

supportedLangs = { "en", "ja" }
offlineStatuses = { "Last Seen", "Offline", "オフライン", "前回の参加" }
friendTitleKeywords = { "Friends", "フレンド" }
friendTitleStatusKeywords = { "Online ", "Remote ", "Offline", "オンライン ", "リモート ", "オフライン" }

isModuleRequest = false

function containsKeyword(text, keywords)
  for _, keyword in ipairs(keywords) do
    if text:find(keyword) then
      return true
    end
  end
  return false
end

function removeKeyWords(text, keywords)
  for _, keyword in ipairs(keywords) do
    text = text:gsub(keyword, "")
  end
  return text
end

function formatCompactRegion(text)
  return text:gsub("North America", "NA"):gsub("Asia", "AS"):gsub("Europe", "EU")
end

function onModalRequested(arg1, arg2)
  ---@type ModalFormRequest
  local request = arg1
  ---@type ModalFormReplyer
  local response = arg2

  local language = client.language()
  if not containsKeyword(language, supportedLangs) then
    print("§c[!]§rChat Friend List supports English or Japanese.")
    client.execute("toggle off script" .. name)
    return
  end

  if not server.ip():find("hive") or not isModuleRequest or request.type ~= "form" then
    return
  end

  if containsKeyword(request.form.title, friendTitleKeywords) then
    local title = request.form.title
    if isCompactModeEnabled.value then
      title = removeKeyWords(title, friendTitleStatusKeywords)
    end
    print(title)

    local offlineFriends = "- "
    print("Online friends: ")
    for _, button in pairs(request.form.buttons) do
      local cleanedText = button.text:gsub("%s%s+", " ")
      if isCompactModeEnabled.value then
        cleanedText = formatCompactRegion(cleanedText)
      end

      local isOnline = not containsKeyword(cleanedText, offlineStatuses)
      if isOnline then
        if cleanedText:find("Add A Friend") then
          break
        end
        print("- " .. cleanedText)
      else
        offlineFriends = offlineFriends .. button.text:gsub("%s+", ""):match("^(.-)%s*%[") .. ", "
      end
    end

    if showOffline.value then
      print("Offline friends: ", offlineFriends)
    end
  end

  isModuleRequest = false;
  response.form:cancel()
end

function onChatRequest(message)
  if message == commandTrigger.value then
    isModuleRequest = true
    client.execute("execute /f ")
    return true
  end
end

function onMouseInput(button, down)
  if button ~= 2 or not down then return end

  local holdItem = player.inventory().at(player.inventory().selected)
  if not holdItem then return end
  if isEnabledOnFriendItem.value and holdItem.name == "hivehub:friends" then
    client.execute("execute /f ")
    isModuleRequest = true
    return true
  end
  if isEnabledOnPartyItem.value and holdItem.name == "hivehub:party" then
    client.execute("execute /p list")
    isModuleRequest = true
    return true
  end
end

event.listen("ModalRequested", onModalRequested)
event.listen("ChatMessageRequest", onChatRequest)
event.listen("MouseInput", onMouseInput)
