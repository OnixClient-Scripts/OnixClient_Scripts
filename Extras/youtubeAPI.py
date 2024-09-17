from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from http.server import BaseHTTPRequestHandler, HTTPServer


LIVE_STREAM_ID = input("What is your livestream id?")

# Scopes for OAuth
scopes = ['https://www.googleapis.com/auth/youtube.readonly']

flow = InstalledAppFlow.from_client_secrets_file(
    "C:\Users\ms\AppData\Local\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\RoamingState\OnixClient\Scripts\Extras\YOUR_CLIENT_SECRET_FILE.json", scopes)
credentials = flow.run_local_server(port=0)

youtube = build('youtube', 'v3', credentials=credentials)


def getLiveChatId(LIVE_STREAM_ID):
    """
    It takes a live stream ID as input, and returns the live chat ID associated with that live stream

    LIVE_STREAM_ID: The ID of the live stream
    return: The live chat ID of the live stream.
    """

    stream = youtube.videos().list(
        part="liveStreamingDetails",
        id=LIVE_STREAM_ID,  # Live stream ID
    )
    response = stream.execute()
    # print("\nLive Stream Details:  ", json.dumps(response, indent=2))

    liveChatId = response['items'][0]['liveStreamingDetails']['activeLiveChatId']
    print("\nLive Chat ID: ", liveChatId)
    return liveChatId


liveChatId = getLiveChatId(LIVE_STREAM_ID)




import time

def get_live_chat_messages(live_chat_id):
    request = youtube.liveChatMessages().list(
        part='snippet',
        liveChatId=live_chat_id,
        maxResults=5  # Adjust as needed
    )
    
    response = request.execute()
    return response['items']


fullChat = {}
fullAuthors = {}

def print_live_chat_messages(live_chat_id):
    global fullChat
    global fullAuthors        
    fullChat = {}           
    fullAuthors = {}
    
    messages = get_live_chat_messages(live_chat_id)
    for message in messages:
        authors = message['snippet']['authorChannelId'] # authorDetails.displayName
        text = message['snippet']['displayMessage']
        fullChat[len(fullChat)+1] = text 
        fullAuthors[len(fullAuthors)+1] = authors
        time.sleep(1)
    # print(fullChat)
    thingToReturn = {}
    thingToReturn[0] = fullAuthors
    thingToReturn[1] = fullChat
    return thingToReturn

    



lastMessage = None

from http.server import BaseHTTPRequestHandler, HTTPServer

class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):
    
    def do_GET(self):
        # Set response status code
        self.send_response(200)

        # Set the headers
        self.send_header("Content-type", "text/html")
        self.end_headers()

        # Send some content
        chat = print_live_chat_messages(liveChatId)
        fullChat = chat[1]
        fullAuthors = chat[0]
        

        # addToList = False
        # toSendMsgs = {}
        
        # print(lastMessage)
        # global lastMessage
    
        


        # if lastMessage is not None:
        #     for x in range(1,len(fullChat)):
        #         if addToList:
        #             toSendMsgs[len(toSendMsgs)+1] = fullChat[x]
        #         if fullChat[x] == lastMessage:
        #             addToList = True
        # else:
        #     lastMessage = fullChat[len(fullChat)]
            

        # if not addToList:
        #     toSendMsgs = fullChat


        # lastMessage = fullChat[len(fullChat)]
        outcome = ""
        for n in range(1,len(fullChat)):
            outcome = outcome + fullChat[n] + "//"
        self.wfile.write(outcome.encode())

# Set up and start the server
host = 'localhost'
port = 8080
httpd = HTTPServer((host, port), SimpleHTTPRequestHandler)
print(f"Server started at http://{host}:{port}")
httpd.serve_forever()










