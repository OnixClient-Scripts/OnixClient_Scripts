name = "Hive Quick Mount"
description = "Ride mounts by using hub cosmetic item without opening modals"

mounts = {
  { 0,  "Custom Name" },
  { 1,  "Spaceship" },
  { 2,  "Bumblebee" },
  { 3,  "Cruiser" },
  { 4,  "Pirate Ship" },
  { 5,  "Broomstick" },
  { 6,  "Hoverbike" },
  { 7,  "Ghast" },
  { 8,  "Dragon" },
  { 9,  "Wooden Chair" },
  { 10, "Helicopter" },
}

client.settings.addInfo("While this module is enabled, you can't open hub cosmetic menu.")
mountId = client.settings.addNamelessEnum("Mount Name", 1, mounts)
customMountName = client.settings.addNamelessTextbox("Mount Name", "")

function getTableItemByNumber(table, index)
  for _, item in ipairs(table) do
    if item[1] == index then
      return item[2]
    end
  end
  return nil
end

function containsKeyword(text, keywords)
  for _, keyword in ipairs(keywords) do
    if text:find(keyword) then
      return true
    end
  end
  return false
end

function update()
  if (mountId.value == 0) then
    customMountName.visible = true
  else
    customMountName.visible = false
  end
end

function onModalRequested(arg1, arg2)
  ---@type ModalFormRequest
  local request = arg1
  ---@type ModalFormReplyer
  local response = arg2

  if not server.ip():find("hive") or request.type ~= "form" then
    return
  end

  if request.form.title:find("Hub Cosmetics") then
    response.form:reply(2)
  end

  if request.form.title:find("Mount Selector") then
    local mountName = getTableItemByNumber(mounts, mountId.value)
    if (mountId.value == 0) then
      mountName = customMountName.value
    end
    if not mountName then return end

    for i, button in pairs(request.form.buttons) do
      if (button.text:find(mountName)) then
        print("§c[!] §rQuick Mount is enabled!")
        response.form:reply(i)
      end
    end
  end
end

event.listen("ModalRequested", onModalRequested)
