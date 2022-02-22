name = "MusicBee Overlay"
description = "Displays current song, artist, album name, and album cover. \nMusicBee only."

--[[
    musicbee overlay
	by notshige w/ "borrowed" code from onix's stopwatch script
	
	requirements:
	- musicbee
	- this plugin https://www.getmusicbee.com/addons/plugins/47/now-playing-to-external-files/
	
	after you install the plugin, go to preferences > plugins > 'now playing' to text file > configure
	then set it up like this:
	
	beginning text: blank don't put anything on it
	tag 1: title
	separator text: <cr><lf>
	tag 2: artist
	separator text: <cr><lf>
	tag 3: album
	separator text: <cr><lf>
	tag 4: time
	leave the rest on <not used> and blank
	
	tags file must be %localappdata%\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\RoamingState\OnixClient\Scripts\Data\Tags.txt
	album artwork must be %localappdata%\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\RoamingState\OnixClient\Scripts\Data\Artwork.jpg
	
	encoding for text files must be windows-1252 (otherwise a weird question mark will appear at the beginning of the song title.)
	
	
]]

positionX = 6
positionY = 60
sizeX = 35
sizeY = 30
scale = 1.0

setnothingplaying = true
setnowplayingtext = true

time = 0
Tag = " "
asd = 0
albumartdelay = 0.3

client.settings.addBool("Show 'Nothing playing!' when nothing's playing", "setnothingplaying")
client.settings.addBool("Show a giant 'Now playing:' text", "setnowplayingtext")
client.settings.addAir(15)
client.settings.addFloat("Show album art delay", "albumartdelay", 0.1, 3)
delayinfo = "Sometimes, the album art takes a long time to write, depending on the album art size. \nThis is why this delay is here."
client.settings.addInfo("delayinfo")


function update()											
    local f = io.open("Tags.txt","r")						-- grab the Tags.txt file yes
		if (f ~= nil) then									-- check if it's there...
			io.input(f)
			Tag = io.read("*all")							-- ...read...
			songtitle = get_line("Tags.txt", 1)
			songartist = get_line("Tags.txt", 2)
			songalbum = get_line("Tags.txt", 3)
			songlength = get_line("Tags.txt", 4)			-- ..get songlength...
			io.close(f)
			os.remove("Tags.txt")							-- ...and delete it afterwards. once the file comes back, i'll know it updated.
			asd = 1	
		else end

end

function render(deltaTime)
	local text = Tag
    local font = gui.font()
	local timeelapsed = timeText(time)
	
	if setnowplayingtext == true then
		gfx.text(0, -15, "Now playing:", 1.5)				-- good enough lol
	else end

	if (text == " ") then 									-- if nothing's inside Tags.txt, show sadroc
		                                					-- i also used to use this to check if a new song is playing and unload albumart
		if setnothingplaying == true then					-- problem with this approach is that if it writes the txt too fast,
			gfx.text(33, 2, "Nothing playing!") 			-- this script will have NO idea that it changed and the albumart doesn't change
			gfx.image(0, 0, 30, 30, "sadroc.png")			-- that's why i just delete tags.txt and check when it comes back. hacky workaround ik
			time = 0
		else end

	else 			
		time = time + deltaTime								
		if time > albumartdelay then						-- wait for x number of seconds before showing details. prevents blank/pink images	
			gfx.color(255, 255, 255)						-- delayed songinfo too aside from albumart cuz accessing too fast giving me nil
			gfx.text(33, 2, songtitle .. "\n" .. songartist .. "\n" .. songalbum .. "\n" .. timeelapsed .. " - " .. songlength)
			sizeX = font.width(text, 1) + 41
			gfx.unloadimage("sadroc.png")
			gfx.image(0, 0, 30, 30, "Artwork.jpg")
		else end
	end
	
	if asd == 1 then										-- unload albumart when tags.txt comes back
		gfx.unloadimage("Artwork.jpg")
		asd = 0
		time = 0											
	else end
end

function timeText(time)										-- yoinked from onix's stopwatch script
    local result = ""
    local days = 0
    while (time > 86399) do 
        days = days + 1 
        time = time - 86400 
    end

    local hours = 0
    while (time > 3599) do 
        hours = hours + 1 
        time = time - 86400 
    end
    
    local minutes = 0
    while (time > 59) do 
        minutes = minutes + 1 
        time = time - 60 
    end

    if (days == 0) then
        if (hours == 0) then
            return doubleDigit(minutes) .. ":" .. doubleDigit(time)
        else
            return math.floor(hours) .. " : " .. doubleDigit(minutes) .. ":" ..doubleDigit(time)
        end  
    else
        return math.floor(days) .. " : " .. doubleDigit(hours) .. " : " .. doubleDigit(minutes) .. ":" .. doubleDigit(time)  
    end
end

function doubleDigit(number)								-- also this
    if (number < 10) then
        return "0" .. math.floor(number)
    else
        return math.floor(number)
    end
end

function get_line(filename, line_number)					-- stackoverflow moment
  local i = 0
  for line in io.lines(filename) do
    i = i + 1
    if i == line_number then
      return line
    end
  end
  return nil -- line not found
end
