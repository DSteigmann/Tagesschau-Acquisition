using Telegram, Telegram.API, HTTP

#Links Telegram bot 
global telegram_bot_token = "6265303620:AAHlCVRcfc7pqDzxsmUrY9AXMLDxmdQk5Sc"
global telegram_bot_chat_id = "-1001908698104"

#------------------- TELEGRAM API FUNCTIONS -----------------


#Creates telegram client, which can be used to run telegram commands. I think it is doen once at the very beginning

function telegram_bot_Authorise(token::String, id::String)
    global telegram_bot_client = TelegramClient(token, chat_id = id)
  
    #useglobally!(telegram_bot_client) #to get rid of a client 

    return telegram_bot_client #returns a client
end


#Send a Message when we need it

function telegram_bot_Send_Message(message::String)
    url = "https://api.telegram.org/bot$telegram_bot_token/sendMessage?chat_id=$telegram_bot_chat_id&text=$message"
    #println(url)
    message_sent = HTTP.post(url)
    println(message_sent)
    return message_sent

end
