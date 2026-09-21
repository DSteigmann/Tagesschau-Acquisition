begin
	include("compression.jl")
        ```
        A File to decompress files from a folder.
        Usage : julia --project=. src/decompress_files.jl folder_to_ignore/data/ folder_to_ignore/uncompressed_data/

        This will create a new files in the targetfolder folder_to_ignore/uncompressed_data/filename_uncompressed
	This can be helpful to uncompress the complete folder data.

        ```




	decompress_folder(ARGS[1], ARGS[2])
end
