import Dates
using Dates


include("path.jl")
include("telegram_bot.jl")




directory = readdir(DATA_SAVE_PATH)  # reading files and directory
datetoday = Dates.today() #stirng

global reporting_date_time = Date(Dates.DateTime("$datetoday 12:05:00", "yyyy-mm-dd HH:MM:SS"))
global  daily_report_sent = false

"""
@reporting_files_Count() counts number of files in a given directory. Takes no arguments. Directory is defined globally.

"""
function reporting_files_Count()

    num_of_files = 0 #to save current number of files
    filesize = 0

    for (root, dirs, files) in walkdir(DATA_SAVE_PATH)
	    for file in files
	        filesize += stat(joinpath(root, file)).size # path to files
		num_of_files += 1
            end
    end
    filesize = round(filesize / ( 1024 * 1024 ), digits=2)

    return "The date of this report is $datetoday  Number of files in  directory $num_of_files.  Total size $filesize MB."
end

"""
@check_time sets daily_report_sent value to FALSE, so that the report can be sent later

"""

function check_time()
    now_time = Dates.now()

    if Dates.hour(now_time) == 12 && Dates.minute(now_time) >= 5
        return false
    
    end

    return true
end

"""
@function that sends a report at appropriate time, if the report has not been sent yet

"""
function reporting_All()
    daily_report_sent = check_time()

    if (reporting_date_time <= Dates.now()) && (daily_report_sent == false)

        telegram_bot_Send_Message(reporting_files_Count())
        daily_report_sent = true
  
    end
    
    
end
