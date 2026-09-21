begin

include("telegram_bot.jl")
include("logging.jl")
using HTTP


#----------------- TAGESSCHAU API HTTP Requests ----------------------

"""
description errors_api_Authorise - Exception handling for HTTP requests. Check for errors otherwise throw Unknown error.
@parameter e - Exception

"""

function errors_api_Authorise(e::Exception)
    if isa(e, HTTP.RequestError)
        message = "Error: Request status error"
        telegram_bot_Send_Message(message)
    elseif isa(e, HTTP.ConnectError)
        message = "Error: Connection error"
        telegram_bot_Send_Message(message)
    elseif isa(e, HTTP.TimeoutError)
        message = "Error: Timeout error"
        telegram_bot_Send_Message(message)
    else
        message = "Unknown error while sending a request"
        telegram_bot_Send_Message(message)
    end
    write_log("error", message)
    throw(e)
end

#------------------- IO FUNCTIONS -----------------

"""
description errors_file_io - Exception handling for IO-Operations. Check for Systemcall and Readonly Memory in specific, otherwise throw an Unknown error.
@parameter e - Exception

"""
function errors_file_io(e::Exception)
    if isa(e, ReadOnlyMemoryError)
        message = "Error: Memory is Readonly"
        telegram_bot_Send_Message(message)
    elseif isa(e, SystemError)
        message = "Error: Systemcall Error"
        telegram_bot_Send_Message(message)
    else
        message = "Unknown error while File IO"
        telegram_bot_Send_Message(message)
    end
    write_log("error", message)
    throw(e)
end


#------------------- JSON Functions -------------------
"""
description json_content_error - Exception handling for JSON-Operations. Only throws general errors.
@parameter e - Exception

"""
function json_content_error(e::Exception)
	message = "Unknown error with JSON formatting"
    	write_log("error", message)
        telegram_bot_Send_Message(message)
	throw(e)
end



end  #end file 
