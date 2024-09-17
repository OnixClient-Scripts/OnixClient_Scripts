name = "Live stream testing"
description="A very unstable prototype of one of those things that tells you your chat when livestreeaming. when you find a bug tell it to me in #development in the discord"




debugMode= false

client.settings.addBool("Debug prints?","debugMode")

positionX=50
positionY=50
sizeX = 80
sizeY=20


function onNetworkData(code, identifier, data)
    if debugMode then
        print(data)
    end
    
    prevOutcome=outcome
    LiveChat = data
    if debugMode then
        print("recieved data code"..identifier)    
    end
    
    tableOfThings = string.split(LiveChat,"//")
    outcome = ""
    for n = 1, #tableOfThings do
        outcome = outcome .. "\n" .. tableOfThings[n]
    end
    if outcome == nil or outcome == "" then print("nil/empty outcome!");outcome=prevOutcome end
    
end

debugMode=true

function render(dt)
    
        
    

    if outcome ==nil then --[[print("nil LiveChat!") ]]else
        
        
        gfx.text(0,0,outcome)
    end

    if lastUpdateTime==nil then
        
        codeToBeSent = math.random(1,100)
        network.get("http://localhost:8080", codeToBeSent)
        lastUpdateTime=os.clock()
        if debugMode then
            print("Asked For data code"..codeToBeSent)    
        end
        
    end


    if lastUpdateTime<os.clock()-8 then
        codeToBeSent = math.random(1,100)
        network.get("http://localhost:8080", codeToBeSent)
        lastUpdateTime=os.clock()
        if debugMode then
            print("Asked For data code"..codeToBeSent)    
        end
    end
end