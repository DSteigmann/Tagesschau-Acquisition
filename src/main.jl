using Pkg
if isfile("Project.toml") && isfile("Manifest.toml")
    Pkg.activate(".")
end

include("request.jl")
include("compression.jl")
include("error_handling.jl")
include("logging.jl")
include("path.jl")
include("reporting.jl")
   

# _______________ THIS IS MAIN ()__________________

    # 1. Access the website 
    
    request_process = tagesschau_api_Authorise(API_HOMEPAGE); 

   
    # 2. Convert to json 

    content_in_json = content_to_json(String(request_process))
  #  println(content_in_json) #data converted to json 

    #Compress the data

    compressed_data = compress_data(content_in_json)

    reporting_All()   


# " 1. Use the public interface https://www.tagesschau.de/api2/homepage/ to acquire data
# (json format) from the tagesschau.de website in 5 min intervals for at least a week.
# 2. Store the acquired data on disk.
# 3. Name each json-file by its acquisition date time.
# 4. Each file is about 1.6 MB in size, so roughly 500 MB of data will be incoming per day. Use compression methods keep the storage requirements minimal.
# 5. Write methods to log the process, handle exceptions and monitor the progress.
# 6. Use Julia as much as possible for all these tasks."
