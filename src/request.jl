import Dates

using HTTP, Base, Dates, JSON
include("error_handling.jl")
include("path.jl")



#----------------- TAGESSCHAU API HTTP Requests ----------------------

function tagesschau_api_Authorise(link::String)
    
    try
        r = HTTP.get(link)
	write_log("info", "successfully requested tagesschau api")
	return r
    catch error
        errors_api_Authorise(error)
        return r
    end
    telegram_bot_Send_Message("Success. Request fulfilled.")
    return r.body
end

#------------------- IO FUNCTIONS -----------------
"""
description write_to_json_file - Creates a File and writes the content into it.
@parameter filename - String
@parameter content - String

"""
function write_to_file(content, filename="")
	if filename == ""
	        dt = DateTime(Dates.now())
        	dt = Dates.format(dt, "yyyy-mm-dd HH:MM:SS")
        	filename = String(dt) * ".json"
	end


        try
                open(joinpath(DATA_SAVE_PATH, filename), "a+") do f
                        write(f, content)
                end
        catch error
                errors_file_io(error)
        end

	write_log("info", "successfully written file: " * filename)
        telegram_bot_Send_Message("Success. Data stored.")
end


#------------------- JSON Functions -------------------
"""
description content_to_json - Converts content to json.
@parameter content - String

"""
function content_to_json(content)
        try
                return content = JSON.json(content)

        catch error
                #json_content_error(error)
                println(error)
        end
        telegram_bot_Send_Message("Success. JSON conversion successful.")
        return content
end


function get_status(r)
    return r.status
end

function create_json(r)
    return String(r.body)
end

function get_headers(r)
    return r.headers
end
