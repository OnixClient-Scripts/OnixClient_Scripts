name="In-Game Skin editor"
description = "In Game! Changes your a png file for a skin when you tell it to"

importLib("BlockRGB.lua")

-- second layers dont work
client.settings.addInfo("Make a new superflat work (void world is recomended) and go to 0, 0, 0 to start!")
client.settings.addInfo("Change the skinEdit.png file and then do .loadSkin, if your skin is in the right format\nit will build a statue of it, if you edit the statue then run .saveSkin it will convert the\nblocks back into the original")

autoSave = false
client.settings.addBool("Auto Save","autoSave")

IRLcoordsx = {}
IRLcoordsy = {}
IRLcoordsxIRL ={}
IRLcoordsyIRL = {}
IRLcoordszIRL = {}
if 1 then
IRLcoordsx[ 0]= 8; IRLcoordsy[ 0]= 8; IRLcoordsxIRL[ 0]=-13; IRLcoordsyIRL[ 0]= 40; IRLcoordszIRL[ 0]= 7
IRLcoordsx[ 1]= 8; IRLcoordsy[ 1]= 9; IRLcoordsxIRL[ 1]=-13; IRLcoordsyIRL[ 1]= 39; IRLcoordszIRL[ 1]= 7
IRLcoordsx[ 2]= 8; IRLcoordsy[ 2]= 10; IRLcoordsxIRL[ 2]=-13; IRLcoordsyIRL[ 2]= 38; IRLcoordszIRL[ 2]= 7
IRLcoordsx[ 3]= 8; IRLcoordsy[ 3]= 11; IRLcoordsxIRL[ 3]=-13; IRLcoordsyIRL[ 3]= 37; IRLcoordszIRL[ 3]= 7
IRLcoordsx[ 4]= 8; IRLcoordsy[ 4]= 12; IRLcoordsxIRL[ 4]=-13; IRLcoordsyIRL[ 4]= 36; IRLcoordszIRL[ 4]= 7
IRLcoordsx[ 5]= 8; IRLcoordsy[ 5]= 13; IRLcoordsxIRL[ 5]=-13; IRLcoordsyIRL[ 5]= 35; IRLcoordszIRL[ 5]= 7
IRLcoordsx[ 6]= 8; IRLcoordsy[ 6]= 14; IRLcoordsxIRL[ 6]=-13; IRLcoordsyIRL[ 6]= 34; IRLcoordszIRL[ 6]= 7
IRLcoordsx[ 7]= 8; IRLcoordsy[ 7]= 15; IRLcoordsxIRL[ 7]=-13; IRLcoordsyIRL[ 7]= 33; IRLcoordszIRL[ 7]= 7
IRLcoordsx[ 8]= 9; IRLcoordsy[ 8]= 8; IRLcoordsxIRL[ 8]=-12; IRLcoordsyIRL[ 8]= 40; IRLcoordszIRL[ 8]= 7
IRLcoordsx[ 9]= 9; IRLcoordsy[ 9]= 9; IRLcoordsxIRL[ 9]=-12; IRLcoordsyIRL[ 9]= 39; IRLcoordszIRL[ 9]= 7
IRLcoordsx[ 10]= 9; IRLcoordsy[ 10]= 10; IRLcoordsxIRL[ 10]=-12; IRLcoordsyIRL[ 10]= 38; IRLcoordszIRL[ 10]= 7
IRLcoordsx[ 11]= 9; IRLcoordsy[ 11]= 11; IRLcoordsxIRL[ 11]=-12; IRLcoordsyIRL[ 11]= 37; IRLcoordszIRL[ 11]= 7
IRLcoordsx[ 12]= 9; IRLcoordsy[ 12]= 12; IRLcoordsxIRL[ 12]=-12; IRLcoordsyIRL[ 12]= 36; IRLcoordszIRL[ 12]= 7
IRLcoordsx[ 13]= 9; IRLcoordsy[ 13]= 13; IRLcoordsxIRL[ 13]=-12; IRLcoordsyIRL[ 13]= 35; IRLcoordszIRL[ 13]= 7
IRLcoordsx[ 14]= 9; IRLcoordsy[ 14]= 14; IRLcoordsxIRL[ 14]=-12; IRLcoordsyIRL[ 14]= 34; IRLcoordszIRL[ 14]= 7
IRLcoordsx[ 15]= 9; IRLcoordsy[ 15]= 15; IRLcoordsxIRL[ 15]=-12; IRLcoordsyIRL[ 15]= 33; IRLcoordszIRL[ 15]= 7
IRLcoordsx[ 16]= 10; IRLcoordsy[ 16]= 8; IRLcoordsxIRL[ 16]=-11; IRLcoordsyIRL[ 16]= 40; IRLcoordszIRL[ 16]= 7
IRLcoordsx[ 17]= 10; IRLcoordsy[ 17]= 9; IRLcoordsxIRL[ 17]=-11; IRLcoordsyIRL[ 17]= 39; IRLcoordszIRL[ 17]= 7
IRLcoordsx[ 18]= 10; IRLcoordsy[ 18]= 10; IRLcoordsxIRL[ 18]=-11; IRLcoordsyIRL[ 18]= 38; IRLcoordszIRL[ 18]= 7
IRLcoordsx[ 19]= 10; IRLcoordsy[ 19]= 11; IRLcoordsxIRL[ 19]=-11; IRLcoordsyIRL[ 19]= 37; IRLcoordszIRL[ 19]= 7
IRLcoordsx[ 20]= 10; IRLcoordsy[ 20]= 12; IRLcoordsxIRL[ 20]=-11; IRLcoordsyIRL[ 20]= 36; IRLcoordszIRL[ 20]= 7
IRLcoordsx[ 21]= 10; IRLcoordsy[ 21]= 13; IRLcoordsxIRL[ 21]=-11; IRLcoordsyIRL[ 21]= 35; IRLcoordszIRL[ 21]= 7
IRLcoordsx[ 22]= 10; IRLcoordsy[ 22]= 14; IRLcoordsxIRL[ 22]=-11; IRLcoordsyIRL[ 22]= 34; IRLcoordszIRL[ 22]= 7
IRLcoordsx[ 23]= 10; IRLcoordsy[ 23]= 15; IRLcoordsxIRL[ 23]=-11; IRLcoordsyIRL[ 23]= 33; IRLcoordszIRL[ 23]= 7
IRLcoordsx[ 24]= 11; IRLcoordsy[ 24]= 8; IRLcoordsxIRL[ 24]=-10; IRLcoordsyIRL[ 24]= 40; IRLcoordszIRL[ 24]= 7
IRLcoordsx[ 25]= 11; IRLcoordsy[ 25]= 9; IRLcoordsxIRL[ 25]=-10; IRLcoordsyIRL[ 25]= 39; IRLcoordszIRL[ 25]= 7
IRLcoordsx[ 26]= 11; IRLcoordsy[ 26]= 10; IRLcoordsxIRL[ 26]=-10; IRLcoordsyIRL[ 26]= 38; IRLcoordszIRL[ 26]= 7
IRLcoordsx[ 27]= 11; IRLcoordsy[ 27]= 11; IRLcoordsxIRL[ 27]=-10; IRLcoordsyIRL[ 27]= 37; IRLcoordszIRL[ 27]= 7
IRLcoordsx[ 28]= 11; IRLcoordsy[ 28]= 12; IRLcoordsxIRL[ 28]=-10; IRLcoordsyIRL[ 28]= 36; IRLcoordszIRL[ 28]= 7
IRLcoordsx[ 29]= 11; IRLcoordsy[ 29]= 13; IRLcoordsxIRL[ 29]=-10; IRLcoordsyIRL[ 29]= 35; IRLcoordszIRL[ 29]= 7
IRLcoordsx[ 30]= 11; IRLcoordsy[ 30]= 14; IRLcoordsxIRL[ 30]=-10; IRLcoordsyIRL[ 30]= 34; IRLcoordszIRL[ 30]= 7
IRLcoordsx[ 31]= 11; IRLcoordsy[ 31]= 15; IRLcoordsxIRL[ 31]=-10; IRLcoordsyIRL[ 31]= 33; IRLcoordszIRL[ 31]= 7
IRLcoordsx[ 32]= 12; IRLcoordsy[ 32]= 8; IRLcoordsxIRL[ 32]=-9; IRLcoordsyIRL[ 32]= 40; IRLcoordszIRL[ 32]= 7
IRLcoordsx[ 33]= 12; IRLcoordsy[ 33]= 9; IRLcoordsxIRL[ 33]=-9; IRLcoordsyIRL[ 33]= 39; IRLcoordszIRL[ 33]= 7
IRLcoordsx[ 34]= 12; IRLcoordsy[ 34]= 10; IRLcoordsxIRL[ 34]=-9; IRLcoordsyIRL[ 34]= 38; IRLcoordszIRL[ 34]= 7
IRLcoordsx[ 35]= 12; IRLcoordsy[ 35]= 11; IRLcoordsxIRL[ 35]=-9; IRLcoordsyIRL[ 35]= 37; IRLcoordszIRL[ 35]= 7
IRLcoordsx[ 36]= 12; IRLcoordsy[ 36]= 12; IRLcoordsxIRL[ 36]=-9; IRLcoordsyIRL[ 36]= 36; IRLcoordszIRL[ 36]= 7
IRLcoordsx[ 37]= 12; IRLcoordsy[ 37]= 13; IRLcoordsxIRL[ 37]=-9; IRLcoordsyIRL[ 37]= 35; IRLcoordszIRL[ 37]= 7
IRLcoordsx[ 38]= 12; IRLcoordsy[ 38]= 14; IRLcoordsxIRL[ 38]=-9; IRLcoordsyIRL[ 38]= 34; IRLcoordszIRL[ 38]= 7
IRLcoordsx[ 39]= 12; IRLcoordsy[ 39]= 15; IRLcoordsxIRL[ 39]=-9; IRLcoordsyIRL[ 39]= 33; IRLcoordszIRL[ 39]= 7
IRLcoordsx[ 40]= 13; IRLcoordsy[ 40]= 8; IRLcoordsxIRL[ 40]=-8; IRLcoordsyIRL[ 40]= 40; IRLcoordszIRL[ 40]= 7
IRLcoordsx[ 41]= 13; IRLcoordsy[ 41]= 9; IRLcoordsxIRL[ 41]=-8; IRLcoordsyIRL[ 41]= 39; IRLcoordszIRL[ 41]= 7
IRLcoordsx[ 42]= 13; IRLcoordsy[ 42]= 10; IRLcoordsxIRL[ 42]=-8; IRLcoordsyIRL[ 42]= 38; IRLcoordszIRL[ 42]= 7
IRLcoordsx[ 43]= 13; IRLcoordsy[ 43]= 11; IRLcoordsxIRL[ 43]=-8; IRLcoordsyIRL[ 43]= 37; IRLcoordszIRL[ 43]= 7
IRLcoordsx[ 44]= 13; IRLcoordsy[ 44]= 12; IRLcoordsxIRL[ 44]=-8; IRLcoordsyIRL[ 44]= 36; IRLcoordszIRL[ 44]= 7
IRLcoordsx[ 45]= 13; IRLcoordsy[ 45]= 13; IRLcoordsxIRL[ 45]=-8; IRLcoordsyIRL[ 45]= 35; IRLcoordszIRL[ 45]= 7
IRLcoordsx[ 46]= 13; IRLcoordsy[ 46]= 14; IRLcoordsxIRL[ 46]=-8; IRLcoordsyIRL[ 46]= 34; IRLcoordszIRL[ 46]= 7
IRLcoordsx[ 47]= 13; IRLcoordsy[ 47]= 15; IRLcoordsxIRL[ 47]=-8; IRLcoordsyIRL[ 47]= 33; IRLcoordszIRL[ 47]= 7
IRLcoordsx[ 48]= 14; IRLcoordsy[ 48]= 8; IRLcoordsxIRL[ 48]=-7; IRLcoordsyIRL[ 48]= 40; IRLcoordszIRL[ 48]= 7
IRLcoordsx[ 49]= 14; IRLcoordsy[ 49]= 9; IRLcoordsxIRL[ 49]=-7; IRLcoordsyIRL[ 49]= 39; IRLcoordszIRL[ 49]= 7
IRLcoordsx[ 50]= 14; IRLcoordsy[ 50]= 10; IRLcoordsxIRL[ 50]=-7; IRLcoordsyIRL[ 50]= 38; IRLcoordszIRL[ 50]= 7
IRLcoordsx[ 51]= 14; IRLcoordsy[ 51]= 11; IRLcoordsxIRL[ 51]=-7; IRLcoordsyIRL[ 51]= 37; IRLcoordszIRL[ 51]= 7
IRLcoordsx[ 52]= 14; IRLcoordsy[ 52]= 12; IRLcoordsxIRL[ 52]=-7; IRLcoordsyIRL[ 52]= 36; IRLcoordszIRL[ 52]= 7
IRLcoordsx[ 53]= 14; IRLcoordsy[ 53]= 13; IRLcoordsxIRL[ 53]=-7; IRLcoordsyIRL[ 53]= 35; IRLcoordszIRL[ 53]= 7
IRLcoordsx[ 54]= 14; IRLcoordsy[ 54]= 14; IRLcoordsxIRL[ 54]=-7; IRLcoordsyIRL[ 54]= 34; IRLcoordszIRL[ 54]= 7
IRLcoordsx[ 55]= 14; IRLcoordsy[ 55]= 15; IRLcoordsxIRL[ 55]=-7; IRLcoordsyIRL[ 55]= 33; IRLcoordszIRL[ 55]= 7
IRLcoordsx[ 56]= 15; IRLcoordsy[ 56]= 8; IRLcoordsxIRL[ 56]=-6; IRLcoordsyIRL[ 56]= 40; IRLcoordszIRL[ 56]= 7
IRLcoordsx[ 57]= 15; IRLcoordsy[ 57]= 9; IRLcoordsxIRL[ 57]=-6; IRLcoordsyIRL[ 57]= 39; IRLcoordszIRL[ 57]= 7
IRLcoordsx[ 58]= 15; IRLcoordsy[ 58]= 10; IRLcoordsxIRL[ 58]=-6; IRLcoordsyIRL[ 58]= 38; IRLcoordszIRL[ 58]= 7
IRLcoordsx[ 59]= 15; IRLcoordsy[ 59]= 11; IRLcoordsxIRL[ 59]=-6; IRLcoordsyIRL[ 59]= 37; IRLcoordszIRL[ 59]= 7
IRLcoordsx[ 60]= 15; IRLcoordsy[ 60]= 12; IRLcoordsxIRL[ 60]=-6; IRLcoordsyIRL[ 60]= 36; IRLcoordszIRL[ 60]= 7
IRLcoordsx[ 61]= 15; IRLcoordsy[ 61]= 13; IRLcoordsxIRL[ 61]=-6; IRLcoordsyIRL[ 61]= 35; IRLcoordszIRL[ 61]= 7
IRLcoordsx[ 62]= 15; IRLcoordsy[ 62]= 14; IRLcoordsxIRL[ 62]=-6; IRLcoordsyIRL[ 62]= 34; IRLcoordszIRL[ 62]= 7
IRLcoordsx[ 63]= 15; IRLcoordsy[ 63]= 15; IRLcoordsxIRL[ 63]=-6; IRLcoordsyIRL[ 63]= 33; IRLcoordszIRL[ 63]= 7
IRLcoordsx[ 64]= 24; IRLcoordsy[ 64]= 8; IRLcoordsxIRL[ 64]=-6; IRLcoordsyIRL[ 64]= 40; IRLcoordszIRL[ 64]=-2
IRLcoordsx[ 65]= 24; IRLcoordsy[ 65]= 9; IRLcoordsxIRL[ 65]=-6; IRLcoordsyIRL[ 65]= 39; IRLcoordszIRL[ 65]=-2
IRLcoordsx[ 66]= 24; IRLcoordsy[ 66]= 10; IRLcoordsxIRL[ 66]=-6; IRLcoordsyIRL[ 66]= 38; IRLcoordszIRL[ 66]=-2
IRLcoordsx[ 67]= 24; IRLcoordsy[ 67]= 11; IRLcoordsxIRL[ 67]=-6; IRLcoordsyIRL[ 67]= 37; IRLcoordszIRL[ 67]=-2
IRLcoordsx[ 68]= 24; IRLcoordsy[ 68]= 12; IRLcoordsxIRL[ 68]=-6; IRLcoordsyIRL[ 68]= 36; IRLcoordszIRL[ 68]=-2
IRLcoordsx[ 69]= 24; IRLcoordsy[ 69]= 13; IRLcoordsxIRL[ 69]=-6; IRLcoordsyIRL[ 69]= 35; IRLcoordszIRL[ 69]=-2
IRLcoordsx[ 70]= 24; IRLcoordsy[ 70]= 14; IRLcoordsxIRL[ 70]=-6; IRLcoordsyIRL[ 70]= 34; IRLcoordszIRL[ 70]=-2
IRLcoordsx[ 71]= 24; IRLcoordsy[ 71]= 15; IRLcoordsxIRL[ 71]=-6; IRLcoordsyIRL[ 71]= 33; IRLcoordszIRL[ 71]=-2
IRLcoordsx[ 72]= 25; IRLcoordsy[ 72]= 8; IRLcoordsxIRL[ 72]=-7; IRLcoordsyIRL[ 72]= 40; IRLcoordszIRL[ 72]=-2
IRLcoordsx[ 73]= 25; IRLcoordsy[ 73]= 9; IRLcoordsxIRL[ 73]=-7; IRLcoordsyIRL[ 73]= 39; IRLcoordszIRL[ 73]=-2
IRLcoordsx[ 74]= 25; IRLcoordsy[ 74]= 10; IRLcoordsxIRL[ 74]=-7; IRLcoordsyIRL[ 74]= 38; IRLcoordszIRL[ 74]=-2
IRLcoordsx[ 75]= 25; IRLcoordsy[ 75]= 11; IRLcoordsxIRL[ 75]=-7; IRLcoordsyIRL[ 75]= 37; IRLcoordszIRL[ 75]=-2
IRLcoordsx[ 76]= 25; IRLcoordsy[ 76]= 12; IRLcoordsxIRL[ 76]=-7; IRLcoordsyIRL[ 76]= 36; IRLcoordszIRL[ 76]=-2
IRLcoordsx[ 77]= 25; IRLcoordsy[ 77]= 13; IRLcoordsxIRL[ 77]=-7; IRLcoordsyIRL[ 77]= 35; IRLcoordszIRL[ 77]=-2
IRLcoordsx[ 78]= 25; IRLcoordsy[ 78]= 14; IRLcoordsxIRL[ 78]=-7; IRLcoordsyIRL[ 78]= 34; IRLcoordszIRL[ 78]=-2
IRLcoordsx[ 79]= 25; IRLcoordsy[ 79]= 15; IRLcoordsxIRL[ 79]=-7; IRLcoordsyIRL[ 79]= 33; IRLcoordszIRL[ 79]=-2
IRLcoordsx[ 80]= 26; IRLcoordsy[ 80]= 8; IRLcoordsxIRL[ 80]=-8; IRLcoordsyIRL[ 80]= 40; IRLcoordszIRL[ 80]=-2
IRLcoordsx[ 81]= 26; IRLcoordsy[ 81]= 9; IRLcoordsxIRL[ 81]=-8; IRLcoordsyIRL[ 81]= 39; IRLcoordszIRL[ 81]=-2
IRLcoordsx[ 82]= 26; IRLcoordsy[ 82]= 10; IRLcoordsxIRL[ 82]=-8; IRLcoordsyIRL[ 82]= 38; IRLcoordszIRL[ 82]=-2
IRLcoordsx[ 83]= 26; IRLcoordsy[ 83]= 11; IRLcoordsxIRL[ 83]=-8; IRLcoordsyIRL[ 83]= 37; IRLcoordszIRL[ 83]=-2
IRLcoordsx[ 84]= 26; IRLcoordsy[ 84]= 12; IRLcoordsxIRL[ 84]=-8; IRLcoordsyIRL[ 84]= 36; IRLcoordszIRL[ 84]=-2
IRLcoordsx[ 85]= 26; IRLcoordsy[ 85]= 13; IRLcoordsxIRL[ 85]=-8; IRLcoordsyIRL[ 85]= 35; IRLcoordszIRL[ 85]=-2
IRLcoordsx[ 86]= 26; IRLcoordsy[ 86]= 14; IRLcoordsxIRL[ 86]=-8; IRLcoordsyIRL[ 86]= 34; IRLcoordszIRL[ 86]=-2
IRLcoordsx[ 87]= 26; IRLcoordsy[ 87]= 15; IRLcoordsxIRL[ 87]=-8; IRLcoordsyIRL[ 87]= 33; IRLcoordszIRL[ 87]=-2
IRLcoordsx[ 88]= 27; IRLcoordsy[ 88]= 8; IRLcoordsxIRL[ 88]=-9; IRLcoordsyIRL[ 88]= 40; IRLcoordszIRL[ 88]=-2
IRLcoordsx[ 89]= 27; IRLcoordsy[ 89]= 9; IRLcoordsxIRL[ 89]=-9; IRLcoordsyIRL[ 89]= 39; IRLcoordszIRL[ 89]=-2
IRLcoordsx[ 90]= 27; IRLcoordsy[ 90]= 10; IRLcoordsxIRL[ 90]=-9; IRLcoordsyIRL[ 90]= 38; IRLcoordszIRL[ 90]=-2
IRLcoordsx[ 91]= 27; IRLcoordsy[ 91]= 11; IRLcoordsxIRL[ 91]=-9; IRLcoordsyIRL[ 91]= 37; IRLcoordszIRL[ 91]=-2
IRLcoordsx[ 92]= 27; IRLcoordsy[ 92]= 12; IRLcoordsxIRL[ 92]=-9; IRLcoordsyIRL[ 92]= 36; IRLcoordszIRL[ 92]=-2
IRLcoordsx[ 93]= 27; IRLcoordsy[ 93]= 13; IRLcoordsxIRL[ 93]=-9; IRLcoordsyIRL[ 93]= 35; IRLcoordszIRL[ 93]=-2
IRLcoordsx[ 94]= 27; IRLcoordsy[ 94]= 14; IRLcoordsxIRL[ 94]=-9; IRLcoordsyIRL[ 94]= 34; IRLcoordszIRL[ 94]=-2
IRLcoordsx[ 95]= 27; IRLcoordsy[ 95]= 15; IRLcoordsxIRL[ 95]=-9; IRLcoordsyIRL[ 95]= 33; IRLcoordszIRL[ 95]=-2
IRLcoordsx[ 96]= 28; IRLcoordsy[ 96]= 8; IRLcoordsxIRL[ 96]=-10; IRLcoordsyIRL[ 96]= 40; IRLcoordszIRL[ 96]=-2
IRLcoordsx[ 97]= 28; IRLcoordsy[ 97]= 9; IRLcoordsxIRL[ 97]=-10; IRLcoordsyIRL[ 97]= 39; IRLcoordszIRL[ 97]=-2
IRLcoordsx[ 98]= 28; IRLcoordsy[ 98]= 10; IRLcoordsxIRL[ 98]=-10; IRLcoordsyIRL[ 98]= 38; IRLcoordszIRL[ 98]=-2
IRLcoordsx[ 99]= 28; IRLcoordsy[ 99]= 11; IRLcoordsxIRL[ 99]=-10; IRLcoordsyIRL[ 99]= 37; IRLcoordszIRL[ 99]=-2
IRLcoordsx[ 100]= 28; IRLcoordsy[ 100]= 12; IRLcoordsxIRL[ 100]=-10; IRLcoordsyIRL[ 100]= 36; IRLcoordszIRL[ 100]=-2
IRLcoordsx[ 101]= 28; IRLcoordsy[ 101]= 13; IRLcoordsxIRL[ 101]=-10; IRLcoordsyIRL[ 101]= 35; IRLcoordszIRL[ 101]=-2
IRLcoordsx[ 102]= 28; IRLcoordsy[ 102]= 14; IRLcoordsxIRL[ 102]=-10; IRLcoordsyIRL[ 102]= 34; IRLcoordszIRL[ 102]=-2
IRLcoordsx[ 103]= 28; IRLcoordsy[ 103]= 15; IRLcoordsxIRL[ 103]=-10; IRLcoordsyIRL[ 103]= 33; IRLcoordszIRL[ 103]=-2
IRLcoordsx[ 104]= 29; IRLcoordsy[ 104]= 8; IRLcoordsxIRL[ 104]=-11; IRLcoordsyIRL[ 104]= 40; IRLcoordszIRL[ 104]=-2
IRLcoordsx[ 105]= 29; IRLcoordsy[ 105]= 9; IRLcoordsxIRL[ 105]=-11; IRLcoordsyIRL[ 105]= 39; IRLcoordszIRL[ 105]=-2
IRLcoordsx[ 106]= 29; IRLcoordsy[ 106]= 10; IRLcoordsxIRL[ 106]=-11; IRLcoordsyIRL[ 106]= 38; IRLcoordszIRL[ 106]=-2
IRLcoordsx[ 107]= 29; IRLcoordsy[ 107]= 11; IRLcoordsxIRL[ 107]=-11; IRLcoordsyIRL[ 107]= 37; IRLcoordszIRL[ 107]=-2
IRLcoordsx[ 108]= 29; IRLcoordsy[ 108]= 12; IRLcoordsxIRL[ 108]=-11; IRLcoordsyIRL[ 108]= 36; IRLcoordszIRL[ 108]=-2
IRLcoordsx[ 109]= 29; IRLcoordsy[ 109]= 13; IRLcoordsxIRL[ 109]=-11; IRLcoordsyIRL[ 109]= 35; IRLcoordszIRL[ 109]=-2
IRLcoordsx[ 110]= 29; IRLcoordsy[ 110]= 14; IRLcoordsxIRL[ 110]=-11; IRLcoordsyIRL[ 110]= 34; IRLcoordszIRL[ 110]=-2
IRLcoordsx[ 111]= 29; IRLcoordsy[ 111]= 15; IRLcoordsxIRL[ 111]=-11; IRLcoordsyIRL[ 111]= 33; IRLcoordszIRL[ 111]=-2
IRLcoordsx[ 112]= 30; IRLcoordsy[ 112]= 8; IRLcoordsxIRL[ 112]=-12; IRLcoordsyIRL[ 112]= 40; IRLcoordszIRL[ 112]=-2
IRLcoordsx[ 113]= 30; IRLcoordsy[ 113]= 9; IRLcoordsxIRL[ 113]=-12; IRLcoordsyIRL[ 113]= 39; IRLcoordszIRL[ 113]=-2
IRLcoordsx[ 114]= 30; IRLcoordsy[ 114]= 10; IRLcoordsxIRL[ 114]=-12; IRLcoordsyIRL[ 114]= 38; IRLcoordszIRL[ 114]=-2
IRLcoordsx[ 115]= 30; IRLcoordsy[ 115]= 11; IRLcoordsxIRL[ 115]=-12; IRLcoordsyIRL[ 115]= 37; IRLcoordszIRL[ 115]=-2
IRLcoordsx[ 116]= 30; IRLcoordsy[ 116]= 12; IRLcoordsxIRL[ 116]=-12; IRLcoordsyIRL[ 116]= 36; IRLcoordszIRL[ 116]=-2
IRLcoordsx[ 117]= 30; IRLcoordsy[ 117]= 13; IRLcoordsxIRL[ 117]=-12; IRLcoordsyIRL[ 117]= 35; IRLcoordszIRL[ 117]=-2
IRLcoordsx[ 118]= 30; IRLcoordsy[ 118]= 14; IRLcoordsxIRL[ 118]=-12; IRLcoordsyIRL[ 118]= 34; IRLcoordszIRL[ 118]=-2
IRLcoordsx[ 119]= 30; IRLcoordsy[ 119]= 15; IRLcoordsxIRL[ 119]=-12; IRLcoordsyIRL[ 119]= 33; IRLcoordszIRL[ 119]=-2
IRLcoordsx[ 120]= 31; IRLcoordsy[ 120]= 8; IRLcoordsxIRL[ 120]=-13; IRLcoordsyIRL[ 120]= 40; IRLcoordszIRL[ 120]=-2
IRLcoordsx[ 121]= 31; IRLcoordsy[ 121]= 9; IRLcoordsxIRL[ 121]=-13; IRLcoordsyIRL[ 121]= 39; IRLcoordszIRL[ 121]=-2
IRLcoordsx[ 122]= 31; IRLcoordsy[ 122]= 10; IRLcoordsxIRL[ 122]=-13; IRLcoordsyIRL[ 122]= 38; IRLcoordszIRL[ 122]=-2
IRLcoordsx[ 123]= 31; IRLcoordsy[ 123]= 11; IRLcoordsxIRL[ 123]=-13; IRLcoordsyIRL[ 123]= 37; IRLcoordszIRL[ 123]=-2
IRLcoordsx[ 124]= 31; IRLcoordsy[ 124]= 12; IRLcoordsxIRL[ 124]=-13; IRLcoordsyIRL[ 124]= 36; IRLcoordszIRL[ 124]=-2
IRLcoordsx[ 125]= 31; IRLcoordsy[ 125]= 13; IRLcoordsxIRL[ 125]=-13; IRLcoordsyIRL[ 125]= 35; IRLcoordszIRL[ 125]=-2
IRLcoordsx[ 126]= 31; IRLcoordsy[ 126]= 14; IRLcoordsxIRL[ 126]=-13; IRLcoordsyIRL[ 126]= 34; IRLcoordszIRL[ 126]=-2
IRLcoordsx[ 127]= 31; IRLcoordsy[ 127]= 15; IRLcoordsxIRL[ 127]=-13; IRLcoordsyIRL[ 127]= 33; IRLcoordszIRL[ 127]=-2
IRLcoordsx[ 128]= 0; IRLcoordsy[ 128]= 8; IRLcoordsxIRL[ 128]=-14; IRLcoordsyIRL[ 128]= 40; IRLcoordszIRL[ 128]=-1
IRLcoordsx[ 129]= 0; IRLcoordsy[ 129]= 9; IRLcoordsxIRL[ 129]=-14; IRLcoordsyIRL[ 129]= 39; IRLcoordszIRL[ 129]=-1
IRLcoordsx[ 130]= 0; IRLcoordsy[ 130]= 10; IRLcoordsxIRL[ 130]=-14; IRLcoordsyIRL[ 130]= 38; IRLcoordszIRL[ 130]=-1
IRLcoordsx[ 131]= 0; IRLcoordsy[ 131]= 11; IRLcoordsxIRL[ 131]=-14; IRLcoordsyIRL[ 131]= 37; IRLcoordszIRL[ 131]=-1
IRLcoordsx[ 132]= 0; IRLcoordsy[ 132]= 12; IRLcoordsxIRL[ 132]=-14; IRLcoordsyIRL[ 132]= 36; IRLcoordszIRL[ 132]=-1
IRLcoordsx[ 133]= 0; IRLcoordsy[ 133]= 13; IRLcoordsxIRL[ 133]=-14; IRLcoordsyIRL[ 133]= 35; IRLcoordszIRL[ 133]=-1
IRLcoordsx[ 134]= 0; IRLcoordsy[ 134]= 14; IRLcoordsxIRL[ 134]=-14; IRLcoordsyIRL[ 134]= 34; IRLcoordszIRL[ 134]=-1
IRLcoordsx[ 135]= 0; IRLcoordsy[ 135]= 15; IRLcoordsxIRL[ 135]=-14; IRLcoordsyIRL[ 135]= 33; IRLcoordszIRL[ 135]=-1
IRLcoordsx[ 136]= 1; IRLcoordsy[ 136]= 8; IRLcoordsxIRL[ 136]=-14; IRLcoordsyIRL[ 136]= 40; IRLcoordszIRL[ 136]= 0
IRLcoordsx[ 137]= 1; IRLcoordsy[ 137]= 9; IRLcoordsxIRL[ 137]=-14; IRLcoordsyIRL[ 137]= 39; IRLcoordszIRL[ 137]= 0
IRLcoordsx[ 138]= 1; IRLcoordsy[ 138]= 10; IRLcoordsxIRL[ 138]=-14; IRLcoordsyIRL[ 138]= 38; IRLcoordszIRL[ 138]= 0
IRLcoordsx[ 139]= 1; IRLcoordsy[ 139]= 11; IRLcoordsxIRL[ 139]=-14; IRLcoordsyIRL[ 139]= 37; IRLcoordszIRL[ 139]= 0
IRLcoordsx[ 140]= 1; IRLcoordsy[ 140]= 12; IRLcoordsxIRL[ 140]=-14; IRLcoordsyIRL[ 140]= 36; IRLcoordszIRL[ 140]= 0
IRLcoordsx[ 141]= 1; IRLcoordsy[ 141]= 13; IRLcoordsxIRL[ 141]=-14; IRLcoordsyIRL[ 141]= 35; IRLcoordszIRL[ 141]= 0
IRLcoordsx[ 142]= 1; IRLcoordsy[ 142]= 14; IRLcoordsxIRL[ 142]=-14; IRLcoordsyIRL[ 142]= 34; IRLcoordszIRL[ 142]= 0
IRLcoordsx[ 143]= 1; IRLcoordsy[ 143]= 15; IRLcoordsxIRL[ 143]=-14; IRLcoordsyIRL[ 143]= 33; IRLcoordszIRL[ 143]= 0
IRLcoordsx[ 144]= 2; IRLcoordsy[ 144]= 8; IRLcoordsxIRL[ 144]=-14; IRLcoordsyIRL[ 144]= 40; IRLcoordszIRL[ 144]= 1
IRLcoordsx[ 145]= 2; IRLcoordsy[ 145]= 9; IRLcoordsxIRL[ 145]=-14; IRLcoordsyIRL[ 145]= 39; IRLcoordszIRL[ 145]= 1
IRLcoordsx[ 146]= 2; IRLcoordsy[ 146]= 10; IRLcoordsxIRL[ 146]=-14; IRLcoordsyIRL[ 146]= 38; IRLcoordszIRL[ 146]= 1
IRLcoordsx[ 147]= 2; IRLcoordsy[ 147]= 11; IRLcoordsxIRL[ 147]=-14; IRLcoordsyIRL[ 147]= 37; IRLcoordszIRL[ 147]= 1
IRLcoordsx[ 148]= 2; IRLcoordsy[ 148]= 12; IRLcoordsxIRL[ 148]=-14; IRLcoordsyIRL[ 148]= 36; IRLcoordszIRL[ 148]= 1
IRLcoordsx[ 149]= 2; IRLcoordsy[ 149]= 13; IRLcoordsxIRL[ 149]=-14; IRLcoordsyIRL[ 149]= 35; IRLcoordszIRL[ 149]= 1
IRLcoordsx[ 150]= 2; IRLcoordsy[ 150]= 14; IRLcoordsxIRL[ 150]=-14; IRLcoordsyIRL[ 150]= 34; IRLcoordszIRL[ 150]= 1
IRLcoordsx[ 151]= 2; IRLcoordsy[ 151]= 15; IRLcoordsxIRL[ 151]=-14; IRLcoordsyIRL[ 151]= 33; IRLcoordszIRL[ 151]= 1
IRLcoordsx[ 152]= 3; IRLcoordsy[ 152]= 8; IRLcoordsxIRL[ 152]=-14; IRLcoordsyIRL[ 152]= 40; IRLcoordszIRL[ 152]= 2
IRLcoordsx[ 153]= 3; IRLcoordsy[ 153]= 9; IRLcoordsxIRL[ 153]=-14; IRLcoordsyIRL[ 153]= 39; IRLcoordszIRL[ 153]= 2
IRLcoordsx[ 154]= 3; IRLcoordsy[ 154]= 10; IRLcoordsxIRL[ 154]=-14; IRLcoordsyIRL[ 154]= 38; IRLcoordszIRL[ 154]= 2
IRLcoordsx[ 155]= 3; IRLcoordsy[ 155]= 11; IRLcoordsxIRL[ 155]=-14; IRLcoordsyIRL[ 155]= 37; IRLcoordszIRL[ 155]= 2
IRLcoordsx[ 156]= 3; IRLcoordsy[ 156]= 12; IRLcoordsxIRL[ 156]=-14; IRLcoordsyIRL[ 156]= 36; IRLcoordszIRL[ 156]= 2
IRLcoordsx[ 157]= 3; IRLcoordsy[ 157]= 13; IRLcoordsxIRL[ 157]=-14; IRLcoordsyIRL[ 157]= 35; IRLcoordszIRL[ 157]= 2
IRLcoordsx[ 158]= 3; IRLcoordsy[ 158]= 14; IRLcoordsxIRL[ 158]=-14; IRLcoordsyIRL[ 158]= 34; IRLcoordszIRL[ 158]= 2
IRLcoordsx[ 159]= 3; IRLcoordsy[ 159]= 15; IRLcoordsxIRL[ 159]=-14; IRLcoordsyIRL[ 159]= 33; IRLcoordszIRL[ 159]= 2
IRLcoordsx[ 160]= 4; IRLcoordsy[ 160]= 8; IRLcoordsxIRL[ 160]=-14; IRLcoordsyIRL[ 160]= 40; IRLcoordszIRL[ 160]= 3
IRLcoordsx[ 161]= 4; IRLcoordsy[ 161]= 9; IRLcoordsxIRL[ 161]=-14; IRLcoordsyIRL[ 161]= 39; IRLcoordszIRL[ 161]= 3
IRLcoordsx[ 162]= 4; IRLcoordsy[ 162]= 10; IRLcoordsxIRL[ 162]=-14; IRLcoordsyIRL[ 162]= 38; IRLcoordszIRL[ 162]= 3
IRLcoordsx[ 163]= 4; IRLcoordsy[ 163]= 11; IRLcoordsxIRL[ 163]=-14; IRLcoordsyIRL[ 163]= 37; IRLcoordszIRL[ 163]= 3
IRLcoordsx[ 164]= 4; IRLcoordsy[ 164]= 12; IRLcoordsxIRL[ 164]=-14; IRLcoordsyIRL[ 164]= 36; IRLcoordszIRL[ 164]= 3
IRLcoordsx[ 165]= 4; IRLcoordsy[ 165]= 13; IRLcoordsxIRL[ 165]=-14; IRLcoordsyIRL[ 165]= 35; IRLcoordszIRL[ 165]= 3
IRLcoordsx[ 166]= 4; IRLcoordsy[ 166]= 14; IRLcoordsxIRL[ 166]=-14; IRLcoordsyIRL[ 166]= 34; IRLcoordszIRL[ 166]= 3
IRLcoordsx[ 167]= 4; IRLcoordsy[ 167]= 15; IRLcoordsxIRL[ 167]=-14; IRLcoordsyIRL[ 167]= 33; IRLcoordszIRL[ 167]= 3
IRLcoordsx[ 168]= 5; IRLcoordsy[ 168]= 8; IRLcoordsxIRL[ 168]=-14; IRLcoordsyIRL[ 168]= 40; IRLcoordszIRL[ 168]= 4
IRLcoordsx[ 169]= 5; IRLcoordsy[ 169]= 9; IRLcoordsxIRL[ 169]=-14; IRLcoordsyIRL[ 169]= 39; IRLcoordszIRL[ 169]= 4
IRLcoordsx[ 170]= 5; IRLcoordsy[ 170]= 10; IRLcoordsxIRL[ 170]=-14; IRLcoordsyIRL[ 170]= 38; IRLcoordszIRL[ 170]= 4
IRLcoordsx[ 171]= 5; IRLcoordsy[ 171]= 11; IRLcoordsxIRL[ 171]=-14; IRLcoordsyIRL[ 171]= 37; IRLcoordszIRL[ 171]= 4
IRLcoordsx[ 172]= 5; IRLcoordsy[ 172]= 12; IRLcoordsxIRL[ 172]=-14; IRLcoordsyIRL[ 172]= 36; IRLcoordszIRL[ 172]= 4
IRLcoordsx[ 173]= 5; IRLcoordsy[ 173]= 13; IRLcoordsxIRL[ 173]=-14; IRLcoordsyIRL[ 173]= 35; IRLcoordszIRL[ 173]= 4
IRLcoordsx[ 174]= 5; IRLcoordsy[ 174]= 14; IRLcoordsxIRL[ 174]=-14; IRLcoordsyIRL[ 174]= 34; IRLcoordszIRL[ 174]= 4
IRLcoordsx[ 175]= 5; IRLcoordsy[ 175]= 15; IRLcoordsxIRL[ 175]=-14; IRLcoordsyIRL[ 175]= 33; IRLcoordszIRL[ 175]= 4
IRLcoordsx[ 176]= 6; IRLcoordsy[ 176]= 8; IRLcoordsxIRL[ 176]=-14; IRLcoordsyIRL[ 176]= 40; IRLcoordszIRL[ 176]= 5
IRLcoordsx[ 177]= 6; IRLcoordsy[ 177]= 9; IRLcoordsxIRL[ 177]=-14; IRLcoordsyIRL[ 177]= 39; IRLcoordszIRL[ 177]= 5
IRLcoordsx[ 178]= 6; IRLcoordsy[ 178]= 10; IRLcoordsxIRL[ 178]=-14; IRLcoordsyIRL[ 178]= 38; IRLcoordszIRL[ 178]= 5
IRLcoordsx[ 179]= 6; IRLcoordsy[ 179]= 11; IRLcoordsxIRL[ 179]=-14; IRLcoordsyIRL[ 179]= 37; IRLcoordszIRL[ 179]= 5
IRLcoordsx[ 180]= 6; IRLcoordsy[ 180]= 12; IRLcoordsxIRL[ 180]=-14; IRLcoordsyIRL[ 180]= 36; IRLcoordszIRL[ 180]= 5
IRLcoordsx[ 181]= 6; IRLcoordsy[ 181]= 13; IRLcoordsxIRL[ 181]=-14; IRLcoordsyIRL[ 181]= 35; IRLcoordszIRL[ 181]= 5
IRLcoordsx[ 182]= 6; IRLcoordsy[ 182]= 14; IRLcoordsxIRL[ 182]=-14; IRLcoordsyIRL[ 182]= 34; IRLcoordszIRL[ 182]= 5
IRLcoordsx[ 183]= 6; IRLcoordsy[ 183]= 15; IRLcoordsxIRL[ 183]=-14; IRLcoordsyIRL[ 183]= 33; IRLcoordszIRL[ 183]= 5
IRLcoordsx[ 184]= 7; IRLcoordsy[ 184]= 8; IRLcoordsxIRL[ 184]=-14; IRLcoordsyIRL[ 184]= 40; IRLcoordszIRL[ 184]= 6
IRLcoordsx[ 185]= 7; IRLcoordsy[ 185]= 9; IRLcoordsxIRL[ 185]=-14; IRLcoordsyIRL[ 185]= 39; IRLcoordszIRL[ 185]= 6
IRLcoordsx[ 186]= 7; IRLcoordsy[ 186]= 10; IRLcoordsxIRL[ 186]=-14; IRLcoordsyIRL[ 186]= 38; IRLcoordszIRL[ 186]= 6
IRLcoordsx[ 187]= 7; IRLcoordsy[ 187]= 11; IRLcoordsxIRL[ 187]=-14; IRLcoordsyIRL[ 187]= 37; IRLcoordszIRL[ 187]= 6
IRLcoordsx[ 188]= 7; IRLcoordsy[ 188]= 12; IRLcoordsxIRL[ 188]=-14; IRLcoordsyIRL[ 188]= 36; IRLcoordszIRL[ 188]= 6
IRLcoordsx[ 189]= 7; IRLcoordsy[ 189]= 13; IRLcoordsxIRL[ 189]=-14; IRLcoordsyIRL[ 189]= 35; IRLcoordszIRL[ 189]= 6
IRLcoordsx[ 190]= 7; IRLcoordsy[ 190]= 14; IRLcoordsxIRL[ 190]=-14; IRLcoordsyIRL[ 190]= 34; IRLcoordszIRL[ 190]= 6
IRLcoordsx[ 191]= 7; IRLcoordsy[ 191]= 15; IRLcoordsxIRL[ 191]=-14; IRLcoordsyIRL[ 191]= 33; IRLcoordszIRL[ 191]= 6
IRLcoordsx[ 192]= 16; IRLcoordsy[ 192]= 8; IRLcoordsxIRL[ 192]=-5; IRLcoordsyIRL[ 192]= 40; IRLcoordszIRL[ 192]= 6
IRLcoordsx[ 193]= 16; IRLcoordsy[ 193]= 9; IRLcoordsxIRL[ 193]=-5; IRLcoordsyIRL[ 193]= 39; IRLcoordszIRL[ 193]= 6
IRLcoordsx[ 194]= 16; IRLcoordsy[ 194]= 10; IRLcoordsxIRL[ 194]=-5; IRLcoordsyIRL[ 194]= 38; IRLcoordszIRL[ 194]= 6
IRLcoordsx[ 195]= 16; IRLcoordsy[ 195]= 11; IRLcoordsxIRL[ 195]=-5; IRLcoordsyIRL[ 195]= 37; IRLcoordszIRL[ 195]= 6
IRLcoordsx[ 196]= 16; IRLcoordsy[ 196]= 12; IRLcoordsxIRL[ 196]=-5; IRLcoordsyIRL[ 196]= 36; IRLcoordszIRL[ 196]= 6
IRLcoordsx[ 197]= 16; IRLcoordsy[ 197]= 13; IRLcoordsxIRL[ 197]=-5; IRLcoordsyIRL[ 197]= 35; IRLcoordszIRL[ 197]= 6
IRLcoordsx[ 198]= 16; IRLcoordsy[ 198]= 14; IRLcoordsxIRL[ 198]=-5; IRLcoordsyIRL[ 198]= 34; IRLcoordszIRL[ 198]= 6
IRLcoordsx[ 199]= 16; IRLcoordsy[ 199]= 15; IRLcoordsxIRL[ 199]=-5; IRLcoordsyIRL[ 199]= 33; IRLcoordszIRL[ 199]= 6
IRLcoordsx[ 200]= 17; IRLcoordsy[ 200]= 8; IRLcoordsxIRL[ 200]=-5; IRLcoordsyIRL[ 200]= 40; IRLcoordszIRL[ 200]= 5
IRLcoordsx[ 201]= 17; IRLcoordsy[ 201]= 9; IRLcoordsxIRL[ 201]=-5; IRLcoordsyIRL[ 201]= 39; IRLcoordszIRL[ 201]= 5
IRLcoordsx[ 202]= 17; IRLcoordsy[ 202]= 10; IRLcoordsxIRL[ 202]=-5; IRLcoordsyIRL[ 202]= 38; IRLcoordszIRL[ 202]= 5
IRLcoordsx[ 203]= 17; IRLcoordsy[ 203]= 11; IRLcoordsxIRL[ 203]=-5; IRLcoordsyIRL[ 203]= 37; IRLcoordszIRL[ 203]= 5
IRLcoordsx[ 204]= 17; IRLcoordsy[ 204]= 12; IRLcoordsxIRL[ 204]=-5; IRLcoordsyIRL[ 204]= 36; IRLcoordszIRL[ 204]= 5
IRLcoordsx[ 205]= 17; IRLcoordsy[ 205]= 13; IRLcoordsxIRL[ 205]=-5; IRLcoordsyIRL[ 205]= 35; IRLcoordszIRL[ 205]= 5
IRLcoordsx[ 206]= 17; IRLcoordsy[ 206]= 14; IRLcoordsxIRL[ 206]=-5; IRLcoordsyIRL[ 206]= 34; IRLcoordszIRL[ 206]= 5
IRLcoordsx[ 207]= 17; IRLcoordsy[ 207]= 15; IRLcoordsxIRL[ 207]=-5; IRLcoordsyIRL[ 207]= 33; IRLcoordszIRL[ 207]= 5
IRLcoordsx[ 208]= 18; IRLcoordsy[ 208]= 8; IRLcoordsxIRL[ 208]=-5; IRLcoordsyIRL[ 208]= 40; IRLcoordszIRL[ 208]= 4
IRLcoordsx[ 209]= 18; IRLcoordsy[ 209]= 9; IRLcoordsxIRL[ 209]=-5; IRLcoordsyIRL[ 209]= 39; IRLcoordszIRL[ 209]= 4
IRLcoordsx[ 210]= 18; IRLcoordsy[ 210]= 10; IRLcoordsxIRL[ 210]=-5; IRLcoordsyIRL[ 210]= 38; IRLcoordszIRL[ 210]= 4
IRLcoordsx[ 211]= 18; IRLcoordsy[ 211]= 11; IRLcoordsxIRL[ 211]=-5; IRLcoordsyIRL[ 211]= 37; IRLcoordszIRL[ 211]= 4
IRLcoordsx[ 212]= 18; IRLcoordsy[ 212]= 12; IRLcoordsxIRL[ 212]=-5; IRLcoordsyIRL[ 212]= 36; IRLcoordszIRL[ 212]= 4
IRLcoordsx[ 213]= 18; IRLcoordsy[ 213]= 13; IRLcoordsxIRL[ 213]=-5; IRLcoordsyIRL[ 213]= 35; IRLcoordszIRL[ 213]= 4
IRLcoordsx[ 214]= 18; IRLcoordsy[ 214]= 14; IRLcoordsxIRL[ 214]=-5; IRLcoordsyIRL[ 214]= 34; IRLcoordszIRL[ 214]= 4
IRLcoordsx[ 215]= 18; IRLcoordsy[ 215]= 15; IRLcoordsxIRL[ 215]=-5; IRLcoordsyIRL[ 215]= 33; IRLcoordszIRL[ 215]= 4
IRLcoordsx[ 216]= 19; IRLcoordsy[ 216]= 8; IRLcoordsxIRL[ 216]=-5; IRLcoordsyIRL[ 216]= 40; IRLcoordszIRL[ 216]= 3
IRLcoordsx[ 217]= 19; IRLcoordsy[ 217]= 9; IRLcoordsxIRL[ 217]=-5; IRLcoordsyIRL[ 217]= 39; IRLcoordszIRL[ 217]= 3
IRLcoordsx[ 218]= 19; IRLcoordsy[ 218]= 10; IRLcoordsxIRL[ 218]=-5; IRLcoordsyIRL[ 218]= 38; IRLcoordszIRL[ 218]= 3
IRLcoordsx[ 219]= 19; IRLcoordsy[ 219]= 11; IRLcoordsxIRL[ 219]=-5; IRLcoordsyIRL[ 219]= 37; IRLcoordszIRL[ 219]= 3
IRLcoordsx[ 220]= 19; IRLcoordsy[ 220]= 12; IRLcoordsxIRL[ 220]=-5; IRLcoordsyIRL[ 220]= 36; IRLcoordszIRL[ 220]= 3
IRLcoordsx[ 221]= 19; IRLcoordsy[ 221]= 13; IRLcoordsxIRL[ 221]=-5; IRLcoordsyIRL[ 221]= 35; IRLcoordszIRL[ 221]= 3
IRLcoordsx[ 222]= 19; IRLcoordsy[ 222]= 14; IRLcoordsxIRL[ 222]=-5; IRLcoordsyIRL[ 222]= 34; IRLcoordszIRL[ 222]= 3
IRLcoordsx[ 223]= 19; IRLcoordsy[ 223]= 15; IRLcoordsxIRL[ 223]=-5; IRLcoordsyIRL[ 223]= 33; IRLcoordszIRL[ 223]= 3
IRLcoordsx[ 224]= 20; IRLcoordsy[ 224]= 8; IRLcoordsxIRL[ 224]=-5; IRLcoordsyIRL[ 224]= 40; IRLcoordszIRL[ 224]= 2
IRLcoordsx[ 225]= 20; IRLcoordsy[ 225]= 9; IRLcoordsxIRL[ 225]=-5; IRLcoordsyIRL[ 225]= 39; IRLcoordszIRL[ 225]= 2
IRLcoordsx[ 226]= 20; IRLcoordsy[ 226]= 10; IRLcoordsxIRL[ 226]=-5; IRLcoordsyIRL[ 226]= 38; IRLcoordszIRL[ 226]= 2
IRLcoordsx[ 227]= 20; IRLcoordsy[ 227]= 11; IRLcoordsxIRL[ 227]=-5; IRLcoordsyIRL[ 227]= 37; IRLcoordszIRL[ 227]= 2
IRLcoordsx[ 228]= 20; IRLcoordsy[ 228]= 12; IRLcoordsxIRL[ 228]=-5; IRLcoordsyIRL[ 228]= 36; IRLcoordszIRL[ 228]= 2
IRLcoordsx[ 229]= 20; IRLcoordsy[ 229]= 13; IRLcoordsxIRL[ 229]=-5; IRLcoordsyIRL[ 229]= 35; IRLcoordszIRL[ 229]= 2
IRLcoordsx[ 230]= 20; IRLcoordsy[ 230]= 14; IRLcoordsxIRL[ 230]=-5; IRLcoordsyIRL[ 230]= 34; IRLcoordszIRL[ 230]= 2
IRLcoordsx[ 231]= 20; IRLcoordsy[ 231]= 15; IRLcoordsxIRL[ 231]=-5; IRLcoordsyIRL[ 231]= 33; IRLcoordszIRL[ 231]= 2
IRLcoordsx[ 232]= 21; IRLcoordsy[ 232]= 8; IRLcoordsxIRL[ 232]=-5; IRLcoordsyIRL[ 232]= 40; IRLcoordszIRL[ 232]= 1
IRLcoordsx[ 233]= 21; IRLcoordsy[ 233]= 9; IRLcoordsxIRL[ 233]=-5; IRLcoordsyIRL[ 233]= 39; IRLcoordszIRL[ 233]= 1
IRLcoordsx[ 234]= 21; IRLcoordsy[ 234]= 10; IRLcoordsxIRL[ 234]=-5; IRLcoordsyIRL[ 234]= 38; IRLcoordszIRL[ 234]= 1
IRLcoordsx[ 235]= 21; IRLcoordsy[ 235]= 11; IRLcoordsxIRL[ 235]=-5; IRLcoordsyIRL[ 235]= 37; IRLcoordszIRL[ 235]= 1
IRLcoordsx[ 236]= 21; IRLcoordsy[ 236]= 12; IRLcoordsxIRL[ 236]=-5; IRLcoordsyIRL[ 236]= 36; IRLcoordszIRL[ 236]= 1
IRLcoordsx[ 237]= 21; IRLcoordsy[ 237]= 13; IRLcoordsxIRL[ 237]=-5; IRLcoordsyIRL[ 237]= 35; IRLcoordszIRL[ 237]= 1
IRLcoordsx[ 238]= 21; IRLcoordsy[ 238]= 14; IRLcoordsxIRL[ 238]=-5; IRLcoordsyIRL[ 238]= 34; IRLcoordszIRL[ 238]= 1
IRLcoordsx[ 239]= 21; IRLcoordsy[ 239]= 15; IRLcoordsxIRL[ 239]=-5; IRLcoordsyIRL[ 239]= 33; IRLcoordszIRL[ 239]= 1
IRLcoordsx[ 240]= 22; IRLcoordsy[ 240]= 8; IRLcoordsxIRL[ 240]=-5; IRLcoordsyIRL[ 240]= 40; IRLcoordszIRL[ 240]= 0
IRLcoordsx[ 241]= 22; IRLcoordsy[ 241]= 9; IRLcoordsxIRL[ 241]=-5; IRLcoordsyIRL[ 241]= 39; IRLcoordszIRL[ 241]= 0
IRLcoordsx[ 242]= 22; IRLcoordsy[ 242]= 10; IRLcoordsxIRL[ 242]=-5; IRLcoordsyIRL[ 242]= 38; IRLcoordszIRL[ 242]= 0
IRLcoordsx[ 243]= 22; IRLcoordsy[ 243]= 11; IRLcoordsxIRL[ 243]=-5; IRLcoordsyIRL[ 243]= 37; IRLcoordszIRL[ 243]= 0
IRLcoordsx[ 244]= 22; IRLcoordsy[ 244]= 12; IRLcoordsxIRL[ 244]=-5; IRLcoordsyIRL[ 244]= 36; IRLcoordszIRL[ 244]= 0
IRLcoordsx[ 245]= 22; IRLcoordsy[ 245]= 13; IRLcoordsxIRL[ 245]=-5; IRLcoordsyIRL[ 245]= 35; IRLcoordszIRL[ 245]= 0
IRLcoordsx[ 246]= 22; IRLcoordsy[ 246]= 14; IRLcoordsxIRL[ 246]=-5; IRLcoordsyIRL[ 246]= 34; IRLcoordszIRL[ 246]= 0
IRLcoordsx[ 247]= 22; IRLcoordsy[ 247]= 15; IRLcoordsxIRL[ 247]=-5; IRLcoordsyIRL[ 247]= 33; IRLcoordszIRL[ 247]= 0
IRLcoordsx[ 248]= 23; IRLcoordsy[ 248]= 8; IRLcoordsxIRL[ 248]=-5; IRLcoordsyIRL[ 248]= 40; IRLcoordszIRL[ 248]=-1
IRLcoordsx[ 249]= 23; IRLcoordsy[ 249]= 9; IRLcoordsxIRL[ 249]=-5; IRLcoordsyIRL[ 249]= 39; IRLcoordszIRL[ 249]=-1
IRLcoordsx[ 250]= 23; IRLcoordsy[ 250]= 10; IRLcoordsxIRL[ 250]=-5; IRLcoordsyIRL[ 250]= 38; IRLcoordszIRL[ 250]=-1
IRLcoordsx[ 251]= 23; IRLcoordsy[ 251]= 11; IRLcoordsxIRL[ 251]=-5; IRLcoordsyIRL[ 251]= 37; IRLcoordszIRL[ 251]=-1
IRLcoordsx[ 252]= 23; IRLcoordsy[ 252]= 12; IRLcoordsxIRL[ 252]=-5; IRLcoordsyIRL[ 252]= 36; IRLcoordszIRL[ 252]=-1
IRLcoordsx[ 253]= 23; IRLcoordsy[ 253]= 13; IRLcoordsxIRL[ 253]=-5; IRLcoordsyIRL[ 253]= 35; IRLcoordszIRL[ 253]=-1
IRLcoordsx[ 254]= 23; IRLcoordsy[ 254]= 14; IRLcoordsxIRL[ 254]=-5; IRLcoordsyIRL[ 254]= 34; IRLcoordszIRL[ 254]=-1
IRLcoordsx[ 255]= 23; IRLcoordsy[ 255]= 15; IRLcoordsxIRL[ 255]=-5; IRLcoordsyIRL[ 255]= 33; IRLcoordszIRL[ 255]=-1
IRLcoordsx[ 256]= 8; IRLcoordsy[ 256]= 0; IRLcoordsxIRL[ 256]=-13; IRLcoordsyIRL[ 256]= 41; IRLcoordszIRL[ 256]=-1
IRLcoordsx[ 257]= 8; IRLcoordsy[ 257]= 1; IRLcoordsxIRL[ 257]=-13; IRLcoordsyIRL[ 257]= 41; IRLcoordszIRL[ 257]= 0
IRLcoordsx[ 258]= 8; IRLcoordsy[ 258]= 2; IRLcoordsxIRL[ 258]=-13; IRLcoordsyIRL[ 258]= 41; IRLcoordszIRL[ 258]= 1
IRLcoordsx[ 259]= 8; IRLcoordsy[ 259]= 3; IRLcoordsxIRL[ 259]=-13; IRLcoordsyIRL[ 259]= 41; IRLcoordszIRL[ 259]= 2
IRLcoordsx[ 260]= 8; IRLcoordsy[ 260]= 4; IRLcoordsxIRL[ 260]=-13; IRLcoordsyIRL[ 260]= 41; IRLcoordszIRL[ 260]= 3
IRLcoordsx[ 261]= 8; IRLcoordsy[ 261]= 5; IRLcoordsxIRL[ 261]=-13; IRLcoordsyIRL[ 261]= 41; IRLcoordszIRL[ 261]= 4
IRLcoordsx[ 262]= 8; IRLcoordsy[ 262]= 6; IRLcoordsxIRL[ 262]=-13; IRLcoordsyIRL[ 262]= 41; IRLcoordszIRL[ 262]= 5
IRLcoordsx[ 263]= 8; IRLcoordsy[ 263]= 7; IRLcoordsxIRL[ 263]=-13; IRLcoordsyIRL[ 263]= 41; IRLcoordszIRL[ 263]= 6
IRLcoordsx[ 264]= 9; IRLcoordsy[ 264]= 0; IRLcoordsxIRL[ 264]=-12; IRLcoordsyIRL[ 264]= 41; IRLcoordszIRL[ 264]=-1
IRLcoordsx[ 265]= 9; IRLcoordsy[ 265]= 1; IRLcoordsxIRL[ 265]=-12; IRLcoordsyIRL[ 265]= 41; IRLcoordszIRL[ 265]= 0
IRLcoordsx[ 266]= 9; IRLcoordsy[ 266]= 2; IRLcoordsxIRL[ 266]=-12; IRLcoordsyIRL[ 266]= 41; IRLcoordszIRL[ 266]= 1
IRLcoordsx[ 267]= 9; IRLcoordsy[ 267]= 3; IRLcoordsxIRL[ 267]=-12; IRLcoordsyIRL[ 267]= 41; IRLcoordszIRL[ 267]= 2
IRLcoordsx[ 268]= 9; IRLcoordsy[ 268]= 4; IRLcoordsxIRL[ 268]=-12; IRLcoordsyIRL[ 268]= 41; IRLcoordszIRL[ 268]= 3
IRLcoordsx[ 269]= 9; IRLcoordsy[ 269]= 5; IRLcoordsxIRL[ 269]=-12; IRLcoordsyIRL[ 269]= 41; IRLcoordszIRL[ 269]= 4
IRLcoordsx[ 270]= 9; IRLcoordsy[ 270]= 6; IRLcoordsxIRL[ 270]=-12; IRLcoordsyIRL[ 270]= 41; IRLcoordszIRL[ 270]= 5
IRLcoordsx[ 271]= 9; IRLcoordsy[ 271]= 7; IRLcoordsxIRL[ 271]=-12; IRLcoordsyIRL[ 271]= 41; IRLcoordszIRL[ 271]= 6
IRLcoordsx[ 272]= 10; IRLcoordsy[ 272]= 0; IRLcoordsxIRL[ 272]=-11; IRLcoordsyIRL[ 272]= 41; IRLcoordszIRL[ 272]=-1
IRLcoordsx[ 273]= 10; IRLcoordsy[ 273]= 1; IRLcoordsxIRL[ 273]=-11; IRLcoordsyIRL[ 273]= 41; IRLcoordszIRL[ 273]= 0
IRLcoordsx[ 274]= 10; IRLcoordsy[ 274]= 2; IRLcoordsxIRL[ 274]=-11; IRLcoordsyIRL[ 274]= 41; IRLcoordszIRL[ 274]= 1
IRLcoordsx[ 275]= 10; IRLcoordsy[ 275]= 3; IRLcoordsxIRL[ 275]=-11; IRLcoordsyIRL[ 275]= 41; IRLcoordszIRL[ 275]= 2
IRLcoordsx[ 276]= 10; IRLcoordsy[ 276]= 4; IRLcoordsxIRL[ 276]=-11; IRLcoordsyIRL[ 276]= 41; IRLcoordszIRL[ 276]= 3
IRLcoordsx[ 277]= 10; IRLcoordsy[ 277]= 5; IRLcoordsxIRL[ 277]=-11; IRLcoordsyIRL[ 277]= 41; IRLcoordszIRL[ 277]= 4
IRLcoordsx[ 278]= 10; IRLcoordsy[ 278]= 6; IRLcoordsxIRL[ 278]=-11; IRLcoordsyIRL[ 278]= 41; IRLcoordszIRL[ 278]= 5
IRLcoordsx[ 279]= 10; IRLcoordsy[ 279]= 7; IRLcoordsxIRL[ 279]=-11; IRLcoordsyIRL[ 279]= 41; IRLcoordszIRL[ 279]= 6
IRLcoordsx[ 280]= 11; IRLcoordsy[ 280]= 0; IRLcoordsxIRL[ 280]=-10; IRLcoordsyIRL[ 280]= 41; IRLcoordszIRL[ 280]=-1
IRLcoordsx[ 281]= 11; IRLcoordsy[ 281]= 1; IRLcoordsxIRL[ 281]=-10; IRLcoordsyIRL[ 281]= 41; IRLcoordszIRL[ 281]= 0
IRLcoordsx[ 282]= 11; IRLcoordsy[ 282]= 2; IRLcoordsxIRL[ 282]=-10; IRLcoordsyIRL[ 282]= 41; IRLcoordszIRL[ 282]= 1
IRLcoordsx[ 283]= 11; IRLcoordsy[ 283]= 3; IRLcoordsxIRL[ 283]=-10; IRLcoordsyIRL[ 283]= 41; IRLcoordszIRL[ 283]= 2
IRLcoordsx[ 284]= 11; IRLcoordsy[ 284]= 4; IRLcoordsxIRL[ 284]=-10; IRLcoordsyIRL[ 284]= 41; IRLcoordszIRL[ 284]= 3
IRLcoordsx[ 285]= 11; IRLcoordsy[ 285]= 5; IRLcoordsxIRL[ 285]=-10; IRLcoordsyIRL[ 285]= 41; IRLcoordszIRL[ 285]= 4
IRLcoordsx[ 286]= 11; IRLcoordsy[ 286]= 6; IRLcoordsxIRL[ 286]=-10; IRLcoordsyIRL[ 286]= 41; IRLcoordszIRL[ 286]= 5
IRLcoordsx[ 287]= 11; IRLcoordsy[ 287]= 7; IRLcoordsxIRL[ 287]=-10; IRLcoordsyIRL[ 287]= 41; IRLcoordszIRL[ 287]= 6
IRLcoordsx[ 288]= 12; IRLcoordsy[ 288]= 0; IRLcoordsxIRL[ 288]=-9; IRLcoordsyIRL[ 288]= 41; IRLcoordszIRL[ 288]=-1
IRLcoordsx[ 289]= 12; IRLcoordsy[ 289]= 1; IRLcoordsxIRL[ 289]=-9; IRLcoordsyIRL[ 289]= 41; IRLcoordszIRL[ 289]= 0
IRLcoordsx[ 290]= 12; IRLcoordsy[ 290]= 2; IRLcoordsxIRL[ 290]=-9; IRLcoordsyIRL[ 290]= 41; IRLcoordszIRL[ 290]= 1
IRLcoordsx[ 291]= 12; IRLcoordsy[ 291]= 3; IRLcoordsxIRL[ 291]=-9; IRLcoordsyIRL[ 291]= 41; IRLcoordszIRL[ 291]= 2
IRLcoordsx[ 292]= 12; IRLcoordsy[ 292]= 4; IRLcoordsxIRL[ 292]=-9; IRLcoordsyIRL[ 292]= 41; IRLcoordszIRL[ 292]= 3
IRLcoordsx[ 293]= 12; IRLcoordsy[ 293]= 5; IRLcoordsxIRL[ 293]=-9; IRLcoordsyIRL[ 293]= 41; IRLcoordszIRL[ 293]= 4
IRLcoordsx[ 294]= 12; IRLcoordsy[ 294]= 6; IRLcoordsxIRL[ 294]=-9; IRLcoordsyIRL[ 294]= 41; IRLcoordszIRL[ 294]= 5
IRLcoordsx[ 295]= 12; IRLcoordsy[ 295]= 7; IRLcoordsxIRL[ 295]=-9; IRLcoordsyIRL[ 295]= 41; IRLcoordszIRL[ 295]= 6
IRLcoordsx[ 296]= 13; IRLcoordsy[ 296]= 0; IRLcoordsxIRL[ 296]=-8; IRLcoordsyIRL[ 296]= 41; IRLcoordszIRL[ 296]=-1
IRLcoordsx[ 297]= 13; IRLcoordsy[ 297]= 1; IRLcoordsxIRL[ 297]=-8; IRLcoordsyIRL[ 297]= 41; IRLcoordszIRL[ 297]= 0
IRLcoordsx[ 298]= 13; IRLcoordsy[ 298]= 2; IRLcoordsxIRL[ 298]=-8; IRLcoordsyIRL[ 298]= 41; IRLcoordszIRL[ 298]= 1
IRLcoordsx[ 299]= 13; IRLcoordsy[ 299]= 3; IRLcoordsxIRL[ 299]=-8; IRLcoordsyIRL[ 299]= 41; IRLcoordszIRL[ 299]= 2
IRLcoordsx[ 300]= 13; IRLcoordsy[ 300]= 4; IRLcoordsxIRL[ 300]=-8; IRLcoordsyIRL[ 300]= 41; IRLcoordszIRL[ 300]= 3
IRLcoordsx[ 301]= 13; IRLcoordsy[ 301]= 5; IRLcoordsxIRL[ 301]=-8; IRLcoordsyIRL[ 301]= 41; IRLcoordszIRL[ 301]= 4
IRLcoordsx[ 302]= 13; IRLcoordsy[ 302]= 6; IRLcoordsxIRL[ 302]=-8; IRLcoordsyIRL[ 302]= 41; IRLcoordszIRL[ 302]= 5
IRLcoordsx[ 303]= 13; IRLcoordsy[ 303]= 7; IRLcoordsxIRL[ 303]=-8; IRLcoordsyIRL[ 303]= 41; IRLcoordszIRL[ 303]= 6
IRLcoordsx[ 304]= 14; IRLcoordsy[ 304]= 0; IRLcoordsxIRL[ 304]=-7; IRLcoordsyIRL[ 304]= 41; IRLcoordszIRL[ 304]=-1
IRLcoordsx[ 305]= 14; IRLcoordsy[ 305]= 1; IRLcoordsxIRL[ 305]=-7; IRLcoordsyIRL[ 305]= 41; IRLcoordszIRL[ 305]= 0
IRLcoordsx[ 306]= 14; IRLcoordsy[ 306]= 2; IRLcoordsxIRL[ 306]=-7; IRLcoordsyIRL[ 306]= 41; IRLcoordszIRL[ 306]= 1
IRLcoordsx[ 307]= 14; IRLcoordsy[ 307]= 3; IRLcoordsxIRL[ 307]=-7; IRLcoordsyIRL[ 307]= 41; IRLcoordszIRL[ 307]= 2
IRLcoordsx[ 308]= 14; IRLcoordsy[ 308]= 4; IRLcoordsxIRL[ 308]=-7; IRLcoordsyIRL[ 308]= 41; IRLcoordszIRL[ 308]= 3
IRLcoordsx[ 309]= 14; IRLcoordsy[ 309]= 5; IRLcoordsxIRL[ 309]=-7; IRLcoordsyIRL[ 309]= 41; IRLcoordszIRL[ 309]= 4
IRLcoordsx[ 310]= 14; IRLcoordsy[ 310]= 6; IRLcoordsxIRL[ 310]=-7; IRLcoordsyIRL[ 310]= 41; IRLcoordszIRL[ 310]= 5
IRLcoordsx[ 311]= 14; IRLcoordsy[ 311]= 7; IRLcoordsxIRL[ 311]=-7; IRLcoordsyIRL[ 311]= 41; IRLcoordszIRL[ 311]= 6
IRLcoordsx[ 312]= 15; IRLcoordsy[ 312]= 0; IRLcoordsxIRL[ 312]=-6; IRLcoordsyIRL[ 312]= 41; IRLcoordszIRL[ 312]=-1
IRLcoordsx[ 313]= 15; IRLcoordsy[ 313]= 1; IRLcoordsxIRL[ 313]=-6; IRLcoordsyIRL[ 313]= 41; IRLcoordszIRL[ 313]= 0
IRLcoordsx[ 314]= 15; IRLcoordsy[ 314]= 2; IRLcoordsxIRL[ 314]=-6; IRLcoordsyIRL[ 314]= 41; IRLcoordszIRL[ 314]= 1
IRLcoordsx[ 315]= 15; IRLcoordsy[ 315]= 3; IRLcoordsxIRL[ 315]=-6; IRLcoordsyIRL[ 315]= 41; IRLcoordszIRL[ 315]= 2
IRLcoordsx[ 316]= 15; IRLcoordsy[ 316]= 4; IRLcoordsxIRL[ 316]=-6; IRLcoordsyIRL[ 316]= 41; IRLcoordszIRL[ 316]= 3
IRLcoordsx[ 317]= 15; IRLcoordsy[ 317]= 5; IRLcoordsxIRL[ 317]=-6; IRLcoordsyIRL[ 317]= 41; IRLcoordszIRL[ 317]= 4
IRLcoordsx[ 318]= 15; IRLcoordsy[ 318]= 6; IRLcoordsxIRL[ 318]=-6; IRLcoordsyIRL[ 318]= 41; IRLcoordszIRL[ 318]= 5
IRLcoordsx[ 319]= 15; IRLcoordsy[ 319]= 7; IRLcoordsxIRL[ 319]=-6; IRLcoordsyIRL[ 319]= 41; IRLcoordszIRL[ 319]= 6
IRLcoordsx[ 320]= 16; IRLcoordsy[ 320]= 0; IRLcoordsxIRL[ 320]=-13; IRLcoordsyIRL[ 320]= 32; IRLcoordszIRL[ 320]=-1
IRLcoordsx[ 321]= 16; IRLcoordsy[ 321]= 1; IRLcoordsxIRL[ 321]=-13; IRLcoordsyIRL[ 321]= 32; IRLcoordszIRL[ 321]= 0
IRLcoordsx[ 322]= 16; IRLcoordsy[ 322]= 2; IRLcoordsxIRL[ 322]=-13; IRLcoordsyIRL[ 322]= 32; IRLcoordszIRL[ 322]= 1
IRLcoordsx[ 323]= 16; IRLcoordsy[ 323]= 3; IRLcoordsxIRL[ 323]=-13; IRLcoordsyIRL[ 323]= 32; IRLcoordszIRL[ 323]= 2
IRLcoordsx[ 324]= 16; IRLcoordsy[ 324]= 4; IRLcoordsxIRL[ 324]=-13; IRLcoordsyIRL[ 324]= 32; IRLcoordszIRL[ 324]= 3
IRLcoordsx[ 325]= 16; IRLcoordsy[ 325]= 5; IRLcoordsxIRL[ 325]=-13; IRLcoordsyIRL[ 325]= 32; IRLcoordszIRL[ 325]= 4
IRLcoordsx[ 326]= 16; IRLcoordsy[ 326]= 6; IRLcoordsxIRL[ 326]=-13; IRLcoordsyIRL[ 326]= 32; IRLcoordszIRL[ 326]= 5
IRLcoordsx[ 327]= 16; IRLcoordsy[ 327]= 7; IRLcoordsxIRL[ 327]=-13; IRLcoordsyIRL[ 327]= 32; IRLcoordszIRL[ 327]= 6
IRLcoordsx[ 328]= 17; IRLcoordsy[ 328]= 0; IRLcoordsxIRL[ 328]=-12; IRLcoordsyIRL[ 328]= 32; IRLcoordszIRL[ 328]=-1
IRLcoordsx[ 329]= 17; IRLcoordsy[ 329]= 1; IRLcoordsxIRL[ 329]=-12; IRLcoordsyIRL[ 329]= 32; IRLcoordszIRL[ 329]= 0
IRLcoordsx[ 330]= 17; IRLcoordsy[ 330]= 2; IRLcoordsxIRL[ 330]=-12; IRLcoordsyIRL[ 330]= 32; IRLcoordszIRL[ 330]= 1
IRLcoordsx[ 331]= 17; IRLcoordsy[ 331]= 3; IRLcoordsxIRL[ 331]=-12; IRLcoordsyIRL[ 331]= 32; IRLcoordszIRL[ 331]= 2
IRLcoordsx[ 332]= 17; IRLcoordsy[ 332]= 4; IRLcoordsxIRL[ 332]=-12; IRLcoordsyIRL[ 332]= 32; IRLcoordszIRL[ 332]= 3
IRLcoordsx[ 333]= 17; IRLcoordsy[ 333]= 5; IRLcoordsxIRL[ 333]=-12; IRLcoordsyIRL[ 333]= 32; IRLcoordszIRL[ 333]= 4
IRLcoordsx[ 334]= 17; IRLcoordsy[ 334]= 6; IRLcoordsxIRL[ 334]=-12; IRLcoordsyIRL[ 334]= 32; IRLcoordszIRL[ 334]= 5
IRLcoordsx[ 335]= 17; IRLcoordsy[ 335]= 7; IRLcoordsxIRL[ 335]=-12; IRLcoordsyIRL[ 335]= 32; IRLcoordszIRL[ 335]= 6
IRLcoordsx[ 336]= 18; IRLcoordsy[ 336]= 0; IRLcoordsxIRL[ 336]=-11; IRLcoordsyIRL[ 336]= 32; IRLcoordszIRL[ 336]=-1
IRLcoordsx[ 337]= 18; IRLcoordsy[ 337]= 1; IRLcoordsxIRL[ 337]=-11; IRLcoordsyIRL[ 337]= 32; IRLcoordszIRL[ 337]= 0
IRLcoordsx[ 338]= 18; IRLcoordsy[ 338]= 2; IRLcoordsxIRL[ 338]=-11; IRLcoordsyIRL[ 338]= 32; IRLcoordszIRL[ 338]= 1
IRLcoordsx[ 339]= 18; IRLcoordsy[ 339]= 3; IRLcoordsxIRL[ 339]=-11; IRLcoordsyIRL[ 339]= 32; IRLcoordszIRL[ 339]= 2
IRLcoordsx[ 340]= 18; IRLcoordsy[ 340]= 4; IRLcoordsxIRL[ 340]=-11; IRLcoordsyIRL[ 340]= 32; IRLcoordszIRL[ 340]= 3
IRLcoordsx[ 341]= 18; IRLcoordsy[ 341]= 5; IRLcoordsxIRL[ 341]=-11; IRLcoordsyIRL[ 341]= 32; IRLcoordszIRL[ 341]= 4
IRLcoordsx[ 342]= 18; IRLcoordsy[ 342]= 6; IRLcoordsxIRL[ 342]=-11; IRLcoordsyIRL[ 342]= 32; IRLcoordszIRL[ 342]= 5
IRLcoordsx[ 343]= 18; IRLcoordsy[ 343]= 7; IRLcoordsxIRL[ 343]=-11; IRLcoordsyIRL[ 343]= 32; IRLcoordszIRL[ 343]= 6
IRLcoordsx[ 344]= 19; IRLcoordsy[ 344]= 0; IRLcoordsxIRL[ 344]=-10; IRLcoordsyIRL[ 344]= 32; IRLcoordszIRL[ 344]=-1
IRLcoordsx[ 345]= 19; IRLcoordsy[ 345]= 1; IRLcoordsxIRL[ 345]=-10; IRLcoordsyIRL[ 345]= 32; IRLcoordszIRL[ 345]= 0
IRLcoordsx[ 346]= 19; IRLcoordsy[ 346]= 2; IRLcoordsxIRL[ 346]=-10; IRLcoordsyIRL[ 346]= 32; IRLcoordszIRL[ 346]= 1
IRLcoordsx[ 347]= 19; IRLcoordsy[ 347]= 3; IRLcoordsxIRL[ 347]=-10; IRLcoordsyIRL[ 347]= 32; IRLcoordszIRL[ 347]= 2
IRLcoordsx[ 348]= 19; IRLcoordsy[ 348]= 4; IRLcoordsxIRL[ 348]=-10; IRLcoordsyIRL[ 348]= 32; IRLcoordszIRL[ 348]= 3
IRLcoordsx[ 349]= 19; IRLcoordsy[ 349]= 5; IRLcoordsxIRL[ 349]=-10; IRLcoordsyIRL[ 349]= 32; IRLcoordszIRL[ 349]= 4
IRLcoordsx[ 350]= 19; IRLcoordsy[ 350]= 6; IRLcoordsxIRL[ 350]=-10; IRLcoordsyIRL[ 350]= 32; IRLcoordszIRL[ 350]= 5
IRLcoordsx[ 351]= 19; IRLcoordsy[ 351]= 7; IRLcoordsxIRL[ 351]=-10; IRLcoordsyIRL[ 351]= 32; IRLcoordszIRL[ 351]= 6
IRLcoordsx[ 352]= 20; IRLcoordsy[ 352]= 0; IRLcoordsxIRL[ 352]=-9; IRLcoordsyIRL[ 352]= 32; IRLcoordszIRL[ 352]=-1
IRLcoordsx[ 353]= 20; IRLcoordsy[ 353]= 1; IRLcoordsxIRL[ 353]=-9; IRLcoordsyIRL[ 353]= 32; IRLcoordszIRL[ 353]= 0
IRLcoordsx[ 354]= 20; IRLcoordsy[ 354]= 2; IRLcoordsxIRL[ 354]=-9; IRLcoordsyIRL[ 354]= 32; IRLcoordszIRL[ 354]= 1
IRLcoordsx[ 355]= 20; IRLcoordsy[ 355]= 3; IRLcoordsxIRL[ 355]=-9; IRLcoordsyIRL[ 355]= 32; IRLcoordszIRL[ 355]= 2
IRLcoordsx[ 356]= 20; IRLcoordsy[ 356]= 4; IRLcoordsxIRL[ 356]=-9; IRLcoordsyIRL[ 356]= 32; IRLcoordszIRL[ 356]= 3
IRLcoordsx[ 357]= 20; IRLcoordsy[ 357]= 5; IRLcoordsxIRL[ 357]=-9; IRLcoordsyIRL[ 357]= 32; IRLcoordszIRL[ 357]= 4
IRLcoordsx[ 358]= 20; IRLcoordsy[ 358]= 6; IRLcoordsxIRL[ 358]=-9; IRLcoordsyIRL[ 358]= 32; IRLcoordszIRL[ 358]= 5
IRLcoordsx[ 359]= 20; IRLcoordsy[ 359]= 7; IRLcoordsxIRL[ 359]=-9; IRLcoordsyIRL[ 359]= 32; IRLcoordszIRL[ 359]= 6
IRLcoordsx[ 360]= 21; IRLcoordsy[ 360]= 0; IRLcoordsxIRL[ 360]=-8; IRLcoordsyIRL[ 360]= 32; IRLcoordszIRL[ 360]=-1
IRLcoordsx[ 361]= 21; IRLcoordsy[ 361]= 1; IRLcoordsxIRL[ 361]=-8; IRLcoordsyIRL[ 361]= 32; IRLcoordszIRL[ 361]= 0
IRLcoordsx[ 362]= 21; IRLcoordsy[ 362]= 2; IRLcoordsxIRL[ 362]=-8; IRLcoordsyIRL[ 362]= 32; IRLcoordszIRL[ 362]= 1
IRLcoordsx[ 363]= 21; IRLcoordsy[ 363]= 3; IRLcoordsxIRL[ 363]=-8; IRLcoordsyIRL[ 363]= 32; IRLcoordszIRL[ 363]= 2
IRLcoordsx[ 364]= 21; IRLcoordsy[ 364]= 4; IRLcoordsxIRL[ 364]=-8; IRLcoordsyIRL[ 364]= 32; IRLcoordszIRL[ 364]= 3
IRLcoordsx[ 365]= 21; IRLcoordsy[ 365]= 5; IRLcoordsxIRL[ 365]=-8; IRLcoordsyIRL[ 365]= 32; IRLcoordszIRL[ 365]= 4
IRLcoordsx[ 366]= 21; IRLcoordsy[ 366]= 6; IRLcoordsxIRL[ 366]=-8; IRLcoordsyIRL[ 366]= 32; IRLcoordszIRL[ 366]= 5
IRLcoordsx[ 367]= 21; IRLcoordsy[ 367]= 7; IRLcoordsxIRL[ 367]=-8; IRLcoordsyIRL[ 367]= 32; IRLcoordszIRL[ 367]= 6
IRLcoordsx[ 368]= 22; IRLcoordsy[ 368]= 0; IRLcoordsxIRL[ 368]=-7; IRLcoordsyIRL[ 368]= 32; IRLcoordszIRL[ 368]=-1
IRLcoordsx[ 369]= 22; IRLcoordsy[ 369]= 1; IRLcoordsxIRL[ 369]=-7; IRLcoordsyIRL[ 369]= 32; IRLcoordszIRL[ 369]= 0
IRLcoordsx[ 370]= 22; IRLcoordsy[ 370]= 2; IRLcoordsxIRL[ 370]=-7; IRLcoordsyIRL[ 370]= 32; IRLcoordszIRL[ 370]= 1
IRLcoordsx[ 371]= 22; IRLcoordsy[ 371]= 3; IRLcoordsxIRL[ 371]=-7; IRLcoordsyIRL[ 371]= 32; IRLcoordszIRL[ 371]= 2
IRLcoordsx[ 372]= 22; IRLcoordsy[ 372]= 4; IRLcoordsxIRL[ 372]=-7; IRLcoordsyIRL[ 372]= 32; IRLcoordszIRL[ 372]= 3
IRLcoordsx[ 373]= 22; IRLcoordsy[ 373]= 5; IRLcoordsxIRL[ 373]=-7; IRLcoordsyIRL[ 373]= 32; IRLcoordszIRL[ 373]= 4
IRLcoordsx[ 374]= 22; IRLcoordsy[ 374]= 6; IRLcoordsxIRL[ 374]=-7; IRLcoordsyIRL[ 374]= 32; IRLcoordszIRL[ 374]= 5
IRLcoordsx[ 375]= 22; IRLcoordsy[ 375]= 7; IRLcoordsxIRL[ 375]=-7; IRLcoordsyIRL[ 375]= 32; IRLcoordszIRL[ 375]= 6
IRLcoordsx[ 376]= 23; IRLcoordsy[ 376]= 0; IRLcoordsxIRL[ 376]=-6; IRLcoordsyIRL[ 376]= 32; IRLcoordszIRL[ 376]=-1
IRLcoordsx[ 377]= 23; IRLcoordsy[ 377]= 1; IRLcoordsxIRL[ 377]=-6; IRLcoordsyIRL[ 377]= 32; IRLcoordszIRL[ 377]= 0
IRLcoordsx[ 378]= 23; IRLcoordsy[ 378]= 2; IRLcoordsxIRL[ 378]=-6; IRLcoordsyIRL[ 378]= 32; IRLcoordszIRL[ 378]= 1
IRLcoordsx[ 379]= 23; IRLcoordsy[ 379]= 3; IRLcoordsxIRL[ 379]=-6; IRLcoordsyIRL[ 379]= 32; IRLcoordszIRL[ 379]= 2
IRLcoordsx[ 380]= 23; IRLcoordsy[ 380]= 4; IRLcoordsxIRL[ 380]=-6; IRLcoordsyIRL[ 380]= 32; IRLcoordszIRL[ 380]= 3
IRLcoordsx[ 381]= 23; IRLcoordsy[ 381]= 5; IRLcoordsxIRL[ 381]=-6; IRLcoordsyIRL[ 381]= 32; IRLcoordszIRL[ 381]= 4
IRLcoordsx[ 382]= 23; IRLcoordsy[ 382]= 6; IRLcoordsxIRL[ 382]=-6; IRLcoordsyIRL[ 382]= 32; IRLcoordszIRL[ 382]= 5
IRLcoordsx[ 383]= 23; IRLcoordsy[ 383]= 7; IRLcoordsxIRL[ 383]=-6; IRLcoordsyIRL[ 383]= 32; IRLcoordszIRL[ 383]= 6
IRLcoordsx[ 384]= 20; IRLcoordsy[ 384]= 20; IRLcoordsxIRL[ 384]=-13; IRLcoordsyIRL[ 384]= 28; IRLcoordszIRL[ 384]= 5
IRLcoordsx[ 385]= 20; IRLcoordsy[ 385]= 21; IRLcoordsxIRL[ 385]=-13; IRLcoordsyIRL[ 385]= 27; IRLcoordszIRL[ 385]= 5
IRLcoordsx[ 386]= 20; IRLcoordsy[ 386]= 22; IRLcoordsxIRL[ 386]=-13; IRLcoordsyIRL[ 386]= 26; IRLcoordszIRL[ 386]= 5
IRLcoordsx[ 387]= 20; IRLcoordsy[ 387]= 23; IRLcoordsxIRL[ 387]=-13; IRLcoordsyIRL[ 387]= 25; IRLcoordszIRL[ 387]= 5
IRLcoordsx[ 388]= 20; IRLcoordsy[ 388]= 24; IRLcoordsxIRL[ 388]=-13; IRLcoordsyIRL[ 388]= 24; IRLcoordszIRL[ 388]= 5
IRLcoordsx[ 389]= 20; IRLcoordsy[ 389]= 25; IRLcoordsxIRL[ 389]=-13; IRLcoordsyIRL[ 389]= 23; IRLcoordszIRL[ 389]= 5
IRLcoordsx[ 390]= 20; IRLcoordsy[ 390]= 26; IRLcoordsxIRL[ 390]=-13; IRLcoordsyIRL[ 390]= 22; IRLcoordszIRL[ 390]= 5
IRLcoordsx[ 391]= 20; IRLcoordsy[ 391]= 27; IRLcoordsxIRL[ 391]=-13; IRLcoordsyIRL[ 391]= 21; IRLcoordszIRL[ 391]= 5
IRLcoordsx[ 392]= 20; IRLcoordsy[ 392]= 28; IRLcoordsxIRL[ 392]=-13; IRLcoordsyIRL[ 392]= 20; IRLcoordszIRL[ 392]= 5
IRLcoordsx[ 393]= 20; IRLcoordsy[ 393]= 29; IRLcoordsxIRL[ 393]=-13; IRLcoordsyIRL[ 393]= 19; IRLcoordszIRL[ 393]= 5
IRLcoordsx[ 394]= 20; IRLcoordsy[ 394]= 30; IRLcoordsxIRL[ 394]=-13; IRLcoordsyIRL[ 394]= 18; IRLcoordszIRL[ 394]= 5
IRLcoordsx[ 395]= 20; IRLcoordsy[ 395]= 31; IRLcoordsxIRL[ 395]=-13; IRLcoordsyIRL[ 395]= 17; IRLcoordszIRL[ 395]= 5
IRLcoordsx[ 396]= 21; IRLcoordsy[ 396]= 20; IRLcoordsxIRL[ 396]=-12; IRLcoordsyIRL[ 396]= 28; IRLcoordszIRL[ 396]= 5
IRLcoordsx[ 397]= 21; IRLcoordsy[ 397]= 21; IRLcoordsxIRL[ 397]=-12; IRLcoordsyIRL[ 397]= 27; IRLcoordszIRL[ 397]= 5
IRLcoordsx[ 398]= 21; IRLcoordsy[ 398]= 22; IRLcoordsxIRL[ 398]=-12; IRLcoordsyIRL[ 398]= 26; IRLcoordszIRL[ 398]= 5
IRLcoordsx[ 399]= 21; IRLcoordsy[ 399]= 23; IRLcoordsxIRL[ 399]=-12; IRLcoordsyIRL[ 399]= 25; IRLcoordszIRL[ 399]= 5
IRLcoordsx[ 400]= 21; IRLcoordsy[ 400]= 24; IRLcoordsxIRL[ 400]=-12; IRLcoordsyIRL[ 400]= 24; IRLcoordszIRL[ 400]= 5
IRLcoordsx[ 401]= 21; IRLcoordsy[ 401]= 25; IRLcoordsxIRL[ 401]=-12; IRLcoordsyIRL[ 401]= 23; IRLcoordszIRL[ 401]= 5
IRLcoordsx[ 402]= 21; IRLcoordsy[ 402]= 26; IRLcoordsxIRL[ 402]=-12; IRLcoordsyIRL[ 402]= 22; IRLcoordszIRL[ 402]= 5
IRLcoordsx[ 403]= 21; IRLcoordsy[ 403]= 27; IRLcoordsxIRL[ 403]=-12; IRLcoordsyIRL[ 403]= 21; IRLcoordszIRL[ 403]= 5
IRLcoordsx[ 404]= 21; IRLcoordsy[ 404]= 28; IRLcoordsxIRL[ 404]=-12; IRLcoordsyIRL[ 404]= 20; IRLcoordszIRL[ 404]= 5
IRLcoordsx[ 405]= 21; IRLcoordsy[ 405]= 29; IRLcoordsxIRL[ 405]=-12; IRLcoordsyIRL[ 405]= 19; IRLcoordszIRL[ 405]= 5
IRLcoordsx[ 406]= 21; IRLcoordsy[ 406]= 30; IRLcoordsxIRL[ 406]=-12; IRLcoordsyIRL[ 406]= 18; IRLcoordszIRL[ 406]= 5
IRLcoordsx[ 407]= 21; IRLcoordsy[ 407]= 31; IRLcoordsxIRL[ 407]=-12; IRLcoordsyIRL[ 407]= 17; IRLcoordszIRL[ 407]= 5
IRLcoordsx[ 408]= 22; IRLcoordsy[ 408]= 20; IRLcoordsxIRL[ 408]=-11; IRLcoordsyIRL[ 408]= 28; IRLcoordszIRL[ 408]= 5
IRLcoordsx[ 409]= 22; IRLcoordsy[ 409]= 21; IRLcoordsxIRL[ 409]=-11; IRLcoordsyIRL[ 409]= 27; IRLcoordszIRL[ 409]= 5
IRLcoordsx[ 410]= 22; IRLcoordsy[ 410]= 22; IRLcoordsxIRL[ 410]=-11; IRLcoordsyIRL[ 410]= 26; IRLcoordszIRL[ 410]= 5
IRLcoordsx[ 411]= 22; IRLcoordsy[ 411]= 23; IRLcoordsxIRL[ 411]=-11; IRLcoordsyIRL[ 411]= 25; IRLcoordszIRL[ 411]= 5
IRLcoordsx[ 412]= 22; IRLcoordsy[ 412]= 24; IRLcoordsxIRL[ 412]=-11; IRLcoordsyIRL[ 412]= 24; IRLcoordszIRL[ 412]= 5
IRLcoordsx[ 413]= 22; IRLcoordsy[ 413]= 25; IRLcoordsxIRL[ 413]=-11; IRLcoordsyIRL[ 413]= 23; IRLcoordszIRL[ 413]= 5
IRLcoordsx[ 414]= 22; IRLcoordsy[ 414]= 26; IRLcoordsxIRL[ 414]=-11; IRLcoordsyIRL[ 414]= 22; IRLcoordszIRL[ 414]= 5
IRLcoordsx[ 415]= 22; IRLcoordsy[ 415]= 27; IRLcoordsxIRL[ 415]=-11; IRLcoordsyIRL[ 415]= 21; IRLcoordszIRL[ 415]= 5
IRLcoordsx[ 416]= 22; IRLcoordsy[ 416]= 28; IRLcoordsxIRL[ 416]=-11; IRLcoordsyIRL[ 416]= 20; IRLcoordszIRL[ 416]= 5
IRLcoordsx[ 417]= 22; IRLcoordsy[ 417]= 29; IRLcoordsxIRL[ 417]=-11; IRLcoordsyIRL[ 417]= 19; IRLcoordszIRL[ 417]= 5
IRLcoordsx[ 418]= 22; IRLcoordsy[ 418]= 30; IRLcoordsxIRL[ 418]=-11; IRLcoordsyIRL[ 418]= 18; IRLcoordszIRL[ 418]= 5
IRLcoordsx[ 419]= 22; IRLcoordsy[ 419]= 31; IRLcoordsxIRL[ 419]=-11; IRLcoordsyIRL[ 419]= 17; IRLcoordszIRL[ 419]= 5
IRLcoordsx[ 420]= 23; IRLcoordsy[ 420]= 20; IRLcoordsxIRL[ 420]=-10; IRLcoordsyIRL[ 420]= 28; IRLcoordszIRL[ 420]= 5
IRLcoordsx[ 421]= 23; IRLcoordsy[ 421]= 21; IRLcoordsxIRL[ 421]=-10; IRLcoordsyIRL[ 421]= 27; IRLcoordszIRL[ 421]= 5
IRLcoordsx[ 422]= 23; IRLcoordsy[ 422]= 22; IRLcoordsxIRL[ 422]=-10; IRLcoordsyIRL[ 422]= 26; IRLcoordszIRL[ 422]= 5
IRLcoordsx[ 423]= 23; IRLcoordsy[ 423]= 23; IRLcoordsxIRL[ 423]=-10; IRLcoordsyIRL[ 423]= 25; IRLcoordszIRL[ 423]= 5
IRLcoordsx[ 424]= 23; IRLcoordsy[ 424]= 24; IRLcoordsxIRL[ 424]=-10; IRLcoordsyIRL[ 424]= 24; IRLcoordszIRL[ 424]= 5
IRLcoordsx[ 425]= 23; IRLcoordsy[ 425]= 25; IRLcoordsxIRL[ 425]=-10; IRLcoordsyIRL[ 425]= 23; IRLcoordszIRL[ 425]= 5
IRLcoordsx[ 426]= 23; IRLcoordsy[ 426]= 26; IRLcoordsxIRL[ 426]=-10; IRLcoordsyIRL[ 426]= 22; IRLcoordszIRL[ 426]= 5
IRLcoordsx[ 427]= 23; IRLcoordsy[ 427]= 27; IRLcoordsxIRL[ 427]=-10; IRLcoordsyIRL[ 427]= 21; IRLcoordszIRL[ 427]= 5
IRLcoordsx[ 428]= 23; IRLcoordsy[ 428]= 28; IRLcoordsxIRL[ 428]=-10; IRLcoordsyIRL[ 428]= 20; IRLcoordszIRL[ 428]= 5
IRLcoordsx[ 429]= 23; IRLcoordsy[ 429]= 29; IRLcoordsxIRL[ 429]=-10; IRLcoordsyIRL[ 429]= 19; IRLcoordszIRL[ 429]= 5
IRLcoordsx[ 430]= 23; IRLcoordsy[ 430]= 30; IRLcoordsxIRL[ 430]=-10; IRLcoordsyIRL[ 430]= 18; IRLcoordszIRL[ 430]= 5
IRLcoordsx[ 431]= 23; IRLcoordsy[ 431]= 31; IRLcoordsxIRL[ 431]=-10; IRLcoordsyIRL[ 431]= 17; IRLcoordszIRL[ 431]= 5
IRLcoordsx[ 432]= 24; IRLcoordsy[ 432]= 20; IRLcoordsxIRL[ 432]=-9; IRLcoordsyIRL[ 432]= 28; IRLcoordszIRL[ 432]= 5
IRLcoordsx[ 433]= 24; IRLcoordsy[ 433]= 21; IRLcoordsxIRL[ 433]=-9; IRLcoordsyIRL[ 433]= 27; IRLcoordszIRL[ 433]= 5
IRLcoordsx[ 434]= 24; IRLcoordsy[ 434]= 22; IRLcoordsxIRL[ 434]=-9; IRLcoordsyIRL[ 434]= 26; IRLcoordszIRL[ 434]= 5
IRLcoordsx[ 435]= 24; IRLcoordsy[ 435]= 23; IRLcoordsxIRL[ 435]=-9; IRLcoordsyIRL[ 435]= 25; IRLcoordszIRL[ 435]= 5
IRLcoordsx[ 436]= 24; IRLcoordsy[ 436]= 24; IRLcoordsxIRL[ 436]=-9; IRLcoordsyIRL[ 436]= 24; IRLcoordszIRL[ 436]= 5
IRLcoordsx[ 437]= 24; IRLcoordsy[ 437]= 25; IRLcoordsxIRL[ 437]=-9; IRLcoordsyIRL[ 437]= 23; IRLcoordszIRL[ 437]= 5
IRLcoordsx[ 438]= 24; IRLcoordsy[ 438]= 26; IRLcoordsxIRL[ 438]=-9; IRLcoordsyIRL[ 438]= 22; IRLcoordszIRL[ 438]= 5
IRLcoordsx[ 439]= 24; IRLcoordsy[ 439]= 27; IRLcoordsxIRL[ 439]=-9; IRLcoordsyIRL[ 439]= 21; IRLcoordszIRL[ 439]= 5
IRLcoordsx[ 440]= 24; IRLcoordsy[ 440]= 28; IRLcoordsxIRL[ 440]=-9; IRLcoordsyIRL[ 440]= 20; IRLcoordszIRL[ 440]= 5
IRLcoordsx[ 441]= 24; IRLcoordsy[ 441]= 29; IRLcoordsxIRL[ 441]=-9; IRLcoordsyIRL[ 441]= 19; IRLcoordszIRL[ 441]= 5
IRLcoordsx[ 442]= 24; IRLcoordsy[ 442]= 30; IRLcoordsxIRL[ 442]=-9; IRLcoordsyIRL[ 442]= 18; IRLcoordszIRL[ 442]= 5
IRLcoordsx[ 443]= 24; IRLcoordsy[ 443]= 31; IRLcoordsxIRL[ 443]=-9; IRLcoordsyIRL[ 443]= 17; IRLcoordszIRL[ 443]= 5
IRLcoordsx[ 444]= 25; IRLcoordsy[ 444]= 20; IRLcoordsxIRL[ 444]=-8; IRLcoordsyIRL[ 444]= 28; IRLcoordszIRL[ 444]= 5
IRLcoordsx[ 445]= 25; IRLcoordsy[ 445]= 21; IRLcoordsxIRL[ 445]=-8; IRLcoordsyIRL[ 445]= 27; IRLcoordszIRL[ 445]= 5
IRLcoordsx[ 446]= 25; IRLcoordsy[ 446]= 22; IRLcoordsxIRL[ 446]=-8; IRLcoordsyIRL[ 446]= 26; IRLcoordszIRL[ 446]= 5
IRLcoordsx[ 447]= 25; IRLcoordsy[ 447]= 23; IRLcoordsxIRL[ 447]=-8; IRLcoordsyIRL[ 447]= 25; IRLcoordszIRL[ 447]= 5
IRLcoordsx[ 448]= 25; IRLcoordsy[ 448]= 24; IRLcoordsxIRL[ 448]=-8; IRLcoordsyIRL[ 448]= 24; IRLcoordszIRL[ 448]= 5
IRLcoordsx[ 449]= 25; IRLcoordsy[ 449]= 25; IRLcoordsxIRL[ 449]=-8; IRLcoordsyIRL[ 449]= 23; IRLcoordszIRL[ 449]= 5
IRLcoordsx[ 450]= 25; IRLcoordsy[ 450]= 26; IRLcoordsxIRL[ 450]=-8; IRLcoordsyIRL[ 450]= 22; IRLcoordszIRL[ 450]= 5
IRLcoordsx[ 451]= 25; IRLcoordsy[ 451]= 27; IRLcoordsxIRL[ 451]=-8; IRLcoordsyIRL[ 451]= 21; IRLcoordszIRL[ 451]= 5
IRLcoordsx[ 452]= 25; IRLcoordsy[ 452]= 28; IRLcoordsxIRL[ 452]=-8; IRLcoordsyIRL[ 452]= 20; IRLcoordszIRL[ 452]= 5
IRLcoordsx[ 453]= 25; IRLcoordsy[ 453]= 29; IRLcoordsxIRL[ 453]=-8; IRLcoordsyIRL[ 453]= 19; IRLcoordszIRL[ 453]= 5
IRLcoordsx[ 454]= 25; IRLcoordsy[ 454]= 30; IRLcoordsxIRL[ 454]=-8; IRLcoordsyIRL[ 454]= 18; IRLcoordszIRL[ 454]= 5
IRLcoordsx[ 455]= 25; IRLcoordsy[ 455]= 31; IRLcoordsxIRL[ 455]=-8; IRLcoordsyIRL[ 455]= 17; IRLcoordszIRL[ 455]= 5
IRLcoordsx[ 456]= 26; IRLcoordsy[ 456]= 20; IRLcoordsxIRL[ 456]=-7; IRLcoordsyIRL[ 456]= 28; IRLcoordszIRL[ 456]= 5
IRLcoordsx[ 457]= 26; IRLcoordsy[ 457]= 21; IRLcoordsxIRL[ 457]=-7; IRLcoordsyIRL[ 457]= 27; IRLcoordszIRL[ 457]= 5
IRLcoordsx[ 458]= 26; IRLcoordsy[ 458]= 22; IRLcoordsxIRL[ 458]=-7; IRLcoordsyIRL[ 458]= 26; IRLcoordszIRL[ 458]= 5
IRLcoordsx[ 459]= 26; IRLcoordsy[ 459]= 23; IRLcoordsxIRL[ 459]=-7; IRLcoordsyIRL[ 459]= 25; IRLcoordszIRL[ 459]= 5
IRLcoordsx[ 460]= 26; IRLcoordsy[ 460]= 24; IRLcoordsxIRL[ 460]=-7; IRLcoordsyIRL[ 460]= 24; IRLcoordszIRL[ 460]= 5
IRLcoordsx[ 461]= 26; IRLcoordsy[ 461]= 25; IRLcoordsxIRL[ 461]=-7; IRLcoordsyIRL[ 461]= 23; IRLcoordszIRL[ 461]= 5
IRLcoordsx[ 462]= 26; IRLcoordsy[ 462]= 26; IRLcoordsxIRL[ 462]=-7; IRLcoordsyIRL[ 462]= 22; IRLcoordszIRL[ 462]= 5
IRLcoordsx[ 463]= 26; IRLcoordsy[ 463]= 27; IRLcoordsxIRL[ 463]=-7; IRLcoordsyIRL[ 463]= 21; IRLcoordszIRL[ 463]= 5
IRLcoordsx[ 464]= 26; IRLcoordsy[ 464]= 28; IRLcoordsxIRL[ 464]=-7; IRLcoordsyIRL[ 464]= 20; IRLcoordszIRL[ 464]= 5
IRLcoordsx[ 465]= 26; IRLcoordsy[ 465]= 29; IRLcoordsxIRL[ 465]=-7; IRLcoordsyIRL[ 465]= 19; IRLcoordszIRL[ 465]= 5
IRLcoordsx[ 466]= 26; IRLcoordsy[ 466]= 30; IRLcoordsxIRL[ 466]=-7; IRLcoordsyIRL[ 466]= 18; IRLcoordszIRL[ 466]= 5
IRLcoordsx[ 467]= 26; IRLcoordsy[ 467]= 31; IRLcoordsxIRL[ 467]=-7; IRLcoordsyIRL[ 467]= 17; IRLcoordszIRL[ 467]= 5
IRLcoordsx[ 468]= 27; IRLcoordsy[ 468]= 20; IRLcoordsxIRL[ 468]=-6; IRLcoordsyIRL[ 468]= 28; IRLcoordszIRL[ 468]= 5
IRLcoordsx[ 469]= 27; IRLcoordsy[ 469]= 21; IRLcoordsxIRL[ 469]=-6; IRLcoordsyIRL[ 469]= 27; IRLcoordszIRL[ 469]= 5
IRLcoordsx[ 470]= 27; IRLcoordsy[ 470]= 22; IRLcoordsxIRL[ 470]=-6; IRLcoordsyIRL[ 470]= 26; IRLcoordszIRL[ 470]= 5
IRLcoordsx[ 471]= 27; IRLcoordsy[ 471]= 23; IRLcoordsxIRL[ 471]=-6; IRLcoordsyIRL[ 471]= 25; IRLcoordszIRL[ 471]= 5
IRLcoordsx[ 472]= 27; IRLcoordsy[ 472]= 24; IRLcoordsxIRL[ 472]=-6; IRLcoordsyIRL[ 472]= 24; IRLcoordszIRL[ 472]= 5
IRLcoordsx[ 473]= 27; IRLcoordsy[ 473]= 25; IRLcoordsxIRL[ 473]=-6; IRLcoordsyIRL[ 473]= 23; IRLcoordszIRL[ 473]= 5
IRLcoordsx[ 474]= 27; IRLcoordsy[ 474]= 26; IRLcoordsxIRL[ 474]=-6; IRLcoordsyIRL[ 474]= 22; IRLcoordszIRL[ 474]= 5
IRLcoordsx[ 475]= 27; IRLcoordsy[ 475]= 27; IRLcoordsxIRL[ 475]=-6; IRLcoordsyIRL[ 475]= 21; IRLcoordszIRL[ 475]= 5
IRLcoordsx[ 476]= 27; IRLcoordsy[ 476]= 28; IRLcoordsxIRL[ 476]=-6; IRLcoordsyIRL[ 476]= 20; IRLcoordszIRL[ 476]= 5
IRLcoordsx[ 477]= 27; IRLcoordsy[ 477]= 29; IRLcoordsxIRL[ 477]=-6; IRLcoordsyIRL[ 477]= 19; IRLcoordszIRL[ 477]= 5
IRLcoordsx[ 478]= 27; IRLcoordsy[ 478]= 30; IRLcoordsxIRL[ 478]=-6; IRLcoordsyIRL[ 478]= 18; IRLcoordszIRL[ 478]= 5
IRLcoordsx[ 479]= 27; IRLcoordsy[ 479]= 31; IRLcoordsxIRL[ 479]=-6; IRLcoordsyIRL[ 479]= 17; IRLcoordszIRL[ 479]= 5
IRLcoordsx[ 480]= 32; IRLcoordsy[ 480]= 20; IRLcoordsxIRL[ 480]=-6; IRLcoordsyIRL[ 480]= 28; IRLcoordszIRL[ 480]= 0
IRLcoordsx[ 481]= 32; IRLcoordsy[ 481]= 21; IRLcoordsxIRL[ 481]=-6; IRLcoordsyIRL[ 481]= 27; IRLcoordszIRL[ 481]= 0
IRLcoordsx[ 482]= 32; IRLcoordsy[ 482]= 22; IRLcoordsxIRL[ 482]=-6; IRLcoordsyIRL[ 482]= 26; IRLcoordszIRL[ 482]= 0
IRLcoordsx[ 483]= 32; IRLcoordsy[ 483]= 23; IRLcoordsxIRL[ 483]=-6; IRLcoordsyIRL[ 483]= 25; IRLcoordszIRL[ 483]= 0
IRLcoordsx[ 484]= 32; IRLcoordsy[ 484]= 24; IRLcoordsxIRL[ 484]=-6; IRLcoordsyIRL[ 484]= 24; IRLcoordszIRL[ 484]= 0
IRLcoordsx[ 485]= 32; IRLcoordsy[ 485]= 25; IRLcoordsxIRL[ 485]=-6; IRLcoordsyIRL[ 485]= 23; IRLcoordszIRL[ 485]= 0
IRLcoordsx[ 486]= 32; IRLcoordsy[ 486]= 26; IRLcoordsxIRL[ 486]=-6; IRLcoordsyIRL[ 486]= 22; IRLcoordszIRL[ 486]= 0
IRLcoordsx[ 487]= 32; IRLcoordsy[ 487]= 27; IRLcoordsxIRL[ 487]=-6; IRLcoordsyIRL[ 487]= 21; IRLcoordszIRL[ 487]= 0
IRLcoordsx[ 488]= 32; IRLcoordsy[ 488]= 28; IRLcoordsxIRL[ 488]=-6; IRLcoordsyIRL[ 488]= 20; IRLcoordszIRL[ 488]= 0
IRLcoordsx[ 489]= 32; IRLcoordsy[ 489]= 29; IRLcoordsxIRL[ 489]=-6; IRLcoordsyIRL[ 489]= 19; IRLcoordszIRL[ 489]= 0
IRLcoordsx[ 490]= 32; IRLcoordsy[ 490]= 30; IRLcoordsxIRL[ 490]=-6; IRLcoordsyIRL[ 490]= 18; IRLcoordszIRL[ 490]= 0
IRLcoordsx[ 491]= 32; IRLcoordsy[ 491]= 31; IRLcoordsxIRL[ 491]=-6; IRLcoordsyIRL[ 491]= 17; IRLcoordszIRL[ 491]= 0
IRLcoordsx[ 492]= 33; IRLcoordsy[ 492]= 20; IRLcoordsxIRL[ 492]=-7; IRLcoordsyIRL[ 492]= 28; IRLcoordszIRL[ 492]= 0
IRLcoordsx[ 493]= 33; IRLcoordsy[ 493]= 21; IRLcoordsxIRL[ 493]=-7; IRLcoordsyIRL[ 493]= 27; IRLcoordszIRL[ 493]= 0
IRLcoordsx[ 494]= 33; IRLcoordsy[ 494]= 22; IRLcoordsxIRL[ 494]=-7; IRLcoordsyIRL[ 494]= 26; IRLcoordszIRL[ 494]= 0
IRLcoordsx[ 495]= 33; IRLcoordsy[ 495]= 23; IRLcoordsxIRL[ 495]=-7; IRLcoordsyIRL[ 495]= 25; IRLcoordszIRL[ 495]= 0
IRLcoordsx[ 496]= 33; IRLcoordsy[ 496]= 24; IRLcoordsxIRL[ 496]=-7; IRLcoordsyIRL[ 496]= 24; IRLcoordszIRL[ 496]= 0
IRLcoordsx[ 497]= 33; IRLcoordsy[ 497]= 25; IRLcoordsxIRL[ 497]=-7; IRLcoordsyIRL[ 497]= 23; IRLcoordszIRL[ 497]= 0
IRLcoordsx[ 498]= 33; IRLcoordsy[ 498]= 26; IRLcoordsxIRL[ 498]=-7; IRLcoordsyIRL[ 498]= 22; IRLcoordszIRL[ 498]= 0
IRLcoordsx[ 499]= 33; IRLcoordsy[ 499]= 27; IRLcoordsxIRL[ 499]=-7; IRLcoordsyIRL[ 499]= 21; IRLcoordszIRL[ 499]= 0
IRLcoordsx[ 500]= 33; IRLcoordsy[ 500]= 28; IRLcoordsxIRL[ 500]=-7; IRLcoordsyIRL[ 500]= 20; IRLcoordszIRL[ 500]= 0
IRLcoordsx[ 501]= 33; IRLcoordsy[ 501]= 29; IRLcoordsxIRL[ 501]=-7; IRLcoordsyIRL[ 501]= 19; IRLcoordszIRL[ 501]= 0
IRLcoordsx[ 502]= 33; IRLcoordsy[ 502]= 30; IRLcoordsxIRL[ 502]=-7; IRLcoordsyIRL[ 502]= 18; IRLcoordszIRL[ 502]= 0
IRLcoordsx[ 503]= 33; IRLcoordsy[ 503]= 31; IRLcoordsxIRL[ 503]=-7; IRLcoordsyIRL[ 503]= 17; IRLcoordszIRL[ 503]= 0
IRLcoordsx[ 504]= 34; IRLcoordsy[ 504]= 20; IRLcoordsxIRL[ 504]=-8; IRLcoordsyIRL[ 504]= 28; IRLcoordszIRL[ 504]= 0
IRLcoordsx[ 505]= 34; IRLcoordsy[ 505]= 21; IRLcoordsxIRL[ 505]=-8; IRLcoordsyIRL[ 505]= 27; IRLcoordszIRL[ 505]= 0
IRLcoordsx[ 506]= 34; IRLcoordsy[ 506]= 22; IRLcoordsxIRL[ 506]=-8; IRLcoordsyIRL[ 506]= 26; IRLcoordszIRL[ 506]= 0
IRLcoordsx[ 507]= 34; IRLcoordsy[ 507]= 23; IRLcoordsxIRL[ 507]=-8; IRLcoordsyIRL[ 507]= 25; IRLcoordszIRL[ 507]= 0
IRLcoordsx[ 508]= 34; IRLcoordsy[ 508]= 24; IRLcoordsxIRL[ 508]=-8; IRLcoordsyIRL[ 508]= 24; IRLcoordszIRL[ 508]= 0
IRLcoordsx[ 509]= 34; IRLcoordsy[ 509]= 25; IRLcoordsxIRL[ 509]=-8; IRLcoordsyIRL[ 509]= 23; IRLcoordszIRL[ 509]= 0
IRLcoordsx[ 510]= 34; IRLcoordsy[ 510]= 26; IRLcoordsxIRL[ 510]=-8; IRLcoordsyIRL[ 510]= 22; IRLcoordszIRL[ 510]= 0
IRLcoordsx[ 511]= 34; IRLcoordsy[ 511]= 27; IRLcoordsxIRL[ 511]=-8; IRLcoordsyIRL[ 511]= 21; IRLcoordszIRL[ 511]= 0
IRLcoordsx[ 512]= 34; IRLcoordsy[ 512]= 28; IRLcoordsxIRL[ 512]=-8; IRLcoordsyIRL[ 512]= 20; IRLcoordszIRL[ 512]= 0
IRLcoordsx[ 513]= 34; IRLcoordsy[ 513]= 29; IRLcoordsxIRL[ 513]=-8; IRLcoordsyIRL[ 513]= 19; IRLcoordszIRL[ 513]= 0
IRLcoordsx[ 514]= 34; IRLcoordsy[ 514]= 30; IRLcoordsxIRL[ 514]=-8; IRLcoordsyIRL[ 514]= 18; IRLcoordszIRL[ 514]= 0
IRLcoordsx[ 515]= 34; IRLcoordsy[ 515]= 31; IRLcoordsxIRL[ 515]=-8; IRLcoordsyIRL[ 515]= 17; IRLcoordszIRL[ 515]= 0
IRLcoordsx[ 516]= 35; IRLcoordsy[ 516]= 20; IRLcoordsxIRL[ 516]=-9; IRLcoordsyIRL[ 516]= 28; IRLcoordszIRL[ 516]= 0
IRLcoordsx[ 517]= 35; IRLcoordsy[ 517]= 21; IRLcoordsxIRL[ 517]=-9; IRLcoordsyIRL[ 517]= 27; IRLcoordszIRL[ 517]= 0
IRLcoordsx[ 518]= 35; IRLcoordsy[ 518]= 22; IRLcoordsxIRL[ 518]=-9; IRLcoordsyIRL[ 518]= 26; IRLcoordszIRL[ 518]= 0
IRLcoordsx[ 519]= 35; IRLcoordsy[ 519]= 23; IRLcoordsxIRL[ 519]=-9; IRLcoordsyIRL[ 519]= 25; IRLcoordszIRL[ 519]= 0
IRLcoordsx[ 520]= 35; IRLcoordsy[ 520]= 24; IRLcoordsxIRL[ 520]=-9; IRLcoordsyIRL[ 520]= 24; IRLcoordszIRL[ 520]= 0
IRLcoordsx[ 521]= 35; IRLcoordsy[ 521]= 25; IRLcoordsxIRL[ 521]=-9; IRLcoordsyIRL[ 521]= 23; IRLcoordszIRL[ 521]= 0
IRLcoordsx[ 522]= 35; IRLcoordsy[ 522]= 26; IRLcoordsxIRL[ 522]=-9; IRLcoordsyIRL[ 522]= 22; IRLcoordszIRL[ 522]= 0
IRLcoordsx[ 523]= 35; IRLcoordsy[ 523]= 27; IRLcoordsxIRL[ 523]=-9; IRLcoordsyIRL[ 523]= 21; IRLcoordszIRL[ 523]= 0
IRLcoordsx[ 524]= 35; IRLcoordsy[ 524]= 28; IRLcoordsxIRL[ 524]=-9; IRLcoordsyIRL[ 524]= 20; IRLcoordszIRL[ 524]= 0
IRLcoordsx[ 525]= 35; IRLcoordsy[ 525]= 29; IRLcoordsxIRL[ 525]=-9; IRLcoordsyIRL[ 525]= 19; IRLcoordszIRL[ 525]= 0
IRLcoordsx[ 526]= 35; IRLcoordsy[ 526]= 30; IRLcoordsxIRL[ 526]=-9; IRLcoordsyIRL[ 526]= 18; IRLcoordszIRL[ 526]= 0
IRLcoordsx[ 527]= 35; IRLcoordsy[ 527]= 31; IRLcoordsxIRL[ 527]=-9; IRLcoordsyIRL[ 527]= 17; IRLcoordszIRL[ 527]= 0
IRLcoordsx[ 528]= 36; IRLcoordsy[ 528]= 20; IRLcoordsxIRL[ 528]=-10; IRLcoordsyIRL[ 528]= 28; IRLcoordszIRL[ 528]= 0
IRLcoordsx[ 529]= 36; IRLcoordsy[ 529]= 21; IRLcoordsxIRL[ 529]=-10; IRLcoordsyIRL[ 529]= 27; IRLcoordszIRL[ 529]= 0
IRLcoordsx[ 530]= 36; IRLcoordsy[ 530]= 22; IRLcoordsxIRL[ 530]=-10; IRLcoordsyIRL[ 530]= 26; IRLcoordszIRL[ 530]= 0
IRLcoordsx[ 531]= 36; IRLcoordsy[ 531]= 23; IRLcoordsxIRL[ 531]=-10; IRLcoordsyIRL[ 531]= 25; IRLcoordszIRL[ 531]= 0
IRLcoordsx[ 532]= 36; IRLcoordsy[ 532]= 24; IRLcoordsxIRL[ 532]=-10; IRLcoordsyIRL[ 532]= 24; IRLcoordszIRL[ 532]= 0
IRLcoordsx[ 533]= 36; IRLcoordsy[ 533]= 25; IRLcoordsxIRL[ 533]=-10; IRLcoordsyIRL[ 533]= 23; IRLcoordszIRL[ 533]= 0
IRLcoordsx[ 534]= 36; IRLcoordsy[ 534]= 26; IRLcoordsxIRL[ 534]=-10; IRLcoordsyIRL[ 534]= 22; IRLcoordszIRL[ 534]= 0
IRLcoordsx[ 535]= 36; IRLcoordsy[ 535]= 27; IRLcoordsxIRL[ 535]=-10; IRLcoordsyIRL[ 535]= 21; IRLcoordszIRL[ 535]= 0
IRLcoordsx[ 536]= 36; IRLcoordsy[ 536]= 28; IRLcoordsxIRL[ 536]=-10; IRLcoordsyIRL[ 536]= 20; IRLcoordszIRL[ 536]= 0
IRLcoordsx[ 537]= 36; IRLcoordsy[ 537]= 29; IRLcoordsxIRL[ 537]=-10; IRLcoordsyIRL[ 537]= 19; IRLcoordszIRL[ 537]= 0
IRLcoordsx[ 538]= 36; IRLcoordsy[ 538]= 30; IRLcoordsxIRL[ 538]=-10; IRLcoordsyIRL[ 538]= 18; IRLcoordszIRL[ 538]= 0
IRLcoordsx[ 539]= 36; IRLcoordsy[ 539]= 31; IRLcoordsxIRL[ 539]=-10; IRLcoordsyIRL[ 539]= 17; IRLcoordszIRL[ 539]= 0
IRLcoordsx[ 540]= 37; IRLcoordsy[ 540]= 20; IRLcoordsxIRL[ 540]=-11; IRLcoordsyIRL[ 540]= 28; IRLcoordszIRL[ 540]= 0
IRLcoordsx[ 541]= 37; IRLcoordsy[ 541]= 21; IRLcoordsxIRL[ 541]=-11; IRLcoordsyIRL[ 541]= 27; IRLcoordszIRL[ 541]= 0
IRLcoordsx[ 542]= 37; IRLcoordsy[ 542]= 22; IRLcoordsxIRL[ 542]=-11; IRLcoordsyIRL[ 542]= 26; IRLcoordszIRL[ 542]= 0
IRLcoordsx[ 543]= 37; IRLcoordsy[ 543]= 23; IRLcoordsxIRL[ 543]=-11; IRLcoordsyIRL[ 543]= 25; IRLcoordszIRL[ 543]= 0
IRLcoordsx[ 544]= 37; IRLcoordsy[ 544]= 24; IRLcoordsxIRL[ 544]=-11; IRLcoordsyIRL[ 544]= 24; IRLcoordszIRL[ 544]= 0
IRLcoordsx[ 545]= 37; IRLcoordsy[ 545]= 25; IRLcoordsxIRL[ 545]=-11; IRLcoordsyIRL[ 545]= 23; IRLcoordszIRL[ 545]= 0
IRLcoordsx[ 546]= 37; IRLcoordsy[ 546]= 26; IRLcoordsxIRL[ 546]=-11; IRLcoordsyIRL[ 546]= 22; IRLcoordszIRL[ 546]= 0
IRLcoordsx[ 547]= 37; IRLcoordsy[ 547]= 27; IRLcoordsxIRL[ 547]=-11; IRLcoordsyIRL[ 547]= 21; IRLcoordszIRL[ 547]= 0
IRLcoordsx[ 548]= 37; IRLcoordsy[ 548]= 28; IRLcoordsxIRL[ 548]=-11; IRLcoordsyIRL[ 548]= 20; IRLcoordszIRL[ 548]= 0
IRLcoordsx[ 549]= 37; IRLcoordsy[ 549]= 29; IRLcoordsxIRL[ 549]=-11; IRLcoordsyIRL[ 549]= 19; IRLcoordszIRL[ 549]= 0
IRLcoordsx[ 550]= 37; IRLcoordsy[ 550]= 30; IRLcoordsxIRL[ 550]=-11; IRLcoordsyIRL[ 550]= 18; IRLcoordszIRL[ 550]= 0
IRLcoordsx[ 551]= 37; IRLcoordsy[ 551]= 31; IRLcoordsxIRL[ 551]=-11; IRLcoordsyIRL[ 551]= 17; IRLcoordszIRL[ 551]= 0
IRLcoordsx[ 552]= 38; IRLcoordsy[ 552]= 20; IRLcoordsxIRL[ 552]=-12; IRLcoordsyIRL[ 552]= 28; IRLcoordszIRL[ 552]= 0
IRLcoordsx[ 553]= 38; IRLcoordsy[ 553]= 21; IRLcoordsxIRL[ 553]=-12; IRLcoordsyIRL[ 553]= 27; IRLcoordszIRL[ 553]= 0
IRLcoordsx[ 554]= 38; IRLcoordsy[ 554]= 22; IRLcoordsxIRL[ 554]=-12; IRLcoordsyIRL[ 554]= 26; IRLcoordszIRL[ 554]= 0
IRLcoordsx[ 555]= 38; IRLcoordsy[ 555]= 23; IRLcoordsxIRL[ 555]=-12; IRLcoordsyIRL[ 555]= 25; IRLcoordszIRL[ 555]= 0
IRLcoordsx[ 556]= 38; IRLcoordsy[ 556]= 24; IRLcoordsxIRL[ 556]=-12; IRLcoordsyIRL[ 556]= 24; IRLcoordszIRL[ 556]= 0
IRLcoordsx[ 557]= 38; IRLcoordsy[ 557]= 25; IRLcoordsxIRL[ 557]=-12; IRLcoordsyIRL[ 557]= 23; IRLcoordszIRL[ 557]= 0
IRLcoordsx[ 558]= 38; IRLcoordsy[ 558]= 26; IRLcoordsxIRL[ 558]=-12; IRLcoordsyIRL[ 558]= 22; IRLcoordszIRL[ 558]= 0
IRLcoordsx[ 559]= 38; IRLcoordsy[ 559]= 27; IRLcoordsxIRL[ 559]=-12; IRLcoordsyIRL[ 559]= 21; IRLcoordszIRL[ 559]= 0
IRLcoordsx[ 560]= 38; IRLcoordsy[ 560]= 28; IRLcoordsxIRL[ 560]=-12; IRLcoordsyIRL[ 560]= 20; IRLcoordszIRL[ 560]= 0
IRLcoordsx[ 561]= 38; IRLcoordsy[ 561]= 29; IRLcoordsxIRL[ 561]=-12; IRLcoordsyIRL[ 561]= 19; IRLcoordszIRL[ 561]= 0
IRLcoordsx[ 562]= 38; IRLcoordsy[ 562]= 30; IRLcoordsxIRL[ 562]=-12; IRLcoordsyIRL[ 562]= 18; IRLcoordszIRL[ 562]= 0
IRLcoordsx[ 563]= 38; IRLcoordsy[ 563]= 31; IRLcoordsxIRL[ 563]=-12; IRLcoordsyIRL[ 563]= 17; IRLcoordszIRL[ 563]= 0
IRLcoordsx[ 564]= 39; IRLcoordsy[ 564]= 20; IRLcoordsxIRL[ 564]=-13; IRLcoordsyIRL[ 564]= 28; IRLcoordszIRL[ 564]= 0
IRLcoordsx[ 565]= 39; IRLcoordsy[ 565]= 21; IRLcoordsxIRL[ 565]=-13; IRLcoordsyIRL[ 565]= 27; IRLcoordszIRL[ 565]= 0
IRLcoordsx[ 566]= 39; IRLcoordsy[ 566]= 22; IRLcoordsxIRL[ 566]=-13; IRLcoordsyIRL[ 566]= 26; IRLcoordszIRL[ 566]= 0
IRLcoordsx[ 567]= 39; IRLcoordsy[ 567]= 23; IRLcoordsxIRL[ 567]=-13; IRLcoordsyIRL[ 567]= 25; IRLcoordszIRL[ 567]= 0
IRLcoordsx[ 568]= 39; IRLcoordsy[ 568]= 24; IRLcoordsxIRL[ 568]=-13; IRLcoordsyIRL[ 568]= 24; IRLcoordszIRL[ 568]= 0
IRLcoordsx[ 569]= 39; IRLcoordsy[ 569]= 25; IRLcoordsxIRL[ 569]=-13; IRLcoordsyIRL[ 569]= 23; IRLcoordszIRL[ 569]= 0
IRLcoordsx[ 570]= 39; IRLcoordsy[ 570]= 26; IRLcoordsxIRL[ 570]=-13; IRLcoordsyIRL[ 570]= 22; IRLcoordszIRL[ 570]= 0
IRLcoordsx[ 571]= 39; IRLcoordsy[ 571]= 27; IRLcoordsxIRL[ 571]=-13; IRLcoordsyIRL[ 571]= 21; IRLcoordszIRL[ 571]= 0
IRLcoordsx[ 572]= 39; IRLcoordsy[ 572]= 28; IRLcoordsxIRL[ 572]=-13; IRLcoordsyIRL[ 572]= 20; IRLcoordszIRL[ 572]= 0
IRLcoordsx[ 573]= 39; IRLcoordsy[ 573]= 29; IRLcoordsxIRL[ 573]=-13; IRLcoordsyIRL[ 573]= 19; IRLcoordszIRL[ 573]= 0
IRLcoordsx[ 574]= 39; IRLcoordsy[ 574]= 30; IRLcoordsxIRL[ 574]=-13; IRLcoordsyIRL[ 574]= 18; IRLcoordszIRL[ 574]= 0
IRLcoordsx[ 575]= 39; IRLcoordsy[ 575]= 31; IRLcoordsxIRL[ 575]=-13; IRLcoordsyIRL[ 575]= 17; IRLcoordszIRL[ 575]= 0
IRLcoordsx[ 576]= 16; IRLcoordsy[ 576]= 20; IRLcoordsxIRL[ 576]=-14; IRLcoordsyIRL[ 576]= 28; IRLcoordszIRL[ 576]= 1
IRLcoordsx[ 577]= 16; IRLcoordsy[ 577]= 21; IRLcoordsxIRL[ 577]=-14; IRLcoordsyIRL[ 577]= 27; IRLcoordszIRL[ 577]= 1
IRLcoordsx[ 578]= 16; IRLcoordsy[ 578]= 22; IRLcoordsxIRL[ 578]=-14; IRLcoordsyIRL[ 578]= 26; IRLcoordszIRL[ 578]= 1
IRLcoordsx[ 579]= 16; IRLcoordsy[ 579]= 23; IRLcoordsxIRL[ 579]=-14; IRLcoordsyIRL[ 579]= 25; IRLcoordszIRL[ 579]= 1
IRLcoordsx[ 580]= 16; IRLcoordsy[ 580]= 24; IRLcoordsxIRL[ 580]=-14; IRLcoordsyIRL[ 580]= 24; IRLcoordszIRL[ 580]= 1
IRLcoordsx[ 581]= 16; IRLcoordsy[ 581]= 25; IRLcoordsxIRL[ 581]=-14; IRLcoordsyIRL[ 581]= 23; IRLcoordszIRL[ 581]= 1
IRLcoordsx[ 582]= 16; IRLcoordsy[ 582]= 26; IRLcoordsxIRL[ 582]=-14; IRLcoordsyIRL[ 582]= 22; IRLcoordszIRL[ 582]= 1
IRLcoordsx[ 583]= 16; IRLcoordsy[ 583]= 27; IRLcoordsxIRL[ 583]=-14; IRLcoordsyIRL[ 583]= 21; IRLcoordszIRL[ 583]= 1
IRLcoordsx[ 584]= 16; IRLcoordsy[ 584]= 28; IRLcoordsxIRL[ 584]=-14; IRLcoordsyIRL[ 584]= 20; IRLcoordszIRL[ 584]= 1
IRLcoordsx[ 585]= 16; IRLcoordsy[ 585]= 29; IRLcoordsxIRL[ 585]=-14; IRLcoordsyIRL[ 585]= 19; IRLcoordszIRL[ 585]= 1
IRLcoordsx[ 586]= 16; IRLcoordsy[ 586]= 30; IRLcoordsxIRL[ 586]=-14; IRLcoordsyIRL[ 586]= 18; IRLcoordszIRL[ 586]= 1
IRLcoordsx[ 587]= 16; IRLcoordsy[ 587]= 31; IRLcoordsxIRL[ 587]=-14; IRLcoordsyIRL[ 587]= 17; IRLcoordszIRL[ 587]= 1
IRLcoordsx[ 588]= 17; IRLcoordsy[ 588]= 20; IRLcoordsxIRL[ 588]=-14; IRLcoordsyIRL[ 588]= 28; IRLcoordszIRL[ 588]= 2
IRLcoordsx[ 589]= 17; IRLcoordsy[ 589]= 21; IRLcoordsxIRL[ 589]=-14; IRLcoordsyIRL[ 589]= 27; IRLcoordszIRL[ 589]= 2
IRLcoordsx[ 590]= 17; IRLcoordsy[ 590]= 22; IRLcoordsxIRL[ 590]=-14; IRLcoordsyIRL[ 590]= 26; IRLcoordszIRL[ 590]= 2
IRLcoordsx[ 591]= 17; IRLcoordsy[ 591]= 23; IRLcoordsxIRL[ 591]=-14; IRLcoordsyIRL[ 591]= 25; IRLcoordszIRL[ 591]= 2
IRLcoordsx[ 592]= 17; IRLcoordsy[ 592]= 24; IRLcoordsxIRL[ 592]=-14; IRLcoordsyIRL[ 592]= 24; IRLcoordszIRL[ 592]= 2
IRLcoordsx[ 593]= 17; IRLcoordsy[ 593]= 25; IRLcoordsxIRL[ 593]=-14; IRLcoordsyIRL[ 593]= 23; IRLcoordszIRL[ 593]= 2
IRLcoordsx[ 594]= 17; IRLcoordsy[ 594]= 26; IRLcoordsxIRL[ 594]=-14; IRLcoordsyIRL[ 594]= 22; IRLcoordszIRL[ 594]= 2
IRLcoordsx[ 595]= 17; IRLcoordsy[ 595]= 27; IRLcoordsxIRL[ 595]=-14; IRLcoordsyIRL[ 595]= 21; IRLcoordszIRL[ 595]= 2
IRLcoordsx[ 596]= 17; IRLcoordsy[ 596]= 28; IRLcoordsxIRL[ 596]=-14; IRLcoordsyIRL[ 596]= 20; IRLcoordszIRL[ 596]= 2
IRLcoordsx[ 597]= 17; IRLcoordsy[ 597]= 29; IRLcoordsxIRL[ 597]=-14; IRLcoordsyIRL[ 597]= 19; IRLcoordszIRL[ 597]= 2
IRLcoordsx[ 598]= 17; IRLcoordsy[ 598]= 30; IRLcoordsxIRL[ 598]=-14; IRLcoordsyIRL[ 598]= 18; IRLcoordszIRL[ 598]= 2
IRLcoordsx[ 599]= 17; IRLcoordsy[ 599]= 31; IRLcoordsxIRL[ 599]=-14; IRLcoordsyIRL[ 599]= 17; IRLcoordszIRL[ 599]= 2
IRLcoordsx[ 600]= 18; IRLcoordsy[ 600]= 20; IRLcoordsxIRL[ 600]=-14; IRLcoordsyIRL[ 600]= 28; IRLcoordszIRL[ 600]= 3
IRLcoordsx[ 601]= 18; IRLcoordsy[ 601]= 21; IRLcoordsxIRL[ 601]=-14; IRLcoordsyIRL[ 601]= 27; IRLcoordszIRL[ 601]= 3
IRLcoordsx[ 602]= 18; IRLcoordsy[ 602]= 22; IRLcoordsxIRL[ 602]=-14; IRLcoordsyIRL[ 602]= 26; IRLcoordszIRL[ 602]= 3
IRLcoordsx[ 603]= 18; IRLcoordsy[ 603]= 23; IRLcoordsxIRL[ 603]=-14; IRLcoordsyIRL[ 603]= 25; IRLcoordszIRL[ 603]= 3
IRLcoordsx[ 604]= 18; IRLcoordsy[ 604]= 24; IRLcoordsxIRL[ 604]=-14; IRLcoordsyIRL[ 604]= 24; IRLcoordszIRL[ 604]= 3
IRLcoordsx[ 605]= 18; IRLcoordsy[ 605]= 25; IRLcoordsxIRL[ 605]=-14; IRLcoordsyIRL[ 605]= 23; IRLcoordszIRL[ 605]= 3
IRLcoordsx[ 606]= 18; IRLcoordsy[ 606]= 26; IRLcoordsxIRL[ 606]=-14; IRLcoordsyIRL[ 606]= 22; IRLcoordszIRL[ 606]= 3
IRLcoordsx[ 607]= 18; IRLcoordsy[ 607]= 27; IRLcoordsxIRL[ 607]=-14; IRLcoordsyIRL[ 607]= 21; IRLcoordszIRL[ 607]= 3
IRLcoordsx[ 608]= 18; IRLcoordsy[ 608]= 28; IRLcoordsxIRL[ 608]=-14; IRLcoordsyIRL[ 608]= 20; IRLcoordszIRL[ 608]= 3
IRLcoordsx[ 609]= 18; IRLcoordsy[ 609]= 29; IRLcoordsxIRL[ 609]=-14; IRLcoordsyIRL[ 609]= 19; IRLcoordszIRL[ 609]= 3
IRLcoordsx[ 610]= 18; IRLcoordsy[ 610]= 30; IRLcoordsxIRL[ 610]=-14; IRLcoordsyIRL[ 610]= 18; IRLcoordszIRL[ 610]= 3
IRLcoordsx[ 611]= 18; IRLcoordsy[ 611]= 31; IRLcoordsxIRL[ 611]=-14; IRLcoordsyIRL[ 611]= 17; IRLcoordszIRL[ 611]= 3
IRLcoordsx[ 612]= 19; IRLcoordsy[ 612]= 20; IRLcoordsxIRL[ 612]=-14; IRLcoordsyIRL[ 612]= 28; IRLcoordszIRL[ 612]= 4
IRLcoordsx[ 613]= 19; IRLcoordsy[ 613]= 21; IRLcoordsxIRL[ 613]=-14; IRLcoordsyIRL[ 613]= 27; IRLcoordszIRL[ 613]= 4
IRLcoordsx[ 614]= 19; IRLcoordsy[ 614]= 22; IRLcoordsxIRL[ 614]=-14; IRLcoordsyIRL[ 614]= 26; IRLcoordszIRL[ 614]= 4
IRLcoordsx[ 615]= 19; IRLcoordsy[ 615]= 23; IRLcoordsxIRL[ 615]=-14; IRLcoordsyIRL[ 615]= 25; IRLcoordszIRL[ 615]= 4
IRLcoordsx[ 616]= 19; IRLcoordsy[ 616]= 24; IRLcoordsxIRL[ 616]=-14; IRLcoordsyIRL[ 616]= 24; IRLcoordszIRL[ 616]= 4
IRLcoordsx[ 617]= 19; IRLcoordsy[ 617]= 25; IRLcoordsxIRL[ 617]=-14; IRLcoordsyIRL[ 617]= 23; IRLcoordszIRL[ 617]= 4
IRLcoordsx[ 618]= 19; IRLcoordsy[ 618]= 26; IRLcoordsxIRL[ 618]=-14; IRLcoordsyIRL[ 618]= 22; IRLcoordszIRL[ 618]= 4
IRLcoordsx[ 619]= 19; IRLcoordsy[ 619]= 27; IRLcoordsxIRL[ 619]=-14; IRLcoordsyIRL[ 619]= 21; IRLcoordszIRL[ 619]= 4
IRLcoordsx[ 620]= 19; IRLcoordsy[ 620]= 28; IRLcoordsxIRL[ 620]=-14; IRLcoordsyIRL[ 620]= 20; IRLcoordszIRL[ 620]= 4
IRLcoordsx[ 621]= 19; IRLcoordsy[ 621]= 29; IRLcoordsxIRL[ 621]=-14; IRLcoordsyIRL[ 621]= 19; IRLcoordszIRL[ 621]= 4
IRLcoordsx[ 622]= 19; IRLcoordsy[ 622]= 30; IRLcoordsxIRL[ 622]=-14; IRLcoordsyIRL[ 622]= 18; IRLcoordszIRL[ 622]= 4
IRLcoordsx[ 623]= 19; IRLcoordsy[ 623]= 31; IRLcoordsxIRL[ 623]=-14; IRLcoordsyIRL[ 623]= 17; IRLcoordszIRL[ 623]= 4
IRLcoordsx[ 624]= 28; IRLcoordsy[ 624]= 20; IRLcoordsxIRL[ 624]=-5; IRLcoordsyIRL[ 624]= 28; IRLcoordszIRL[ 624]= 4
IRLcoordsx[ 625]= 28; IRLcoordsy[ 625]= 21; IRLcoordsxIRL[ 625]=-5; IRLcoordsyIRL[ 625]= 27; IRLcoordszIRL[ 625]= 4
IRLcoordsx[ 626]= 28; IRLcoordsy[ 626]= 22; IRLcoordsxIRL[ 626]=-5; IRLcoordsyIRL[ 626]= 26; IRLcoordszIRL[ 626]= 4
IRLcoordsx[ 627]= 28; IRLcoordsy[ 627]= 23; IRLcoordsxIRL[ 627]=-5; IRLcoordsyIRL[ 627]= 25; IRLcoordszIRL[ 627]= 4
IRLcoordsx[ 628]= 28; IRLcoordsy[ 628]= 24; IRLcoordsxIRL[ 628]=-5; IRLcoordsyIRL[ 628]= 24; IRLcoordszIRL[ 628]= 4
IRLcoordsx[ 629]= 28; IRLcoordsy[ 629]= 25; IRLcoordsxIRL[ 629]=-5; IRLcoordsyIRL[ 629]= 23; IRLcoordszIRL[ 629]= 4
IRLcoordsx[ 630]= 28; IRLcoordsy[ 630]= 26; IRLcoordsxIRL[ 630]=-5; IRLcoordsyIRL[ 630]= 22; IRLcoordszIRL[ 630]= 4
IRLcoordsx[ 631]= 28; IRLcoordsy[ 631]= 27; IRLcoordsxIRL[ 631]=-5; IRLcoordsyIRL[ 631]= 21; IRLcoordszIRL[ 631]= 4
IRLcoordsx[ 632]= 28; IRLcoordsy[ 632]= 28; IRLcoordsxIRL[ 632]=-5; IRLcoordsyIRL[ 632]= 20; IRLcoordszIRL[ 632]= 4
IRLcoordsx[ 633]= 28; IRLcoordsy[ 633]= 29; IRLcoordsxIRL[ 633]=-5; IRLcoordsyIRL[ 633]= 19; IRLcoordszIRL[ 633]= 4
IRLcoordsx[ 634]= 28; IRLcoordsy[ 634]= 30; IRLcoordsxIRL[ 634]=-5; IRLcoordsyIRL[ 634]= 18; IRLcoordszIRL[ 634]= 4
IRLcoordsx[ 635]= 28; IRLcoordsy[ 635]= 31; IRLcoordsxIRL[ 635]=-5; IRLcoordsyIRL[ 635]= 17; IRLcoordszIRL[ 635]= 4
IRLcoordsx[ 636]= 29; IRLcoordsy[ 636]= 20; IRLcoordsxIRL[ 636]=-5; IRLcoordsyIRL[ 636]= 28; IRLcoordszIRL[ 636]= 3
IRLcoordsx[ 637]= 29; IRLcoordsy[ 637]= 21; IRLcoordsxIRL[ 637]=-5; IRLcoordsyIRL[ 637]= 27; IRLcoordszIRL[ 637]= 3
IRLcoordsx[ 638]= 29; IRLcoordsy[ 638]= 22; IRLcoordsxIRL[ 638]=-5; IRLcoordsyIRL[ 638]= 26; IRLcoordszIRL[ 638]= 3
IRLcoordsx[ 639]= 29; IRLcoordsy[ 639]= 23; IRLcoordsxIRL[ 639]=-5; IRLcoordsyIRL[ 639]= 25; IRLcoordszIRL[ 639]= 3
IRLcoordsx[ 640]= 29; IRLcoordsy[ 640]= 24; IRLcoordsxIRL[ 640]=-5; IRLcoordsyIRL[ 640]= 24; IRLcoordszIRL[ 640]= 3
IRLcoordsx[ 641]= 29; IRLcoordsy[ 641]= 25; IRLcoordsxIRL[ 641]=-5; IRLcoordsyIRL[ 641]= 23; IRLcoordszIRL[ 641]= 3
IRLcoordsx[ 642]= 29; IRLcoordsy[ 642]= 26; IRLcoordsxIRL[ 642]=-5; IRLcoordsyIRL[ 642]= 22; IRLcoordszIRL[ 642]= 3
IRLcoordsx[ 643]= 29; IRLcoordsy[ 643]= 27; IRLcoordsxIRL[ 643]=-5; IRLcoordsyIRL[ 643]= 21; IRLcoordszIRL[ 643]= 3
IRLcoordsx[ 644]= 29; IRLcoordsy[ 644]= 28; IRLcoordsxIRL[ 644]=-5; IRLcoordsyIRL[ 644]= 20; IRLcoordszIRL[ 644]= 3
IRLcoordsx[ 645]= 29; IRLcoordsy[ 645]= 29; IRLcoordsxIRL[ 645]=-5; IRLcoordsyIRL[ 645]= 19; IRLcoordszIRL[ 645]= 3
IRLcoordsx[ 646]= 29; IRLcoordsy[ 646]= 30; IRLcoordsxIRL[ 646]=-5; IRLcoordsyIRL[ 646]= 18; IRLcoordszIRL[ 646]= 3
IRLcoordsx[ 647]= 29; IRLcoordsy[ 647]= 31; IRLcoordsxIRL[ 647]=-5; IRLcoordsyIRL[ 647]= 17; IRLcoordszIRL[ 647]= 3
IRLcoordsx[ 648]= 30; IRLcoordsy[ 648]= 20; IRLcoordsxIRL[ 648]=-5; IRLcoordsyIRL[ 648]= 28; IRLcoordszIRL[ 648]= 2
IRLcoordsx[ 649]= 30; IRLcoordsy[ 649]= 21; IRLcoordsxIRL[ 649]=-5; IRLcoordsyIRL[ 649]= 27; IRLcoordszIRL[ 649]= 2
IRLcoordsx[ 650]= 30; IRLcoordsy[ 650]= 22; IRLcoordsxIRL[ 650]=-5; IRLcoordsyIRL[ 650]= 26; IRLcoordszIRL[ 650]= 2
IRLcoordsx[ 651]= 30; IRLcoordsy[ 651]= 23; IRLcoordsxIRL[ 651]=-5; IRLcoordsyIRL[ 651]= 25; IRLcoordszIRL[ 651]= 2
IRLcoordsx[ 652]= 30; IRLcoordsy[ 652]= 24; IRLcoordsxIRL[ 652]=-5; IRLcoordsyIRL[ 652]= 24; IRLcoordszIRL[ 652]= 2
IRLcoordsx[ 653]= 30; IRLcoordsy[ 653]= 25; IRLcoordsxIRL[ 653]=-5; IRLcoordsyIRL[ 653]= 23; IRLcoordszIRL[ 653]= 2
IRLcoordsx[ 654]= 30; IRLcoordsy[ 654]= 26; IRLcoordsxIRL[ 654]=-5; IRLcoordsyIRL[ 654]= 22; IRLcoordszIRL[ 654]= 2
IRLcoordsx[ 655]= 30; IRLcoordsy[ 655]= 27; IRLcoordsxIRL[ 655]=-5; IRLcoordsyIRL[ 655]= 21; IRLcoordszIRL[ 655]= 2
IRLcoordsx[ 656]= 30; IRLcoordsy[ 656]= 28; IRLcoordsxIRL[ 656]=-5; IRLcoordsyIRL[ 656]= 20; IRLcoordszIRL[ 656]= 2
IRLcoordsx[ 657]= 30; IRLcoordsy[ 657]= 29; IRLcoordsxIRL[ 657]=-5; IRLcoordsyIRL[ 657]= 19; IRLcoordszIRL[ 657]= 2
IRLcoordsx[ 658]= 30; IRLcoordsy[ 658]= 30; IRLcoordsxIRL[ 658]=-5; IRLcoordsyIRL[ 658]= 18; IRLcoordszIRL[ 658]= 2
IRLcoordsx[ 659]= 30; IRLcoordsy[ 659]= 31; IRLcoordsxIRL[ 659]=-5; IRLcoordsyIRL[ 659]= 17; IRLcoordszIRL[ 659]= 2
IRLcoordsx[ 660]= 31; IRLcoordsy[ 660]= 20; IRLcoordsxIRL[ 660]=-5; IRLcoordsyIRL[ 660]= 28; IRLcoordszIRL[ 660]= 1
IRLcoordsx[ 661]= 31; IRLcoordsy[ 661]= 21; IRLcoordsxIRL[ 661]=-5; IRLcoordsyIRL[ 661]= 27; IRLcoordszIRL[ 661]= 1
IRLcoordsx[ 662]= 31; IRLcoordsy[ 662]= 22; IRLcoordsxIRL[ 662]=-5; IRLcoordsyIRL[ 662]= 26; IRLcoordszIRL[ 662]= 1
IRLcoordsx[ 663]= 31; IRLcoordsy[ 663]= 23; IRLcoordsxIRL[ 663]=-5; IRLcoordsyIRL[ 663]= 25; IRLcoordszIRL[ 663]= 1
IRLcoordsx[ 664]= 31; IRLcoordsy[ 664]= 24; IRLcoordsxIRL[ 664]=-5; IRLcoordsyIRL[ 664]= 24; IRLcoordszIRL[ 664]= 1
IRLcoordsx[ 665]= 31; IRLcoordsy[ 665]= 25; IRLcoordsxIRL[ 665]=-5; IRLcoordsyIRL[ 665]= 23; IRLcoordszIRL[ 665]= 1
IRLcoordsx[ 666]= 31; IRLcoordsy[ 666]= 26; IRLcoordsxIRL[ 666]=-5; IRLcoordsyIRL[ 666]= 22; IRLcoordszIRL[ 666]= 1
IRLcoordsx[ 667]= 31; IRLcoordsy[ 667]= 27; IRLcoordsxIRL[ 667]=-5; IRLcoordsyIRL[ 667]= 21; IRLcoordszIRL[ 667]= 1
IRLcoordsx[ 668]= 31; IRLcoordsy[ 668]= 28; IRLcoordsxIRL[ 668]=-5; IRLcoordsyIRL[ 668]= 20; IRLcoordszIRL[ 668]= 1
IRLcoordsx[ 669]= 31; IRLcoordsy[ 669]= 29; IRLcoordsxIRL[ 669]=-5; IRLcoordsyIRL[ 669]= 19; IRLcoordszIRL[ 669]= 1
IRLcoordsx[ 670]= 31; IRLcoordsy[ 670]= 30; IRLcoordsxIRL[ 670]=-5; IRLcoordsyIRL[ 670]= 18; IRLcoordszIRL[ 670]= 1
IRLcoordsx[ 671]= 31; IRLcoordsy[ 671]= 31; IRLcoordsxIRL[ 671]=-5; IRLcoordsyIRL[ 671]= 17; IRLcoordszIRL[ 671]= 1
IRLcoordsx[ 672]= 20; IRLcoordsy[ 672]= 16; IRLcoordsxIRL[ 672]=-13; IRLcoordsyIRL[ 672]= 29; IRLcoordszIRL[ 672]= 1
IRLcoordsx[ 673]= 20; IRLcoordsy[ 673]= 17; IRLcoordsxIRL[ 673]=-13; IRLcoordsyIRL[ 673]= 29; IRLcoordszIRL[ 673]= 2
IRLcoordsx[ 674]= 20; IRLcoordsy[ 674]= 18; IRLcoordsxIRL[ 674]=-13; IRLcoordsyIRL[ 674]= 29; IRLcoordszIRL[ 674]= 3
IRLcoordsx[ 675]= 20; IRLcoordsy[ 675]= 19; IRLcoordsxIRL[ 675]=-13; IRLcoordsyIRL[ 675]= 29; IRLcoordszIRL[ 675]= 4
IRLcoordsx[ 676]= 21; IRLcoordsy[ 676]= 16; IRLcoordsxIRL[ 676]=-12; IRLcoordsyIRL[ 676]= 29; IRLcoordszIRL[ 676]= 1
IRLcoordsx[ 677]= 21; IRLcoordsy[ 677]= 17; IRLcoordsxIRL[ 677]=-12; IRLcoordsyIRL[ 677]= 29; IRLcoordszIRL[ 677]= 2
IRLcoordsx[ 678]= 21; IRLcoordsy[ 678]= 18; IRLcoordsxIRL[ 678]=-12; IRLcoordsyIRL[ 678]= 29; IRLcoordszIRL[ 678]= 3
IRLcoordsx[ 679]= 21; IRLcoordsy[ 679]= 19; IRLcoordsxIRL[ 679]=-12; IRLcoordsyIRL[ 679]= 29; IRLcoordszIRL[ 679]= 4
IRLcoordsx[ 680]= 22; IRLcoordsy[ 680]= 16; IRLcoordsxIRL[ 680]=-11; IRLcoordsyIRL[ 680]= 29; IRLcoordszIRL[ 680]= 1
IRLcoordsx[ 681]= 22; IRLcoordsy[ 681]= 17; IRLcoordsxIRL[ 681]=-11; IRLcoordsyIRL[ 681]= 29; IRLcoordszIRL[ 681]= 2
IRLcoordsx[ 682]= 22; IRLcoordsy[ 682]= 18; IRLcoordsxIRL[ 682]=-11; IRLcoordsyIRL[ 682]= 29; IRLcoordszIRL[ 682]= 3
IRLcoordsx[ 683]= 22; IRLcoordsy[ 683]= 19; IRLcoordsxIRL[ 683]=-11; IRLcoordsyIRL[ 683]= 29; IRLcoordszIRL[ 683]= 4
IRLcoordsx[ 684]= 23; IRLcoordsy[ 684]= 16; IRLcoordsxIRL[ 684]=-10; IRLcoordsyIRL[ 684]= 29; IRLcoordszIRL[ 684]= 1
IRLcoordsx[ 685]= 23; IRLcoordsy[ 685]= 17; IRLcoordsxIRL[ 685]=-10; IRLcoordsyIRL[ 685]= 29; IRLcoordszIRL[ 685]= 2
IRLcoordsx[ 686]= 23; IRLcoordsy[ 686]= 18; IRLcoordsxIRL[ 686]=-10; IRLcoordsyIRL[ 686]= 29; IRLcoordszIRL[ 686]= 3
IRLcoordsx[ 687]= 23; IRLcoordsy[ 687]= 19; IRLcoordsxIRL[ 687]=-10; IRLcoordsyIRL[ 687]= 29; IRLcoordszIRL[ 687]= 4
IRLcoordsx[ 688]= 24; IRLcoordsy[ 688]= 16; IRLcoordsxIRL[ 688]=-9; IRLcoordsyIRL[ 688]= 29; IRLcoordszIRL[ 688]= 1
IRLcoordsx[ 689]= 24; IRLcoordsy[ 689]= 17; IRLcoordsxIRL[ 689]=-9; IRLcoordsyIRL[ 689]= 29; IRLcoordszIRL[ 689]= 2
IRLcoordsx[ 690]= 24; IRLcoordsy[ 690]= 18; IRLcoordsxIRL[ 690]=-9; IRLcoordsyIRL[ 690]= 29; IRLcoordszIRL[ 690]= 3
IRLcoordsx[ 691]= 24; IRLcoordsy[ 691]= 19; IRLcoordsxIRL[ 691]=-9; IRLcoordsyIRL[ 691]= 29; IRLcoordszIRL[ 691]= 4
IRLcoordsx[ 692]= 25; IRLcoordsy[ 692]= 16; IRLcoordsxIRL[ 692]=-8; IRLcoordsyIRL[ 692]= 29; IRLcoordszIRL[ 692]= 1
IRLcoordsx[ 693]= 25; IRLcoordsy[ 693]= 17; IRLcoordsxIRL[ 693]=-8; IRLcoordsyIRL[ 693]= 29; IRLcoordszIRL[ 693]= 2
IRLcoordsx[ 694]= 25; IRLcoordsy[ 694]= 18; IRLcoordsxIRL[ 694]=-8; IRLcoordsyIRL[ 694]= 29; IRLcoordszIRL[ 694]= 3
IRLcoordsx[ 695]= 25; IRLcoordsy[ 695]= 19; IRLcoordsxIRL[ 695]=-8; IRLcoordsyIRL[ 695]= 29; IRLcoordszIRL[ 695]= 4
IRLcoordsx[ 696]= 26; IRLcoordsy[ 696]= 16; IRLcoordsxIRL[ 696]=-7; IRLcoordsyIRL[ 696]= 29; IRLcoordszIRL[ 696]= 1
IRLcoordsx[ 697]= 26; IRLcoordsy[ 697]= 17; IRLcoordsxIRL[ 697]=-7; IRLcoordsyIRL[ 697]= 29; IRLcoordszIRL[ 697]= 2
IRLcoordsx[ 698]= 26; IRLcoordsy[ 698]= 18; IRLcoordsxIRL[ 698]=-7; IRLcoordsyIRL[ 698]= 29; IRLcoordszIRL[ 698]= 3
IRLcoordsx[ 699]= 26; IRLcoordsy[ 699]= 19; IRLcoordsxIRL[ 699]=-7; IRLcoordsyIRL[ 699]= 29; IRLcoordszIRL[ 699]= 4
IRLcoordsx[ 700]= 27; IRLcoordsy[ 700]= 16; IRLcoordsxIRL[ 700]=-6; IRLcoordsyIRL[ 700]= 29; IRLcoordszIRL[ 700]= 1
IRLcoordsx[ 701]= 27; IRLcoordsy[ 701]= 17; IRLcoordsxIRL[ 701]=-6; IRLcoordsyIRL[ 701]= 29; IRLcoordszIRL[ 701]= 2
IRLcoordsx[ 702]= 27; IRLcoordsy[ 702]= 18; IRLcoordsxIRL[ 702]=-6; IRLcoordsyIRL[ 702]= 29; IRLcoordszIRL[ 702]= 3
IRLcoordsx[ 703]= 27; IRLcoordsy[ 703]= 19; IRLcoordsxIRL[ 703]=-6; IRLcoordsyIRL[ 703]= 29; IRLcoordszIRL[ 703]= 4
IRLcoordsx[ 704]= 28; IRLcoordsy[ 704]= 16; IRLcoordsxIRL[ 704]=-13; IRLcoordsyIRL[ 704]= 16; IRLcoordszIRL[ 704]= 1
IRLcoordsx[ 705]= 28; IRLcoordsy[ 705]= 17; IRLcoordsxIRL[ 705]=-13; IRLcoordsyIRL[ 705]= 16; IRLcoordszIRL[ 705]= 2
IRLcoordsx[ 706]= 28; IRLcoordsy[ 706]= 18; IRLcoordsxIRL[ 706]=-13; IRLcoordsyIRL[ 706]= 16; IRLcoordszIRL[ 706]= 3
IRLcoordsx[ 707]= 28; IRLcoordsy[ 707]= 19; IRLcoordsxIRL[ 707]=-13; IRLcoordsyIRL[ 707]= 16; IRLcoordszIRL[ 707]= 4
IRLcoordsx[ 708]= 29; IRLcoordsy[ 708]= 16; IRLcoordsxIRL[ 708]=-12; IRLcoordsyIRL[ 708]= 16; IRLcoordszIRL[ 708]= 1
IRLcoordsx[ 709]= 29; IRLcoordsy[ 709]= 17; IRLcoordsxIRL[ 709]=-12; IRLcoordsyIRL[ 709]= 16; IRLcoordszIRL[ 709]= 2
IRLcoordsx[ 710]= 29; IRLcoordsy[ 710]= 18; IRLcoordsxIRL[ 710]=-12; IRLcoordsyIRL[ 710]= 16; IRLcoordszIRL[ 710]= 3
IRLcoordsx[ 711]= 29; IRLcoordsy[ 711]= 19; IRLcoordsxIRL[ 711]=-12; IRLcoordsyIRL[ 711]= 16; IRLcoordszIRL[ 711]= 4
IRLcoordsx[ 712]= 30; IRLcoordsy[ 712]= 16; IRLcoordsxIRL[ 712]=-11; IRLcoordsyIRL[ 712]= 16; IRLcoordszIRL[ 712]= 1
IRLcoordsx[ 713]= 30; IRLcoordsy[ 713]= 17; IRLcoordsxIRL[ 713]=-11; IRLcoordsyIRL[ 713]= 16; IRLcoordszIRL[ 713]= 2
IRLcoordsx[ 714]= 30; IRLcoordsy[ 714]= 18; IRLcoordsxIRL[ 714]=-11; IRLcoordsyIRL[ 714]= 16; IRLcoordszIRL[ 714]= 3
IRLcoordsx[ 715]= 30; IRLcoordsy[ 715]= 19; IRLcoordsxIRL[ 715]=-11; IRLcoordsyIRL[ 715]= 16; IRLcoordszIRL[ 715]= 4
IRLcoordsx[ 716]= 31; IRLcoordsy[ 716]= 16; IRLcoordsxIRL[ 716]=-10; IRLcoordsyIRL[ 716]= 16; IRLcoordszIRL[ 716]= 1
IRLcoordsx[ 717]= 31; IRLcoordsy[ 717]= 17; IRLcoordsxIRL[ 717]=-10; IRLcoordsyIRL[ 717]= 16; IRLcoordszIRL[ 717]= 2
IRLcoordsx[ 718]= 31; IRLcoordsy[ 718]= 18; IRLcoordsxIRL[ 718]=-10; IRLcoordsyIRL[ 718]= 16; IRLcoordszIRL[ 718]= 3
IRLcoordsx[ 719]= 31; IRLcoordsy[ 719]= 19; IRLcoordsxIRL[ 719]=-10; IRLcoordsyIRL[ 719]= 16; IRLcoordszIRL[ 719]= 4
IRLcoordsx[ 720]= 32; IRLcoordsy[ 720]= 16; IRLcoordsxIRL[ 720]=-9; IRLcoordsyIRL[ 720]= 16; IRLcoordszIRL[ 720]= 1
IRLcoordsx[ 721]= 32; IRLcoordsy[ 721]= 17; IRLcoordsxIRL[ 721]=-9; IRLcoordsyIRL[ 721]= 16; IRLcoordszIRL[ 721]= 2
IRLcoordsx[ 722]= 32; IRLcoordsy[ 722]= 18; IRLcoordsxIRL[ 722]=-9; IRLcoordsyIRL[ 722]= 16; IRLcoordszIRL[ 722]= 3
IRLcoordsx[ 723]= 32; IRLcoordsy[ 723]= 19; IRLcoordsxIRL[ 723]=-9; IRLcoordsyIRL[ 723]= 16; IRLcoordszIRL[ 723]= 4
IRLcoordsx[ 724]= 33; IRLcoordsy[ 724]= 16; IRLcoordsxIRL[ 724]=-8; IRLcoordsyIRL[ 724]= 16; IRLcoordszIRL[ 724]= 1
IRLcoordsx[ 725]= 33; IRLcoordsy[ 725]= 17; IRLcoordsxIRL[ 725]=-8; IRLcoordsyIRL[ 725]= 16; IRLcoordszIRL[ 725]= 2
IRLcoordsx[ 726]= 33; IRLcoordsy[ 726]= 18; IRLcoordsxIRL[ 726]=-8; IRLcoordsyIRL[ 726]= 16; IRLcoordszIRL[ 726]= 3
IRLcoordsx[ 727]= 33; IRLcoordsy[ 727]= 19; IRLcoordsxIRL[ 727]=-8; IRLcoordsyIRL[ 727]= 16; IRLcoordszIRL[ 727]= 4
IRLcoordsx[ 728]= 34; IRLcoordsy[ 728]= 16; IRLcoordsxIRL[ 728]=-7; IRLcoordsyIRL[ 728]= 16; IRLcoordszIRL[ 728]= 1
IRLcoordsx[ 729]= 34; IRLcoordsy[ 729]= 17; IRLcoordsxIRL[ 729]=-7; IRLcoordsyIRL[ 729]= 16; IRLcoordszIRL[ 729]= 2
IRLcoordsx[ 730]= 34; IRLcoordsy[ 730]= 18; IRLcoordsxIRL[ 730]=-7; IRLcoordsyIRL[ 730]= 16; IRLcoordszIRL[ 730]= 3
IRLcoordsx[ 731]= 34; IRLcoordsy[ 731]= 19; IRLcoordsxIRL[ 731]=-7; IRLcoordsyIRL[ 731]= 16; IRLcoordszIRL[ 731]= 4
IRLcoordsx[ 732]= 35; IRLcoordsy[ 732]= 16; IRLcoordsxIRL[ 732]=-6; IRLcoordsyIRL[ 732]= 16; IRLcoordszIRL[ 732]= 1
IRLcoordsx[ 733]= 35; IRLcoordsy[ 733]= 17; IRLcoordsxIRL[ 733]=-6; IRLcoordsyIRL[ 733]= 16; IRLcoordszIRL[ 733]= 2
IRLcoordsx[ 734]= 35; IRLcoordsy[ 734]= 18; IRLcoordsxIRL[ 734]=-6; IRLcoordsyIRL[ 734]= 16; IRLcoordszIRL[ 734]= 3
IRLcoordsx[ 735]= 35; IRLcoordsy[ 735]= 19; IRLcoordsxIRL[ 735]=-6; IRLcoordsyIRL[ 735]= 16; IRLcoordszIRL[ 735]= 4
IRLcoordsx[ 736]= 28; IRLcoordsy[ 736]= 52; IRLcoordsxIRL[ 736]=-4; IRLcoordsyIRL[ 736]= 12; IRLcoordszIRL[ 736]=-1
IRLcoordsx[ 737]= 28; IRLcoordsy[ 737]= 53; IRLcoordsxIRL[ 737]=-4; IRLcoordsyIRL[ 737]= 11; IRLcoordszIRL[ 737]=-1
IRLcoordsx[ 738]= 28; IRLcoordsy[ 738]= 54; IRLcoordsxIRL[ 738]=-4; IRLcoordsyIRL[ 738]= 10; IRLcoordszIRL[ 738]=-1
IRLcoordsx[ 739]= 28; IRLcoordsy[ 739]= 55; IRLcoordsxIRL[ 739]=-4; IRLcoordsyIRL[ 739]= 9; IRLcoordszIRL[ 739]=-1
IRLcoordsx[ 740]= 28; IRLcoordsy[ 740]= 56; IRLcoordsxIRL[ 740]=-4; IRLcoordsyIRL[ 740]= 8; IRLcoordszIRL[ 740]=-1
IRLcoordsx[ 741]= 28; IRLcoordsy[ 741]= 57; IRLcoordsxIRL[ 741]=-4; IRLcoordsyIRL[ 741]= 7; IRLcoordszIRL[ 741]=-1
IRLcoordsx[ 742]= 28; IRLcoordsy[ 742]= 58; IRLcoordsxIRL[ 742]=-4; IRLcoordsyIRL[ 742]= 6; IRLcoordszIRL[ 742]=-1
IRLcoordsx[ 743]= 28; IRLcoordsy[ 743]= 59; IRLcoordsxIRL[ 743]=-4; IRLcoordsyIRL[ 743]= 5; IRLcoordszIRL[ 743]=-1
IRLcoordsx[ 744]= 28; IRLcoordsy[ 744]= 60; IRLcoordsxIRL[ 744]=-4; IRLcoordsyIRL[ 744]= 4; IRLcoordszIRL[ 744]=-1
IRLcoordsx[ 745]= 28; IRLcoordsy[ 745]= 61; IRLcoordsxIRL[ 745]=-4; IRLcoordsyIRL[ 745]= 3; IRLcoordszIRL[ 745]=-1
IRLcoordsx[ 746]= 28; IRLcoordsy[ 746]= 62; IRLcoordsxIRL[ 746]=-4; IRLcoordsyIRL[ 746]= 2; IRLcoordszIRL[ 746]=-1
IRLcoordsx[ 747]= 28; IRLcoordsy[ 747]= 63; IRLcoordsxIRL[ 747]=-4; IRLcoordsyIRL[ 747]= 1; IRLcoordszIRL[ 747]=-1
IRLcoordsx[ 748]= 29; IRLcoordsy[ 748]= 52; IRLcoordsxIRL[ 748]=-5; IRLcoordsyIRL[ 748]= 12; IRLcoordszIRL[ 748]=-1
IRLcoordsx[ 749]= 29; IRLcoordsy[ 749]= 53; IRLcoordsxIRL[ 749]=-5; IRLcoordsyIRL[ 749]= 11; IRLcoordszIRL[ 749]=-1
IRLcoordsx[ 750]= 29; IRLcoordsy[ 750]= 54; IRLcoordsxIRL[ 750]=-5; IRLcoordsyIRL[ 750]= 10; IRLcoordszIRL[ 750]=-1
IRLcoordsx[ 751]= 29; IRLcoordsy[ 751]= 55; IRLcoordsxIRL[ 751]=-5; IRLcoordsyIRL[ 751]= 9; IRLcoordszIRL[ 751]=-1
IRLcoordsx[ 752]= 29; IRLcoordsy[ 752]= 56; IRLcoordsxIRL[ 752]=-5; IRLcoordsyIRL[ 752]= 8; IRLcoordszIRL[ 752]=-1
IRLcoordsx[ 753]= 29; IRLcoordsy[ 753]= 57; IRLcoordsxIRL[ 753]=-5; IRLcoordsyIRL[ 753]= 7; IRLcoordszIRL[ 753]=-1
IRLcoordsx[ 754]= 29; IRLcoordsy[ 754]= 58; IRLcoordsxIRL[ 754]=-5; IRLcoordsyIRL[ 754]= 6; IRLcoordszIRL[ 754]=-1
IRLcoordsx[ 755]= 29; IRLcoordsy[ 755]= 59; IRLcoordsxIRL[ 755]=-5; IRLcoordsyIRL[ 755]= 5; IRLcoordszIRL[ 755]=-1
IRLcoordsx[ 756]= 29; IRLcoordsy[ 756]= 60; IRLcoordsxIRL[ 756]=-5; IRLcoordsyIRL[ 756]= 4; IRLcoordszIRL[ 756]=-1
IRLcoordsx[ 757]= 29; IRLcoordsy[ 757]= 61; IRLcoordsxIRL[ 757]=-5; IRLcoordsyIRL[ 757]= 3; IRLcoordszIRL[ 757]=-1
IRLcoordsx[ 758]= 29; IRLcoordsy[ 758]= 62; IRLcoordsxIRL[ 758]=-5; IRLcoordsyIRL[ 758]= 2; IRLcoordszIRL[ 758]=-1
IRLcoordsx[ 759]= 29; IRLcoordsy[ 759]= 63; IRLcoordsxIRL[ 759]=-5; IRLcoordsyIRL[ 759]= 1; IRLcoordszIRL[ 759]=-1
IRLcoordsx[ 760]= 30; IRLcoordsy[ 760]= 52; IRLcoordsxIRL[ 760]=-6; IRLcoordsyIRL[ 760]= 12; IRLcoordszIRL[ 760]=-1
IRLcoordsx[ 761]= 30; IRLcoordsy[ 761]= 53; IRLcoordsxIRL[ 761]=-6; IRLcoordsyIRL[ 761]= 11; IRLcoordszIRL[ 761]=-1
IRLcoordsx[ 762]= 30; IRLcoordsy[ 762]= 54; IRLcoordsxIRL[ 762]=-6; IRLcoordsyIRL[ 762]= 10; IRLcoordszIRL[ 762]=-1
IRLcoordsx[ 763]= 30; IRLcoordsy[ 763]= 55; IRLcoordsxIRL[ 763]=-6; IRLcoordsyIRL[ 763]= 9; IRLcoordszIRL[ 763]=-1
IRLcoordsx[ 764]= 30; IRLcoordsy[ 764]= 56; IRLcoordsxIRL[ 764]=-6; IRLcoordsyIRL[ 764]= 8; IRLcoordszIRL[ 764]=-1
IRLcoordsx[ 765]= 30; IRLcoordsy[ 765]= 57; IRLcoordsxIRL[ 765]=-6; IRLcoordsyIRL[ 765]= 7; IRLcoordszIRL[ 765]=-1
IRLcoordsx[ 766]= 30; IRLcoordsy[ 766]= 58; IRLcoordsxIRL[ 766]=-6; IRLcoordsyIRL[ 766]= 6; IRLcoordszIRL[ 766]=-1
IRLcoordsx[ 767]= 30; IRLcoordsy[ 767]= 59; IRLcoordsxIRL[ 767]=-6; IRLcoordsyIRL[ 767]= 5; IRLcoordszIRL[ 767]=-1
IRLcoordsx[ 768]= 30; IRLcoordsy[ 768]= 60; IRLcoordsxIRL[ 768]=-6; IRLcoordsyIRL[ 768]= 4; IRLcoordszIRL[ 768]=-1
IRLcoordsx[ 769]= 30; IRLcoordsy[ 769]= 61; IRLcoordsxIRL[ 769]=-6; IRLcoordsyIRL[ 769]= 3; IRLcoordszIRL[ 769]=-1
IRLcoordsx[ 770]= 30; IRLcoordsy[ 770]= 62; IRLcoordsxIRL[ 770]=-6; IRLcoordsyIRL[ 770]= 2; IRLcoordszIRL[ 770]=-1
IRLcoordsx[ 771]= 30; IRLcoordsy[ 771]= 63; IRLcoordsxIRL[ 771]=-6; IRLcoordsyIRL[ 771]= 1; IRLcoordszIRL[ 771]=-1
IRLcoordsx[ 772]= 31; IRLcoordsy[ 772]= 52; IRLcoordsxIRL[ 772]=-7; IRLcoordsyIRL[ 772]= 12; IRLcoordszIRL[ 772]=-1
IRLcoordsx[ 773]= 31; IRLcoordsy[ 773]= 53; IRLcoordsxIRL[ 773]=-7; IRLcoordsyIRL[ 773]= 11; IRLcoordszIRL[ 773]=-1
IRLcoordsx[ 774]= 31; IRLcoordsy[ 774]= 54; IRLcoordsxIRL[ 774]=-7; IRLcoordsyIRL[ 774]= 10; IRLcoordszIRL[ 774]=-1
IRLcoordsx[ 775]= 31; IRLcoordsy[ 775]= 55; IRLcoordsxIRL[ 775]=-7; IRLcoordsyIRL[ 775]= 9; IRLcoordszIRL[ 775]=-1
IRLcoordsx[ 776]= 31; IRLcoordsy[ 776]= 56; IRLcoordsxIRL[ 776]=-7; IRLcoordsyIRL[ 776]= 8; IRLcoordszIRL[ 776]=-1
IRLcoordsx[ 777]= 31; IRLcoordsy[ 777]= 57; IRLcoordsxIRL[ 777]=-7; IRLcoordsyIRL[ 777]= 7; IRLcoordszIRL[ 777]=-1
IRLcoordsx[ 778]= 31; IRLcoordsy[ 778]= 58; IRLcoordsxIRL[ 778]=-7; IRLcoordsyIRL[ 778]= 6; IRLcoordszIRL[ 778]=-1
IRLcoordsx[ 779]= 31; IRLcoordsy[ 779]= 59; IRLcoordsxIRL[ 779]=-7; IRLcoordsyIRL[ 779]= 5; IRLcoordszIRL[ 779]=-1
IRLcoordsx[ 780]= 31; IRLcoordsy[ 780]= 60; IRLcoordsxIRL[ 780]=-7; IRLcoordsyIRL[ 780]= 4; IRLcoordszIRL[ 780]=-1
IRLcoordsx[ 781]= 31; IRLcoordsy[ 781]= 61; IRLcoordsxIRL[ 781]=-7; IRLcoordsyIRL[ 781]= 3; IRLcoordszIRL[ 781]=-1
IRLcoordsx[ 782]= 31; IRLcoordsy[ 782]= 62; IRLcoordsxIRL[ 782]=-7; IRLcoordsyIRL[ 782]= 2; IRLcoordszIRL[ 782]=-1
IRLcoordsx[ 783]= 31; IRLcoordsy[ 783]= 63; IRLcoordsxIRL[ 783]=-7; IRLcoordsyIRL[ 783]= 1; IRLcoordszIRL[ 783]=-1
IRLcoordsx[ 784]= 20; IRLcoordsy[ 784]= 52; IRLcoordsxIRL[ 784]=-7; IRLcoordsyIRL[ 784]= 12; IRLcoordszIRL[ 784]= 4
IRLcoordsx[ 785]= 20; IRLcoordsy[ 785]= 53; IRLcoordsxIRL[ 785]=-7; IRLcoordsyIRL[ 785]= 11; IRLcoordszIRL[ 785]= 4
IRLcoordsx[ 786]= 20; IRLcoordsy[ 786]= 54; IRLcoordsxIRL[ 786]=-7; IRLcoordsyIRL[ 786]= 10; IRLcoordszIRL[ 786]= 4
IRLcoordsx[ 787]= 20; IRLcoordsy[ 787]= 55; IRLcoordsxIRL[ 787]=-7; IRLcoordsyIRL[ 787]= 9; IRLcoordszIRL[ 787]= 4
IRLcoordsx[ 788]= 20; IRLcoordsy[ 788]= 56; IRLcoordsxIRL[ 788]=-7; IRLcoordsyIRL[ 788]= 8; IRLcoordszIRL[ 788]= 4
IRLcoordsx[ 789]= 20; IRLcoordsy[ 789]= 57; IRLcoordsxIRL[ 789]=-7; IRLcoordsyIRL[ 789]= 7; IRLcoordszIRL[ 789]= 4
IRLcoordsx[ 790]= 20; IRLcoordsy[ 790]= 58; IRLcoordsxIRL[ 790]=-7; IRLcoordsyIRL[ 790]= 6; IRLcoordszIRL[ 790]= 4
IRLcoordsx[ 791]= 20; IRLcoordsy[ 791]= 59; IRLcoordsxIRL[ 791]=-7; IRLcoordsyIRL[ 791]= 5; IRLcoordszIRL[ 791]= 4
IRLcoordsx[ 792]= 20; IRLcoordsy[ 792]= 60; IRLcoordsxIRL[ 792]=-7; IRLcoordsyIRL[ 792]= 4; IRLcoordszIRL[ 792]= 4
IRLcoordsx[ 793]= 20; IRLcoordsy[ 793]= 61; IRLcoordsxIRL[ 793]=-7; IRLcoordsyIRL[ 793]= 3; IRLcoordszIRL[ 793]= 4
IRLcoordsx[ 794]= 20; IRLcoordsy[ 794]= 62; IRLcoordsxIRL[ 794]=-7; IRLcoordsyIRL[ 794]= 2; IRLcoordszIRL[ 794]= 4
IRLcoordsx[ 795]= 20; IRLcoordsy[ 795]= 63; IRLcoordsxIRL[ 795]=-7; IRLcoordsyIRL[ 795]= 1; IRLcoordszIRL[ 795]= 4
IRLcoordsx[ 796]= 21; IRLcoordsy[ 796]= 52; IRLcoordsxIRL[ 796]=-6; IRLcoordsyIRL[ 796]= 12; IRLcoordszIRL[ 796]= 4
IRLcoordsx[ 797]= 21; IRLcoordsy[ 797]= 53; IRLcoordsxIRL[ 797]=-6; IRLcoordsyIRL[ 797]= 11; IRLcoordszIRL[ 797]= 4
IRLcoordsx[ 798]= 21; IRLcoordsy[ 798]= 54; IRLcoordsxIRL[ 798]=-6; IRLcoordsyIRL[ 798]= 10; IRLcoordszIRL[ 798]= 4
IRLcoordsx[ 799]= 21; IRLcoordsy[ 799]= 55; IRLcoordsxIRL[ 799]=-6; IRLcoordsyIRL[ 799]= 9; IRLcoordszIRL[ 799]= 4
IRLcoordsx[ 800]= 21; IRLcoordsy[ 800]= 56; IRLcoordsxIRL[ 800]=-6; IRLcoordsyIRL[ 800]= 8; IRLcoordszIRL[ 800]= 4
IRLcoordsx[ 801]= 21; IRLcoordsy[ 801]= 57; IRLcoordsxIRL[ 801]=-6; IRLcoordsyIRL[ 801]= 7; IRLcoordszIRL[ 801]= 4
IRLcoordsx[ 802]= 21; IRLcoordsy[ 802]= 58; IRLcoordsxIRL[ 802]=-6; IRLcoordsyIRL[ 802]= 6; IRLcoordszIRL[ 802]= 4
IRLcoordsx[ 803]= 21; IRLcoordsy[ 803]= 59; IRLcoordsxIRL[ 803]=-6; IRLcoordsyIRL[ 803]= 5; IRLcoordszIRL[ 803]= 4
IRLcoordsx[ 804]= 21; IRLcoordsy[ 804]= 60; IRLcoordsxIRL[ 804]=-6; IRLcoordsyIRL[ 804]= 4; IRLcoordszIRL[ 804]= 4
IRLcoordsx[ 805]= 21; IRLcoordsy[ 805]= 61; IRLcoordsxIRL[ 805]=-6; IRLcoordsyIRL[ 805]= 3; IRLcoordszIRL[ 805]= 4
IRLcoordsx[ 806]= 21; IRLcoordsy[ 806]= 62; IRLcoordsxIRL[ 806]=-6; IRLcoordsyIRL[ 806]= 2; IRLcoordszIRL[ 806]= 4
IRLcoordsx[ 807]= 21; IRLcoordsy[ 807]= 63; IRLcoordsxIRL[ 807]=-6; IRLcoordsyIRL[ 807]= 1; IRLcoordszIRL[ 807]= 4
IRLcoordsx[ 808]= 22; IRLcoordsy[ 808]= 52; IRLcoordsxIRL[ 808]=-5; IRLcoordsyIRL[ 808]= 12; IRLcoordszIRL[ 808]= 4
IRLcoordsx[ 809]= 22; IRLcoordsy[ 809]= 53; IRLcoordsxIRL[ 809]=-5; IRLcoordsyIRL[ 809]= 11; IRLcoordszIRL[ 809]= 4
IRLcoordsx[ 810]= 22; IRLcoordsy[ 810]= 54; IRLcoordsxIRL[ 810]=-5; IRLcoordsyIRL[ 810]= 10; IRLcoordszIRL[ 810]= 4
IRLcoordsx[ 811]= 22; IRLcoordsy[ 811]= 55; IRLcoordsxIRL[ 811]=-5; IRLcoordsyIRL[ 811]= 9; IRLcoordszIRL[ 811]= 4
IRLcoordsx[ 812]= 22; IRLcoordsy[ 812]= 56; IRLcoordsxIRL[ 812]=-5; IRLcoordsyIRL[ 812]= 8; IRLcoordszIRL[ 812]= 4
IRLcoordsx[ 813]= 22; IRLcoordsy[ 813]= 57; IRLcoordsxIRL[ 813]=-5; IRLcoordsyIRL[ 813]= 7; IRLcoordszIRL[ 813]= 4
IRLcoordsx[ 814]= 22; IRLcoordsy[ 814]= 58; IRLcoordsxIRL[ 814]=-5; IRLcoordsyIRL[ 814]= 6; IRLcoordszIRL[ 814]= 4
IRLcoordsx[ 815]= 22; IRLcoordsy[ 815]= 59; IRLcoordsxIRL[ 815]=-5; IRLcoordsyIRL[ 815]= 5; IRLcoordszIRL[ 815]= 4
IRLcoordsx[ 816]= 22; IRLcoordsy[ 816]= 60; IRLcoordsxIRL[ 816]=-5; IRLcoordsyIRL[ 816]= 4; IRLcoordszIRL[ 816]= 4
IRLcoordsx[ 817]= 22; IRLcoordsy[ 817]= 61; IRLcoordsxIRL[ 817]=-5; IRLcoordsyIRL[ 817]= 3; IRLcoordszIRL[ 817]= 4
IRLcoordsx[ 818]= 22; IRLcoordsy[ 818]= 62; IRLcoordsxIRL[ 818]=-5; IRLcoordsyIRL[ 818]= 2; IRLcoordszIRL[ 818]= 4
IRLcoordsx[ 819]= 22; IRLcoordsy[ 819]= 63; IRLcoordsxIRL[ 819]=-5; IRLcoordsyIRL[ 819]= 1; IRLcoordszIRL[ 819]= 4
IRLcoordsx[ 820]= 23; IRLcoordsy[ 820]= 52; IRLcoordsxIRL[ 820]=-4; IRLcoordsyIRL[ 820]= 12; IRLcoordszIRL[ 820]= 4
IRLcoordsx[ 821]= 23; IRLcoordsy[ 821]= 53; IRLcoordsxIRL[ 821]=-4; IRLcoordsyIRL[ 821]= 11; IRLcoordszIRL[ 821]= 4
IRLcoordsx[ 822]= 23; IRLcoordsy[ 822]= 54; IRLcoordsxIRL[ 822]=-4; IRLcoordsyIRL[ 822]= 10; IRLcoordszIRL[ 822]= 4
IRLcoordsx[ 823]= 23; IRLcoordsy[ 823]= 55; IRLcoordsxIRL[ 823]=-4; IRLcoordsyIRL[ 823]= 9; IRLcoordszIRL[ 823]= 4
IRLcoordsx[ 824]= 23; IRLcoordsy[ 824]= 56; IRLcoordsxIRL[ 824]=-4; IRLcoordsyIRL[ 824]= 8; IRLcoordszIRL[ 824]= 4
IRLcoordsx[ 825]= 23; IRLcoordsy[ 825]= 57; IRLcoordsxIRL[ 825]=-4; IRLcoordsyIRL[ 825]= 7; IRLcoordszIRL[ 825]= 4
IRLcoordsx[ 826]= 23; IRLcoordsy[ 826]= 58; IRLcoordsxIRL[ 826]=-4; IRLcoordsyIRL[ 826]= 6; IRLcoordszIRL[ 826]= 4
IRLcoordsx[ 827]= 23; IRLcoordsy[ 827]= 59; IRLcoordsxIRL[ 827]=-4; IRLcoordsyIRL[ 827]= 5; IRLcoordszIRL[ 827]= 4
IRLcoordsx[ 828]= 23; IRLcoordsy[ 828]= 60; IRLcoordsxIRL[ 828]=-4; IRLcoordsyIRL[ 828]= 4; IRLcoordszIRL[ 828]= 4
IRLcoordsx[ 829]= 23; IRLcoordsy[ 829]= 61; IRLcoordsxIRL[ 829]=-4; IRLcoordsyIRL[ 829]= 3; IRLcoordszIRL[ 829]= 4
IRLcoordsx[ 830]= 23; IRLcoordsy[ 830]= 62; IRLcoordsxIRL[ 830]=-4; IRLcoordsyIRL[ 830]= 2; IRLcoordszIRL[ 830]= 4
IRLcoordsx[ 831]= 23; IRLcoordsy[ 831]= 63; IRLcoordsxIRL[ 831]=-4; IRLcoordsyIRL[ 831]= 1; IRLcoordszIRL[ 831]= 4
IRLcoordsx[ 832]= 24; IRLcoordsy[ 832]= 52; IRLcoordsxIRL[ 832]=-3; IRLcoordsyIRL[ 832]= 12; IRLcoordszIRL[ 832]= 3
IRLcoordsx[ 833]= 24; IRLcoordsy[ 833]= 53; IRLcoordsxIRL[ 833]=-3; IRLcoordsyIRL[ 833]= 11; IRLcoordszIRL[ 833]= 3
IRLcoordsx[ 834]= 24; IRLcoordsy[ 834]= 54; IRLcoordsxIRL[ 834]=-3; IRLcoordsyIRL[ 834]= 10; IRLcoordszIRL[ 834]= 3
IRLcoordsx[ 835]= 24; IRLcoordsy[ 835]= 55; IRLcoordsxIRL[ 835]=-3; IRLcoordsyIRL[ 835]= 9; IRLcoordszIRL[ 835]= 3
IRLcoordsx[ 836]= 24; IRLcoordsy[ 836]= 56; IRLcoordsxIRL[ 836]=-3; IRLcoordsyIRL[ 836]= 8; IRLcoordszIRL[ 836]= 3
IRLcoordsx[ 837]= 24; IRLcoordsy[ 837]= 57; IRLcoordsxIRL[ 837]=-3; IRLcoordsyIRL[ 837]= 7; IRLcoordszIRL[ 837]= 3
IRLcoordsx[ 838]= 24; IRLcoordsy[ 838]= 58; IRLcoordsxIRL[ 838]=-3; IRLcoordsyIRL[ 838]= 6; IRLcoordszIRL[ 838]= 3
IRLcoordsx[ 839]= 24; IRLcoordsy[ 839]= 59; IRLcoordsxIRL[ 839]=-3; IRLcoordsyIRL[ 839]= 5; IRLcoordszIRL[ 839]= 3
IRLcoordsx[ 840]= 24; IRLcoordsy[ 840]= 60; IRLcoordsxIRL[ 840]=-3; IRLcoordsyIRL[ 840]= 4; IRLcoordszIRL[ 840]= 3
IRLcoordsx[ 841]= 24; IRLcoordsy[ 841]= 61; IRLcoordsxIRL[ 841]=-3; IRLcoordsyIRL[ 841]= 3; IRLcoordszIRL[ 841]= 3
IRLcoordsx[ 842]= 24; IRLcoordsy[ 842]= 62; IRLcoordsxIRL[ 842]=-3; IRLcoordsyIRL[ 842]= 2; IRLcoordszIRL[ 842]= 3
IRLcoordsx[ 843]= 24; IRLcoordsy[ 843]= 63; IRLcoordsxIRL[ 843]=-3; IRLcoordsyIRL[ 843]= 1; IRLcoordszIRL[ 843]= 3
IRLcoordsx[ 844]= 25; IRLcoordsy[ 844]= 52; IRLcoordsxIRL[ 844]=-3; IRLcoordsyIRL[ 844]= 12; IRLcoordszIRL[ 844]= 2
IRLcoordsx[ 845]= 25; IRLcoordsy[ 845]= 53; IRLcoordsxIRL[ 845]=-3; IRLcoordsyIRL[ 845]= 11; IRLcoordszIRL[ 845]= 2
IRLcoordsx[ 846]= 25; IRLcoordsy[ 846]= 54; IRLcoordsxIRL[ 846]=-3; IRLcoordsyIRL[ 846]= 10; IRLcoordszIRL[ 846]= 2
IRLcoordsx[ 847]= 25; IRLcoordsy[ 847]= 55; IRLcoordsxIRL[ 847]=-3; IRLcoordsyIRL[ 847]= 9; IRLcoordszIRL[ 847]= 2
IRLcoordsx[ 848]= 25; IRLcoordsy[ 848]= 56; IRLcoordsxIRL[ 848]=-3; IRLcoordsyIRL[ 848]= 8; IRLcoordszIRL[ 848]= 2
IRLcoordsx[ 849]= 25; IRLcoordsy[ 849]= 57; IRLcoordsxIRL[ 849]=-3; IRLcoordsyIRL[ 849]= 7; IRLcoordszIRL[ 849]= 2
IRLcoordsx[ 850]= 25; IRLcoordsy[ 850]= 58; IRLcoordsxIRL[ 850]=-3; IRLcoordsyIRL[ 850]= 6; IRLcoordszIRL[ 850]= 2
IRLcoordsx[ 851]= 25; IRLcoordsy[ 851]= 59; IRLcoordsxIRL[ 851]=-3; IRLcoordsyIRL[ 851]= 5; IRLcoordszIRL[ 851]= 2
IRLcoordsx[ 852]= 25; IRLcoordsy[ 852]= 60; IRLcoordsxIRL[ 852]=-3; IRLcoordsyIRL[ 852]= 4; IRLcoordszIRL[ 852]= 2
IRLcoordsx[ 853]= 25; IRLcoordsy[ 853]= 61; IRLcoordsxIRL[ 853]=-3; IRLcoordsyIRL[ 853]= 3; IRLcoordszIRL[ 853]= 2
IRLcoordsx[ 854]= 25; IRLcoordsy[ 854]= 62; IRLcoordsxIRL[ 854]=-3; IRLcoordsyIRL[ 854]= 2; IRLcoordszIRL[ 854]= 2
IRLcoordsx[ 855]= 25; IRLcoordsy[ 855]= 63; IRLcoordsxIRL[ 855]=-3; IRLcoordsyIRL[ 855]= 1; IRLcoordszIRL[ 855]= 2
IRLcoordsx[ 856]= 26; IRLcoordsy[ 856]= 52; IRLcoordsxIRL[ 856]=-3; IRLcoordsyIRL[ 856]= 12; IRLcoordszIRL[ 856]= 1
IRLcoordsx[ 857]= 26; IRLcoordsy[ 857]= 53; IRLcoordsxIRL[ 857]=-3; IRLcoordsyIRL[ 857]= 11; IRLcoordszIRL[ 857]= 1
IRLcoordsx[ 858]= 26; IRLcoordsy[ 858]= 54; IRLcoordsxIRL[ 858]=-3; IRLcoordsyIRL[ 858]= 10; IRLcoordszIRL[ 858]= 1
IRLcoordsx[ 859]= 26; IRLcoordsy[ 859]= 55; IRLcoordsxIRL[ 859]=-3; IRLcoordsyIRL[ 859]= 9; IRLcoordszIRL[ 859]= 1
IRLcoordsx[ 860]= 26; IRLcoordsy[ 860]= 56; IRLcoordsxIRL[ 860]=-3; IRLcoordsyIRL[ 860]= 8; IRLcoordszIRL[ 860]= 1
IRLcoordsx[ 861]= 26; IRLcoordsy[ 861]= 57; IRLcoordsxIRL[ 861]=-3; IRLcoordsyIRL[ 861]= 7; IRLcoordszIRL[ 861]= 1
IRLcoordsx[ 862]= 26; IRLcoordsy[ 862]= 58; IRLcoordsxIRL[ 862]=-3; IRLcoordsyIRL[ 862]= 6; IRLcoordszIRL[ 862]= 1
IRLcoordsx[ 863]= 26; IRLcoordsy[ 863]= 59; IRLcoordsxIRL[ 863]=-3; IRLcoordsyIRL[ 863]= 5; IRLcoordszIRL[ 863]= 1
IRLcoordsx[ 864]= 26; IRLcoordsy[ 864]= 60; IRLcoordsxIRL[ 864]=-3; IRLcoordsyIRL[ 864]= 4; IRLcoordszIRL[ 864]= 1
IRLcoordsx[ 865]= 26; IRLcoordsy[ 865]= 61; IRLcoordsxIRL[ 865]=-3; IRLcoordsyIRL[ 865]= 3; IRLcoordszIRL[ 865]= 1
IRLcoordsx[ 866]= 26; IRLcoordsy[ 866]= 62; IRLcoordsxIRL[ 866]=-3; IRLcoordsyIRL[ 866]= 2; IRLcoordszIRL[ 866]= 1
IRLcoordsx[ 867]= 26; IRLcoordsy[ 867]= 63; IRLcoordsxIRL[ 867]=-3; IRLcoordsyIRL[ 867]= 1; IRLcoordszIRL[ 867]= 1
IRLcoordsx[ 868]= 27; IRLcoordsy[ 868]= 52; IRLcoordsxIRL[ 868]=-3; IRLcoordsyIRL[ 868]= 12; IRLcoordszIRL[ 868]= 0
IRLcoordsx[ 869]= 27; IRLcoordsy[ 869]= 53; IRLcoordsxIRL[ 869]=-3; IRLcoordsyIRL[ 869]= 11; IRLcoordszIRL[ 869]= 0
IRLcoordsx[ 870]= 27; IRLcoordsy[ 870]= 54; IRLcoordsxIRL[ 870]=-3; IRLcoordsyIRL[ 870]= 10; IRLcoordszIRL[ 870]= 0
IRLcoordsx[ 871]= 27; IRLcoordsy[ 871]= 55; IRLcoordsxIRL[ 871]=-3; IRLcoordsyIRL[ 871]= 9; IRLcoordszIRL[ 871]= 0
IRLcoordsx[ 872]= 27; IRLcoordsy[ 872]= 56; IRLcoordsxIRL[ 872]=-3; IRLcoordsyIRL[ 872]= 8; IRLcoordszIRL[ 872]= 0
IRLcoordsx[ 873]= 27; IRLcoordsy[ 873]= 57; IRLcoordsxIRL[ 873]=-3; IRLcoordsyIRL[ 873]= 7; IRLcoordszIRL[ 873]= 0
IRLcoordsx[ 874]= 27; IRLcoordsy[ 874]= 58; IRLcoordsxIRL[ 874]=-3; IRLcoordsyIRL[ 874]= 6; IRLcoordszIRL[ 874]= 0
IRLcoordsx[ 875]= 27; IRLcoordsy[ 875]= 59; IRLcoordsxIRL[ 875]=-3; IRLcoordsyIRL[ 875]= 5; IRLcoordszIRL[ 875]= 0
IRLcoordsx[ 876]= 27; IRLcoordsy[ 876]= 60; IRLcoordsxIRL[ 876]=-3; IRLcoordsyIRL[ 876]= 4; IRLcoordszIRL[ 876]= 0
IRLcoordsx[ 877]= 27; IRLcoordsy[ 877]= 61; IRLcoordsxIRL[ 877]=-3; IRLcoordsyIRL[ 877]= 3; IRLcoordszIRL[ 877]= 0
IRLcoordsx[ 878]= 27; IRLcoordsy[ 878]= 62; IRLcoordsxIRL[ 878]=-3; IRLcoordsyIRL[ 878]= 2; IRLcoordszIRL[ 878]= 0
IRLcoordsx[ 879]= 27; IRLcoordsy[ 879]= 63; IRLcoordsxIRL[ 879]=-3; IRLcoordsyIRL[ 879]= 1; IRLcoordszIRL[ 879]= 0
IRLcoordsx[ 880]= 16; IRLcoordsy[ 880]= 52; IRLcoordsxIRL[ 880]=-8; IRLcoordsyIRL[ 880]= 12; IRLcoordszIRL[ 880]= 0
IRLcoordsx[ 881]= 16; IRLcoordsy[ 881]= 53; IRLcoordsxIRL[ 881]=-8; IRLcoordsyIRL[ 881]= 11; IRLcoordszIRL[ 881]= 0
IRLcoordsx[ 882]= 16; IRLcoordsy[ 882]= 54; IRLcoordsxIRL[ 882]=-8; IRLcoordsyIRL[ 882]= 10; IRLcoordszIRL[ 882]= 0
IRLcoordsx[ 883]= 16; IRLcoordsy[ 883]= 55; IRLcoordsxIRL[ 883]=-8; IRLcoordsyIRL[ 883]= 9; IRLcoordszIRL[ 883]= 0
IRLcoordsx[ 884]= 16; IRLcoordsy[ 884]= 56; IRLcoordsxIRL[ 884]=-8; IRLcoordsyIRL[ 884]= 8; IRLcoordszIRL[ 884]= 0
IRLcoordsx[ 885]= 16; IRLcoordsy[ 885]= 57; IRLcoordsxIRL[ 885]=-8; IRLcoordsyIRL[ 885]= 7; IRLcoordszIRL[ 885]= 0
IRLcoordsx[ 886]= 16; IRLcoordsy[ 886]= 58; IRLcoordsxIRL[ 886]=-8; IRLcoordsyIRL[ 886]= 6; IRLcoordszIRL[ 886]= 0
IRLcoordsx[ 887]= 16; IRLcoordsy[ 887]= 59; IRLcoordsxIRL[ 887]=-8; IRLcoordsyIRL[ 887]= 5; IRLcoordszIRL[ 887]= 0
IRLcoordsx[ 888]= 16; IRLcoordsy[ 888]= 60; IRLcoordsxIRL[ 888]=-8; IRLcoordsyIRL[ 888]= 4; IRLcoordszIRL[ 888]= 0
IRLcoordsx[ 889]= 16; IRLcoordsy[ 889]= 61; IRLcoordsxIRL[ 889]=-8; IRLcoordsyIRL[ 889]= 3; IRLcoordszIRL[ 889]= 0
IRLcoordsx[ 890]= 16; IRLcoordsy[ 890]= 62; IRLcoordsxIRL[ 890]=-8; IRLcoordsyIRL[ 890]= 2; IRLcoordszIRL[ 890]= 0
IRLcoordsx[ 891]= 16; IRLcoordsy[ 891]= 63; IRLcoordsxIRL[ 891]=-8; IRLcoordsyIRL[ 891]= 1; IRLcoordszIRL[ 891]= 0
IRLcoordsx[ 892]= 17; IRLcoordsy[ 892]= 52; IRLcoordsxIRL[ 892]=-8; IRLcoordsyIRL[ 892]= 12; IRLcoordszIRL[ 892]= 1
IRLcoordsx[ 893]= 17; IRLcoordsy[ 893]= 53; IRLcoordsxIRL[ 893]=-8; IRLcoordsyIRL[ 893]= 11; IRLcoordszIRL[ 893]= 1
IRLcoordsx[ 894]= 17; IRLcoordsy[ 894]= 54; IRLcoordsxIRL[ 894]=-8; IRLcoordsyIRL[ 894]= 10; IRLcoordszIRL[ 894]= 1
IRLcoordsx[ 895]= 17; IRLcoordsy[ 895]= 55; IRLcoordsxIRL[ 895]=-8; IRLcoordsyIRL[ 895]= 9; IRLcoordszIRL[ 895]= 1
IRLcoordsx[ 896]= 17; IRLcoordsy[ 896]= 56; IRLcoordsxIRL[ 896]=-8; IRLcoordsyIRL[ 896]= 8; IRLcoordszIRL[ 896]= 1
IRLcoordsx[ 897]= 17; IRLcoordsy[ 897]= 57; IRLcoordsxIRL[ 897]=-8; IRLcoordsyIRL[ 897]= 7; IRLcoordszIRL[ 897]= 1
IRLcoordsx[ 898]= 17; IRLcoordsy[ 898]= 58; IRLcoordsxIRL[ 898]=-8; IRLcoordsyIRL[ 898]= 6; IRLcoordszIRL[ 898]= 1
IRLcoordsx[ 899]= 17; IRLcoordsy[ 899]= 59; IRLcoordsxIRL[ 899]=-8; IRLcoordsyIRL[ 899]= 5; IRLcoordszIRL[ 899]= 1
IRLcoordsx[ 900]= 17; IRLcoordsy[ 900]= 60; IRLcoordsxIRL[ 900]=-8; IRLcoordsyIRL[ 900]= 4; IRLcoordszIRL[ 900]= 1
IRLcoordsx[ 901]= 17; IRLcoordsy[ 901]= 61; IRLcoordsxIRL[ 901]=-8; IRLcoordsyIRL[ 901]= 3; IRLcoordszIRL[ 901]= 1
IRLcoordsx[ 902]= 17; IRLcoordsy[ 902]= 62; IRLcoordsxIRL[ 902]=-8; IRLcoordsyIRL[ 902]= 2; IRLcoordszIRL[ 902]= 1
IRLcoordsx[ 903]= 17; IRLcoordsy[ 903]= 63; IRLcoordsxIRL[ 903]=-8; IRLcoordsyIRL[ 903]= 1; IRLcoordszIRL[ 903]= 1
IRLcoordsx[ 904]= 18; IRLcoordsy[ 904]= 52; IRLcoordsxIRL[ 904]=-8; IRLcoordsyIRL[ 904]= 12; IRLcoordszIRL[ 904]= 2
IRLcoordsx[ 905]= 18; IRLcoordsy[ 905]= 53; IRLcoordsxIRL[ 905]=-8; IRLcoordsyIRL[ 905]= 11; IRLcoordszIRL[ 905]= 2
IRLcoordsx[ 906]= 18; IRLcoordsy[ 906]= 54; IRLcoordsxIRL[ 906]=-8; IRLcoordsyIRL[ 906]= 10; IRLcoordszIRL[ 906]= 2
IRLcoordsx[ 907]= 18; IRLcoordsy[ 907]= 55; IRLcoordsxIRL[ 907]=-8; IRLcoordsyIRL[ 907]= 9; IRLcoordszIRL[ 907]= 2
IRLcoordsx[ 908]= 18; IRLcoordsy[ 908]= 56; IRLcoordsxIRL[ 908]=-8; IRLcoordsyIRL[ 908]= 8; IRLcoordszIRL[ 908]= 2
IRLcoordsx[ 909]= 18; IRLcoordsy[ 909]= 57; IRLcoordsxIRL[ 909]=-8; IRLcoordsyIRL[ 909]= 7; IRLcoordszIRL[ 909]= 2
IRLcoordsx[ 910]= 18; IRLcoordsy[ 910]= 58; IRLcoordsxIRL[ 910]=-8; IRLcoordsyIRL[ 910]= 6; IRLcoordszIRL[ 910]= 2
IRLcoordsx[ 911]= 18; IRLcoordsy[ 911]= 59; IRLcoordsxIRL[ 911]=-8; IRLcoordsyIRL[ 911]= 5; IRLcoordszIRL[ 911]= 2
IRLcoordsx[ 912]= 18; IRLcoordsy[ 912]= 60; IRLcoordsxIRL[ 912]=-8; IRLcoordsyIRL[ 912]= 4; IRLcoordszIRL[ 912]= 2
IRLcoordsx[ 913]= 18; IRLcoordsy[ 913]= 61; IRLcoordsxIRL[ 913]=-8; IRLcoordsyIRL[ 913]= 3; IRLcoordszIRL[ 913]= 2
IRLcoordsx[ 914]= 18; IRLcoordsy[ 914]= 62; IRLcoordsxIRL[ 914]=-8; IRLcoordsyIRL[ 914]= 2; IRLcoordszIRL[ 914]= 2
IRLcoordsx[ 915]= 18; IRLcoordsy[ 915]= 63; IRLcoordsxIRL[ 915]=-8; IRLcoordsyIRL[ 915]= 1; IRLcoordszIRL[ 915]= 2
IRLcoordsx[ 916]= 19; IRLcoordsy[ 916]= 52; IRLcoordsxIRL[ 916]=-8; IRLcoordsyIRL[ 916]= 12; IRLcoordszIRL[ 916]= 3
IRLcoordsx[ 917]= 19; IRLcoordsy[ 917]= 53; IRLcoordsxIRL[ 917]=-8; IRLcoordsyIRL[ 917]= 11; IRLcoordszIRL[ 917]= 3
IRLcoordsx[ 918]= 19; IRLcoordsy[ 918]= 54; IRLcoordsxIRL[ 918]=-8; IRLcoordsyIRL[ 918]= 10; IRLcoordszIRL[ 918]= 3
IRLcoordsx[ 919]= 19; IRLcoordsy[ 919]= 55; IRLcoordsxIRL[ 919]=-8; IRLcoordsyIRL[ 919]= 9; IRLcoordszIRL[ 919]= 3
IRLcoordsx[ 920]= 19; IRLcoordsy[ 920]= 56; IRLcoordsxIRL[ 920]=-8; IRLcoordsyIRL[ 920]= 8; IRLcoordszIRL[ 920]= 3
IRLcoordsx[ 921]= 19; IRLcoordsy[ 921]= 57; IRLcoordsxIRL[ 921]=-8; IRLcoordsyIRL[ 921]= 7; IRLcoordszIRL[ 921]= 3
IRLcoordsx[ 922]= 19; IRLcoordsy[ 922]= 58; IRLcoordsxIRL[ 922]=-8; IRLcoordsyIRL[ 922]= 6; IRLcoordszIRL[ 922]= 3
IRLcoordsx[ 923]= 19; IRLcoordsy[ 923]= 59; IRLcoordsxIRL[ 923]=-8; IRLcoordsyIRL[ 923]= 5; IRLcoordszIRL[ 923]= 3
IRLcoordsx[ 924]= 19; IRLcoordsy[ 924]= 60; IRLcoordsxIRL[ 924]=-8; IRLcoordsyIRL[ 924]= 4; IRLcoordszIRL[ 924]= 3
IRLcoordsx[ 925]= 19; IRLcoordsy[ 925]= 61; IRLcoordsxIRL[ 925]=-8; IRLcoordsyIRL[ 925]= 3; IRLcoordszIRL[ 925]= 3
IRLcoordsx[ 926]= 19; IRLcoordsy[ 926]= 62; IRLcoordsxIRL[ 926]=-8; IRLcoordsyIRL[ 926]= 2; IRLcoordszIRL[ 926]= 3
IRLcoordsx[ 927]= 19; IRLcoordsy[ 927]= 63; IRLcoordsxIRL[ 927]=-8; IRLcoordsyIRL[ 927]= 1; IRLcoordszIRL[ 927]= 3
IRLcoordsx[ 928]= 20; IRLcoordsy[ 928]= 48; IRLcoordsxIRL[ 928]=-7; IRLcoordsyIRL[ 928]= 13; IRLcoordszIRL[ 928]= 0
IRLcoordsx[ 929]= 20; IRLcoordsy[ 929]= 49; IRLcoordsxIRL[ 929]=-7; IRLcoordsyIRL[ 929]= 13; IRLcoordszIRL[ 929]= 1
IRLcoordsx[ 930]= 20; IRLcoordsy[ 930]= 50; IRLcoordsxIRL[ 930]=-7; IRLcoordsyIRL[ 930]= 13; IRLcoordszIRL[ 930]= 2
IRLcoordsx[ 931]= 20; IRLcoordsy[ 931]= 51; IRLcoordsxIRL[ 931]=-7; IRLcoordsyIRL[ 931]= 13; IRLcoordszIRL[ 931]= 3
IRLcoordsx[ 932]= 21; IRLcoordsy[ 932]= 48; IRLcoordsxIRL[ 932]=-6; IRLcoordsyIRL[ 932]= 13; IRLcoordszIRL[ 932]= 0
IRLcoordsx[ 933]= 21; IRLcoordsy[ 933]= 49; IRLcoordsxIRL[ 933]=-6; IRLcoordsyIRL[ 933]= 13; IRLcoordszIRL[ 933]= 1
IRLcoordsx[ 934]= 21; IRLcoordsy[ 934]= 50; IRLcoordsxIRL[ 934]=-6; IRLcoordsyIRL[ 934]= 13; IRLcoordszIRL[ 934]= 2
IRLcoordsx[ 935]= 21; IRLcoordsy[ 935]= 51; IRLcoordsxIRL[ 935]=-6; IRLcoordsyIRL[ 935]= 13; IRLcoordszIRL[ 935]= 3
IRLcoordsx[ 936]= 22; IRLcoordsy[ 936]= 48; IRLcoordsxIRL[ 936]=-5; IRLcoordsyIRL[ 936]= 13; IRLcoordszIRL[ 936]= 0
IRLcoordsx[ 937]= 22; IRLcoordsy[ 937]= 49; IRLcoordsxIRL[ 937]=-5; IRLcoordsyIRL[ 937]= 13; IRLcoordszIRL[ 937]= 1
IRLcoordsx[ 938]= 22; IRLcoordsy[ 938]= 50; IRLcoordsxIRL[ 938]=-5; IRLcoordsyIRL[ 938]= 13; IRLcoordszIRL[ 938]= 2
IRLcoordsx[ 939]= 22; IRLcoordsy[ 939]= 51; IRLcoordsxIRL[ 939]=-5; IRLcoordsyIRL[ 939]= 13; IRLcoordszIRL[ 939]= 3
IRLcoordsx[ 940]= 23; IRLcoordsy[ 940]= 48; IRLcoordsxIRL[ 940]=-4; IRLcoordsyIRL[ 940]= 13; IRLcoordszIRL[ 940]= 0
IRLcoordsx[ 941]= 23; IRLcoordsy[ 941]= 49; IRLcoordsxIRL[ 941]=-4; IRLcoordsyIRL[ 941]= 13; IRLcoordszIRL[ 941]= 1
IRLcoordsx[ 942]= 23; IRLcoordsy[ 942]= 50; IRLcoordsxIRL[ 942]=-4; IRLcoordsyIRL[ 942]= 13; IRLcoordszIRL[ 942]= 2
IRLcoordsx[ 943]= 23; IRLcoordsy[ 943]= 51; IRLcoordsxIRL[ 943]=-4; IRLcoordsyIRL[ 943]= 13; IRLcoordszIRL[ 943]= 3
IRLcoordsx[ 944]= 24; IRLcoordsy[ 944]= 48; IRLcoordsxIRL[ 944]=-7; IRLcoordsyIRL[ 944]= 0; IRLcoordszIRL[ 944]= 0
IRLcoordsx[ 945]= 24; IRLcoordsy[ 945]= 49; IRLcoordsxIRL[ 945]=-7; IRLcoordsyIRL[ 945]= 0; IRLcoordszIRL[ 945]= 1
IRLcoordsx[ 946]= 24; IRLcoordsy[ 946]= 50; IRLcoordsxIRL[ 946]=-7; IRLcoordsyIRL[ 946]= 0; IRLcoordszIRL[ 946]= 2
IRLcoordsx[ 947]= 24; IRLcoordsy[ 947]= 51; IRLcoordsxIRL[ 947]=-7; IRLcoordsyIRL[ 947]= 0; IRLcoordszIRL[ 947]= 3
IRLcoordsx[ 948]= 25; IRLcoordsy[ 948]= 48; IRLcoordsxIRL[ 948]=-6; IRLcoordsyIRL[ 948]= 0; IRLcoordszIRL[ 948]= 0
IRLcoordsx[ 949]= 25; IRLcoordsy[ 949]= 49; IRLcoordsxIRL[ 949]=-6; IRLcoordsyIRL[ 949]= 0; IRLcoordszIRL[ 949]= 1
IRLcoordsx[ 950]= 25; IRLcoordsy[ 950]= 50; IRLcoordsxIRL[ 950]=-6; IRLcoordsyIRL[ 950]= 0; IRLcoordszIRL[ 950]= 2
IRLcoordsx[ 951]= 25; IRLcoordsy[ 951]= 51; IRLcoordsxIRL[ 951]=-6; IRLcoordsyIRL[ 951]= 0; IRLcoordszIRL[ 951]= 3
IRLcoordsx[ 952]= 26; IRLcoordsy[ 952]= 48; IRLcoordsxIRL[ 952]=-5; IRLcoordsyIRL[ 952]= 0; IRLcoordszIRL[ 952]= 0
IRLcoordsx[ 953]= 26; IRLcoordsy[ 953]= 49; IRLcoordsxIRL[ 953]=-5; IRLcoordsyIRL[ 953]= 0; IRLcoordszIRL[ 953]= 1
IRLcoordsx[ 954]= 26; IRLcoordsy[ 954]= 50; IRLcoordsxIRL[ 954]=-5; IRLcoordsyIRL[ 954]= 0; IRLcoordszIRL[ 954]= 2
IRLcoordsx[ 955]= 26; IRLcoordsy[ 955]= 51; IRLcoordsxIRL[ 955]=-5; IRLcoordsyIRL[ 955]= 0; IRLcoordszIRL[ 955]= 3
IRLcoordsx[ 956]= 27; IRLcoordsy[ 956]= 48; IRLcoordsxIRL[ 956]=-4; IRLcoordsyIRL[ 956]= 0; IRLcoordszIRL[ 956]= 0
IRLcoordsx[ 957]= 27; IRLcoordsy[ 957]= 49; IRLcoordsxIRL[ 957]=-4; IRLcoordsyIRL[ 957]= 0; IRLcoordszIRL[ 957]= 1
IRLcoordsx[ 958]= 27; IRLcoordsy[ 958]= 50; IRLcoordsxIRL[ 958]=-4; IRLcoordsyIRL[ 958]= 0; IRLcoordszIRL[ 958]= 2
IRLcoordsx[ 959]= 27; IRLcoordsy[ 959]= 51; IRLcoordsxIRL[ 959]=-4; IRLcoordsyIRL[ 959]= 0; IRLcoordszIRL[ 959]= 3
IRLcoordsx[ 960]= 12; IRLcoordsy[ 960]= 20; IRLcoordsxIRL[ 960]=-12; IRLcoordsyIRL[ 960]= 12; IRLcoordszIRL[ 960]=-1
IRLcoordsx[ 961]= 12; IRLcoordsy[ 961]= 21; IRLcoordsxIRL[ 961]=-12; IRLcoordsyIRL[ 961]= 11; IRLcoordszIRL[ 961]=-1
IRLcoordsx[ 962]= 12; IRLcoordsy[ 962]= 22; IRLcoordsxIRL[ 962]=-12; IRLcoordsyIRL[ 962]= 10; IRLcoordszIRL[ 962]=-1
IRLcoordsx[ 963]= 12; IRLcoordsy[ 963]= 23; IRLcoordsxIRL[ 963]=-12; IRLcoordsyIRL[ 963]= 9; IRLcoordszIRL[ 963]=-1
IRLcoordsx[ 964]= 12; IRLcoordsy[ 964]= 24; IRLcoordsxIRL[ 964]=-12; IRLcoordsyIRL[ 964]= 8; IRLcoordszIRL[ 964]=-1
IRLcoordsx[ 965]= 12; IRLcoordsy[ 965]= 25; IRLcoordsxIRL[ 965]=-12; IRLcoordsyIRL[ 965]= 7; IRLcoordszIRL[ 965]=-1
IRLcoordsx[ 966]= 12; IRLcoordsy[ 966]= 26; IRLcoordsxIRL[ 966]=-12; IRLcoordsyIRL[ 966]= 6; IRLcoordszIRL[ 966]=-1
IRLcoordsx[ 967]= 12; IRLcoordsy[ 967]= 27; IRLcoordsxIRL[ 967]=-12; IRLcoordsyIRL[ 967]= 5; IRLcoordszIRL[ 967]=-1
IRLcoordsx[ 968]= 12; IRLcoordsy[ 968]= 28; IRLcoordsxIRL[ 968]=-12; IRLcoordsyIRL[ 968]= 4; IRLcoordszIRL[ 968]=-1
IRLcoordsx[ 969]= 12; IRLcoordsy[ 969]= 29; IRLcoordsxIRL[ 969]=-12; IRLcoordsyIRL[ 969]= 3; IRLcoordszIRL[ 969]=-1
IRLcoordsx[ 970]= 12; IRLcoordsy[ 970]= 30; IRLcoordsxIRL[ 970]=-12; IRLcoordsyIRL[ 970]= 2; IRLcoordszIRL[ 970]=-1
IRLcoordsx[ 971]= 12; IRLcoordsy[ 971]= 31; IRLcoordsxIRL[ 971]=-12; IRLcoordsyIRL[ 971]= 1; IRLcoordszIRL[ 971]=-1
IRLcoordsx[ 972]= 13; IRLcoordsy[ 972]= 20; IRLcoordsxIRL[ 972]=-13; IRLcoordsyIRL[ 972]= 12; IRLcoordszIRL[ 972]=-1
IRLcoordsx[ 973]= 13; IRLcoordsy[ 973]= 21; IRLcoordsxIRL[ 973]=-13; IRLcoordsyIRL[ 973]= 11; IRLcoordszIRL[ 973]=-1
IRLcoordsx[ 974]= 13; IRLcoordsy[ 974]= 22; IRLcoordsxIRL[ 974]=-13; IRLcoordsyIRL[ 974]= 10; IRLcoordszIRL[ 974]=-1
IRLcoordsx[ 975]= 13; IRLcoordsy[ 975]= 23; IRLcoordsxIRL[ 975]=-13; IRLcoordsyIRL[ 975]= 9; IRLcoordszIRL[ 975]=-1
IRLcoordsx[ 976]= 13; IRLcoordsy[ 976]= 24; IRLcoordsxIRL[ 976]=-13; IRLcoordsyIRL[ 976]= 8; IRLcoordszIRL[ 976]=-1
IRLcoordsx[ 977]= 13; IRLcoordsy[ 977]= 25; IRLcoordsxIRL[ 977]=-13; IRLcoordsyIRL[ 977]= 7; IRLcoordszIRL[ 977]=-1
IRLcoordsx[ 978]= 13; IRLcoordsy[ 978]= 26; IRLcoordsxIRL[ 978]=-13; IRLcoordsyIRL[ 978]= 6; IRLcoordszIRL[ 978]=-1
IRLcoordsx[ 979]= 13; IRLcoordsy[ 979]= 27; IRLcoordsxIRL[ 979]=-13; IRLcoordsyIRL[ 979]= 5; IRLcoordszIRL[ 979]=-1
IRLcoordsx[ 980]= 13; IRLcoordsy[ 980]= 28; IRLcoordsxIRL[ 980]=-13; IRLcoordsyIRL[ 980]= 4; IRLcoordszIRL[ 980]=-1
IRLcoordsx[ 981]= 13; IRLcoordsy[ 981]= 29; IRLcoordsxIRL[ 981]=-13; IRLcoordsyIRL[ 981]= 3; IRLcoordszIRL[ 981]=-1
IRLcoordsx[ 982]= 13; IRLcoordsy[ 982]= 30; IRLcoordsxIRL[ 982]=-13; IRLcoordsyIRL[ 982]= 2; IRLcoordszIRL[ 982]=-1
IRLcoordsx[ 983]= 13; IRLcoordsy[ 983]= 31; IRLcoordsxIRL[ 983]=-13; IRLcoordsyIRL[ 983]= 1; IRLcoordszIRL[ 983]=-1
IRLcoordsx[ 984]= 14; IRLcoordsy[ 984]= 20; IRLcoordsxIRL[ 984]=-14; IRLcoordsyIRL[ 984]= 12; IRLcoordszIRL[ 984]=-1
IRLcoordsx[ 985]= 14; IRLcoordsy[ 985]= 21; IRLcoordsxIRL[ 985]=-14; IRLcoordsyIRL[ 985]= 11; IRLcoordszIRL[ 985]=-1
IRLcoordsx[ 986]= 14; IRLcoordsy[ 986]= 22; IRLcoordsxIRL[ 986]=-14; IRLcoordsyIRL[ 986]= 10; IRLcoordszIRL[ 986]=-1
IRLcoordsx[ 987]= 14; IRLcoordsy[ 987]= 23; IRLcoordsxIRL[ 987]=-14; IRLcoordsyIRL[ 987]= 9; IRLcoordszIRL[ 987]=-1
IRLcoordsx[ 988]= 14; IRLcoordsy[ 988]= 24; IRLcoordsxIRL[ 988]=-14; IRLcoordsyIRL[ 988]= 8; IRLcoordszIRL[ 988]=-1
IRLcoordsx[ 989]= 14; IRLcoordsy[ 989]= 25; IRLcoordsxIRL[ 989]=-14; IRLcoordsyIRL[ 989]= 7; IRLcoordszIRL[ 989]=-1
IRLcoordsx[ 990]= 14; IRLcoordsy[ 990]= 26; IRLcoordsxIRL[ 990]=-14; IRLcoordsyIRL[ 990]= 6; IRLcoordszIRL[ 990]=-1
IRLcoordsx[ 991]= 14; IRLcoordsy[ 991]= 27; IRLcoordsxIRL[ 991]=-14; IRLcoordsyIRL[ 991]= 5; IRLcoordszIRL[ 991]=-1
IRLcoordsx[ 992]= 14; IRLcoordsy[ 992]= 28; IRLcoordsxIRL[ 992]=-14; IRLcoordsyIRL[ 992]= 4; IRLcoordszIRL[ 992]=-1
IRLcoordsx[ 993]= 14; IRLcoordsy[ 993]= 29; IRLcoordsxIRL[ 993]=-14; IRLcoordsyIRL[ 993]= 3; IRLcoordszIRL[ 993]=-1
IRLcoordsx[ 994]= 14; IRLcoordsy[ 994]= 30; IRLcoordsxIRL[ 994]=-14; IRLcoordsyIRL[ 994]= 2; IRLcoordszIRL[ 994]=-1
IRLcoordsx[ 995]= 14; IRLcoordsy[ 995]= 31; IRLcoordsxIRL[ 995]=-14; IRLcoordsyIRL[ 995]= 1; IRLcoordszIRL[ 995]=-1
IRLcoordsx[ 996]= 15; IRLcoordsy[ 996]= 20; IRLcoordsxIRL[ 996]=-15; IRLcoordsyIRL[ 996]= 12; IRLcoordszIRL[ 996]=-1
IRLcoordsx[ 997]= 15; IRLcoordsy[ 997]= 21; IRLcoordsxIRL[ 997]=-15; IRLcoordsyIRL[ 997]= 11; IRLcoordszIRL[ 997]=-1
IRLcoordsx[ 998]= 15; IRLcoordsy[ 998]= 22; IRLcoordsxIRL[ 998]=-15; IRLcoordsyIRL[ 998]= 10; IRLcoordszIRL[ 998]=-1
IRLcoordsx[ 999]= 15; IRLcoordsy[ 999]= 23; IRLcoordsxIRL[ 999]=-15; IRLcoordsyIRL[ 999]= 9; IRLcoordszIRL[ 999]=-1
IRLcoordsx[ 1000]= 15; IRLcoordsy[ 1000]= 24; IRLcoordsxIRL[ 1000]=-15; IRLcoordsyIRL[ 1000]= 8; IRLcoordszIRL[ 1000]=-1
IRLcoordsx[ 1001]= 15; IRLcoordsy[ 1001]= 25; IRLcoordsxIRL[ 1001]=-15; IRLcoordsyIRL[ 1001]= 7; IRLcoordszIRL[ 1001]=-1
IRLcoordsx[ 1002]= 15; IRLcoordsy[ 1002]= 26; IRLcoordsxIRL[ 1002]=-15; IRLcoordsyIRL[ 1002]= 6; IRLcoordszIRL[ 1002]=-1
IRLcoordsx[ 1003]= 15; IRLcoordsy[ 1003]= 27; IRLcoordsxIRL[ 1003]=-15; IRLcoordsyIRL[ 1003]= 5; IRLcoordszIRL[ 1003]=-1
IRLcoordsx[ 1004]= 15; IRLcoordsy[ 1004]= 28; IRLcoordsxIRL[ 1004]=-15; IRLcoordsyIRL[ 1004]= 4; IRLcoordszIRL[ 1004]=-1
IRLcoordsx[ 1005]= 15; IRLcoordsy[ 1005]= 29; IRLcoordsxIRL[ 1005]=-15; IRLcoordsyIRL[ 1005]= 3; IRLcoordszIRL[ 1005]=-1
IRLcoordsx[ 1006]= 15; IRLcoordsy[ 1006]= 30; IRLcoordsxIRL[ 1006]=-15; IRLcoordsyIRL[ 1006]= 2; IRLcoordszIRL[ 1006]=-1
IRLcoordsx[ 1007]= 15; IRLcoordsy[ 1007]= 31; IRLcoordsxIRL[ 1007]=-15; IRLcoordsyIRL[ 1007]= 1; IRLcoordszIRL[ 1007]=-1
IRLcoordsx[ 1008]= 4; IRLcoordsy[ 1008]= 20; IRLcoordsxIRL[ 1008]=-15; IRLcoordsyIRL[ 1008]= 12; IRLcoordszIRL[ 1008]= 4
IRLcoordsx[ 1009]= 4; IRLcoordsy[ 1009]= 21; IRLcoordsxIRL[ 1009]=-15; IRLcoordsyIRL[ 1009]= 11; IRLcoordszIRL[ 1009]= 4
IRLcoordsx[ 1010]= 4; IRLcoordsy[ 1010]= 22; IRLcoordsxIRL[ 1010]=-15; IRLcoordsyIRL[ 1010]= 10; IRLcoordszIRL[ 1010]= 4
IRLcoordsx[ 1011]= 4; IRLcoordsy[ 1011]= 23; IRLcoordsxIRL[ 1011]=-15; IRLcoordsyIRL[ 1011]= 9; IRLcoordszIRL[ 1011]= 4
IRLcoordsx[ 1012]= 4; IRLcoordsy[ 1012]= 24; IRLcoordsxIRL[ 1012]=-15; IRLcoordsyIRL[ 1012]= 8; IRLcoordszIRL[ 1012]= 4
IRLcoordsx[ 1013]= 4; IRLcoordsy[ 1013]= 25; IRLcoordsxIRL[ 1013]=-15; IRLcoordsyIRL[ 1013]= 7; IRLcoordszIRL[ 1013]= 4
IRLcoordsx[ 1014]= 4; IRLcoordsy[ 1014]= 26; IRLcoordsxIRL[ 1014]=-15; IRLcoordsyIRL[ 1014]= 6; IRLcoordszIRL[ 1014]= 4
IRLcoordsx[ 1015]= 4; IRLcoordsy[ 1015]= 27; IRLcoordsxIRL[ 1015]=-15; IRLcoordsyIRL[ 1015]= 5; IRLcoordszIRL[ 1015]= 4
IRLcoordsx[ 1016]= 4; IRLcoordsy[ 1016]= 28; IRLcoordsxIRL[ 1016]=-15; IRLcoordsyIRL[ 1016]= 4; IRLcoordszIRL[ 1016]= 4
IRLcoordsx[ 1017]= 4; IRLcoordsy[ 1017]= 29; IRLcoordsxIRL[ 1017]=-15; IRLcoordsyIRL[ 1017]= 3; IRLcoordszIRL[ 1017]= 4
IRLcoordsx[ 1018]= 4; IRLcoordsy[ 1018]= 30; IRLcoordsxIRL[ 1018]=-15; IRLcoordsyIRL[ 1018]= 2; IRLcoordszIRL[ 1018]= 4
IRLcoordsx[ 1019]= 4; IRLcoordsy[ 1019]= 31; IRLcoordsxIRL[ 1019]=-15; IRLcoordsyIRL[ 1019]= 1; IRLcoordszIRL[ 1019]= 4
IRLcoordsx[ 1020]= 5; IRLcoordsy[ 1020]= 20; IRLcoordsxIRL[ 1020]=-14; IRLcoordsyIRL[ 1020]= 12; IRLcoordszIRL[ 1020]= 4
IRLcoordsx[ 1021]= 5; IRLcoordsy[ 1021]= 21; IRLcoordsxIRL[ 1021]=-14; IRLcoordsyIRL[ 1021]= 11; IRLcoordszIRL[ 1021]= 4
IRLcoordsx[ 1022]= 5; IRLcoordsy[ 1022]= 22; IRLcoordsxIRL[ 1022]=-14; IRLcoordsyIRL[ 1022]= 10; IRLcoordszIRL[ 1022]= 4
IRLcoordsx[ 1023]= 5; IRLcoordsy[ 1023]= 23; IRLcoordsxIRL[ 1023]=-14; IRLcoordsyIRL[ 1023]= 9; IRLcoordszIRL[ 1023]= 4
IRLcoordsx[ 1024]= 5; IRLcoordsy[ 1024]= 24; IRLcoordsxIRL[ 1024]=-14; IRLcoordsyIRL[ 1024]= 8; IRLcoordszIRL[ 1024]= 4
IRLcoordsx[ 1025]= 5; IRLcoordsy[ 1025]= 25; IRLcoordsxIRL[ 1025]=-14; IRLcoordsyIRL[ 1025]= 7; IRLcoordszIRL[ 1025]= 4
IRLcoordsx[ 1026]= 5; IRLcoordsy[ 1026]= 26; IRLcoordsxIRL[ 1026]=-14; IRLcoordsyIRL[ 1026]= 6; IRLcoordszIRL[ 1026]= 4
IRLcoordsx[ 1027]= 5; IRLcoordsy[ 1027]= 27; IRLcoordsxIRL[ 1027]=-14; IRLcoordsyIRL[ 1027]= 5; IRLcoordszIRL[ 1027]= 4
IRLcoordsx[ 1028]= 5; IRLcoordsy[ 1028]= 28; IRLcoordsxIRL[ 1028]=-14; IRLcoordsyIRL[ 1028]= 4; IRLcoordszIRL[ 1028]= 4
IRLcoordsx[ 1029]= 5; IRLcoordsy[ 1029]= 29; IRLcoordsxIRL[ 1029]=-14; IRLcoordsyIRL[ 1029]= 3; IRLcoordszIRL[ 1029]= 4
IRLcoordsx[ 1030]= 5; IRLcoordsy[ 1030]= 30; IRLcoordsxIRL[ 1030]=-14; IRLcoordsyIRL[ 1030]= 2; IRLcoordszIRL[ 1030]= 4
IRLcoordsx[ 1031]= 5; IRLcoordsy[ 1031]= 31; IRLcoordsxIRL[ 1031]=-14; IRLcoordsyIRL[ 1031]= 1; IRLcoordszIRL[ 1031]= 4
IRLcoordsx[ 1032]= 6; IRLcoordsy[ 1032]= 20; IRLcoordsxIRL[ 1032]=-13; IRLcoordsyIRL[ 1032]= 12; IRLcoordszIRL[ 1032]= 4
IRLcoordsx[ 1033]= 6; IRLcoordsy[ 1033]= 21; IRLcoordsxIRL[ 1033]=-13; IRLcoordsyIRL[ 1033]= 11; IRLcoordszIRL[ 1033]= 4
IRLcoordsx[ 1034]= 6; IRLcoordsy[ 1034]= 22; IRLcoordsxIRL[ 1034]=-13; IRLcoordsyIRL[ 1034]= 10; IRLcoordszIRL[ 1034]= 4
IRLcoordsx[ 1035]= 6; IRLcoordsy[ 1035]= 23; IRLcoordsxIRL[ 1035]=-13; IRLcoordsyIRL[ 1035]= 9; IRLcoordszIRL[ 1035]= 4
IRLcoordsx[ 1036]= 6; IRLcoordsy[ 1036]= 24; IRLcoordsxIRL[ 1036]=-13; IRLcoordsyIRL[ 1036]= 8; IRLcoordszIRL[ 1036]= 4
IRLcoordsx[ 1037]= 6; IRLcoordsy[ 1037]= 25; IRLcoordsxIRL[ 1037]=-13; IRLcoordsyIRL[ 1037]= 7; IRLcoordszIRL[ 1037]= 4
IRLcoordsx[ 1038]= 6; IRLcoordsy[ 1038]= 26; IRLcoordsxIRL[ 1038]=-13; IRLcoordsyIRL[ 1038]= 6; IRLcoordszIRL[ 1038]= 4
IRLcoordsx[ 1039]= 6; IRLcoordsy[ 1039]= 27; IRLcoordsxIRL[ 1039]=-13; IRLcoordsyIRL[ 1039]= 5; IRLcoordszIRL[ 1039]= 4
IRLcoordsx[ 1040]= 6; IRLcoordsy[ 1040]= 28; IRLcoordsxIRL[ 1040]=-13; IRLcoordsyIRL[ 1040]= 4; IRLcoordszIRL[ 1040]= 4
IRLcoordsx[ 1041]= 6; IRLcoordsy[ 1041]= 29; IRLcoordsxIRL[ 1041]=-13; IRLcoordsyIRL[ 1041]= 3; IRLcoordszIRL[ 1041]= 4
IRLcoordsx[ 1042]= 6; IRLcoordsy[ 1042]= 30; IRLcoordsxIRL[ 1042]=-13; IRLcoordsyIRL[ 1042]= 2; IRLcoordszIRL[ 1042]= 4
IRLcoordsx[ 1043]= 6; IRLcoordsy[ 1043]= 31; IRLcoordsxIRL[ 1043]=-13; IRLcoordsyIRL[ 1043]= 1; IRLcoordszIRL[ 1043]= 4
IRLcoordsx[ 1044]= 7; IRLcoordsy[ 1044]= 20; IRLcoordsxIRL[ 1044]=-12; IRLcoordsyIRL[ 1044]= 12; IRLcoordszIRL[ 1044]= 4
IRLcoordsx[ 1045]= 7; IRLcoordsy[ 1045]= 21; IRLcoordsxIRL[ 1045]=-12; IRLcoordsyIRL[ 1045]= 11; IRLcoordszIRL[ 1045]= 4
IRLcoordsx[ 1046]= 7; IRLcoordsy[ 1046]= 22; IRLcoordsxIRL[ 1046]=-12; IRLcoordsyIRL[ 1046]= 10; IRLcoordszIRL[ 1046]= 4
IRLcoordsx[ 1047]= 7; IRLcoordsy[ 1047]= 23; IRLcoordsxIRL[ 1047]=-12; IRLcoordsyIRL[ 1047]= 9; IRLcoordszIRL[ 1047]= 4
IRLcoordsx[ 1048]= 7; IRLcoordsy[ 1048]= 24; IRLcoordsxIRL[ 1048]=-12; IRLcoordsyIRL[ 1048]= 8; IRLcoordszIRL[ 1048]= 4
IRLcoordsx[ 1049]= 7; IRLcoordsy[ 1049]= 25; IRLcoordsxIRL[ 1049]=-12; IRLcoordsyIRL[ 1049]= 7; IRLcoordszIRL[ 1049]= 4
IRLcoordsx[ 1050]= 7; IRLcoordsy[ 1050]= 26; IRLcoordsxIRL[ 1050]=-12; IRLcoordsyIRL[ 1050]= 6; IRLcoordszIRL[ 1050]= 4
IRLcoordsx[ 1051]= 7; IRLcoordsy[ 1051]= 27; IRLcoordsxIRL[ 1051]=-12; IRLcoordsyIRL[ 1051]= 5; IRLcoordszIRL[ 1051]= 4
IRLcoordsx[ 1052]= 7; IRLcoordsy[ 1052]= 28; IRLcoordsxIRL[ 1052]=-12; IRLcoordsyIRL[ 1052]= 4; IRLcoordszIRL[ 1052]= 4
IRLcoordsx[ 1053]= 7; IRLcoordsy[ 1053]= 29; IRLcoordsxIRL[ 1053]=-12; IRLcoordsyIRL[ 1053]= 3; IRLcoordszIRL[ 1053]= 4
IRLcoordsx[ 1054]= 7; IRLcoordsy[ 1054]= 30; IRLcoordsxIRL[ 1054]=-12; IRLcoordsyIRL[ 1054]= 2; IRLcoordszIRL[ 1054]= 4
IRLcoordsx[ 1055]= 7; IRLcoordsy[ 1055]= 31; IRLcoordsxIRL[ 1055]=-12; IRLcoordsyIRL[ 1055]= 1; IRLcoordszIRL[ 1055]= 4
IRLcoordsx[ 1056]= 8; IRLcoordsy[ 1056]= 20; IRLcoordsxIRL[ 1056]=-11; IRLcoordsyIRL[ 1056]= 12; IRLcoordszIRL[ 1056]= 3
IRLcoordsx[ 1057]= 8; IRLcoordsy[ 1057]= 21; IRLcoordsxIRL[ 1057]=-11; IRLcoordsyIRL[ 1057]= 11; IRLcoordszIRL[ 1057]= 3
IRLcoordsx[ 1058]= 8; IRLcoordsy[ 1058]= 22; IRLcoordsxIRL[ 1058]=-11; IRLcoordsyIRL[ 1058]= 10; IRLcoordszIRL[ 1058]= 3
IRLcoordsx[ 1059]= 8; IRLcoordsy[ 1059]= 23; IRLcoordsxIRL[ 1059]=-11; IRLcoordsyIRL[ 1059]= 9; IRLcoordszIRL[ 1059]= 3
IRLcoordsx[ 1060]= 8; IRLcoordsy[ 1060]= 24; IRLcoordsxIRL[ 1060]=-11; IRLcoordsyIRL[ 1060]= 8; IRLcoordszIRL[ 1060]= 3
IRLcoordsx[ 1061]= 8; IRLcoordsy[ 1061]= 25; IRLcoordsxIRL[ 1061]=-11; IRLcoordsyIRL[ 1061]= 7; IRLcoordszIRL[ 1061]= 3
IRLcoordsx[ 1062]= 8; IRLcoordsy[ 1062]= 26; IRLcoordsxIRL[ 1062]=-11; IRLcoordsyIRL[ 1062]= 6; IRLcoordszIRL[ 1062]= 3
IRLcoordsx[ 1063]= 8; IRLcoordsy[ 1063]= 27; IRLcoordsxIRL[ 1063]=-11; IRLcoordsyIRL[ 1063]= 5; IRLcoordszIRL[ 1063]= 3
IRLcoordsx[ 1064]= 8; IRLcoordsy[ 1064]= 28; IRLcoordsxIRL[ 1064]=-11; IRLcoordsyIRL[ 1064]= 4; IRLcoordszIRL[ 1064]= 3
IRLcoordsx[ 1065]= 8; IRLcoordsy[ 1065]= 29; IRLcoordsxIRL[ 1065]=-11; IRLcoordsyIRL[ 1065]= 3; IRLcoordszIRL[ 1065]= 3
IRLcoordsx[ 1066]= 8; IRLcoordsy[ 1066]= 30; IRLcoordsxIRL[ 1066]=-11; IRLcoordsyIRL[ 1066]= 2; IRLcoordszIRL[ 1066]= 3
IRLcoordsx[ 1067]= 8; IRLcoordsy[ 1067]= 31; IRLcoordsxIRL[ 1067]=-11; IRLcoordsyIRL[ 1067]= 1; IRLcoordszIRL[ 1067]= 3
IRLcoordsx[ 1068]= 9; IRLcoordsy[ 1068]= 20; IRLcoordsxIRL[ 1068]=-11; IRLcoordsyIRL[ 1068]= 12; IRLcoordszIRL[ 1068]= 2
IRLcoordsx[ 1069]= 9; IRLcoordsy[ 1069]= 21; IRLcoordsxIRL[ 1069]=-11; IRLcoordsyIRL[ 1069]= 11; IRLcoordszIRL[ 1069]= 2
IRLcoordsx[ 1070]= 9; IRLcoordsy[ 1070]= 22; IRLcoordsxIRL[ 1070]=-11; IRLcoordsyIRL[ 1070]= 10; IRLcoordszIRL[ 1070]= 2
IRLcoordsx[ 1071]= 9; IRLcoordsy[ 1071]= 23; IRLcoordsxIRL[ 1071]=-11; IRLcoordsyIRL[ 1071]= 9; IRLcoordszIRL[ 1071]= 2
IRLcoordsx[ 1072]= 9; IRLcoordsy[ 1072]= 24; IRLcoordsxIRL[ 1072]=-11; IRLcoordsyIRL[ 1072]= 8; IRLcoordszIRL[ 1072]= 2
IRLcoordsx[ 1073]= 9; IRLcoordsy[ 1073]= 25; IRLcoordsxIRL[ 1073]=-11; IRLcoordsyIRL[ 1073]= 7; IRLcoordszIRL[ 1073]= 2
IRLcoordsx[ 1074]= 9; IRLcoordsy[ 1074]= 26; IRLcoordsxIRL[ 1074]=-11; IRLcoordsyIRL[ 1074]= 6; IRLcoordszIRL[ 1074]= 2
IRLcoordsx[ 1075]= 9; IRLcoordsy[ 1075]= 27; IRLcoordsxIRL[ 1075]=-11; IRLcoordsyIRL[ 1075]= 5; IRLcoordszIRL[ 1075]= 2
IRLcoordsx[ 1076]= 9; IRLcoordsy[ 1076]= 28; IRLcoordsxIRL[ 1076]=-11; IRLcoordsyIRL[ 1076]= 4; IRLcoordszIRL[ 1076]= 2
IRLcoordsx[ 1077]= 9; IRLcoordsy[ 1077]= 29; IRLcoordsxIRL[ 1077]=-11; IRLcoordsyIRL[ 1077]= 3; IRLcoordszIRL[ 1077]= 2
IRLcoordsx[ 1078]= 9; IRLcoordsy[ 1078]= 30; IRLcoordsxIRL[ 1078]=-11; IRLcoordsyIRL[ 1078]= 2; IRLcoordszIRL[ 1078]= 2
IRLcoordsx[ 1079]= 9; IRLcoordsy[ 1079]= 31; IRLcoordsxIRL[ 1079]=-11; IRLcoordsyIRL[ 1079]= 1; IRLcoordszIRL[ 1079]= 2
IRLcoordsx[ 1080]= 10; IRLcoordsy[ 1080]= 20; IRLcoordsxIRL[ 1080]=-11; IRLcoordsyIRL[ 1080]= 12; IRLcoordszIRL[ 1080]= 1
IRLcoordsx[ 1081]= 10; IRLcoordsy[ 1081]= 21; IRLcoordsxIRL[ 1081]=-11; IRLcoordsyIRL[ 1081]= 11; IRLcoordszIRL[ 1081]= 1
IRLcoordsx[ 1082]= 10; IRLcoordsy[ 1082]= 22; IRLcoordsxIRL[ 1082]=-11; IRLcoordsyIRL[ 1082]= 10; IRLcoordszIRL[ 1082]= 1
IRLcoordsx[ 1083]= 10; IRLcoordsy[ 1083]= 23; IRLcoordsxIRL[ 1083]=-11; IRLcoordsyIRL[ 1083]= 9; IRLcoordszIRL[ 1083]= 1
IRLcoordsx[ 1084]= 10; IRLcoordsy[ 1084]= 24; IRLcoordsxIRL[ 1084]=-11; IRLcoordsyIRL[ 1084]= 8; IRLcoordszIRL[ 1084]= 1
IRLcoordsx[ 1085]= 10; IRLcoordsy[ 1085]= 25; IRLcoordsxIRL[ 1085]=-11; IRLcoordsyIRL[ 1085]= 7; IRLcoordszIRL[ 1085]= 1
IRLcoordsx[ 1086]= 10; IRLcoordsy[ 1086]= 26; IRLcoordsxIRL[ 1086]=-11; IRLcoordsyIRL[ 1086]= 6; IRLcoordszIRL[ 1086]= 1
IRLcoordsx[ 1087]= 10; IRLcoordsy[ 1087]= 27; IRLcoordsxIRL[ 1087]=-11; IRLcoordsyIRL[ 1087]= 5; IRLcoordszIRL[ 1087]= 1
IRLcoordsx[ 1088]= 10; IRLcoordsy[ 1088]= 28; IRLcoordsxIRL[ 1088]=-11; IRLcoordsyIRL[ 1088]= 4; IRLcoordszIRL[ 1088]= 1
IRLcoordsx[ 1089]= 10; IRLcoordsy[ 1089]= 29; IRLcoordsxIRL[ 1089]=-11; IRLcoordsyIRL[ 1089]= 3; IRLcoordszIRL[ 1089]= 1
IRLcoordsx[ 1090]= 10; IRLcoordsy[ 1090]= 30; IRLcoordsxIRL[ 1090]=-11; IRLcoordsyIRL[ 1090]= 2; IRLcoordszIRL[ 1090]= 1
IRLcoordsx[ 1091]= 10; IRLcoordsy[ 1091]= 31; IRLcoordsxIRL[ 1091]=-11; IRLcoordsyIRL[ 1091]= 1; IRLcoordszIRL[ 1091]= 1
IRLcoordsx[ 1092]= 11; IRLcoordsy[ 1092]= 20; IRLcoordsxIRL[ 1092]=-11; IRLcoordsyIRL[ 1092]= 12; IRLcoordszIRL[ 1092]= 0
IRLcoordsx[ 1093]= 11; IRLcoordsy[ 1093]= 21; IRLcoordsxIRL[ 1093]=-11; IRLcoordsyIRL[ 1093]= 11; IRLcoordszIRL[ 1093]= 0
IRLcoordsx[ 1094]= 11; IRLcoordsy[ 1094]= 22; IRLcoordsxIRL[ 1094]=-11; IRLcoordsyIRL[ 1094]= 10; IRLcoordszIRL[ 1094]= 0
IRLcoordsx[ 1095]= 11; IRLcoordsy[ 1095]= 23; IRLcoordsxIRL[ 1095]=-11; IRLcoordsyIRL[ 1095]= 9; IRLcoordszIRL[ 1095]= 0
IRLcoordsx[ 1096]= 11; IRLcoordsy[ 1096]= 24; IRLcoordsxIRL[ 1096]=-11; IRLcoordsyIRL[ 1096]= 8; IRLcoordszIRL[ 1096]= 0
IRLcoordsx[ 1097]= 11; IRLcoordsy[ 1097]= 25; IRLcoordsxIRL[ 1097]=-11; IRLcoordsyIRL[ 1097]= 7; IRLcoordszIRL[ 1097]= 0
IRLcoordsx[ 1098]= 11; IRLcoordsy[ 1098]= 26; IRLcoordsxIRL[ 1098]=-11; IRLcoordsyIRL[ 1098]= 6; IRLcoordszIRL[ 1098]= 0
IRLcoordsx[ 1099]= 11; IRLcoordsy[ 1099]= 27; IRLcoordsxIRL[ 1099]=-11; IRLcoordsyIRL[ 1099]= 5; IRLcoordszIRL[ 1099]= 0
IRLcoordsx[ 1100]= 11; IRLcoordsy[ 1100]= 28; IRLcoordsxIRL[ 1100]=-11; IRLcoordsyIRL[ 1100]= 4; IRLcoordszIRL[ 1100]= 0
IRLcoordsx[ 1101]= 11; IRLcoordsy[ 1101]= 29; IRLcoordsxIRL[ 1101]=-11; IRLcoordsyIRL[ 1101]= 3; IRLcoordszIRL[ 1101]= 0
IRLcoordsx[ 1102]= 11; IRLcoordsy[ 1102]= 30; IRLcoordsxIRL[ 1102]=-11; IRLcoordsyIRL[ 1102]= 2; IRLcoordszIRL[ 1102]= 0
IRLcoordsx[ 1103]= 11; IRLcoordsy[ 1103]= 31; IRLcoordsxIRL[ 1103]=-11; IRLcoordsyIRL[ 1103]= 1; IRLcoordszIRL[ 1103]= 0
IRLcoordsx[ 1104]= 0; IRLcoordsy[ 1104]= 20; IRLcoordsxIRL[ 1104]=-16; IRLcoordsyIRL[ 1104]= 12; IRLcoordszIRL[ 1104]= 0
IRLcoordsx[ 1105]= 0; IRLcoordsy[ 1105]= 21; IRLcoordsxIRL[ 1105]=-16; IRLcoordsyIRL[ 1105]= 11; IRLcoordszIRL[ 1105]= 0
IRLcoordsx[ 1106]= 0; IRLcoordsy[ 1106]= 22; IRLcoordsxIRL[ 1106]=-16; IRLcoordsyIRL[ 1106]= 10; IRLcoordszIRL[ 1106]= 0
IRLcoordsx[ 1107]= 0; IRLcoordsy[ 1107]= 23; IRLcoordsxIRL[ 1107]=-16; IRLcoordsyIRL[ 1107]= 9; IRLcoordszIRL[ 1107]= 0
IRLcoordsx[ 1108]= 0; IRLcoordsy[ 1108]= 24; IRLcoordsxIRL[ 1108]=-16; IRLcoordsyIRL[ 1108]= 8; IRLcoordszIRL[ 1108]= 0
IRLcoordsx[ 1109]= 0; IRLcoordsy[ 1109]= 25; IRLcoordsxIRL[ 1109]=-16; IRLcoordsyIRL[ 1109]= 7; IRLcoordszIRL[ 1109]= 0
IRLcoordsx[ 1110]= 0; IRLcoordsy[ 1110]= 26; IRLcoordsxIRL[ 1110]=-16; IRLcoordsyIRL[ 1110]= 6; IRLcoordszIRL[ 1110]= 0
IRLcoordsx[ 1111]= 0; IRLcoordsy[ 1111]= 27; IRLcoordsxIRL[ 1111]=-16; IRLcoordsyIRL[ 1111]= 5; IRLcoordszIRL[ 1111]= 0
IRLcoordsx[ 1112]= 0; IRLcoordsy[ 1112]= 28; IRLcoordsxIRL[ 1112]=-16; IRLcoordsyIRL[ 1112]= 4; IRLcoordszIRL[ 1112]= 0
IRLcoordsx[ 1113]= 0; IRLcoordsy[ 1113]= 29; IRLcoordsxIRL[ 1113]=-16; IRLcoordsyIRL[ 1113]= 3; IRLcoordszIRL[ 1113]= 0
IRLcoordsx[ 1114]= 0; IRLcoordsy[ 1114]= 30; IRLcoordsxIRL[ 1114]=-16; IRLcoordsyIRL[ 1114]= 2; IRLcoordszIRL[ 1114]= 0
IRLcoordsx[ 1115]= 0; IRLcoordsy[ 1115]= 31; IRLcoordsxIRL[ 1115]=-16; IRLcoordsyIRL[ 1115]= 1; IRLcoordszIRL[ 1115]= 0
IRLcoordsx[ 1116]= 1; IRLcoordsy[ 1116]= 20; IRLcoordsxIRL[ 1116]=-16; IRLcoordsyIRL[ 1116]= 12; IRLcoordszIRL[ 1116]= 1
IRLcoordsx[ 1117]= 1; IRLcoordsy[ 1117]= 21; IRLcoordsxIRL[ 1117]=-16; IRLcoordsyIRL[ 1117]= 11; IRLcoordszIRL[ 1117]= 1
IRLcoordsx[ 1118]= 1; IRLcoordsy[ 1118]= 22; IRLcoordsxIRL[ 1118]=-16; IRLcoordsyIRL[ 1118]= 10; IRLcoordszIRL[ 1118]= 1
IRLcoordsx[ 1119]= 1; IRLcoordsy[ 1119]= 23; IRLcoordsxIRL[ 1119]=-16; IRLcoordsyIRL[ 1119]= 9; IRLcoordszIRL[ 1119]= 1
IRLcoordsx[ 1120]= 1; IRLcoordsy[ 1120]= 24; IRLcoordsxIRL[ 1120]=-16; IRLcoordsyIRL[ 1120]= 8; IRLcoordszIRL[ 1120]= 1
IRLcoordsx[ 1121]= 1; IRLcoordsy[ 1121]= 25; IRLcoordsxIRL[ 1121]=-16; IRLcoordsyIRL[ 1121]= 7; IRLcoordszIRL[ 1121]= 1
IRLcoordsx[ 1122]= 1; IRLcoordsy[ 1122]= 26; IRLcoordsxIRL[ 1122]=-16; IRLcoordsyIRL[ 1122]= 6; IRLcoordszIRL[ 1122]= 1
IRLcoordsx[ 1123]= 1; IRLcoordsy[ 1123]= 27; IRLcoordsxIRL[ 1123]=-16; IRLcoordsyIRL[ 1123]= 5; IRLcoordszIRL[ 1123]= 1
IRLcoordsx[ 1124]= 1; IRLcoordsy[ 1124]= 28; IRLcoordsxIRL[ 1124]=-16; IRLcoordsyIRL[ 1124]= 4; IRLcoordszIRL[ 1124]= 1
IRLcoordsx[ 1125]= 1; IRLcoordsy[ 1125]= 29; IRLcoordsxIRL[ 1125]=-16; IRLcoordsyIRL[ 1125]= 3; IRLcoordszIRL[ 1125]= 1
IRLcoordsx[ 1126]= 1; IRLcoordsy[ 1126]= 30; IRLcoordsxIRL[ 1126]=-16; IRLcoordsyIRL[ 1126]= 2; IRLcoordszIRL[ 1126]= 1
IRLcoordsx[ 1127]= 1; IRLcoordsy[ 1127]= 31; IRLcoordsxIRL[ 1127]=-16; IRLcoordsyIRL[ 1127]= 1; IRLcoordszIRL[ 1127]= 1
IRLcoordsx[ 1128]= 2; IRLcoordsy[ 1128]= 20; IRLcoordsxIRL[ 1128]=-16; IRLcoordsyIRL[ 1128]= 12; IRLcoordszIRL[ 1128]= 2
IRLcoordsx[ 1129]= 2; IRLcoordsy[ 1129]= 21; IRLcoordsxIRL[ 1129]=-16; IRLcoordsyIRL[ 1129]= 11; IRLcoordszIRL[ 1129]= 2
IRLcoordsx[ 1130]= 2; IRLcoordsy[ 1130]= 22; IRLcoordsxIRL[ 1130]=-16; IRLcoordsyIRL[ 1130]= 10; IRLcoordszIRL[ 1130]= 2
IRLcoordsx[ 1131]= 2; IRLcoordsy[ 1131]= 23; IRLcoordsxIRL[ 1131]=-16; IRLcoordsyIRL[ 1131]= 9; IRLcoordszIRL[ 1131]= 2
IRLcoordsx[ 1132]= 2; IRLcoordsy[ 1132]= 24; IRLcoordsxIRL[ 1132]=-16; IRLcoordsyIRL[ 1132]= 8; IRLcoordszIRL[ 1132]= 2
IRLcoordsx[ 1133]= 2; IRLcoordsy[ 1133]= 25; IRLcoordsxIRL[ 1133]=-16; IRLcoordsyIRL[ 1133]= 7; IRLcoordszIRL[ 1133]= 2
IRLcoordsx[ 1134]= 2; IRLcoordsy[ 1134]= 26; IRLcoordsxIRL[ 1134]=-16; IRLcoordsyIRL[ 1134]= 6; IRLcoordszIRL[ 1134]= 2
IRLcoordsx[ 1135]= 2; IRLcoordsy[ 1135]= 27; IRLcoordsxIRL[ 1135]=-16; IRLcoordsyIRL[ 1135]= 5; IRLcoordszIRL[ 1135]= 2
IRLcoordsx[ 1136]= 2; IRLcoordsy[ 1136]= 28; IRLcoordsxIRL[ 1136]=-16; IRLcoordsyIRL[ 1136]= 4; IRLcoordszIRL[ 1136]= 2
IRLcoordsx[ 1137]= 2; IRLcoordsy[ 1137]= 29; IRLcoordsxIRL[ 1137]=-16; IRLcoordsyIRL[ 1137]= 3; IRLcoordszIRL[ 1137]= 2
IRLcoordsx[ 1138]= 2; IRLcoordsy[ 1138]= 30; IRLcoordsxIRL[ 1138]=-16; IRLcoordsyIRL[ 1138]= 2; IRLcoordszIRL[ 1138]= 2
IRLcoordsx[ 1139]= 2; IRLcoordsy[ 1139]= 31; IRLcoordsxIRL[ 1139]=-16; IRLcoordsyIRL[ 1139]= 1; IRLcoordszIRL[ 1139]= 2
IRLcoordsx[ 1140]= 3; IRLcoordsy[ 1140]= 20; IRLcoordsxIRL[ 1140]=-16; IRLcoordsyIRL[ 1140]= 12; IRLcoordszIRL[ 1140]= 3
IRLcoordsx[ 1141]= 3; IRLcoordsy[ 1141]= 21; IRLcoordsxIRL[ 1141]=-16; IRLcoordsyIRL[ 1141]= 11; IRLcoordszIRL[ 1141]= 3
IRLcoordsx[ 1142]= 3; IRLcoordsy[ 1142]= 22; IRLcoordsxIRL[ 1142]=-16; IRLcoordsyIRL[ 1142]= 10; IRLcoordszIRL[ 1142]= 3
IRLcoordsx[ 1143]= 3; IRLcoordsy[ 1143]= 23; IRLcoordsxIRL[ 1143]=-16; IRLcoordsyIRL[ 1143]= 9; IRLcoordszIRL[ 1143]= 3
IRLcoordsx[ 1144]= 3; IRLcoordsy[ 1144]= 24; IRLcoordsxIRL[ 1144]=-16; IRLcoordsyIRL[ 1144]= 8; IRLcoordszIRL[ 1144]= 3
IRLcoordsx[ 1145]= 3; IRLcoordsy[ 1145]= 25; IRLcoordsxIRL[ 1145]=-16; IRLcoordsyIRL[ 1145]= 7; IRLcoordszIRL[ 1145]= 3
IRLcoordsx[ 1146]= 3; IRLcoordsy[ 1146]= 26; IRLcoordsxIRL[ 1146]=-16; IRLcoordsyIRL[ 1146]= 6; IRLcoordszIRL[ 1146]= 3
IRLcoordsx[ 1147]= 3; IRLcoordsy[ 1147]= 27; IRLcoordsxIRL[ 1147]=-16; IRLcoordsyIRL[ 1147]= 5; IRLcoordszIRL[ 1147]= 3
IRLcoordsx[ 1148]= 3; IRLcoordsy[ 1148]= 28; IRLcoordsxIRL[ 1148]=-16; IRLcoordsyIRL[ 1148]= 4; IRLcoordszIRL[ 1148]= 3
IRLcoordsx[ 1149]= 3; IRLcoordsy[ 1149]= 29; IRLcoordsxIRL[ 1149]=-16; IRLcoordsyIRL[ 1149]= 3; IRLcoordszIRL[ 1149]= 3
IRLcoordsx[ 1150]= 3; IRLcoordsy[ 1150]= 30; IRLcoordsxIRL[ 1150]=-16; IRLcoordsyIRL[ 1150]= 2; IRLcoordszIRL[ 1150]= 3
IRLcoordsx[ 1151]= 3; IRLcoordsy[ 1151]= 31; IRLcoordsxIRL[ 1151]=-16; IRLcoordsyIRL[ 1151]= 1; IRLcoordszIRL[ 1151]= 3
IRLcoordsx[ 1152]= 4; IRLcoordsy[ 1152]= 16; IRLcoordsxIRL[ 1152]=-15; IRLcoordsyIRL[ 1152]= 13; IRLcoordszIRL[ 1152]= 0
IRLcoordsx[ 1153]= 4; IRLcoordsy[ 1153]= 17; IRLcoordsxIRL[ 1153]=-15; IRLcoordsyIRL[ 1153]= 13; IRLcoordszIRL[ 1153]= 1
IRLcoordsx[ 1154]= 4; IRLcoordsy[ 1154]= 18; IRLcoordsxIRL[ 1154]=-15; IRLcoordsyIRL[ 1154]= 13; IRLcoordszIRL[ 1154]= 2
IRLcoordsx[ 1155]= 4; IRLcoordsy[ 1155]= 19; IRLcoordsxIRL[ 1155]=-15; IRLcoordsyIRL[ 1155]= 13; IRLcoordszIRL[ 1155]= 3
IRLcoordsx[ 1156]= 5; IRLcoordsy[ 1156]= 16; IRLcoordsxIRL[ 1156]=-14; IRLcoordsyIRL[ 1156]= 13; IRLcoordszIRL[ 1156]= 0
IRLcoordsx[ 1157]= 5; IRLcoordsy[ 1157]= 17; IRLcoordsxIRL[ 1157]=-14; IRLcoordsyIRL[ 1157]= 13; IRLcoordszIRL[ 1157]= 1
IRLcoordsx[ 1158]= 5; IRLcoordsy[ 1158]= 18; IRLcoordsxIRL[ 1158]=-14; IRLcoordsyIRL[ 1158]= 13; IRLcoordszIRL[ 1158]= 2
IRLcoordsx[ 1159]= 5; IRLcoordsy[ 1159]= 19; IRLcoordsxIRL[ 1159]=-14; IRLcoordsyIRL[ 1159]= 13; IRLcoordszIRL[ 1159]= 3
IRLcoordsx[ 1160]= 6; IRLcoordsy[ 1160]= 16; IRLcoordsxIRL[ 1160]=-13; IRLcoordsyIRL[ 1160]= 13; IRLcoordszIRL[ 1160]= 0
IRLcoordsx[ 1161]= 6; IRLcoordsy[ 1161]= 17; IRLcoordsxIRL[ 1161]=-13; IRLcoordsyIRL[ 1161]= 13; IRLcoordszIRL[ 1161]= 1
IRLcoordsx[ 1162]= 6; IRLcoordsy[ 1162]= 18; IRLcoordsxIRL[ 1162]=-13; IRLcoordsyIRL[ 1162]= 13; IRLcoordszIRL[ 1162]= 2
IRLcoordsx[ 1163]= 6; IRLcoordsy[ 1163]= 19; IRLcoordsxIRL[ 1163]=-13; IRLcoordsyIRL[ 1163]= 13; IRLcoordszIRL[ 1163]= 3
IRLcoordsx[ 1164]= 7; IRLcoordsy[ 1164]= 16; IRLcoordsxIRL[ 1164]=-12; IRLcoordsyIRL[ 1164]= 13; IRLcoordszIRL[ 1164]= 0
IRLcoordsx[ 1165]= 7; IRLcoordsy[ 1165]= 17; IRLcoordsxIRL[ 1165]=-12; IRLcoordsyIRL[ 1165]= 13; IRLcoordszIRL[ 1165]= 1
IRLcoordsx[ 1166]= 7; IRLcoordsy[ 1166]= 18; IRLcoordsxIRL[ 1166]=-12; IRLcoordsyIRL[ 1166]= 13; IRLcoordszIRL[ 1166]= 2
IRLcoordsx[ 1167]= 7; IRLcoordsy[ 1167]= 19; IRLcoordsxIRL[ 1167]=-12; IRLcoordsyIRL[ 1167]= 13; IRLcoordszIRL[ 1167]= 3
IRLcoordsx[ 1168]= 8; IRLcoordsy[ 1168]= 16; IRLcoordsxIRL[ 1168]=-15; IRLcoordsyIRL[ 1168]= 0; IRLcoordszIRL[ 1168]= 0
IRLcoordsx[ 1169]= 8; IRLcoordsy[ 1169]= 17; IRLcoordsxIRL[ 1169]=-15; IRLcoordsyIRL[ 1169]= 0; IRLcoordszIRL[ 1169]= 1
IRLcoordsx[ 1170]= 8; IRLcoordsy[ 1170]= 18; IRLcoordsxIRL[ 1170]=-15; IRLcoordsyIRL[ 1170]= 0; IRLcoordszIRL[ 1170]= 2
IRLcoordsx[ 1171]= 8; IRLcoordsy[ 1171]= 19; IRLcoordsxIRL[ 1171]=-15; IRLcoordsyIRL[ 1171]= 0; IRLcoordszIRL[ 1171]= 3
IRLcoordsx[ 1172]= 9; IRLcoordsy[ 1172]= 16; IRLcoordsxIRL[ 1172]=-14; IRLcoordsyIRL[ 1172]= 0; IRLcoordszIRL[ 1172]= 0
IRLcoordsx[ 1173]= 9; IRLcoordsy[ 1173]= 17; IRLcoordsxIRL[ 1173]=-14; IRLcoordsyIRL[ 1173]= 0; IRLcoordszIRL[ 1173]= 1
IRLcoordsx[ 1174]= 9; IRLcoordsy[ 1174]= 18; IRLcoordsxIRL[ 1174]=-14; IRLcoordsyIRL[ 1174]= 0; IRLcoordszIRL[ 1174]= 2
IRLcoordsx[ 1175]= 9; IRLcoordsy[ 1175]= 19; IRLcoordsxIRL[ 1175]=-14; IRLcoordsyIRL[ 1175]= 0; IRLcoordszIRL[ 1175]= 3
IRLcoordsx[ 1176]= 10; IRLcoordsy[ 1176]= 16; IRLcoordsxIRL[ 1176]=-13; IRLcoordsyIRL[ 1176]= 0; IRLcoordszIRL[ 1176]= 0
IRLcoordsx[ 1177]= 10; IRLcoordsy[ 1177]= 17; IRLcoordsxIRL[ 1177]=-13; IRLcoordsyIRL[ 1177]= 0; IRLcoordszIRL[ 1177]= 1
IRLcoordsx[ 1178]= 10; IRLcoordsy[ 1178]= 18; IRLcoordsxIRL[ 1178]=-13; IRLcoordsyIRL[ 1178]= 0; IRLcoordszIRL[ 1178]= 2
IRLcoordsx[ 1179]= 10; IRLcoordsy[ 1179]= 19; IRLcoordsxIRL[ 1179]=-13; IRLcoordsyIRL[ 1179]= 0; IRLcoordszIRL[ 1179]= 3
IRLcoordsx[ 1180]= 11; IRLcoordsy[ 1180]= 16; IRLcoordsxIRL[ 1180]=-12; IRLcoordsyIRL[ 1180]= 0; IRLcoordszIRL[ 1180]= 0
IRLcoordsx[ 1181]= 11; IRLcoordsy[ 1181]= 17; IRLcoordsxIRL[ 1181]=-12; IRLcoordsyIRL[ 1181]= 0; IRLcoordszIRL[ 1181]= 1
IRLcoordsx[ 1182]= 11; IRLcoordsy[ 1182]= 18; IRLcoordsxIRL[ 1182]=-12; IRLcoordsyIRL[ 1182]= 0; IRLcoordszIRL[ 1182]= 2
IRLcoordsx[ 1183]= 11; IRLcoordsy[ 1183]= 19; IRLcoordsxIRL[ 1183]=-12; IRLcoordsyIRL[ 1183]= 0; IRLcoordszIRL[ 1183]= 3
IRLcoordsx[ 1184]= 44; IRLcoordsy[ 1184]= 52; IRLcoordsxIRL[ 1184]= 2; IRLcoordsyIRL[ 1184]= 28; IRLcoordszIRL[ 1184]= 0
IRLcoordsx[ 1185]= 44; IRLcoordsy[ 1185]= 53; IRLcoordsxIRL[ 1185]= 2; IRLcoordsyIRL[ 1185]= 27; IRLcoordszIRL[ 1185]= 0
IRLcoordsx[ 1186]= 44; IRLcoordsy[ 1186]= 54; IRLcoordsxIRL[ 1186]= 2; IRLcoordsyIRL[ 1186]= 26; IRLcoordszIRL[ 1186]= 0
IRLcoordsx[ 1187]= 44; IRLcoordsy[ 1187]= 55; IRLcoordsxIRL[ 1187]= 2; IRLcoordsyIRL[ 1187]= 25; IRLcoordszIRL[ 1187]= 0
IRLcoordsx[ 1188]= 44; IRLcoordsy[ 1188]= 56; IRLcoordsxIRL[ 1188]= 2; IRLcoordsyIRL[ 1188]= 24; IRLcoordszIRL[ 1188]= 0
IRLcoordsx[ 1189]= 44; IRLcoordsy[ 1189]= 57; IRLcoordsxIRL[ 1189]= 2; IRLcoordsyIRL[ 1189]= 23; IRLcoordszIRL[ 1189]= 0
IRLcoordsx[ 1190]= 44; IRLcoordsy[ 1190]= 58; IRLcoordsxIRL[ 1190]= 2; IRLcoordsyIRL[ 1190]= 22; IRLcoordszIRL[ 1190]= 0
IRLcoordsx[ 1191]= 44; IRLcoordsy[ 1191]= 59; IRLcoordsxIRL[ 1191]= 2; IRLcoordsyIRL[ 1191]= 21; IRLcoordszIRL[ 1191]= 0
IRLcoordsx[ 1192]= 44; IRLcoordsy[ 1192]= 60; IRLcoordsxIRL[ 1192]= 2; IRLcoordsyIRL[ 1192]= 20; IRLcoordszIRL[ 1192]= 0
IRLcoordsx[ 1193]= 44; IRLcoordsy[ 1193]= 61; IRLcoordsxIRL[ 1193]= 2; IRLcoordsyIRL[ 1193]= 19; IRLcoordszIRL[ 1193]= 0
IRLcoordsx[ 1194]= 44; IRLcoordsy[ 1194]= 62; IRLcoordsxIRL[ 1194]= 2; IRLcoordsyIRL[ 1194]= 18; IRLcoordszIRL[ 1194]= 0
IRLcoordsx[ 1195]= 44; IRLcoordsy[ 1195]= 63; IRLcoordsxIRL[ 1195]= 2; IRLcoordsyIRL[ 1195]= 17; IRLcoordszIRL[ 1195]= 0
IRLcoordsx[ 1196]= 45; IRLcoordsy[ 1196]= 52; IRLcoordsxIRL[ 1196]= 1; IRLcoordsyIRL[ 1196]= 28; IRLcoordszIRL[ 1196]= 0
IRLcoordsx[ 1197]= 45; IRLcoordsy[ 1197]= 53; IRLcoordsxIRL[ 1197]= 1; IRLcoordsyIRL[ 1197]= 27; IRLcoordszIRL[ 1197]= 0
IRLcoordsx[ 1198]= 45; IRLcoordsy[ 1198]= 54; IRLcoordsxIRL[ 1198]= 1; IRLcoordsyIRL[ 1198]= 26; IRLcoordszIRL[ 1198]= 0
IRLcoordsx[ 1199]= 45; IRLcoordsy[ 1199]= 55; IRLcoordsxIRL[ 1199]= 1; IRLcoordsyIRL[ 1199]= 25; IRLcoordszIRL[ 1199]= 0
IRLcoordsx[ 1200]= 45; IRLcoordsy[ 1200]= 56; IRLcoordsxIRL[ 1200]= 1; IRLcoordsyIRL[ 1200]= 24; IRLcoordszIRL[ 1200]= 0
IRLcoordsx[ 1201]= 45; IRLcoordsy[ 1201]= 57; IRLcoordsxIRL[ 1201]= 1; IRLcoordsyIRL[ 1201]= 23; IRLcoordszIRL[ 1201]= 0
IRLcoordsx[ 1202]= 45; IRLcoordsy[ 1202]= 58; IRLcoordsxIRL[ 1202]= 1; IRLcoordsyIRL[ 1202]= 22; IRLcoordszIRL[ 1202]= 0
IRLcoordsx[ 1203]= 45; IRLcoordsy[ 1203]= 59; IRLcoordsxIRL[ 1203]= 1; IRLcoordsyIRL[ 1203]= 21; IRLcoordszIRL[ 1203]= 0
IRLcoordsx[ 1204]= 45; IRLcoordsy[ 1204]= 60; IRLcoordsxIRL[ 1204]= 1; IRLcoordsyIRL[ 1204]= 20; IRLcoordszIRL[ 1204]= 0
IRLcoordsx[ 1205]= 45; IRLcoordsy[ 1205]= 61; IRLcoordsxIRL[ 1205]= 1; IRLcoordsyIRL[ 1205]= 19; IRLcoordszIRL[ 1205]= 0
IRLcoordsx[ 1206]= 45; IRLcoordsy[ 1206]= 62; IRLcoordsxIRL[ 1206]= 1; IRLcoordsyIRL[ 1206]= 18; IRLcoordszIRL[ 1206]= 0
IRLcoordsx[ 1207]= 45; IRLcoordsy[ 1207]= 63; IRLcoordsxIRL[ 1207]= 1; IRLcoordsyIRL[ 1207]= 17; IRLcoordszIRL[ 1207]= 0
IRLcoordsx[ 1208]= 46; IRLcoordsy[ 1208]= 52; IRLcoordsxIRL[ 1208]= 0; IRLcoordsyIRL[ 1208]= 28; IRLcoordszIRL[ 1208]= 0
IRLcoordsx[ 1209]= 46; IRLcoordsy[ 1209]= 53; IRLcoordsxIRL[ 1209]= 0; IRLcoordsyIRL[ 1209]= 27; IRLcoordszIRL[ 1209]= 0
IRLcoordsx[ 1210]= 46; IRLcoordsy[ 1210]= 54; IRLcoordsxIRL[ 1210]= 0; IRLcoordsyIRL[ 1210]= 26; IRLcoordszIRL[ 1210]= 0
IRLcoordsx[ 1211]= 46; IRLcoordsy[ 1211]= 55; IRLcoordsxIRL[ 1211]= 0; IRLcoordsyIRL[ 1211]= 25; IRLcoordszIRL[ 1211]= 0
IRLcoordsx[ 1212]= 46; IRLcoordsy[ 1212]= 56; IRLcoordsxIRL[ 1212]= 0; IRLcoordsyIRL[ 1212]= 24; IRLcoordszIRL[ 1212]= 0
IRLcoordsx[ 1213]= 46; IRLcoordsy[ 1213]= 57; IRLcoordsxIRL[ 1213]= 0; IRLcoordsyIRL[ 1213]= 23; IRLcoordszIRL[ 1213]= 0
IRLcoordsx[ 1214]= 46; IRLcoordsy[ 1214]= 58; IRLcoordsxIRL[ 1214]= 0; IRLcoordsyIRL[ 1214]= 22; IRLcoordszIRL[ 1214]= 0
IRLcoordsx[ 1215]= 46; IRLcoordsy[ 1215]= 59; IRLcoordsxIRL[ 1215]= 0; IRLcoordsyIRL[ 1215]= 21; IRLcoordszIRL[ 1215]= 0
IRLcoordsx[ 1216]= 46; IRLcoordsy[ 1216]= 60; IRLcoordsxIRL[ 1216]= 0; IRLcoordsyIRL[ 1216]= 20; IRLcoordszIRL[ 1216]= 0
IRLcoordsx[ 1217]= 46; IRLcoordsy[ 1217]= 61; IRLcoordsxIRL[ 1217]= 0; IRLcoordsyIRL[ 1217]= 19; IRLcoordszIRL[ 1217]= 0
IRLcoordsx[ 1218]= 46; IRLcoordsy[ 1218]= 62; IRLcoordsxIRL[ 1218]= 0; IRLcoordsyIRL[ 1218]= 18; IRLcoordszIRL[ 1218]= 0
IRLcoordsx[ 1219]= 46; IRLcoordsy[ 1219]= 63; IRLcoordsxIRL[ 1219]= 0; IRLcoordsyIRL[ 1219]= 17; IRLcoordszIRL[ 1219]= 0
IRLcoordsx[ 1220]= 47; IRLcoordsy[ 1220]= 52; IRLcoordsxIRL[ 1220]=-1; IRLcoordsyIRL[ 1220]= 28; IRLcoordszIRL[ 1220]= 0
IRLcoordsx[ 1221]= 47; IRLcoordsy[ 1221]= 53; IRLcoordsxIRL[ 1221]=-1; IRLcoordsyIRL[ 1221]= 27; IRLcoordszIRL[ 1221]= 0
IRLcoordsx[ 1222]= 47; IRLcoordsy[ 1222]= 54; IRLcoordsxIRL[ 1222]=-1; IRLcoordsyIRL[ 1222]= 26; IRLcoordszIRL[ 1222]= 0
IRLcoordsx[ 1223]= 47; IRLcoordsy[ 1223]= 55; IRLcoordsxIRL[ 1223]=-1; IRLcoordsyIRL[ 1223]= 25; IRLcoordszIRL[ 1223]= 0
IRLcoordsx[ 1224]= 47; IRLcoordsy[ 1224]= 56; IRLcoordsxIRL[ 1224]=-1; IRLcoordsyIRL[ 1224]= 24; IRLcoordszIRL[ 1224]= 0
IRLcoordsx[ 1225]= 47; IRLcoordsy[ 1225]= 57; IRLcoordsxIRL[ 1225]=-1; IRLcoordsyIRL[ 1225]= 23; IRLcoordszIRL[ 1225]= 0
IRLcoordsx[ 1226]= 47; IRLcoordsy[ 1226]= 58; IRLcoordsxIRL[ 1226]=-1; IRLcoordsyIRL[ 1226]= 22; IRLcoordszIRL[ 1226]= 0
IRLcoordsx[ 1227]= 47; IRLcoordsy[ 1227]= 59; IRLcoordsxIRL[ 1227]=-1; IRLcoordsyIRL[ 1227]= 21; IRLcoordszIRL[ 1227]= 0
IRLcoordsx[ 1228]= 47; IRLcoordsy[ 1228]= 60; IRLcoordsxIRL[ 1228]=-1; IRLcoordsyIRL[ 1228]= 20; IRLcoordszIRL[ 1228]= 0
IRLcoordsx[ 1229]= 47; IRLcoordsy[ 1229]= 61; IRLcoordsxIRL[ 1229]=-1; IRLcoordsyIRL[ 1229]= 19; IRLcoordszIRL[ 1229]= 0
IRLcoordsx[ 1230]= 47; IRLcoordsy[ 1230]= 62; IRLcoordsxIRL[ 1230]=-1; IRLcoordsyIRL[ 1230]= 18; IRLcoordszIRL[ 1230]= 0
IRLcoordsx[ 1231]= 47; IRLcoordsy[ 1231]= 63; IRLcoordsxIRL[ 1231]=-1; IRLcoordsyIRL[ 1231]= 17; IRLcoordszIRL[ 1231]= 0
IRLcoordsx[ 1232]= 36; IRLcoordsy[ 1232]= 52; IRLcoordsxIRL[ 1232]=-1; IRLcoordsyIRL[ 1232]= 28; IRLcoordszIRL[ 1232]= 5
IRLcoordsx[ 1233]= 36; IRLcoordsy[ 1233]= 53; IRLcoordsxIRL[ 1233]=-1; IRLcoordsyIRL[ 1233]= 27; IRLcoordszIRL[ 1233]= 5
IRLcoordsx[ 1234]= 36; IRLcoordsy[ 1234]= 54; IRLcoordsxIRL[ 1234]=-1; IRLcoordsyIRL[ 1234]= 26; IRLcoordszIRL[ 1234]= 5
IRLcoordsx[ 1235]= 36; IRLcoordsy[ 1235]= 55; IRLcoordsxIRL[ 1235]=-1; IRLcoordsyIRL[ 1235]= 25; IRLcoordszIRL[ 1235]= 5
IRLcoordsx[ 1236]= 36; IRLcoordsy[ 1236]= 56; IRLcoordsxIRL[ 1236]=-1; IRLcoordsyIRL[ 1236]= 24; IRLcoordszIRL[ 1236]= 5
IRLcoordsx[ 1237]= 36; IRLcoordsy[ 1237]= 57; IRLcoordsxIRL[ 1237]=-1; IRLcoordsyIRL[ 1237]= 23; IRLcoordszIRL[ 1237]= 5
IRLcoordsx[ 1238]= 36; IRLcoordsy[ 1238]= 58; IRLcoordsxIRL[ 1238]=-1; IRLcoordsyIRL[ 1238]= 22; IRLcoordszIRL[ 1238]= 5
IRLcoordsx[ 1239]= 36; IRLcoordsy[ 1239]= 59; IRLcoordsxIRL[ 1239]=-1; IRLcoordsyIRL[ 1239]= 21; IRLcoordszIRL[ 1239]= 5
IRLcoordsx[ 1240]= 36; IRLcoordsy[ 1240]= 60; IRLcoordsxIRL[ 1240]=-1; IRLcoordsyIRL[ 1240]= 20; IRLcoordszIRL[ 1240]= 5
IRLcoordsx[ 1241]= 36; IRLcoordsy[ 1241]= 61; IRLcoordsxIRL[ 1241]=-1; IRLcoordsyIRL[ 1241]= 19; IRLcoordszIRL[ 1241]= 5
IRLcoordsx[ 1242]= 36; IRLcoordsy[ 1242]= 62; IRLcoordsxIRL[ 1242]=-1; IRLcoordsyIRL[ 1242]= 18; IRLcoordszIRL[ 1242]= 5
IRLcoordsx[ 1243]= 36; IRLcoordsy[ 1243]= 63; IRLcoordsxIRL[ 1243]=-1; IRLcoordsyIRL[ 1243]= 17; IRLcoordszIRL[ 1243]= 5
IRLcoordsx[ 1244]= 37; IRLcoordsy[ 1244]= 52; IRLcoordsxIRL[ 1244]= 0; IRLcoordsyIRL[ 1244]= 28; IRLcoordszIRL[ 1244]= 5
IRLcoordsx[ 1245]= 37; IRLcoordsy[ 1245]= 53; IRLcoordsxIRL[ 1245]= 0; IRLcoordsyIRL[ 1245]= 27; IRLcoordszIRL[ 1245]= 5
IRLcoordsx[ 1246]= 37; IRLcoordsy[ 1246]= 54; IRLcoordsxIRL[ 1246]= 0; IRLcoordsyIRL[ 1246]= 26; IRLcoordszIRL[ 1246]= 5
IRLcoordsx[ 1247]= 37; IRLcoordsy[ 1247]= 55; IRLcoordsxIRL[ 1247]= 0; IRLcoordsyIRL[ 1247]= 25; IRLcoordszIRL[ 1247]= 5
IRLcoordsx[ 1248]= 37; IRLcoordsy[ 1248]= 56; IRLcoordsxIRL[ 1248]= 0; IRLcoordsyIRL[ 1248]= 24; IRLcoordszIRL[ 1248]= 5
IRLcoordsx[ 1249]= 37; IRLcoordsy[ 1249]= 57; IRLcoordsxIRL[ 1249]= 0; IRLcoordsyIRL[ 1249]= 23; IRLcoordszIRL[ 1249]= 5
IRLcoordsx[ 1250]= 37; IRLcoordsy[ 1250]= 58; IRLcoordsxIRL[ 1250]= 0; IRLcoordsyIRL[ 1250]= 22; IRLcoordszIRL[ 1250]= 5
IRLcoordsx[ 1251]= 37; IRLcoordsy[ 1251]= 59; IRLcoordsxIRL[ 1251]= 0; IRLcoordsyIRL[ 1251]= 21; IRLcoordszIRL[ 1251]= 5
IRLcoordsx[ 1252]= 37; IRLcoordsy[ 1252]= 60; IRLcoordsxIRL[ 1252]= 0; IRLcoordsyIRL[ 1252]= 20; IRLcoordszIRL[ 1252]= 5
IRLcoordsx[ 1253]= 37; IRLcoordsy[ 1253]= 61; IRLcoordsxIRL[ 1253]= 0; IRLcoordsyIRL[ 1253]= 19; IRLcoordszIRL[ 1253]= 5
IRLcoordsx[ 1254]= 37; IRLcoordsy[ 1254]= 62; IRLcoordsxIRL[ 1254]= 0; IRLcoordsyIRL[ 1254]= 18; IRLcoordszIRL[ 1254]= 5
IRLcoordsx[ 1255]= 37; IRLcoordsy[ 1255]= 63; IRLcoordsxIRL[ 1255]= 0; IRLcoordsyIRL[ 1255]= 17; IRLcoordszIRL[ 1255]= 5
IRLcoordsx[ 1256]= 38; IRLcoordsy[ 1256]= 52; IRLcoordsxIRL[ 1256]= 1; IRLcoordsyIRL[ 1256]= 28; IRLcoordszIRL[ 1256]= 5
IRLcoordsx[ 1257]= 38; IRLcoordsy[ 1257]= 53; IRLcoordsxIRL[ 1257]= 1; IRLcoordsyIRL[ 1257]= 27; IRLcoordszIRL[ 1257]= 5
IRLcoordsx[ 1258]= 38; IRLcoordsy[ 1258]= 54; IRLcoordsxIRL[ 1258]= 1; IRLcoordsyIRL[ 1258]= 26; IRLcoordszIRL[ 1258]= 5
IRLcoordsx[ 1259]= 38; IRLcoordsy[ 1259]= 55; IRLcoordsxIRL[ 1259]= 1; IRLcoordsyIRL[ 1259]= 25; IRLcoordszIRL[ 1259]= 5
IRLcoordsx[ 1260]= 38; IRLcoordsy[ 1260]= 56; IRLcoordsxIRL[ 1260]= 1; IRLcoordsyIRL[ 1260]= 24; IRLcoordszIRL[ 1260]= 5
IRLcoordsx[ 1261]= 38; IRLcoordsy[ 1261]= 57; IRLcoordsxIRL[ 1261]= 1; IRLcoordsyIRL[ 1261]= 23; IRLcoordszIRL[ 1261]= 5
IRLcoordsx[ 1262]= 38; IRLcoordsy[ 1262]= 58; IRLcoordsxIRL[ 1262]= 1; IRLcoordsyIRL[ 1262]= 22; IRLcoordszIRL[ 1262]= 5
IRLcoordsx[ 1263]= 38; IRLcoordsy[ 1263]= 59; IRLcoordsxIRL[ 1263]= 1; IRLcoordsyIRL[ 1263]= 21; IRLcoordszIRL[ 1263]= 5
IRLcoordsx[ 1264]= 38; IRLcoordsy[ 1264]= 60; IRLcoordsxIRL[ 1264]= 1; IRLcoordsyIRL[ 1264]= 20; IRLcoordszIRL[ 1264]= 5
IRLcoordsx[ 1265]= 38; IRLcoordsy[ 1265]= 61; IRLcoordsxIRL[ 1265]= 1; IRLcoordsyIRL[ 1265]= 19; IRLcoordszIRL[ 1265]= 5
IRLcoordsx[ 1266]= 38; IRLcoordsy[ 1266]= 62; IRLcoordsxIRL[ 1266]= 1; IRLcoordsyIRL[ 1266]= 18; IRLcoordszIRL[ 1266]= 5
IRLcoordsx[ 1267]= 38; IRLcoordsy[ 1267]= 63; IRLcoordsxIRL[ 1267]= 1; IRLcoordsyIRL[ 1267]= 17; IRLcoordszIRL[ 1267]= 5
IRLcoordsx[ 1268]= 39; IRLcoordsy[ 1268]= 52; IRLcoordsxIRL[ 1268]= 2; IRLcoordsyIRL[ 1268]= 28; IRLcoordszIRL[ 1268]= 5
IRLcoordsx[ 1269]= 39; IRLcoordsy[ 1269]= 53; IRLcoordsxIRL[ 1269]= 2; IRLcoordsyIRL[ 1269]= 27; IRLcoordszIRL[ 1269]= 5
IRLcoordsx[ 1270]= 39; IRLcoordsy[ 1270]= 54; IRLcoordsxIRL[ 1270]= 2; IRLcoordsyIRL[ 1270]= 26; IRLcoordszIRL[ 1270]= 5
IRLcoordsx[ 1271]= 39; IRLcoordsy[ 1271]= 55; IRLcoordsxIRL[ 1271]= 2; IRLcoordsyIRL[ 1271]= 25; IRLcoordszIRL[ 1271]= 5
IRLcoordsx[ 1272]= 39; IRLcoordsy[ 1272]= 56; IRLcoordsxIRL[ 1272]= 2; IRLcoordsyIRL[ 1272]= 24; IRLcoordszIRL[ 1272]= 5
IRLcoordsx[ 1273]= 39; IRLcoordsy[ 1273]= 57; IRLcoordsxIRL[ 1273]= 2; IRLcoordsyIRL[ 1273]= 23; IRLcoordszIRL[ 1273]= 5
IRLcoordsx[ 1274]= 39; IRLcoordsy[ 1274]= 58; IRLcoordsxIRL[ 1274]= 2; IRLcoordsyIRL[ 1274]= 22; IRLcoordszIRL[ 1274]= 5
IRLcoordsx[ 1275]= 39; IRLcoordsy[ 1275]= 59; IRLcoordsxIRL[ 1275]= 2; IRLcoordsyIRL[ 1275]= 21; IRLcoordszIRL[ 1275]= 5
IRLcoordsx[ 1276]= 39; IRLcoordsy[ 1276]= 60; IRLcoordsxIRL[ 1276]= 2; IRLcoordsyIRL[ 1276]= 20; IRLcoordszIRL[ 1276]= 5
IRLcoordsx[ 1277]= 39; IRLcoordsy[ 1277]= 61; IRLcoordsxIRL[ 1277]= 2; IRLcoordsyIRL[ 1277]= 19; IRLcoordszIRL[ 1277]= 5
IRLcoordsx[ 1278]= 39; IRLcoordsy[ 1278]= 62; IRLcoordsxIRL[ 1278]= 2; IRLcoordsyIRL[ 1278]= 18; IRLcoordszIRL[ 1278]= 5
IRLcoordsx[ 1279]= 39; IRLcoordsy[ 1279]= 63; IRLcoordsxIRL[ 1279]= 2; IRLcoordsyIRL[ 1279]= 17; IRLcoordszIRL[ 1279]= 5
IRLcoordsx[ 1280]= 40; IRLcoordsy[ 1280]= 52; IRLcoordsxIRL[ 1280]= 3; IRLcoordsyIRL[ 1280]= 28; IRLcoordszIRL[ 1280]= 4
IRLcoordsx[ 1281]= 40; IRLcoordsy[ 1281]= 53; IRLcoordsxIRL[ 1281]= 3; IRLcoordsyIRL[ 1281]= 27; IRLcoordszIRL[ 1281]= 4
IRLcoordsx[ 1282]= 40; IRLcoordsy[ 1282]= 54; IRLcoordsxIRL[ 1282]= 3; IRLcoordsyIRL[ 1282]= 26; IRLcoordszIRL[ 1282]= 4
IRLcoordsx[ 1283]= 40; IRLcoordsy[ 1283]= 55; IRLcoordsxIRL[ 1283]= 3; IRLcoordsyIRL[ 1283]= 25; IRLcoordszIRL[ 1283]= 4
IRLcoordsx[ 1284]= 40; IRLcoordsy[ 1284]= 56; IRLcoordsxIRL[ 1284]= 3; IRLcoordsyIRL[ 1284]= 24; IRLcoordszIRL[ 1284]= 4
IRLcoordsx[ 1285]= 40; IRLcoordsy[ 1285]= 57; IRLcoordsxIRL[ 1285]= 3; IRLcoordsyIRL[ 1285]= 23; IRLcoordszIRL[ 1285]= 4
IRLcoordsx[ 1286]= 40; IRLcoordsy[ 1286]= 58; IRLcoordsxIRL[ 1286]= 3; IRLcoordsyIRL[ 1286]= 22; IRLcoordszIRL[ 1286]= 4
IRLcoordsx[ 1287]= 40; IRLcoordsy[ 1287]= 59; IRLcoordsxIRL[ 1287]= 3; IRLcoordsyIRL[ 1287]= 21; IRLcoordszIRL[ 1287]= 4
IRLcoordsx[ 1288]= 40; IRLcoordsy[ 1288]= 60; IRLcoordsxIRL[ 1288]= 3; IRLcoordsyIRL[ 1288]= 20; IRLcoordszIRL[ 1288]= 4
IRLcoordsx[ 1289]= 40; IRLcoordsy[ 1289]= 61; IRLcoordsxIRL[ 1289]= 3; IRLcoordsyIRL[ 1289]= 19; IRLcoordszIRL[ 1289]= 4
IRLcoordsx[ 1290]= 40; IRLcoordsy[ 1290]= 62; IRLcoordsxIRL[ 1290]= 3; IRLcoordsyIRL[ 1290]= 18; IRLcoordszIRL[ 1290]= 4
IRLcoordsx[ 1291]= 40; IRLcoordsy[ 1291]= 63; IRLcoordsxIRL[ 1291]= 3; IRLcoordsyIRL[ 1291]= 17; IRLcoordszIRL[ 1291]= 4
IRLcoordsx[ 1292]= 41; IRLcoordsy[ 1292]= 52; IRLcoordsxIRL[ 1292]= 3; IRLcoordsyIRL[ 1292]= 28; IRLcoordszIRL[ 1292]= 3
IRLcoordsx[ 1293]= 41; IRLcoordsy[ 1293]= 53; IRLcoordsxIRL[ 1293]= 3; IRLcoordsyIRL[ 1293]= 27; IRLcoordszIRL[ 1293]= 3
IRLcoordsx[ 1294]= 41; IRLcoordsy[ 1294]= 54; IRLcoordsxIRL[ 1294]= 3; IRLcoordsyIRL[ 1294]= 26; IRLcoordszIRL[ 1294]= 3
IRLcoordsx[ 1295]= 41; IRLcoordsy[ 1295]= 55; IRLcoordsxIRL[ 1295]= 3; IRLcoordsyIRL[ 1295]= 25; IRLcoordszIRL[ 1295]= 3
IRLcoordsx[ 1296]= 41; IRLcoordsy[ 1296]= 56; IRLcoordsxIRL[ 1296]= 3; IRLcoordsyIRL[ 1296]= 24; IRLcoordszIRL[ 1296]= 3
IRLcoordsx[ 1297]= 41; IRLcoordsy[ 1297]= 57; IRLcoordsxIRL[ 1297]= 3; IRLcoordsyIRL[ 1297]= 23; IRLcoordszIRL[ 1297]= 3
IRLcoordsx[ 1298]= 41; IRLcoordsy[ 1298]= 58; IRLcoordsxIRL[ 1298]= 3; IRLcoordsyIRL[ 1298]= 22; IRLcoordszIRL[ 1298]= 3
IRLcoordsx[ 1299]= 41; IRLcoordsy[ 1299]= 59; IRLcoordsxIRL[ 1299]= 3; IRLcoordsyIRL[ 1299]= 21; IRLcoordszIRL[ 1299]= 3
IRLcoordsx[ 1300]= 41; IRLcoordsy[ 1300]= 60; IRLcoordsxIRL[ 1300]= 3; IRLcoordsyIRL[ 1300]= 20; IRLcoordszIRL[ 1300]= 3
IRLcoordsx[ 1301]= 41; IRLcoordsy[ 1301]= 61; IRLcoordsxIRL[ 1301]= 3; IRLcoordsyIRL[ 1301]= 19; IRLcoordszIRL[ 1301]= 3
IRLcoordsx[ 1302]= 41; IRLcoordsy[ 1302]= 62; IRLcoordsxIRL[ 1302]= 3; IRLcoordsyIRL[ 1302]= 18; IRLcoordszIRL[ 1302]= 3
IRLcoordsx[ 1303]= 41; IRLcoordsy[ 1303]= 63; IRLcoordsxIRL[ 1303]= 3; IRLcoordsyIRL[ 1303]= 17; IRLcoordszIRL[ 1303]= 3
IRLcoordsx[ 1304]= 42; IRLcoordsy[ 1304]= 52; IRLcoordsxIRL[ 1304]= 3; IRLcoordsyIRL[ 1304]= 28; IRLcoordszIRL[ 1304]= 2
IRLcoordsx[ 1305]= 42; IRLcoordsy[ 1305]= 53; IRLcoordsxIRL[ 1305]= 3; IRLcoordsyIRL[ 1305]= 27; IRLcoordszIRL[ 1305]= 2
IRLcoordsx[ 1306]= 42; IRLcoordsy[ 1306]= 54; IRLcoordsxIRL[ 1306]= 3; IRLcoordsyIRL[ 1306]= 26; IRLcoordszIRL[ 1306]= 2
IRLcoordsx[ 1307]= 42; IRLcoordsy[ 1307]= 55; IRLcoordsxIRL[ 1307]= 3; IRLcoordsyIRL[ 1307]= 25; IRLcoordszIRL[ 1307]= 2
IRLcoordsx[ 1308]= 42; IRLcoordsy[ 1308]= 56; IRLcoordsxIRL[ 1308]= 3; IRLcoordsyIRL[ 1308]= 24; IRLcoordszIRL[ 1308]= 2
IRLcoordsx[ 1309]= 42; IRLcoordsy[ 1309]= 57; IRLcoordsxIRL[ 1309]= 3; IRLcoordsyIRL[ 1309]= 23; IRLcoordszIRL[ 1309]= 2
IRLcoordsx[ 1310]= 42; IRLcoordsy[ 1310]= 58; IRLcoordsxIRL[ 1310]= 3; IRLcoordsyIRL[ 1310]= 22; IRLcoordszIRL[ 1310]= 2
IRLcoordsx[ 1311]= 42; IRLcoordsy[ 1311]= 59; IRLcoordsxIRL[ 1311]= 3; IRLcoordsyIRL[ 1311]= 21; IRLcoordszIRL[ 1311]= 2
IRLcoordsx[ 1312]= 42; IRLcoordsy[ 1312]= 60; IRLcoordsxIRL[ 1312]= 3; IRLcoordsyIRL[ 1312]= 20; IRLcoordszIRL[ 1312]= 2
IRLcoordsx[ 1313]= 42; IRLcoordsy[ 1313]= 61; IRLcoordsxIRL[ 1313]= 3; IRLcoordsyIRL[ 1313]= 19; IRLcoordszIRL[ 1313]= 2
IRLcoordsx[ 1314]= 42; IRLcoordsy[ 1314]= 62; IRLcoordsxIRL[ 1314]= 3; IRLcoordsyIRL[ 1314]= 18; IRLcoordszIRL[ 1314]= 2
IRLcoordsx[ 1315]= 42; IRLcoordsy[ 1315]= 63; IRLcoordsxIRL[ 1315]= 3; IRLcoordsyIRL[ 1315]= 17; IRLcoordszIRL[ 1315]= 2
IRLcoordsx[ 1316]= 43; IRLcoordsy[ 1316]= 52; IRLcoordsxIRL[ 1316]= 3; IRLcoordsyIRL[ 1316]= 28; IRLcoordszIRL[ 1316]= 1
IRLcoordsx[ 1317]= 43; IRLcoordsy[ 1317]= 53; IRLcoordsxIRL[ 1317]= 3; IRLcoordsyIRL[ 1317]= 27; IRLcoordszIRL[ 1317]= 1
IRLcoordsx[ 1318]= 43; IRLcoordsy[ 1318]= 54; IRLcoordsxIRL[ 1318]= 3; IRLcoordsyIRL[ 1318]= 26; IRLcoordszIRL[ 1318]= 1
IRLcoordsx[ 1319]= 43; IRLcoordsy[ 1319]= 55; IRLcoordsxIRL[ 1319]= 3; IRLcoordsyIRL[ 1319]= 25; IRLcoordszIRL[ 1319]= 1
IRLcoordsx[ 1320]= 43; IRLcoordsy[ 1320]= 56; IRLcoordsxIRL[ 1320]= 3; IRLcoordsyIRL[ 1320]= 24; IRLcoordszIRL[ 1320]= 1
IRLcoordsx[ 1321]= 43; IRLcoordsy[ 1321]= 57; IRLcoordsxIRL[ 1321]= 3; IRLcoordsyIRL[ 1321]= 23; IRLcoordszIRL[ 1321]= 1
IRLcoordsx[ 1322]= 43; IRLcoordsy[ 1322]= 58; IRLcoordsxIRL[ 1322]= 3; IRLcoordsyIRL[ 1322]= 22; IRLcoordszIRL[ 1322]= 1
IRLcoordsx[ 1323]= 43; IRLcoordsy[ 1323]= 59; IRLcoordsxIRL[ 1323]= 3; IRLcoordsyIRL[ 1323]= 21; IRLcoordszIRL[ 1323]= 1
IRLcoordsx[ 1324]= 43; IRLcoordsy[ 1324]= 60; IRLcoordsxIRL[ 1324]= 3; IRLcoordsyIRL[ 1324]= 20; IRLcoordszIRL[ 1324]= 1
IRLcoordsx[ 1325]= 43; IRLcoordsy[ 1325]= 61; IRLcoordsxIRL[ 1325]= 3; IRLcoordsyIRL[ 1325]= 19; IRLcoordszIRL[ 1325]= 1
IRLcoordsx[ 1326]= 43; IRLcoordsy[ 1326]= 62; IRLcoordsxIRL[ 1326]= 3; IRLcoordsyIRL[ 1326]= 18; IRLcoordszIRL[ 1326]= 1
IRLcoordsx[ 1327]= 43; IRLcoordsy[ 1327]= 63; IRLcoordsxIRL[ 1327]= 3; IRLcoordsyIRL[ 1327]= 17; IRLcoordszIRL[ 1327]= 1
IRLcoordsx[ 1328]= 32; IRLcoordsy[ 1328]= 52; IRLcoordsxIRL[ 1328]=-2; IRLcoordsyIRL[ 1328]= 28; IRLcoordszIRL[ 1328]= 1
IRLcoordsx[ 1329]= 32; IRLcoordsy[ 1329]= 53; IRLcoordsxIRL[ 1329]=-2; IRLcoordsyIRL[ 1329]= 27; IRLcoordszIRL[ 1329]= 1
IRLcoordsx[ 1330]= 32; IRLcoordsy[ 1330]= 54; IRLcoordsxIRL[ 1330]=-2; IRLcoordsyIRL[ 1330]= 26; IRLcoordszIRL[ 1330]= 1
IRLcoordsx[ 1331]= 32; IRLcoordsy[ 1331]= 55; IRLcoordsxIRL[ 1331]=-2; IRLcoordsyIRL[ 1331]= 25; IRLcoordszIRL[ 1331]= 1
IRLcoordsx[ 1332]= 32; IRLcoordsy[ 1332]= 56; IRLcoordsxIRL[ 1332]=-2; IRLcoordsyIRL[ 1332]= 24; IRLcoordszIRL[ 1332]= 1
IRLcoordsx[ 1333]= 32; IRLcoordsy[ 1333]= 57; IRLcoordsxIRL[ 1333]=-2; IRLcoordsyIRL[ 1333]= 23; IRLcoordszIRL[ 1333]= 1
IRLcoordsx[ 1334]= 32; IRLcoordsy[ 1334]= 58; IRLcoordsxIRL[ 1334]=-2; IRLcoordsyIRL[ 1334]= 22; IRLcoordszIRL[ 1334]= 1
IRLcoordsx[ 1335]= 32; IRLcoordsy[ 1335]= 59; IRLcoordsxIRL[ 1335]=-2; IRLcoordsyIRL[ 1335]= 21; IRLcoordszIRL[ 1335]= 1
IRLcoordsx[ 1336]= 32; IRLcoordsy[ 1336]= 60; IRLcoordsxIRL[ 1336]=-2; IRLcoordsyIRL[ 1336]= 20; IRLcoordszIRL[ 1336]= 1
IRLcoordsx[ 1337]= 32; IRLcoordsy[ 1337]= 61; IRLcoordsxIRL[ 1337]=-2; IRLcoordsyIRL[ 1337]= 19; IRLcoordszIRL[ 1337]= 1
IRLcoordsx[ 1338]= 32; IRLcoordsy[ 1338]= 62; IRLcoordsxIRL[ 1338]=-2; IRLcoordsyIRL[ 1338]= 18; IRLcoordszIRL[ 1338]= 1
IRLcoordsx[ 1339]= 32; IRLcoordsy[ 1339]= 63; IRLcoordsxIRL[ 1339]=-2; IRLcoordsyIRL[ 1339]= 17; IRLcoordszIRL[ 1339]= 1
IRLcoordsx[ 1340]= 33; IRLcoordsy[ 1340]= 52; IRLcoordsxIRL[ 1340]=-2; IRLcoordsyIRL[ 1340]= 28; IRLcoordszIRL[ 1340]= 2
IRLcoordsx[ 1341]= 33; IRLcoordsy[ 1341]= 53; IRLcoordsxIRL[ 1341]=-2; IRLcoordsyIRL[ 1341]= 27; IRLcoordszIRL[ 1341]= 2
IRLcoordsx[ 1342]= 33; IRLcoordsy[ 1342]= 54; IRLcoordsxIRL[ 1342]=-2; IRLcoordsyIRL[ 1342]= 26; IRLcoordszIRL[ 1342]= 2
IRLcoordsx[ 1343]= 33; IRLcoordsy[ 1343]= 55; IRLcoordsxIRL[ 1343]=-2; IRLcoordsyIRL[ 1343]= 25; IRLcoordszIRL[ 1343]= 2
IRLcoordsx[ 1344]= 33; IRLcoordsy[ 1344]= 56; IRLcoordsxIRL[ 1344]=-2; IRLcoordsyIRL[ 1344]= 24; IRLcoordszIRL[ 1344]= 2
IRLcoordsx[ 1345]= 33; IRLcoordsy[ 1345]= 57; IRLcoordsxIRL[ 1345]=-2; IRLcoordsyIRL[ 1345]= 23; IRLcoordszIRL[ 1345]= 2
IRLcoordsx[ 1346]= 33; IRLcoordsy[ 1346]= 58; IRLcoordsxIRL[ 1346]=-2; IRLcoordsyIRL[ 1346]= 22; IRLcoordszIRL[ 1346]= 2
IRLcoordsx[ 1347]= 33; IRLcoordsy[ 1347]= 59; IRLcoordsxIRL[ 1347]=-2; IRLcoordsyIRL[ 1347]= 21; IRLcoordszIRL[ 1347]= 2
IRLcoordsx[ 1348]= 33; IRLcoordsy[ 1348]= 60; IRLcoordsxIRL[ 1348]=-2; IRLcoordsyIRL[ 1348]= 20; IRLcoordszIRL[ 1348]= 2
IRLcoordsx[ 1349]= 33; IRLcoordsy[ 1349]= 61; IRLcoordsxIRL[ 1349]=-2; IRLcoordsyIRL[ 1349]= 19; IRLcoordszIRL[ 1349]= 2
IRLcoordsx[ 1350]= 33; IRLcoordsy[ 1350]= 62; IRLcoordsxIRL[ 1350]=-2; IRLcoordsyIRL[ 1350]= 18; IRLcoordszIRL[ 1350]= 2
IRLcoordsx[ 1351]= 33; IRLcoordsy[ 1351]= 63; IRLcoordsxIRL[ 1351]=-2; IRLcoordsyIRL[ 1351]= 17; IRLcoordszIRL[ 1351]= 2
IRLcoordsx[ 1352]= 34; IRLcoordsy[ 1352]= 52; IRLcoordsxIRL[ 1352]=-2; IRLcoordsyIRL[ 1352]= 28; IRLcoordszIRL[ 1352]= 3
IRLcoordsx[ 1353]= 34; IRLcoordsy[ 1353]= 53; IRLcoordsxIRL[ 1353]=-2; IRLcoordsyIRL[ 1353]= 27; IRLcoordszIRL[ 1353]= 3
IRLcoordsx[ 1354]= 34; IRLcoordsy[ 1354]= 54; IRLcoordsxIRL[ 1354]=-2; IRLcoordsyIRL[ 1354]= 26; IRLcoordszIRL[ 1354]= 3
IRLcoordsx[ 1355]= 34; IRLcoordsy[ 1355]= 55; IRLcoordsxIRL[ 1355]=-2; IRLcoordsyIRL[ 1355]= 25; IRLcoordszIRL[ 1355]= 3
IRLcoordsx[ 1356]= 34; IRLcoordsy[ 1356]= 56; IRLcoordsxIRL[ 1356]=-2; IRLcoordsyIRL[ 1356]= 24; IRLcoordszIRL[ 1356]= 3
IRLcoordsx[ 1357]= 34; IRLcoordsy[ 1357]= 57; IRLcoordsxIRL[ 1357]=-2; IRLcoordsyIRL[ 1357]= 23; IRLcoordszIRL[ 1357]= 3
IRLcoordsx[ 1358]= 34; IRLcoordsy[ 1358]= 58; IRLcoordsxIRL[ 1358]=-2; IRLcoordsyIRL[ 1358]= 22; IRLcoordszIRL[ 1358]= 3
IRLcoordsx[ 1359]= 34; IRLcoordsy[ 1359]= 59; IRLcoordsxIRL[ 1359]=-2; IRLcoordsyIRL[ 1359]= 21; IRLcoordszIRL[ 1359]= 3
IRLcoordsx[ 1360]= 34; IRLcoordsy[ 1360]= 60; IRLcoordsxIRL[ 1360]=-2; IRLcoordsyIRL[ 1360]= 20; IRLcoordszIRL[ 1360]= 3
IRLcoordsx[ 1361]= 34; IRLcoordsy[ 1361]= 61; IRLcoordsxIRL[ 1361]=-2; IRLcoordsyIRL[ 1361]= 19; IRLcoordszIRL[ 1361]= 3
IRLcoordsx[ 1362]= 34; IRLcoordsy[ 1362]= 62; IRLcoordsxIRL[ 1362]=-2; IRLcoordsyIRL[ 1362]= 18; IRLcoordszIRL[ 1362]= 3
IRLcoordsx[ 1363]= 34; IRLcoordsy[ 1363]= 63; IRLcoordsxIRL[ 1363]=-2; IRLcoordsyIRL[ 1363]= 17; IRLcoordszIRL[ 1363]= 3
IRLcoordsx[ 1364]= 35; IRLcoordsy[ 1364]= 52; IRLcoordsxIRL[ 1364]=-2; IRLcoordsyIRL[ 1364]= 28; IRLcoordszIRL[ 1364]= 4
IRLcoordsx[ 1365]= 35; IRLcoordsy[ 1365]= 53; IRLcoordsxIRL[ 1365]=-2; IRLcoordsyIRL[ 1365]= 27; IRLcoordszIRL[ 1365]= 4
IRLcoordsx[ 1366]= 35; IRLcoordsy[ 1366]= 54; IRLcoordsxIRL[ 1366]=-2; IRLcoordsyIRL[ 1366]= 26; IRLcoordszIRL[ 1366]= 4
IRLcoordsx[ 1367]= 35; IRLcoordsy[ 1367]= 55; IRLcoordsxIRL[ 1367]=-2; IRLcoordsyIRL[ 1367]= 25; IRLcoordszIRL[ 1367]= 4
IRLcoordsx[ 1368]= 35; IRLcoordsy[ 1368]= 56; IRLcoordsxIRL[ 1368]=-2; IRLcoordsyIRL[ 1368]= 24; IRLcoordszIRL[ 1368]= 4
IRLcoordsx[ 1369]= 35; IRLcoordsy[ 1369]= 57; IRLcoordsxIRL[ 1369]=-2; IRLcoordsyIRL[ 1369]= 23; IRLcoordszIRL[ 1369]= 4
IRLcoordsx[ 1370]= 35; IRLcoordsy[ 1370]= 58; IRLcoordsxIRL[ 1370]=-2; IRLcoordsyIRL[ 1370]= 22; IRLcoordszIRL[ 1370]= 4
IRLcoordsx[ 1371]= 35; IRLcoordsy[ 1371]= 59; IRLcoordsxIRL[ 1371]=-2; IRLcoordsyIRL[ 1371]= 21; IRLcoordszIRL[ 1371]= 4
IRLcoordsx[ 1372]= 35; IRLcoordsy[ 1372]= 60; IRLcoordsxIRL[ 1372]=-2; IRLcoordsyIRL[ 1372]= 20; IRLcoordszIRL[ 1372]= 4
IRLcoordsx[ 1373]= 35; IRLcoordsy[ 1373]= 61; IRLcoordsxIRL[ 1373]=-2; IRLcoordsyIRL[ 1373]= 19; IRLcoordszIRL[ 1373]= 4
IRLcoordsx[ 1374]= 35; IRLcoordsy[ 1374]= 62; IRLcoordsxIRL[ 1374]=-2; IRLcoordsyIRL[ 1374]= 18; IRLcoordszIRL[ 1374]= 4
IRLcoordsx[ 1375]= 35; IRLcoordsy[ 1375]= 63; IRLcoordsxIRL[ 1375]=-2; IRLcoordsyIRL[ 1375]= 17; IRLcoordszIRL[ 1375]= 4
IRLcoordsx[ 1376]= 36; IRLcoordsy[ 1376]= 48; IRLcoordsxIRL[ 1376]=-1; IRLcoordsyIRL[ 1376]= 29; IRLcoordszIRL[ 1376]= 1
IRLcoordsx[ 1377]= 36; IRLcoordsy[ 1377]= 49; IRLcoordsxIRL[ 1377]=-1; IRLcoordsyIRL[ 1377]= 29; IRLcoordszIRL[ 1377]= 2
IRLcoordsx[ 1378]= 36; IRLcoordsy[ 1378]= 50; IRLcoordsxIRL[ 1378]=-1; IRLcoordsyIRL[ 1378]= 29; IRLcoordszIRL[ 1378]= 3
IRLcoordsx[ 1379]= 36; IRLcoordsy[ 1379]= 51; IRLcoordsxIRL[ 1379]=-1; IRLcoordsyIRL[ 1379]= 29; IRLcoordszIRL[ 1379]= 4
IRLcoordsx[ 1380]= 37; IRLcoordsy[ 1380]= 48; IRLcoordsxIRL[ 1380]= 0; IRLcoordsyIRL[ 1380]= 29; IRLcoordszIRL[ 1380]= 1
IRLcoordsx[ 1381]= 37; IRLcoordsy[ 1381]= 49; IRLcoordsxIRL[ 1381]= 0; IRLcoordsyIRL[ 1381]= 29; IRLcoordszIRL[ 1381]= 2
IRLcoordsx[ 1382]= 37; IRLcoordsy[ 1382]= 50; IRLcoordsxIRL[ 1382]= 0; IRLcoordsyIRL[ 1382]= 29; IRLcoordszIRL[ 1382]= 3
IRLcoordsx[ 1383]= 37; IRLcoordsy[ 1383]= 51; IRLcoordsxIRL[ 1383]= 0; IRLcoordsyIRL[ 1383]= 29; IRLcoordszIRL[ 1383]= 4
IRLcoordsx[ 1384]= 38; IRLcoordsy[ 1384]= 48; IRLcoordsxIRL[ 1384]= 1; IRLcoordsyIRL[ 1384]= 29; IRLcoordszIRL[ 1384]= 1
IRLcoordsx[ 1385]= 38; IRLcoordsy[ 1385]= 49; IRLcoordsxIRL[ 1385]= 1; IRLcoordsyIRL[ 1385]= 29; IRLcoordszIRL[ 1385]= 2
IRLcoordsx[ 1386]= 38; IRLcoordsy[ 1386]= 50; IRLcoordsxIRL[ 1386]= 1; IRLcoordsyIRL[ 1386]= 29; IRLcoordszIRL[ 1386]= 3
IRLcoordsx[ 1387]= 38; IRLcoordsy[ 1387]= 51; IRLcoordsxIRL[ 1387]= 1; IRLcoordsyIRL[ 1387]= 29; IRLcoordszIRL[ 1387]= 4
IRLcoordsx[ 1388]= 39; IRLcoordsy[ 1388]= 48; IRLcoordsxIRL[ 1388]= 2; IRLcoordsyIRL[ 1388]= 29; IRLcoordszIRL[ 1388]= 1
IRLcoordsx[ 1389]= 39; IRLcoordsy[ 1389]= 49; IRLcoordsxIRL[ 1389]= 2; IRLcoordsyIRL[ 1389]= 29; IRLcoordszIRL[ 1389]= 2
IRLcoordsx[ 1390]= 39; IRLcoordsy[ 1390]= 50; IRLcoordsxIRL[ 1390]= 2; IRLcoordsyIRL[ 1390]= 29; IRLcoordszIRL[ 1390]= 3
IRLcoordsx[ 1391]= 39; IRLcoordsy[ 1391]= 51; IRLcoordsxIRL[ 1391]= 2; IRLcoordsyIRL[ 1391]= 29; IRLcoordszIRL[ 1391]= 4
IRLcoordsx[ 1392]= 40; IRLcoordsy[ 1392]= 48; IRLcoordsxIRL[ 1392]=-1; IRLcoordsyIRL[ 1392]= 16; IRLcoordszIRL[ 1392]= 1
IRLcoordsx[ 1393]= 40; IRLcoordsy[ 1393]= 49; IRLcoordsxIRL[ 1393]=-1; IRLcoordsyIRL[ 1393]= 16; IRLcoordszIRL[ 1393]= 2
IRLcoordsx[ 1394]= 40; IRLcoordsy[ 1394]= 50; IRLcoordsxIRL[ 1394]=-1; IRLcoordsyIRL[ 1394]= 16; IRLcoordszIRL[ 1394]= 3
IRLcoordsx[ 1395]= 40; IRLcoordsy[ 1395]= 51; IRLcoordsxIRL[ 1395]=-1; IRLcoordsyIRL[ 1395]= 16; IRLcoordszIRL[ 1395]= 4
IRLcoordsx[ 1396]= 41; IRLcoordsy[ 1396]= 48; IRLcoordsxIRL[ 1396]= 0; IRLcoordsyIRL[ 1396]= 16; IRLcoordszIRL[ 1396]= 1
IRLcoordsx[ 1397]= 41; IRLcoordsy[ 1397]= 49; IRLcoordsxIRL[ 1397]= 0; IRLcoordsyIRL[ 1397]= 16; IRLcoordszIRL[ 1397]= 2
IRLcoordsx[ 1398]= 41; IRLcoordsy[ 1398]= 50; IRLcoordsxIRL[ 1398]= 0; IRLcoordsyIRL[ 1398]= 16; IRLcoordszIRL[ 1398]= 3
IRLcoordsx[ 1399]= 41; IRLcoordsy[ 1399]= 51; IRLcoordsxIRL[ 1399]= 0; IRLcoordsyIRL[ 1399]= 16; IRLcoordszIRL[ 1399]= 4
IRLcoordsx[ 1400]= 42; IRLcoordsy[ 1400]= 48; IRLcoordsxIRL[ 1400]= 1; IRLcoordsyIRL[ 1400]= 16; IRLcoordszIRL[ 1400]= 1
IRLcoordsx[ 1401]= 42; IRLcoordsy[ 1401]= 49; IRLcoordsxIRL[ 1401]= 1; IRLcoordsyIRL[ 1401]= 16; IRLcoordszIRL[ 1401]= 2
IRLcoordsx[ 1402]= 42; IRLcoordsy[ 1402]= 50; IRLcoordsxIRL[ 1402]= 1; IRLcoordsyIRL[ 1402]= 16; IRLcoordszIRL[ 1402]= 3
IRLcoordsx[ 1403]= 42; IRLcoordsy[ 1403]= 51; IRLcoordsxIRL[ 1403]= 1; IRLcoordsyIRL[ 1403]= 16; IRLcoordszIRL[ 1403]= 4
IRLcoordsx[ 1404]= 43; IRLcoordsy[ 1404]= 48; IRLcoordsxIRL[ 1404]= 2; IRLcoordsyIRL[ 1404]= 16; IRLcoordszIRL[ 1404]= 1
IRLcoordsx[ 1405]= 43; IRLcoordsy[ 1405]= 49; IRLcoordsxIRL[ 1405]= 2; IRLcoordsyIRL[ 1405]= 16; IRLcoordszIRL[ 1405]= 2
IRLcoordsx[ 1406]= 43; IRLcoordsy[ 1406]= 50; IRLcoordsxIRL[ 1406]= 2; IRLcoordsyIRL[ 1406]= 16; IRLcoordszIRL[ 1406]= 3
IRLcoordsx[ 1407]= 43; IRLcoordsy[ 1407]= 51; IRLcoordsxIRL[ 1407]= 2; IRLcoordsyIRL[ 1407]= 16; IRLcoordszIRL[ 1407]= 4
IRLcoordsx[ 1408]= 52; IRLcoordsy[ 1408]= 20; IRLcoordsxIRL[ 1408]=-18; IRLcoordsyIRL[ 1408]= 28; IRLcoordszIRL[ 1408]= 0
IRLcoordsx[ 1409]= 52; IRLcoordsy[ 1409]= 21; IRLcoordsxIRL[ 1409]=-18; IRLcoordsyIRL[ 1409]= 27; IRLcoordszIRL[ 1409]= 0
IRLcoordsx[ 1410]= 52; IRLcoordsy[ 1410]= 22; IRLcoordsxIRL[ 1410]=-18; IRLcoordsyIRL[ 1410]= 26; IRLcoordszIRL[ 1410]= 0
IRLcoordsx[ 1411]= 52; IRLcoordsy[ 1411]= 23; IRLcoordsxIRL[ 1411]=-18; IRLcoordsyIRL[ 1411]= 25; IRLcoordszIRL[ 1411]= 0
IRLcoordsx[ 1412]= 52; IRLcoordsy[ 1412]= 24; IRLcoordsxIRL[ 1412]=-18; IRLcoordsyIRL[ 1412]= 24; IRLcoordszIRL[ 1412]= 0
IRLcoordsx[ 1413]= 52; IRLcoordsy[ 1413]= 25; IRLcoordsxIRL[ 1413]=-18; IRLcoordsyIRL[ 1413]= 23; IRLcoordszIRL[ 1413]= 0
IRLcoordsx[ 1414]= 52; IRLcoordsy[ 1414]= 26; IRLcoordsxIRL[ 1414]=-18; IRLcoordsyIRL[ 1414]= 22; IRLcoordszIRL[ 1414]= 0
IRLcoordsx[ 1415]= 52; IRLcoordsy[ 1415]= 27; IRLcoordsxIRL[ 1415]=-18; IRLcoordsyIRL[ 1415]= 21; IRLcoordszIRL[ 1415]= 0
IRLcoordsx[ 1416]= 52; IRLcoordsy[ 1416]= 28; IRLcoordsxIRL[ 1416]=-18; IRLcoordsyIRL[ 1416]= 20; IRLcoordszIRL[ 1416]= 0
IRLcoordsx[ 1417]= 52; IRLcoordsy[ 1417]= 29; IRLcoordsxIRL[ 1417]=-18; IRLcoordsyIRL[ 1417]= 19; IRLcoordszIRL[ 1417]= 0
IRLcoordsx[ 1418]= 52; IRLcoordsy[ 1418]= 30; IRLcoordsxIRL[ 1418]=-18; IRLcoordsyIRL[ 1418]= 18; IRLcoordszIRL[ 1418]= 0
IRLcoordsx[ 1419]= 52; IRLcoordsy[ 1419]= 31; IRLcoordsxIRL[ 1419]=-18; IRLcoordsyIRL[ 1419]= 17; IRLcoordszIRL[ 1419]= 0
IRLcoordsx[ 1420]= 53; IRLcoordsy[ 1420]= 20; IRLcoordsxIRL[ 1420]=-19; IRLcoordsyIRL[ 1420]= 28; IRLcoordszIRL[ 1420]= 0
IRLcoordsx[ 1421]= 53; IRLcoordsy[ 1421]= 21; IRLcoordsxIRL[ 1421]=-19; IRLcoordsyIRL[ 1421]= 27; IRLcoordszIRL[ 1421]= 0
IRLcoordsx[ 1422]= 53; IRLcoordsy[ 1422]= 22; IRLcoordsxIRL[ 1422]=-19; IRLcoordsyIRL[ 1422]= 26; IRLcoordszIRL[ 1422]= 0
IRLcoordsx[ 1423]= 53; IRLcoordsy[ 1423]= 23; IRLcoordsxIRL[ 1423]=-19; IRLcoordsyIRL[ 1423]= 25; IRLcoordszIRL[ 1423]= 0
IRLcoordsx[ 1424]= 53; IRLcoordsy[ 1424]= 24; IRLcoordsxIRL[ 1424]=-19; IRLcoordsyIRL[ 1424]= 24; IRLcoordszIRL[ 1424]= 0
IRLcoordsx[ 1425]= 53; IRLcoordsy[ 1425]= 25; IRLcoordsxIRL[ 1425]=-19; IRLcoordsyIRL[ 1425]= 23; IRLcoordszIRL[ 1425]= 0
IRLcoordsx[ 1426]= 53; IRLcoordsy[ 1426]= 26; IRLcoordsxIRL[ 1426]=-19; IRLcoordsyIRL[ 1426]= 22; IRLcoordszIRL[ 1426]= 0
IRLcoordsx[ 1427]= 53; IRLcoordsy[ 1427]= 27; IRLcoordsxIRL[ 1427]=-19; IRLcoordsyIRL[ 1427]= 21; IRLcoordszIRL[ 1427]= 0
IRLcoordsx[ 1428]= 53; IRLcoordsy[ 1428]= 28; IRLcoordsxIRL[ 1428]=-19; IRLcoordsyIRL[ 1428]= 20; IRLcoordszIRL[ 1428]= 0
IRLcoordsx[ 1429]= 53; IRLcoordsy[ 1429]= 29; IRLcoordsxIRL[ 1429]=-19; IRLcoordsyIRL[ 1429]= 19; IRLcoordszIRL[ 1429]= 0
IRLcoordsx[ 1430]= 53; IRLcoordsy[ 1430]= 30; IRLcoordsxIRL[ 1430]=-19; IRLcoordsyIRL[ 1430]= 18; IRLcoordszIRL[ 1430]= 0
IRLcoordsx[ 1431]= 53; IRLcoordsy[ 1431]= 31; IRLcoordsxIRL[ 1431]=-19; IRLcoordsyIRL[ 1431]= 17; IRLcoordszIRL[ 1431]= 0
IRLcoordsx[ 1432]= 54; IRLcoordsy[ 1432]= 20; IRLcoordsxIRL[ 1432]=-20; IRLcoordsyIRL[ 1432]= 28; IRLcoordszIRL[ 1432]= 0
IRLcoordsx[ 1433]= 54; IRLcoordsy[ 1433]= 21; IRLcoordsxIRL[ 1433]=-20; IRLcoordsyIRL[ 1433]= 27; IRLcoordszIRL[ 1433]= 0
IRLcoordsx[ 1434]= 54; IRLcoordsy[ 1434]= 22; IRLcoordsxIRL[ 1434]=-20; IRLcoordsyIRL[ 1434]= 26; IRLcoordszIRL[ 1434]= 0
IRLcoordsx[ 1435]= 54; IRLcoordsy[ 1435]= 23; IRLcoordsxIRL[ 1435]=-20; IRLcoordsyIRL[ 1435]= 25; IRLcoordszIRL[ 1435]= 0
IRLcoordsx[ 1436]= 54; IRLcoordsy[ 1436]= 24; IRLcoordsxIRL[ 1436]=-20; IRLcoordsyIRL[ 1436]= 24; IRLcoordszIRL[ 1436]= 0
IRLcoordsx[ 1437]= 54; IRLcoordsy[ 1437]= 25; IRLcoordsxIRL[ 1437]=-20; IRLcoordsyIRL[ 1437]= 23; IRLcoordszIRL[ 1437]= 0
IRLcoordsx[ 1438]= 54; IRLcoordsy[ 1438]= 26; IRLcoordsxIRL[ 1438]=-20; IRLcoordsyIRL[ 1438]= 22; IRLcoordszIRL[ 1438]= 0
IRLcoordsx[ 1439]= 54; IRLcoordsy[ 1439]= 27; IRLcoordsxIRL[ 1439]=-20; IRLcoordsyIRL[ 1439]= 21; IRLcoordszIRL[ 1439]= 0
IRLcoordsx[ 1440]= 54; IRLcoordsy[ 1440]= 28; IRLcoordsxIRL[ 1440]=-20; IRLcoordsyIRL[ 1440]= 20; IRLcoordszIRL[ 1440]= 0
IRLcoordsx[ 1441]= 54; IRLcoordsy[ 1441]= 29; IRLcoordsxIRL[ 1441]=-20; IRLcoordsyIRL[ 1441]= 19; IRLcoordszIRL[ 1441]= 0
IRLcoordsx[ 1442]= 54; IRLcoordsy[ 1442]= 30; IRLcoordsxIRL[ 1442]=-20; IRLcoordsyIRL[ 1442]= 18; IRLcoordszIRL[ 1442]= 0
IRLcoordsx[ 1443]= 54; IRLcoordsy[ 1443]= 31; IRLcoordsxIRL[ 1443]=-20; IRLcoordsyIRL[ 1443]= 17; IRLcoordszIRL[ 1443]= 0
IRLcoordsx[ 1444]= 55; IRLcoordsy[ 1444]= 20; IRLcoordsxIRL[ 1444]=-21; IRLcoordsyIRL[ 1444]= 28; IRLcoordszIRL[ 1444]= 0
IRLcoordsx[ 1445]= 55; IRLcoordsy[ 1445]= 21; IRLcoordsxIRL[ 1445]=-21; IRLcoordsyIRL[ 1445]= 27; IRLcoordszIRL[ 1445]= 0
IRLcoordsx[ 1446]= 55; IRLcoordsy[ 1446]= 22; IRLcoordsxIRL[ 1446]=-21; IRLcoordsyIRL[ 1446]= 26; IRLcoordszIRL[ 1446]= 0
IRLcoordsx[ 1447]= 55; IRLcoordsy[ 1447]= 23; IRLcoordsxIRL[ 1447]=-21; IRLcoordsyIRL[ 1447]= 25; IRLcoordszIRL[ 1447]= 0
IRLcoordsx[ 1448]= 55; IRLcoordsy[ 1448]= 24; IRLcoordsxIRL[ 1448]=-21; IRLcoordsyIRL[ 1448]= 24; IRLcoordszIRL[ 1448]= 0
IRLcoordsx[ 1449]= 55; IRLcoordsy[ 1449]= 25; IRLcoordsxIRL[ 1449]=-21; IRLcoordsyIRL[ 1449]= 23; IRLcoordszIRL[ 1449]= 0
IRLcoordsx[ 1450]= 55; IRLcoordsy[ 1450]= 26; IRLcoordsxIRL[ 1450]=-21; IRLcoordsyIRL[ 1450]= 22; IRLcoordszIRL[ 1450]= 0
IRLcoordsx[ 1451]= 55; IRLcoordsy[ 1451]= 27; IRLcoordsxIRL[ 1451]=-21; IRLcoordsyIRL[ 1451]= 21; IRLcoordszIRL[ 1451]= 0
IRLcoordsx[ 1452]= 55; IRLcoordsy[ 1452]= 28; IRLcoordsxIRL[ 1452]=-21; IRLcoordsyIRL[ 1452]= 20; IRLcoordszIRL[ 1452]= 0
IRLcoordsx[ 1453]= 55; IRLcoordsy[ 1453]= 29; IRLcoordsxIRL[ 1453]=-21; IRLcoordsyIRL[ 1453]= 19; IRLcoordszIRL[ 1453]= 0
IRLcoordsx[ 1454]= 55; IRLcoordsy[ 1454]= 30; IRLcoordsxIRL[ 1454]=-21; IRLcoordsyIRL[ 1454]= 18; IRLcoordszIRL[ 1454]= 0
IRLcoordsx[ 1455]= 55; IRLcoordsy[ 1455]= 31; IRLcoordsxIRL[ 1455]=-21; IRLcoordsyIRL[ 1455]= 17; IRLcoordszIRL[ 1455]= 0
IRLcoordsx[ 1456]= 44; IRLcoordsy[ 1456]= 20; IRLcoordsxIRL[ 1456]=-21; IRLcoordsyIRL[ 1456]= 28; IRLcoordszIRL[ 1456]= 5
IRLcoordsx[ 1457]= 44; IRLcoordsy[ 1457]= 21; IRLcoordsxIRL[ 1457]=-21; IRLcoordsyIRL[ 1457]= 27; IRLcoordszIRL[ 1457]= 5
IRLcoordsx[ 1458]= 44; IRLcoordsy[ 1458]= 22; IRLcoordsxIRL[ 1458]=-21; IRLcoordsyIRL[ 1458]= 26; IRLcoordszIRL[ 1458]= 5
IRLcoordsx[ 1459]= 44; IRLcoordsy[ 1459]= 23; IRLcoordsxIRL[ 1459]=-21; IRLcoordsyIRL[ 1459]= 25; IRLcoordszIRL[ 1459]= 5
IRLcoordsx[ 1460]= 44; IRLcoordsy[ 1460]= 24; IRLcoordsxIRL[ 1460]=-21; IRLcoordsyIRL[ 1460]= 24; IRLcoordszIRL[ 1460]= 5
IRLcoordsx[ 1461]= 44; IRLcoordsy[ 1461]= 25; IRLcoordsxIRL[ 1461]=-21; IRLcoordsyIRL[ 1461]= 23; IRLcoordszIRL[ 1461]= 5
IRLcoordsx[ 1462]= 44; IRLcoordsy[ 1462]= 26; IRLcoordsxIRL[ 1462]=-21; IRLcoordsyIRL[ 1462]= 22; IRLcoordszIRL[ 1462]= 5
IRLcoordsx[ 1463]= 44; IRLcoordsy[ 1463]= 27; IRLcoordsxIRL[ 1463]=-21; IRLcoordsyIRL[ 1463]= 21; IRLcoordszIRL[ 1463]= 5
IRLcoordsx[ 1464]= 44; IRLcoordsy[ 1464]= 28; IRLcoordsxIRL[ 1464]=-21; IRLcoordsyIRL[ 1464]= 20; IRLcoordszIRL[ 1464]= 5
IRLcoordsx[ 1465]= 44; IRLcoordsy[ 1465]= 29; IRLcoordsxIRL[ 1465]=-21; IRLcoordsyIRL[ 1465]= 19; IRLcoordszIRL[ 1465]= 5
IRLcoordsx[ 1466]= 44; IRLcoordsy[ 1466]= 30; IRLcoordsxIRL[ 1466]=-21; IRLcoordsyIRL[ 1466]= 18; IRLcoordszIRL[ 1466]= 5
IRLcoordsx[ 1467]= 44; IRLcoordsy[ 1467]= 31; IRLcoordsxIRL[ 1467]=-21; IRLcoordsyIRL[ 1467]= 17; IRLcoordszIRL[ 1467]= 5
IRLcoordsx[ 1468]= 45; IRLcoordsy[ 1468]= 20; IRLcoordsxIRL[ 1468]=-20; IRLcoordsyIRL[ 1468]= 28; IRLcoordszIRL[ 1468]= 5
IRLcoordsx[ 1469]= 45; IRLcoordsy[ 1469]= 21; IRLcoordsxIRL[ 1469]=-20; IRLcoordsyIRL[ 1469]= 27; IRLcoordszIRL[ 1469]= 5
IRLcoordsx[ 1470]= 45; IRLcoordsy[ 1470]= 22; IRLcoordsxIRL[ 1470]=-20; IRLcoordsyIRL[ 1470]= 26; IRLcoordszIRL[ 1470]= 5
IRLcoordsx[ 1471]= 45; IRLcoordsy[ 1471]= 23; IRLcoordsxIRL[ 1471]=-20; IRLcoordsyIRL[ 1471]= 25; IRLcoordszIRL[ 1471]= 5
IRLcoordsx[ 1472]= 45; IRLcoordsy[ 1472]= 24; IRLcoordsxIRL[ 1472]=-20; IRLcoordsyIRL[ 1472]= 24; IRLcoordszIRL[ 1472]= 5
IRLcoordsx[ 1473]= 45; IRLcoordsy[ 1473]= 25; IRLcoordsxIRL[ 1473]=-20; IRLcoordsyIRL[ 1473]= 23; IRLcoordszIRL[ 1473]= 5
IRLcoordsx[ 1474]= 45; IRLcoordsy[ 1474]= 26; IRLcoordsxIRL[ 1474]=-20; IRLcoordsyIRL[ 1474]= 22; IRLcoordszIRL[ 1474]= 5
IRLcoordsx[ 1475]= 45; IRLcoordsy[ 1475]= 27; IRLcoordsxIRL[ 1475]=-20; IRLcoordsyIRL[ 1475]= 21; IRLcoordszIRL[ 1475]= 5
IRLcoordsx[ 1476]= 45; IRLcoordsy[ 1476]= 28; IRLcoordsxIRL[ 1476]=-20; IRLcoordsyIRL[ 1476]= 20; IRLcoordszIRL[ 1476]= 5
IRLcoordsx[ 1477]= 45; IRLcoordsy[ 1477]= 29; IRLcoordsxIRL[ 1477]=-20; IRLcoordsyIRL[ 1477]= 19; IRLcoordszIRL[ 1477]= 5
IRLcoordsx[ 1478]= 45; IRLcoordsy[ 1478]= 30; IRLcoordsxIRL[ 1478]=-20; IRLcoordsyIRL[ 1478]= 18; IRLcoordszIRL[ 1478]= 5
IRLcoordsx[ 1479]= 45; IRLcoordsy[ 1479]= 31; IRLcoordsxIRL[ 1479]=-20; IRLcoordsyIRL[ 1479]= 17; IRLcoordszIRL[ 1479]= 5
IRLcoordsx[ 1480]= 46; IRLcoordsy[ 1480]= 20; IRLcoordsxIRL[ 1480]=-19; IRLcoordsyIRL[ 1480]= 28; IRLcoordszIRL[ 1480]= 5
IRLcoordsx[ 1481]= 46; IRLcoordsy[ 1481]= 21; IRLcoordsxIRL[ 1481]=-19; IRLcoordsyIRL[ 1481]= 27; IRLcoordszIRL[ 1481]= 5
IRLcoordsx[ 1482]= 46; IRLcoordsy[ 1482]= 22; IRLcoordsxIRL[ 1482]=-19; IRLcoordsyIRL[ 1482]= 26; IRLcoordszIRL[ 1482]= 5
IRLcoordsx[ 1483]= 46; IRLcoordsy[ 1483]= 23; IRLcoordsxIRL[ 1483]=-19; IRLcoordsyIRL[ 1483]= 25; IRLcoordszIRL[ 1483]= 5
IRLcoordsx[ 1484]= 46; IRLcoordsy[ 1484]= 24; IRLcoordsxIRL[ 1484]=-19; IRLcoordsyIRL[ 1484]= 24; IRLcoordszIRL[ 1484]= 5
IRLcoordsx[ 1485]= 46; IRLcoordsy[ 1485]= 25; IRLcoordsxIRL[ 1485]=-19; IRLcoordsyIRL[ 1485]= 23; IRLcoordszIRL[ 1485]= 5
IRLcoordsx[ 1486]= 46; IRLcoordsy[ 1486]= 26; IRLcoordsxIRL[ 1486]=-19; IRLcoordsyIRL[ 1486]= 22; IRLcoordszIRL[ 1486]= 5
IRLcoordsx[ 1487]= 46; IRLcoordsy[ 1487]= 27; IRLcoordsxIRL[ 1487]=-19; IRLcoordsyIRL[ 1487]= 21; IRLcoordszIRL[ 1487]= 5
IRLcoordsx[ 1488]= 46; IRLcoordsy[ 1488]= 28; IRLcoordsxIRL[ 1488]=-19; IRLcoordsyIRL[ 1488]= 20; IRLcoordszIRL[ 1488]= 5
IRLcoordsx[ 1489]= 46; IRLcoordsy[ 1489]= 29; IRLcoordsxIRL[ 1489]=-19; IRLcoordsyIRL[ 1489]= 19; IRLcoordszIRL[ 1489]= 5
IRLcoordsx[ 1490]= 46; IRLcoordsy[ 1490]= 30; IRLcoordsxIRL[ 1490]=-19; IRLcoordsyIRL[ 1490]= 18; IRLcoordszIRL[ 1490]= 5
IRLcoordsx[ 1491]= 46; IRLcoordsy[ 1491]= 31; IRLcoordsxIRL[ 1491]=-19; IRLcoordsyIRL[ 1491]= 17; IRLcoordszIRL[ 1491]= 5
IRLcoordsx[ 1492]= 47; IRLcoordsy[ 1492]= 20; IRLcoordsxIRL[ 1492]=-18; IRLcoordsyIRL[ 1492]= 28; IRLcoordszIRL[ 1492]= 5
IRLcoordsx[ 1493]= 47; IRLcoordsy[ 1493]= 21; IRLcoordsxIRL[ 1493]=-18; IRLcoordsyIRL[ 1493]= 27; IRLcoordszIRL[ 1493]= 5
IRLcoordsx[ 1494]= 47; IRLcoordsy[ 1494]= 22; IRLcoordsxIRL[ 1494]=-18; IRLcoordsyIRL[ 1494]= 26; IRLcoordszIRL[ 1494]= 5
IRLcoordsx[ 1495]= 47; IRLcoordsy[ 1495]= 23; IRLcoordsxIRL[ 1495]=-18; IRLcoordsyIRL[ 1495]= 25; IRLcoordszIRL[ 1495]= 5
IRLcoordsx[ 1496]= 47; IRLcoordsy[ 1496]= 24; IRLcoordsxIRL[ 1496]=-18; IRLcoordsyIRL[ 1496]= 24; IRLcoordszIRL[ 1496]= 5
IRLcoordsx[ 1497]= 47; IRLcoordsy[ 1497]= 25; IRLcoordsxIRL[ 1497]=-18; IRLcoordsyIRL[ 1497]= 23; IRLcoordszIRL[ 1497]= 5
IRLcoordsx[ 1498]= 47; IRLcoordsy[ 1498]= 26; IRLcoordsxIRL[ 1498]=-18; IRLcoordsyIRL[ 1498]= 22; IRLcoordszIRL[ 1498]= 5
IRLcoordsx[ 1499]= 47; IRLcoordsy[ 1499]= 27; IRLcoordsxIRL[ 1499]=-18; IRLcoordsyIRL[ 1499]= 21; IRLcoordszIRL[ 1499]= 5
IRLcoordsx[ 1500]= 47; IRLcoordsy[ 1500]= 28; IRLcoordsxIRL[ 1500]=-18; IRLcoordsyIRL[ 1500]= 20; IRLcoordszIRL[ 1500]= 5
IRLcoordsx[ 1501]= 47; IRLcoordsy[ 1501]= 29; IRLcoordsxIRL[ 1501]=-18; IRLcoordsyIRL[ 1501]= 19; IRLcoordszIRL[ 1501]= 5
IRLcoordsx[ 1502]= 47; IRLcoordsy[ 1502]= 30; IRLcoordsxIRL[ 1502]=-18; IRLcoordsyIRL[ 1502]= 18; IRLcoordszIRL[ 1502]= 5
IRLcoordsx[ 1503]= 47; IRLcoordsy[ 1503]= 31; IRLcoordsxIRL[ 1503]=-18; IRLcoordsyIRL[ 1503]= 17; IRLcoordszIRL[ 1503]= 5
IRLcoordsx[ 1504]= 48; IRLcoordsy[ 1504]= 20; IRLcoordsxIRL[ 1504]=-17; IRLcoordsyIRL[ 1504]= 28; IRLcoordszIRL[ 1504]= 4
IRLcoordsx[ 1505]= 48; IRLcoordsy[ 1505]= 21; IRLcoordsxIRL[ 1505]=-17; IRLcoordsyIRL[ 1505]= 27; IRLcoordszIRL[ 1505]= 4
IRLcoordsx[ 1506]= 48; IRLcoordsy[ 1506]= 22; IRLcoordsxIRL[ 1506]=-17; IRLcoordsyIRL[ 1506]= 26; IRLcoordszIRL[ 1506]= 4
IRLcoordsx[ 1507]= 48; IRLcoordsy[ 1507]= 23; IRLcoordsxIRL[ 1507]=-17; IRLcoordsyIRL[ 1507]= 25; IRLcoordszIRL[ 1507]= 4
IRLcoordsx[ 1508]= 48; IRLcoordsy[ 1508]= 24; IRLcoordsxIRL[ 1508]=-17; IRLcoordsyIRL[ 1508]= 24; IRLcoordszIRL[ 1508]= 4
IRLcoordsx[ 1509]= 48; IRLcoordsy[ 1509]= 25; IRLcoordsxIRL[ 1509]=-17; IRLcoordsyIRL[ 1509]= 23; IRLcoordszIRL[ 1509]= 4
IRLcoordsx[ 1510]= 48; IRLcoordsy[ 1510]= 26; IRLcoordsxIRL[ 1510]=-17; IRLcoordsyIRL[ 1510]= 22; IRLcoordszIRL[ 1510]= 4
IRLcoordsx[ 1511]= 48; IRLcoordsy[ 1511]= 27; IRLcoordsxIRL[ 1511]=-17; IRLcoordsyIRL[ 1511]= 21; IRLcoordszIRL[ 1511]= 4
IRLcoordsx[ 1512]= 48; IRLcoordsy[ 1512]= 28; IRLcoordsxIRL[ 1512]=-17; IRLcoordsyIRL[ 1512]= 20; IRLcoordszIRL[ 1512]= 4
IRLcoordsx[ 1513]= 48; IRLcoordsy[ 1513]= 29; IRLcoordsxIRL[ 1513]=-17; IRLcoordsyIRL[ 1513]= 19; IRLcoordszIRL[ 1513]= 4
IRLcoordsx[ 1514]= 48; IRLcoordsy[ 1514]= 30; IRLcoordsxIRL[ 1514]=-17; IRLcoordsyIRL[ 1514]= 18; IRLcoordszIRL[ 1514]= 4
IRLcoordsx[ 1515]= 48; IRLcoordsy[ 1515]= 31; IRLcoordsxIRL[ 1515]=-17; IRLcoordsyIRL[ 1515]= 17; IRLcoordszIRL[ 1515]= 4
IRLcoordsx[ 1516]= 49; IRLcoordsy[ 1516]= 20; IRLcoordsxIRL[ 1516]=-17; IRLcoordsyIRL[ 1516]= 28; IRLcoordszIRL[ 1516]= 3
IRLcoordsx[ 1517]= 49; IRLcoordsy[ 1517]= 21; IRLcoordsxIRL[ 1517]=-17; IRLcoordsyIRL[ 1517]= 27; IRLcoordszIRL[ 1517]= 3
IRLcoordsx[ 1518]= 49; IRLcoordsy[ 1518]= 22; IRLcoordsxIRL[ 1518]=-17; IRLcoordsyIRL[ 1518]= 26; IRLcoordszIRL[ 1518]= 3
IRLcoordsx[ 1519]= 49; IRLcoordsy[ 1519]= 23; IRLcoordsxIRL[ 1519]=-17; IRLcoordsyIRL[ 1519]= 25; IRLcoordszIRL[ 1519]= 3
IRLcoordsx[ 1520]= 49; IRLcoordsy[ 1520]= 24; IRLcoordsxIRL[ 1520]=-17; IRLcoordsyIRL[ 1520]= 24; IRLcoordszIRL[ 1520]= 3
IRLcoordsx[ 1521]= 49; IRLcoordsy[ 1521]= 25; IRLcoordsxIRL[ 1521]=-17; IRLcoordsyIRL[ 1521]= 23; IRLcoordszIRL[ 1521]= 3
IRLcoordsx[ 1522]= 49; IRLcoordsy[ 1522]= 26; IRLcoordsxIRL[ 1522]=-17; IRLcoordsyIRL[ 1522]= 22; IRLcoordszIRL[ 1522]= 3
IRLcoordsx[ 1523]= 49; IRLcoordsy[ 1523]= 27; IRLcoordsxIRL[ 1523]=-17; IRLcoordsyIRL[ 1523]= 21; IRLcoordszIRL[ 1523]= 3
IRLcoordsx[ 1524]= 49; IRLcoordsy[ 1524]= 28; IRLcoordsxIRL[ 1524]=-17; IRLcoordsyIRL[ 1524]= 20; IRLcoordszIRL[ 1524]= 3
IRLcoordsx[ 1525]= 49; IRLcoordsy[ 1525]= 29; IRLcoordsxIRL[ 1525]=-17; IRLcoordsyIRL[ 1525]= 19; IRLcoordszIRL[ 1525]= 3
IRLcoordsx[ 1526]= 49; IRLcoordsy[ 1526]= 30; IRLcoordsxIRL[ 1526]=-17; IRLcoordsyIRL[ 1526]= 18; IRLcoordszIRL[ 1526]= 3
IRLcoordsx[ 1527]= 49; IRLcoordsy[ 1527]= 31; IRLcoordsxIRL[ 1527]=-17; IRLcoordsyIRL[ 1527]= 17; IRLcoordszIRL[ 1527]= 3
IRLcoordsx[ 1528]= 50; IRLcoordsy[ 1528]= 20; IRLcoordsxIRL[ 1528]=-17; IRLcoordsyIRL[ 1528]= 28; IRLcoordszIRL[ 1528]= 2
IRLcoordsx[ 1529]= 50; IRLcoordsy[ 1529]= 21; IRLcoordsxIRL[ 1529]=-17; IRLcoordsyIRL[ 1529]= 27; IRLcoordszIRL[ 1529]= 2
IRLcoordsx[ 1530]= 50; IRLcoordsy[ 1530]= 22; IRLcoordsxIRL[ 1530]=-17; IRLcoordsyIRL[ 1530]= 26; IRLcoordszIRL[ 1530]= 2
IRLcoordsx[ 1531]= 50; IRLcoordsy[ 1531]= 23; IRLcoordsxIRL[ 1531]=-17; IRLcoordsyIRL[ 1531]= 25; IRLcoordszIRL[ 1531]= 2
IRLcoordsx[ 1532]= 50; IRLcoordsy[ 1532]= 24; IRLcoordsxIRL[ 1532]=-17; IRLcoordsyIRL[ 1532]= 24; IRLcoordszIRL[ 1532]= 2
IRLcoordsx[ 1533]= 50; IRLcoordsy[ 1533]= 25; IRLcoordsxIRL[ 1533]=-17; IRLcoordsyIRL[ 1533]= 23; IRLcoordszIRL[ 1533]= 2
IRLcoordsx[ 1534]= 50; IRLcoordsy[ 1534]= 26; IRLcoordsxIRL[ 1534]=-17; IRLcoordsyIRL[ 1534]= 22; IRLcoordszIRL[ 1534]= 2
IRLcoordsx[ 1535]= 50; IRLcoordsy[ 1535]= 27; IRLcoordsxIRL[ 1535]=-17; IRLcoordsyIRL[ 1535]= 21; IRLcoordszIRL[ 1535]= 2
IRLcoordsx[ 1536]= 50; IRLcoordsy[ 1536]= 28; IRLcoordsxIRL[ 1536]=-17; IRLcoordsyIRL[ 1536]= 20; IRLcoordszIRL[ 1536]= 2
IRLcoordsx[ 1537]= 50; IRLcoordsy[ 1537]= 29; IRLcoordsxIRL[ 1537]=-17; IRLcoordsyIRL[ 1537]= 19; IRLcoordszIRL[ 1537]= 2
IRLcoordsx[ 1538]= 50; IRLcoordsy[ 1538]= 30; IRLcoordsxIRL[ 1538]=-17; IRLcoordsyIRL[ 1538]= 18; IRLcoordszIRL[ 1538]= 2
IRLcoordsx[ 1539]= 50; IRLcoordsy[ 1539]= 31; IRLcoordsxIRL[ 1539]=-17; IRLcoordsyIRL[ 1539]= 17; IRLcoordszIRL[ 1539]= 2
IRLcoordsx[ 1540]= 51; IRLcoordsy[ 1540]= 20; IRLcoordsxIRL[ 1540]=-17; IRLcoordsyIRL[ 1540]= 28; IRLcoordszIRL[ 1540]= 1
IRLcoordsx[ 1541]= 51; IRLcoordsy[ 1541]= 21; IRLcoordsxIRL[ 1541]=-17; IRLcoordsyIRL[ 1541]= 27; IRLcoordszIRL[ 1541]= 1
IRLcoordsx[ 1542]= 51; IRLcoordsy[ 1542]= 22; IRLcoordsxIRL[ 1542]=-17; IRLcoordsyIRL[ 1542]= 26; IRLcoordszIRL[ 1542]= 1
IRLcoordsx[ 1543]= 51; IRLcoordsy[ 1543]= 23; IRLcoordsxIRL[ 1543]=-17; IRLcoordsyIRL[ 1543]= 25; IRLcoordszIRL[ 1543]= 1
IRLcoordsx[ 1544]= 51; IRLcoordsy[ 1544]= 24; IRLcoordsxIRL[ 1544]=-17; IRLcoordsyIRL[ 1544]= 24; IRLcoordszIRL[ 1544]= 1
IRLcoordsx[ 1545]= 51; IRLcoordsy[ 1545]= 25; IRLcoordsxIRL[ 1545]=-17; IRLcoordsyIRL[ 1545]= 23; IRLcoordszIRL[ 1545]= 1
IRLcoordsx[ 1546]= 51; IRLcoordsy[ 1546]= 26; IRLcoordsxIRL[ 1546]=-17; IRLcoordsyIRL[ 1546]= 22; IRLcoordszIRL[ 1546]= 1
IRLcoordsx[ 1547]= 51; IRLcoordsy[ 1547]= 27; IRLcoordsxIRL[ 1547]=-17; IRLcoordsyIRL[ 1547]= 21; IRLcoordszIRL[ 1547]= 1
IRLcoordsx[ 1548]= 51; IRLcoordsy[ 1548]= 28; IRLcoordsxIRL[ 1548]=-17; IRLcoordsyIRL[ 1548]= 20; IRLcoordszIRL[ 1548]= 1
IRLcoordsx[ 1549]= 51; IRLcoordsy[ 1549]= 29; IRLcoordsxIRL[ 1549]=-17; IRLcoordsyIRL[ 1549]= 19; IRLcoordszIRL[ 1549]= 1
IRLcoordsx[ 1550]= 51; IRLcoordsy[ 1550]= 30; IRLcoordsxIRL[ 1550]=-17; IRLcoordsyIRL[ 1550]= 18; IRLcoordszIRL[ 1550]= 1
IRLcoordsx[ 1551]= 51; IRLcoordsy[ 1551]= 31; IRLcoordsxIRL[ 1551]=-17; IRLcoordsyIRL[ 1551]= 17; IRLcoordszIRL[ 1551]= 1
IRLcoordsx[ 1552]= 40; IRLcoordsy[ 1552]= 20; IRLcoordsxIRL[ 1552]=-22; IRLcoordsyIRL[ 1552]= 28; IRLcoordszIRL[ 1552]= 1
IRLcoordsx[ 1553]= 40; IRLcoordsy[ 1553]= 21; IRLcoordsxIRL[ 1553]=-22; IRLcoordsyIRL[ 1553]= 27; IRLcoordszIRL[ 1553]= 1
IRLcoordsx[ 1554]= 40; IRLcoordsy[ 1554]= 22; IRLcoordsxIRL[ 1554]=-22; IRLcoordsyIRL[ 1554]= 26; IRLcoordszIRL[ 1554]= 1
IRLcoordsx[ 1555]= 40; IRLcoordsy[ 1555]= 23; IRLcoordsxIRL[ 1555]=-22; IRLcoordsyIRL[ 1555]= 25; IRLcoordszIRL[ 1555]= 1
IRLcoordsx[ 1556]= 40; IRLcoordsy[ 1556]= 24; IRLcoordsxIRL[ 1556]=-22; IRLcoordsyIRL[ 1556]= 24; IRLcoordszIRL[ 1556]= 1
IRLcoordsx[ 1557]= 40; IRLcoordsy[ 1557]= 25; IRLcoordsxIRL[ 1557]=-22; IRLcoordsyIRL[ 1557]= 23; IRLcoordszIRL[ 1557]= 1
IRLcoordsx[ 1558]= 40; IRLcoordsy[ 1558]= 26; IRLcoordsxIRL[ 1558]=-22; IRLcoordsyIRL[ 1558]= 22; IRLcoordszIRL[ 1558]= 1
IRLcoordsx[ 1559]= 40; IRLcoordsy[ 1559]= 27; IRLcoordsxIRL[ 1559]=-22; IRLcoordsyIRL[ 1559]= 21; IRLcoordszIRL[ 1559]= 1
IRLcoordsx[ 1560]= 40; IRLcoordsy[ 1560]= 28; IRLcoordsxIRL[ 1560]=-22; IRLcoordsyIRL[ 1560]= 20; IRLcoordszIRL[ 1560]= 1
IRLcoordsx[ 1561]= 40; IRLcoordsy[ 1561]= 29; IRLcoordsxIRL[ 1561]=-22; IRLcoordsyIRL[ 1561]= 19; IRLcoordszIRL[ 1561]= 1
IRLcoordsx[ 1562]= 40; IRLcoordsy[ 1562]= 30; IRLcoordsxIRL[ 1562]=-22; IRLcoordsyIRL[ 1562]= 18; IRLcoordszIRL[ 1562]= 1
IRLcoordsx[ 1563]= 40; IRLcoordsy[ 1563]= 31; IRLcoordsxIRL[ 1563]=-22; IRLcoordsyIRL[ 1563]= 17; IRLcoordszIRL[ 1563]= 1
IRLcoordsx[ 1564]= 41; IRLcoordsy[ 1564]= 20; IRLcoordsxIRL[ 1564]=-22; IRLcoordsyIRL[ 1564]= 28; IRLcoordszIRL[ 1564]= 2
IRLcoordsx[ 1565]= 41; IRLcoordsy[ 1565]= 21; IRLcoordsxIRL[ 1565]=-22; IRLcoordsyIRL[ 1565]= 27; IRLcoordszIRL[ 1565]= 2
IRLcoordsx[ 1566]= 41; IRLcoordsy[ 1566]= 22; IRLcoordsxIRL[ 1566]=-22; IRLcoordsyIRL[ 1566]= 26; IRLcoordszIRL[ 1566]= 2
IRLcoordsx[ 1567]= 41; IRLcoordsy[ 1567]= 23; IRLcoordsxIRL[ 1567]=-22; IRLcoordsyIRL[ 1567]= 25; IRLcoordszIRL[ 1567]= 2
IRLcoordsx[ 1568]= 41; IRLcoordsy[ 1568]= 24; IRLcoordsxIRL[ 1568]=-22; IRLcoordsyIRL[ 1568]= 24; IRLcoordszIRL[ 1568]= 2
IRLcoordsx[ 1569]= 41; IRLcoordsy[ 1569]= 25; IRLcoordsxIRL[ 1569]=-22; IRLcoordsyIRL[ 1569]= 23; IRLcoordszIRL[ 1569]= 2
IRLcoordsx[ 1570]= 41; IRLcoordsy[ 1570]= 26; IRLcoordsxIRL[ 1570]=-22; IRLcoordsyIRL[ 1570]= 22; IRLcoordszIRL[ 1570]= 2
IRLcoordsx[ 1571]= 41; IRLcoordsy[ 1571]= 27; IRLcoordsxIRL[ 1571]=-22; IRLcoordsyIRL[ 1571]= 21; IRLcoordszIRL[ 1571]= 2
IRLcoordsx[ 1572]= 41; IRLcoordsy[ 1572]= 28; IRLcoordsxIRL[ 1572]=-22; IRLcoordsyIRL[ 1572]= 20; IRLcoordszIRL[ 1572]= 2
IRLcoordsx[ 1573]= 41; IRLcoordsy[ 1573]= 29; IRLcoordsxIRL[ 1573]=-22; IRLcoordsyIRL[ 1573]= 19; IRLcoordszIRL[ 1573]= 2
IRLcoordsx[ 1574]= 41; IRLcoordsy[ 1574]= 30; IRLcoordsxIRL[ 1574]=-22; IRLcoordsyIRL[ 1574]= 18; IRLcoordszIRL[ 1574]= 2
IRLcoordsx[ 1575]= 41; IRLcoordsy[ 1575]= 31; IRLcoordsxIRL[ 1575]=-22; IRLcoordsyIRL[ 1575]= 17; IRLcoordszIRL[ 1575]= 2
IRLcoordsx[ 1576]= 42; IRLcoordsy[ 1576]= 20; IRLcoordsxIRL[ 1576]=-22; IRLcoordsyIRL[ 1576]= 28; IRLcoordszIRL[ 1576]= 3
IRLcoordsx[ 1577]= 42; IRLcoordsy[ 1577]= 21; IRLcoordsxIRL[ 1577]=-22; IRLcoordsyIRL[ 1577]= 27; IRLcoordszIRL[ 1577]= 3
IRLcoordsx[ 1578]= 42; IRLcoordsy[ 1578]= 22; IRLcoordsxIRL[ 1578]=-22; IRLcoordsyIRL[ 1578]= 26; IRLcoordszIRL[ 1578]= 3
IRLcoordsx[ 1579]= 42; IRLcoordsy[ 1579]= 23; IRLcoordsxIRL[ 1579]=-22; IRLcoordsyIRL[ 1579]= 25; IRLcoordszIRL[ 1579]= 3
IRLcoordsx[ 1580]= 42; IRLcoordsy[ 1580]= 24; IRLcoordsxIRL[ 1580]=-22; IRLcoordsyIRL[ 1580]= 24; IRLcoordszIRL[ 1580]= 3
IRLcoordsx[ 1581]= 42; IRLcoordsy[ 1581]= 25; IRLcoordsxIRL[ 1581]=-22; IRLcoordsyIRL[ 1581]= 23; IRLcoordszIRL[ 1581]= 3
IRLcoordsx[ 1582]= 42; IRLcoordsy[ 1582]= 26; IRLcoordsxIRL[ 1582]=-22; IRLcoordsyIRL[ 1582]= 22; IRLcoordszIRL[ 1582]= 3
IRLcoordsx[ 1583]= 42; IRLcoordsy[ 1583]= 27; IRLcoordsxIRL[ 1583]=-22; IRLcoordsyIRL[ 1583]= 21; IRLcoordszIRL[ 1583]= 3
IRLcoordsx[ 1584]= 42; IRLcoordsy[ 1584]= 28; IRLcoordsxIRL[ 1584]=-22; IRLcoordsyIRL[ 1584]= 20; IRLcoordszIRL[ 1584]= 3
IRLcoordsx[ 1585]= 42; IRLcoordsy[ 1585]= 29; IRLcoordsxIRL[ 1585]=-22; IRLcoordsyIRL[ 1585]= 19; IRLcoordszIRL[ 1585]= 3
IRLcoordsx[ 1586]= 42; IRLcoordsy[ 1586]= 30; IRLcoordsxIRL[ 1586]=-22; IRLcoordsyIRL[ 1586]= 18; IRLcoordszIRL[ 1586]= 3
IRLcoordsx[ 1587]= 42; IRLcoordsy[ 1587]= 31; IRLcoordsxIRL[ 1587]=-22; IRLcoordsyIRL[ 1587]= 17; IRLcoordszIRL[ 1587]= 3
IRLcoordsx[ 1588]= 43; IRLcoordsy[ 1588]= 20; IRLcoordsxIRL[ 1588]=-22; IRLcoordsyIRL[ 1588]= 28; IRLcoordszIRL[ 1588]= 4
IRLcoordsx[ 1589]= 43; IRLcoordsy[ 1589]= 21; IRLcoordsxIRL[ 1589]=-22; IRLcoordsyIRL[ 1589]= 27; IRLcoordszIRL[ 1589]= 4
IRLcoordsx[ 1590]= 43; IRLcoordsy[ 1590]= 22; IRLcoordsxIRL[ 1590]=-22; IRLcoordsyIRL[ 1590]= 26; IRLcoordszIRL[ 1590]= 4
IRLcoordsx[ 1591]= 43; IRLcoordsy[ 1591]= 23; IRLcoordsxIRL[ 1591]=-22; IRLcoordsyIRL[ 1591]= 25; IRLcoordszIRL[ 1591]= 4
IRLcoordsx[ 1592]= 43; IRLcoordsy[ 1592]= 24; IRLcoordsxIRL[ 1592]=-22; IRLcoordsyIRL[ 1592]= 24; IRLcoordszIRL[ 1592]= 4
IRLcoordsx[ 1593]= 43; IRLcoordsy[ 1593]= 25; IRLcoordsxIRL[ 1593]=-22; IRLcoordsyIRL[ 1593]= 23; IRLcoordszIRL[ 1593]= 4
IRLcoordsx[ 1594]= 43; IRLcoordsy[ 1594]= 26; IRLcoordsxIRL[ 1594]=-22; IRLcoordsyIRL[ 1594]= 22; IRLcoordszIRL[ 1594]= 4
IRLcoordsx[ 1595]= 43; IRLcoordsy[ 1595]= 27; IRLcoordsxIRL[ 1595]=-22; IRLcoordsyIRL[ 1595]= 21; IRLcoordszIRL[ 1595]= 4
IRLcoordsx[ 1596]= 43; IRLcoordsy[ 1596]= 28; IRLcoordsxIRL[ 1596]=-22; IRLcoordsyIRL[ 1596]= 20; IRLcoordszIRL[ 1596]= 4
IRLcoordsx[ 1597]= 43; IRLcoordsy[ 1597]= 29; IRLcoordsxIRL[ 1597]=-22; IRLcoordsyIRL[ 1597]= 19; IRLcoordszIRL[ 1597]= 4
IRLcoordsx[ 1598]= 43; IRLcoordsy[ 1598]= 30; IRLcoordsxIRL[ 1598]=-22; IRLcoordsyIRL[ 1598]= 18; IRLcoordszIRL[ 1598]= 4
IRLcoordsx[ 1599]= 43; IRLcoordsy[ 1599]= 31; IRLcoordsxIRL[ 1599]=-22; IRLcoordsyIRL[ 1599]= 17; IRLcoordszIRL[ 1599]= 4
IRLcoordsx[ 1600]= 44; IRLcoordsy[ 1600]= 16; IRLcoordsxIRL[ 1600]=-21; IRLcoordsyIRL[ 1600]= 29; IRLcoordszIRL[ 1600]= 1
IRLcoordsx[ 1601]= 44; IRLcoordsy[ 1601]= 17; IRLcoordsxIRL[ 1601]=-21; IRLcoordsyIRL[ 1601]= 29; IRLcoordszIRL[ 1601]= 2
IRLcoordsx[ 1602]= 44; IRLcoordsy[ 1602]= 18; IRLcoordsxIRL[ 1602]=-21; IRLcoordsyIRL[ 1602]= 29; IRLcoordszIRL[ 1602]= 3
IRLcoordsx[ 1603]= 44; IRLcoordsy[ 1603]= 19; IRLcoordsxIRL[ 1603]=-21; IRLcoordsyIRL[ 1603]= 29; IRLcoordszIRL[ 1603]= 4
IRLcoordsx[ 1604]= 45; IRLcoordsy[ 1604]= 16; IRLcoordsxIRL[ 1604]=-20; IRLcoordsyIRL[ 1604]= 29; IRLcoordszIRL[ 1604]= 1
IRLcoordsx[ 1605]= 45; IRLcoordsy[ 1605]= 17; IRLcoordsxIRL[ 1605]=-20; IRLcoordsyIRL[ 1605]= 29; IRLcoordszIRL[ 1605]= 2
IRLcoordsx[ 1606]= 45; IRLcoordsy[ 1606]= 18; IRLcoordsxIRL[ 1606]=-20; IRLcoordsyIRL[ 1606]= 29; IRLcoordszIRL[ 1606]= 3
IRLcoordsx[ 1607]= 45; IRLcoordsy[ 1607]= 19; IRLcoordsxIRL[ 1607]=-20; IRLcoordsyIRL[ 1607]= 29; IRLcoordszIRL[ 1607]= 4
IRLcoordsx[ 1608]= 46; IRLcoordsy[ 1608]= 16; IRLcoordsxIRL[ 1608]=-19; IRLcoordsyIRL[ 1608]= 29; IRLcoordszIRL[ 1608]= 1
IRLcoordsx[ 1609]= 46; IRLcoordsy[ 1609]= 17; IRLcoordsxIRL[ 1609]=-19; IRLcoordsyIRL[ 1609]= 29; IRLcoordszIRL[ 1609]= 2
IRLcoordsx[ 1610]= 46; IRLcoordsy[ 1610]= 18; IRLcoordsxIRL[ 1610]=-19; IRLcoordsyIRL[ 1610]= 29; IRLcoordszIRL[ 1610]= 3
IRLcoordsx[ 1611]= 46; IRLcoordsy[ 1611]= 19; IRLcoordsxIRL[ 1611]=-19; IRLcoordsyIRL[ 1611]= 29; IRLcoordszIRL[ 1611]= 4
IRLcoordsx[ 1612]= 47; IRLcoordsy[ 1612]= 16; IRLcoordsxIRL[ 1612]=-18; IRLcoordsyIRL[ 1612]= 29; IRLcoordszIRL[ 1612]= 1
IRLcoordsx[ 1613]= 47; IRLcoordsy[ 1613]= 17; IRLcoordsxIRL[ 1613]=-18; IRLcoordsyIRL[ 1613]= 29; IRLcoordszIRL[ 1613]= 2
IRLcoordsx[ 1614]= 47; IRLcoordsy[ 1614]= 18; IRLcoordsxIRL[ 1614]=-18; IRLcoordsyIRL[ 1614]= 29; IRLcoordszIRL[ 1614]= 3
IRLcoordsx[ 1615]= 47; IRLcoordsy[ 1615]= 19; IRLcoordsxIRL[ 1615]=-18; IRLcoordsyIRL[ 1615]= 29; IRLcoordszIRL[ 1615]= 4
IRLcoordsx[ 1616]= 48; IRLcoordsy[ 1616]= 16; IRLcoordsxIRL[ 1616]=-21; IRLcoordsyIRL[ 1616]= 16; IRLcoordszIRL[ 1616]= 1
IRLcoordsx[ 1617]= 48; IRLcoordsy[ 1617]= 17; IRLcoordsxIRL[ 1617]=-21; IRLcoordsyIRL[ 1617]= 16; IRLcoordszIRL[ 1617]= 2
IRLcoordsx[ 1618]= 48; IRLcoordsy[ 1618]= 18; IRLcoordsxIRL[ 1618]=-21; IRLcoordsyIRL[ 1618]= 16; IRLcoordszIRL[ 1618]= 3
IRLcoordsx[ 1619]= 48; IRLcoordsy[ 1619]= 19; IRLcoordsxIRL[ 1619]=-21; IRLcoordsyIRL[ 1619]= 16; IRLcoordszIRL[ 1619]= 4
IRLcoordsx[ 1620]= 49; IRLcoordsy[ 1620]= 16; IRLcoordsxIRL[ 1620]=-20; IRLcoordsyIRL[ 1620]= 16; IRLcoordszIRL[ 1620]= 1
IRLcoordsx[ 1621]= 49; IRLcoordsy[ 1621]= 17; IRLcoordsxIRL[ 1621]=-20; IRLcoordsyIRL[ 1621]= 16; IRLcoordszIRL[ 1621]= 2
IRLcoordsx[ 1622]= 49; IRLcoordsy[ 1622]= 18; IRLcoordsxIRL[ 1622]=-20; IRLcoordsyIRL[ 1622]= 16; IRLcoordszIRL[ 1622]= 3
IRLcoordsx[ 1623]= 49; IRLcoordsy[ 1623]= 19; IRLcoordsxIRL[ 1623]=-20; IRLcoordsyIRL[ 1623]= 16; IRLcoordszIRL[ 1623]= 4
IRLcoordsx[ 1624]= 50; IRLcoordsy[ 1624]= 16; IRLcoordsxIRL[ 1624]=-19; IRLcoordsyIRL[ 1624]= 16; IRLcoordszIRL[ 1624]= 1
IRLcoordsx[ 1625]= 50; IRLcoordsy[ 1625]= 17; IRLcoordsxIRL[ 1625]=-19; IRLcoordsyIRL[ 1625]= 16; IRLcoordszIRL[ 1625]= 2
IRLcoordsx[ 1626]= 50; IRLcoordsy[ 1626]= 18; IRLcoordsxIRL[ 1626]=-19; IRLcoordsyIRL[ 1626]= 16; IRLcoordszIRL[ 1626]= 3
IRLcoordsx[ 1627]= 50; IRLcoordsy[ 1627]= 19; IRLcoordsxIRL[ 1627]=-19; IRLcoordsyIRL[ 1627]= 16; IRLcoordszIRL[ 1627]= 4
IRLcoordsx[ 1628]= 51; IRLcoordsy[ 1628]= 16; IRLcoordsxIRL[ 1628]=-18; IRLcoordsyIRL[ 1628]= 16; IRLcoordszIRL[ 1628]= 1
IRLcoordsx[ 1629]= 51; IRLcoordsy[ 1629]= 17; IRLcoordsxIRL[ 1629]=-18; IRLcoordsyIRL[ 1629]= 16; IRLcoordszIRL[ 1629]= 2
IRLcoordsx[ 1630]= 51; IRLcoordsy[ 1630]= 18; IRLcoordsxIRL[ 1630]=-18; IRLcoordsyIRL[ 1630]= 16; IRLcoordszIRL[ 1630]= 3
IRLcoordsx[ 1631]= 51; IRLcoordsy[ 1631]= 19; IRLcoordsxIRL[ 1631]=-18; IRLcoordsyIRL[ 1631]= 16; IRLcoordszIRL[ 1631]= 4
end

function loadSkin ()
    
    mySkin = gfx2.loadImage("skinEditor.png")
    for i = 0, 1631 do
        curColour = mySkin:getPixel(IRLcoordsx[i]+1,IRLcoordsy[i]+1)
        curColourBlock = RGBtoBlock(curColour.r,curColour.g,curColour.b)
        client.execute("execute setblock "..IRLcoordsxIRL[i] .. " " .. IRLcoordsyIRL[i] .. " " .. IRLcoordszIRL[i] .. " " .. curColourBlock)
    end
end

registerCommand("loadSkin",loadSkin)

function saveSkin()
    yourSkin2 = gfx2.loadImage("skinEditor.png")
    for i = 0, 1631 do
        curColourBlock = dimension.getBlock(IRLcoordsxIRL[i],IRLcoordsyIRL[i],IRLcoordszIRL[i])
        curColourR, curColourG, curColourB = blockToRGB("minecraft:" .. curColourBlock.name)
        yourSkin2:setPixel(IRLcoordsx[i]+1,IRLcoordsy[i]+1,curColourR,curColourG,curColourB) 
    end
    yourSkin2:save("skinEditor.png") 
end

registerCommand("saveSkin",saveSkin)
    

function render(dt)
    if autoSave then
        nowtime = os.clock()
        doit = false
        if previoustime == nil then doit = true
        elseif (nowtime - previoustime > 5) then doit = true end
        if (doit == true) then  
            previoustime = nowtime
            saveSkin()
            -- player.skin().setSkinCape("yourSkin2","testCaape.png") crashes :( tho the skinstealer doesn't so whats happening 
        end
    end 
end
