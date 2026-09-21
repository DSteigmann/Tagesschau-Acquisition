include("path.jl")
include("error_handling.jl")
import Dates
using TranscodingStreams
#using CodecZlib
using Libz

"""
    compress_data(json_data::String)

Compresses the `json_data` string and saves it as a `.json` file to the directory specified by `DATA_SAVE_PATH`.
The filename is generated using the current date and time. 
If the process of compression and writing to the file is successful, a log entry is made with the message 
successfully written file: `filename`, and a message is sent as a Telegram bot. 
In case of any error during the process, it is logged and passed to `errors_file_io` function for further processing.

# Arguments
- `json_data::String`: A JSON string that needs to be compressed and stored.
"""
function compress_data(json_data::String)
    dt = DateTime(Dates.now())
    dt = Dates.format(dt, "yyyy-mm-dd HH:MM:SS")
    filename = String(dt) * ".json"

    try
        open(joinpath(DATA_SAVE_PATH, filename), "a+") do io
            compress_io = ZlibDeflateOutputStream(io)
            write(compress_io, json_data)
            Libz.close(compress_io)
	    write_log("info", "successfully written file: " * filename)
	    telegram_bot_Send_Message("Success. Data stored.")

        end
    catch error
        errors_file_io(error)
    end

end

"""
    decompress_data(input_file_path::String)

Reads and decompresses a .json file located at `input_file_path`.
The function uses ZlibInflateInputStream to handle the decompression of the contents of the file. 
After the file is decompressed, the data is returned as a string.

# Arguments
- `input_file_path::String`: The path to the .json file that needs to be decompressed and read.

# Returns
- `String`: The decompressed data from the .json file as a string.
"""
function decompress_data(input_file_path::String)
    open(input_file_path, "r") do io
        decompress_io = ZlibInflateInputStream(io)
        json_data = read(decompress_io, String)
        Libz.close(decompress_io)
        return json_data
    end
end

"""
    decompress_single_file(source, target)

Reads and decompresses a .json file located at source path.
The result will be written to the target path.

# Arguments
- `source::String`: The path to the .json file that needs to be decompressed.
- `target::String`: The path to the .json file that needs to be written.

"""
function decompress_single_file(source::String, target::String)
	if isfile(source)
		filename = target * "_uncompressed";
		try
			open(filename, "a+") do f
				write(f, decompress_data(source))
		end
		catch error
			errors_file_io(error)
		end

		write_log("info", "successfully written uncompressed file: " * filename)
	end
end

"""
    decompress_folder(source_folder, target_folder)
Reads the files of the source_folder and will decompress all files to the target_folder.

# Arguments
- `source_folder::String`: The path to the folder that needs to be decompressed.
- `target_folder::String`: The path to the folder where files will be written.

"""

function decompress_folder(source_folder, target_folder)
	for (root, dirs, files) in walkdir(source_folder)
		for file in files
			println(target_folder*file*"_uncompressed")
			decompress_single_file(joinpath(root,file), joinpath(target_folder, file))
		end
	end
end


