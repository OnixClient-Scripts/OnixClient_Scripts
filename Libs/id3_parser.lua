
id3 = {}
---@param file BinaryFile
function id3.id3decode_synchsafe_integer(file)
    local number = file:readUInt()
    local a = number & 0xff;
    local b = (number >> 8) & 0xff;
    local c = (number >> 16) & 0xff;
    local d = (number >> 24) & 0xff;

    local converted = 0
    converted = converted | a;
    converted = converted | (b << 7);
    converted = converted | (c << 14);
    converted = converted | (d << 21);
    return converted
end


---Reads a string from the file with the specified encoding
---@param file BinaryFile the file to read from
---@param encoding integer the encoding
---@return string str the string read from the file
function id3.id3v2_read_string_with_encoding(file, encoding)
    if encoding == 0 then
        return file:readStringUtf8UntilNull()
    elseif encoding == 1 then
        if file:readUByte() == 0xFF and file:readUByte() == 0xFE then
            file:setLittleEndian(true)
            local str =  file:readStringUtf16UntilNull()
            file:setLittleEndian(false)
            return str
        else
            return file:readStringUtf16UntilNull()
        end
    elseif encoding == 2 then
        return file:readStringUtf16UntilNull()
    elseif encoding == 3 then
        return file:readStringUtf8UntilNull()
    end
    return "Unknown text encoding"
end

---@param file BinaryFile
---@param segSize integer
function id3.id3v2_extract_text_frame(file, segSize)
    local filepos = file:tell()
    local encoding = file:readUByte()
    local text = id3.id3v2_read_string_with_encoding(file, encoding)
    file:seek(filepos + segSize)
    return text
end

---@class TitleComment
---@field language string The language of the comment
---@field description string The description of the comment
---@field text string The text of the comment

---@class TitleImageCover
---@field offset integer The offset of the image in the file
---@field size integer The size of the image in bytes

---@class TitleInformation
---@field title string The title of the song
---@field artist string The artist of the song
---@field album string The album of the song
---@field track string The track number of the song
---@field year integer|nil The year of the song
---@field genre string|nil The genre of the song
---@field comments TitleComment[] The comments of the song
---@field image TitleImageCover|nil DO NOT USE
---@field gfx_image Gfx2Texture|nil DO NOT USE
local ___Acsadsa_ACP_TitleInformation = {}

---@param file BinaryFile|nil The file to get the image from
---@return Gfx2Texture|nil coverImage The cover image of the song or nil if not present
function ___Acsadsa_ACP_TitleInformation:getImage(file) return nil end



---@param file BinaryFile
---@return TitleInformation|nil info
function id3.parse_id3v2(file)
    file:seek(0) -- Move to the beginning of the file

    local ImagePriorities = {
        03,     -- "Cover (front)", -- Most important, the primary album artwork
        02,     -- "File icon", -- Secondary option for album art
        07,     -- "Lead artist/lead performer/soloist",
        08,     -- "Artist/performer",
        10,     -- "Band/orchestra",
        4,      -- "Cover (back)", -- Secondary option for album art
        19,     -- "Band/artist logotype",

        -- Lower Priority (situational)
        15,     -- "During performance",
        14,     -- "During recording",
        5       -- "Leaflet page",
    }

    -- Verify ID3 tag header
    if file:read(3) ~= "ID3" then
        return nil -- Not a valid ID3v2.3 tag
    end
    local version_major = file:readUByte()
    local version_minor = file:readUByte()
    file:setLittleEndian(false)

    
    local flags = file:readUByte()  -- ID3v2 flags
    local tag_size = id3.id3decode_synchsafe_integer(file)


    local tag_data = {}
    function tag_data:getImage(file)
        if self.gfx_image then return self.gfx_image end
        if self.image and file ~= nil then
            local prevPos = file:tell()
            file:seek(self.image.offset)
            self.gfx_image = file:parseImage(self.image.size)
            file:seek(prevPos)
            return self.gfx_image
        end
        return nil
    end

    local picOffsets = {}

    while not file:eof() and file:tell() < tag_size do
        local frame_id = file:read(4)
        local frame_size = file:readUInt()
        if frame_size == 0 then break end
        --print("o: " .. file:tell() - 8 .. " s: " .. frame_size .. " " .. frame_id)
        local frame_flags = file:readUShort()
        -- Process frames
        if frame_id == "TIT2" then
            tag_data.title = id3.id3v2_extract_text_frame(file, frame_size)
        elseif frame_id == "TPE1" then
            tag_data.artist = id3.id3v2_extract_text_frame(file, frame_size)
        elseif frame_id == "TALB" then
            tag_data.album = id3.id3v2_extract_text_frame(file, frame_size)
        elseif frame_id == "TYER" then
            tag_data.year = id3.id3v2_extract_text_frame(file, frame_size)
        elseif frame_id == "TRCK" then
            tag_data.track = id3.id3v2_extract_text_frame(file, frame_size)
            local slashPos = tag_data.track:find("/")
            if slashPos then
                tag_data.track = tag_data.track:sub(1, slashPos-1)
            end
        elseif frame_id == "TCON" then
            tag_data.genre = id3.id3v2_extract_text_frame(file, frame_size)
        elseif frame_id == "TDRC" then
            local t = id3.id3v2_extract_text_frame(file, frame_size)
            local dashPos = t:find("-")
            if dashPos then
                tag_data.year = math.floor(tonumber(t:sub(1, dashPos-1)) or 0)
                if tag_data.year == 0 then
                    tag_data.year = nil
                end
            end
        elseif frame_id == "TLEN" then
            tag_data.length = tonumber(id3.id3v2_extract_text_frame(file, frame_size))
        elseif frame_id == "COMM" then
            local encoding = file:readUByte()
            local language = file:read(3)
            local description = id3.id3v2_read_string_with_encoding(file, encoding)
            local comment = id3.id3v2_read_string_with_encoding(file, encoding)
            tag_data.comments = tag_data.comments or {}
            table.insert(tag_data.comments, {language=language,description=description,text=comment})
        elseif frame_id == "APIC" then
            local preData = file:tell()
            local encoding = file:readUByte()
            local mime_type = file:readStringUtf8UntilNull()
            local pic_type = file:readUByte()
            local pic_desc = id3.id3v2_read_string_with_encoding(file, encoding)
            picOffsets[pic_type] = {offset=file:tell(), size=frame_size-(file:tell()-preData)}
            
            file:seek(preData + frame_size)
        else
            file:seek(file:tell() + frame_size)
        end
    end

    for k, picType in pairs(ImagePriorities) do
        if picOffsets[picType] then
            tag_data.image = picOffsets[picType]
            break
        end
    end

    return tag_data
