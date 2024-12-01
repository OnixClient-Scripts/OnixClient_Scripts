name = "Hive Quick Mount"
description = "Hive Quick Mount"

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
  { 11, "Snappy" },
  { 12, "Couch" },
}

isModuleRequest = false;

client.settings.addInfo("While this module is enabled, you can't open hub cosmetic menu.")
mountId = client.settings.addNamelessEnum("Mount Name", 1, mounts)
customMountName = client.settings.addNamelessTextbox("Mount Name", "")
client.settings.addAir(1)
sneakingDisable = client.settings.addNamelessBool("Disable while sneaking", false)

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

  if not server.ip():find("hive") or request.type ~= "form" or not isModuleRequest then
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
        isModuleRequest = false;
      end
    end
  end
end

function onMouseInput(button, down)
  if button ~= 2 or not down then return end

  local isSneaking = player.getFlag(1)

  local holdItem = player.inventory().at(player.inventory().selected)
  if not holdItem then return end
  if not isSneaking and sneakingDisable.value and holdItem.name == "hivehub:pet_egg" then
    isModuleRequest = true
  elseif not sneakingDisable.value then
    isModuleRequest = true
  end
end

event.listen("ModalRequested", onModalRequested)
event.listen("MouseInput", onMouseInput)
