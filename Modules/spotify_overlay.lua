name = "SPOTIFY OVERLAY"
description = "shows the song spotify is playing"

    --the python script is needed for this script to function

ImportedLib = importLib("fileUtility.lua")

positionX = 1
positionY = 1
sizeX = 0
sizeY = 28

image_size = 28
icon_size = 13

show_album_name = true
show_icons = true

use_logo_instead_of_albumart = false

track_name_text_scale = 1.1
track_artist_and_album_text_scale = 0.9
track_duration_text_scale = 0.75

text_color = { 255, 255, 255, 255 }
rect1_color = { 37, 37, 37, 255 }
rect2_color = { 20, 20, 20, 255 }

progress_bar_fg_color = { 255, 255, 255, 255 }
progress_bar_bg_color = { 50, 50, 50, 255 }

client.settings.addBool("Show Album Name", "show_album_name")
client.settings.addBool("Show Icons", "show_icons")

client.settings.addAir(5)

client.settings.addBool("Use Spotify Logo Instead Of Album Art", "use_logo_instead_of_albumart")

client.settings.addAir(5)

client.settings.addColor("Text Color", "text_color")

client.settings.addAir(5)

client.settings.addColor("Color 1", "rect1_color")
client.settings.addColor("Color 2", "rect2_color")

client.settings.addAir(5)

client.settings.addColor("Progress Bar Foreground", "progress_bar_fg_color")
client.settings.addColor("Progress Bar Background", "progress_bar_bg_color")


function update()

    local track_data = readFile("spotify_overlay/track_data.txt")
    if (track_data ~= nil) then
        track_name = track_data[1]
        track_artists_name = track_data[2]
        track_album_name = track_data[3]
        track_is_playing = track_data[4]
    else
    end

    local duration_data_file = readFile("spotify_overlay/duration_data.txt")
    if (duration_data_file ~= nil) then
        track_duration_s = duration_data_file[1]
        track_progress_s = duration_data_file[2]
    else
    end

end

function converDuration(seconds)
    if seconds ~= nil then
        seconds = tonumber(seconds)
        seconds_new = seconds % 60
        minutes_new = (seconds // 60) % 60
        if (seconds_new < 10) then
            seconds_new = "0" .. seconds_new
        end
        return minutes_new .. ":" .. seconds_new
    elseif seconds == nil then
        return "    "
    end
end

--[[
function marqueeText(text, textWidth)
    font = gui.font()

    var = 0
    if var <= font.width(text) then
        var = var + 1
    elseif i > string.len(text) then
        var = 0
    end

    return string.sub(text, var, var + textWidth)
end
]]

local track_name_text_width = ""
local track_artists_text_width = ""
local track_album_text_width = ""

function render(deltaTime)

    local font = gui.font()
    local fontHeight = font.height

    track_duration = converDuration(track_duration_s)
    track_progress = converDuration(track_progress_s)

    if (track_name ~= nil and track_name ~= "" and track_artists_name ~= nil and track_artists_name ~= "" and track_album_name ~= nil and track_album_name ~= "" and track_progress ~= nil and track_progress ~= "" and track_duration ~= nil and track_duration ~= "") then
        track_name_text_width = (font.width(track_name) * track_name_text_scale) + (image_size + 3)
        track_artists_text_width = (font.width(track_artists_name) * track_artist_and_album_text_scale) + (image_size + 3)
        if (show_album_name == true) then
            track_album_text_width = (font.width(track_album_name) * track_artist_and_album_text_scale) + (image_size + 3)
        elseif (show_album_name == false) then
            track_album_text_width = 0
        end

        track_artist_album_width_table = { track_name_text_width, track_artists_text_width, track_album_text_width }
        table.sort(track_artist_album_width_table)
        sizeX = (track_artist_album_width_table[#track_artist_album_width_table])

        icon_start_pos = (track_artist_album_width_table[#track_artist_album_width_table]) + 50


        gfx.color( rect1_color.r, rect1_color.g, rect1_color.b, rect1_color.a )
        gfx.rect(0, 0, icon_start_pos, sizeY)
        gfx.color( rect2_color.r, rect2_color.g, rect2_color.b, rect2_color.a )
        gfx.rect(0, 0 + sizeY, icon_start_pos, (fontHeight * 0.75) + 3)


        progress_bar_size_total = icon_start_pos - ((font.width(track_duration) * track_duration_text_scale) * 2) - 6
        progress_bar_size = (track_progress_s / track_duration_s) * progress_bar_size_total


        gfx.color( progress_bar_bg_color.r, progress_bar_bg_color.g, progress_bar_bg_color.b, progress_bar_bg_color.a )
        gfx.rect(0 + (font.width(track_progress) * track_duration_text_scale) + 3, 0 + (fontHeight * 3) + 8, progress_bar_size_total, 1)
        gfx.color( progress_bar_fg_color.r, progress_bar_fg_color.b, progress_bar_fg_color.g, progress_bar_fg_color.a )
        gfx.rect(0 + (font.width(track_progress) * track_duration_text_scale) + 3, 0 + (fontHeight * 3) + 8, progress_bar_size, 1)


        gfx.color( text_color.r, text_color.g, text_color.b, text_color.a )


        gfx.text(0 + image_size + 3, 0 + 1, track_name, track_name_text_scale)
        --gfx.text(0 + image_size + 3, 0 + 1, string.sub(track_name, i, i + 10), track_name_text_scale)
        gfx.text(0 + image_size + 3, 0 + fontHeight + 3.5, track_artists_name, track_artist_and_album_text_scale)
        if (show_album_name == true) then
            gfx.text(0 + image_size + 3, 0 + (fontHeight * 2) + 4, track_album_name, track_artist_and_album_text_scale)
        elseif (show_album_name == false) then
        end
        gfx.text(0 + 1, 0 + (fontHeight * 3) + 5, track_progress, track_duration_text_scale)
        gfx.text(0 + icon_start_pos - (font.width(track_duration) * track_duration_text_scale) - 1, 0 + (fontHeight * 3) + 5, track_duration, track_duration_text_scale)


        if (use_logo_instead_of_albumart == true) then
            gfx.image(0, 0, image_size, image_size, "spotify_overlay/icons/spotify_icon.png")
        elseif (use_logo_instead_of_albumart == false) then
            gfx.image(0, 0, image_size, image_size, "spotify_overlay/track_image.png")
        end


        if (show_icons == true) then
            gfx.image(0 + (icon_start_pos) - (icon_size * 3) - 6, 0 + 2, icon_size, icon_size, "spotify_overlay/icons/skip_back.png")
            if (track_is_playing == "True") then
                gfx.image(0 + (icon_start_pos) - (icon_size * 2) - 4, 0 + 2, icon_size, icon_size, "spotify_overlay/icons/pause.png")
            elseif (track_is_playing == "False") then
                gfx.image(0 + (icon_start_pos) - (icon_size * 2) - 4, 0 + 2, icon_size, icon_size, "spotify_overlay/icons/play.png")
            end
            gfx.image(0 + (icon_start_pos) - icon_size - 2, 0 + 2, icon_size, icon_size, "spotify_overlay/icons/skip_forward.png")
        elseif (show_icons == false) then
        end
    end

end
