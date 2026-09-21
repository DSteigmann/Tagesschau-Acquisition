begin 
	```
	A File to decompress a single file.
	Usage : julia --project=. src/decompress_file.jl folder_to_ignore/data/<filename>.json folder_to_ignore/uncompressed_data/filename

	This will create a new file in the targetfolder folder_to_ignore/uncompressed_data/filename_uncompressed

	```
	include("compression.jl")
	decompress_single_file(ARGS[1], ARGS[2])


end