end


---@param file BinaryFile
---@return TitleInformation|nil info
function id3.parse_id3v1(file)
    file:seek(file.size - 128)
    if file:read(3) == "TAG" then
        local Genres = {
            [0] = "Blues",
            [1] = "Classic rock",
            [2] = "Country",
            [3] = "Dance",
            [4] = "Disco",
            [5] = "Funk",
            [6] = "Grunge",
            [7] = "Hip-hop",
            [8] = "Jazz",
            [9] = "Metal",
            [10] = "New age",
            [11] = "Oldies",
            [12] = "Other",
            [13] = "Pop",
            [14] = "Rhythm and blues",
            [15] = "Rap",
            [16] = "Reggae",
            [17] = "Rock",
            [18] = "Techno",
            [19] = "Industrial",
            [20] = "Alternative",
            [21] = "Ska",
            [22] = "Death metal",
            [23] = "Pranks",
            [24] = "Soundtrack",
            [25] = "Euro-techno",
            [26] = "Ambient",
            [27] = "Trip-hop",
            [28] = "Vocal",
            [29] = "Jazz & funk",
            [30] = "Fusion",
            [31] = "Trance",
            [32] = "Classical",
            [33] = "Instrumental",
            [34] = "Acid",
            [35] = "House",
            [36] = "Game",
            [37] = "Sound clip",
            [38] = "Gospel",
            [39] = "Noise",
            [40] = "Alternative rock",
            [41] = "Bass",
            [42] = "Soul",
            [43] = "Punk",
            [44] = "Space",
            [45] = "Meditative",
            [46] = "Instrumental pop",
            [47] = "Instrumental rock",
            [48] = "Ethnic",
            [49] = "Gothic",
            [50] = "Darkwave",
            [51] = "Techno-industrial",
            [52] = "Electronic",
            [53] = "Pop-folk",
            [54] = "Eurodance",
            [55] = "Dream",
            [56] = "Southern rock",
            [57] = "Comedy",
            [58] = "Cult",
            [59] = "Gangsta",
            [60] = "Top 40",
            [61] = "Christian rap",
            [62] = "Pop/funk",
            [63] = "Jungle music",
            [64] = "Native US",
            [65] = "Cabaret",
            [66] = "New wave",
            [67] = "Psychedelic",
            [68] = "Rave",
            [69] = "Showtunes",
            [70] = "Trailer",
            [71] = "Lo-fi",
            [72] = "Tribal",
            [73] = "Acid punk",
            [74] = "Acid jazz",
            [75] = "Polka",
            [76] = "Retro",
            [77] = "Musical",
            [78] = "Rock 'n' roll",
            [79] = "Hard rock",
            [80] = "Folk",
            [81] = "Folk rock",
            [82] = "National folk",
            [83] = "Swing",
            [84] = "Fast fusion",
            [85] = "Bebop",
            [86] = "Latin",
            [87] = "Revival",
            [88] = "Celtic",
            [89] = "Bluegrass",
            [90] = "Avantgarde",
            [91] = "Gothic rock",
            [92] = "Progressive rock",
            [93] = "Psychedelic rock",
            [94] = "Symphonic rock",
            [95] = "Slow rock",
            [96] = "Big band",
            [97] = "Chorus",
            [98] = "Easy listening",
            [99] = "Acoustic",
            [100] = "Humour",
            [101] = "Speech",
            [102] = "Chanson",
            [103] = "Opera",
            [104] = "Chamber music",
            [105] = "Sonata",
            [106] = "Symphony",
            [107] = "Booty bass",
            [108] = "Primus",
            [109] = "Porn groove",
            [110] = "Satire",
            [111] = "Slow jam",
            [112] = "Club",
            [113] = "Tango",
            [114] = "Samba",
            [115] = "Folklore",
            [116] = "Ballad",
            [117] = "Power ballad",
            [118] = "Rhythmic Soul",
            [119] = "Freestyle",
            [120] = "Duet",
            [121] = "Punk rock",
            [122] = "Drum solo",
            [123] = "A cappella",
            [124] = "Euro-house",
            [125] = "Dance hall",
            [126] = "Goa music",
            [127] = "Drum & bass",
            [128] = "Club-house",
            [129] = "Hardcore techno",
            [130] = "Terror",
            [131] = "Indie",
            [132] = "Britpop",
            [133] = "Negerpunk",
            [134] = "Polsk punk",
            [135] = "Beat",
            [136] = "Christian gangsta rap",
            [137] = "Heavy metal",
            [138] = "Black metal",
            [139] = "Crossover",
            [140] = "Contemporary Christian",
            [141] = "Christian rock",
            [142] = "Merengue",
            [143] = "Salsa",
            [144] = "Thrash metal",
            [145] = "Anime",
            [146] = "Jpop",
            [147] = "Synthpop",
            [148] = "Christmas",
            [149] = "Art rock",
            [150] = "Baroque",
            [151] = "Bhangra",
            [152] = "Big beat",
            [153] = "Breakbeat",
            [154] = "Chillout",
            [155] = "Downtempo",
            [156] = "Dub",
            [157] = "EBM",
            [158] = "Eclectic",
            [159] = "Electro",
            [160] = "Electroclash",
            [161] = "Emo",
            [162] = "Experimental",
            [163] = "Garage",
            [164] = "Global",
            [165] = "IDM",
            [166] = "Illbient",
            [167] = "Industro-Goth",
            [168] = "Jam Band",
            [169] = "Krautrock",
            [170] = "Leftfield",
            [171] = "Lounge",
            [172] = "Math rock",
            [173] = "New romantic",
            [174] = "Nu-breakz",
            [175] = "Post-punk",
            [176] = "Post-rock",
            [177] = "Psytrance",
            [178] = "Shoegaze",
            [179] = "Space rock",
            [180] = "Trop rock",
            [181] = "World music",
            [182] = "Neoclassical",
            [183] = "Audiobook",
            [184] = "Audio theatre",
            [185] = "Neue Deutsche Welle",
            [186] = "Podcast",
            [187] = "Indie rock",
            [188] = "G-Funk",
            [189] = "Dubstep",
            [190] = "Garage rock",
            [191] = "Psybient",
            [192] = "Undefined"
        }
        local title = file:read(30)
        local artist = file:read(30)
        local album = file:read(30)
        local year = math.floor(tonumber(file:read(4)) or 0)
        local comment = file:read(30)
        local genre = file:readUByte()
        return {
            title = title,
            artist = artist,
            album = album,
            year = year,
            comments = {text=comment, language="XXX", description=""},
            genre = Genres[genre],
            getImage = function(file) return nil end
        }


    end
    return nil
end

---Parses the ID3 tag from the file/filename
---@param file BinaryFile|string|nil The file or filepath to parse the ID3 tag from
---@param parseImage boolean|nil If true, the image will be parsed and stored in the returned object
---@return TitleInformation|nil info The parsed ID3 tag if present
function id3.parse(file, parseImage)
    if file == nil then return nil end
    if parseImage == nil then parseImage = true end
    local closeFile = false
    if type(file) == "string" then
        file = fs.open(file, "r")
        closeFile = true
    end
    if file == nil then return nil end
    local fileInfo = id3.parse_id3v2(file)
        if fileInfo == nil then
            fileInfo = id3.parse_id3v1(file)
        end
        if fileInfo == nil then
            if closeFile then file:close() end
            return nil
        elseif parseImage then
            fileInfo.gfx_image = fileInfo:getImage(file)
            if closeFile then file:close() end
            return fileInfo
        else
            return fileInfo
        end
end
