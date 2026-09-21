using Test
#using Main.group15acquisition #our module
include("../src/compression.jl")  #Here are the compression functions
include("../src/path.jl")
using JSON

@testset "Test Compression and Decompression" begin
    original_data = Dict(
    "name" => "Max Mustermann",
    "city" => "Berlin",
    "age" => 39,
    "occupation" => "Engineer",
    "email" => "max.mustermann@example.com",
    "phone" => "+49 346 33464362",
    "country" => "Germany",
    "postcode" => "101351",
    "street" => "Am Baum",
    "housenumber" => "11"
)
    original_json = JSON.json(original_data)

    #we save the original JSON data to a temp file for the size comparison later
    temp_file_path = tempname()
    open(temp_file_path, "w") do io
        write(io, original_json)
    end
    original_file_size = filesize(temp_file_path)

    """
    Test compress_data function:
    This test case checks if the 'compress_data' function is working correctly. 
    It compresses the original JSON data and checks whether the latest file in 
    the data directory exists, which should be the compressed file. 
    It also tests if the size of the compressed file is less than the original file, 
    as we expect from a compression process.
    """
    
    @testset "Test compress_data function" begin

        compress_data(original_json)
        #this gets the latest file in your data directory.
        latest_file = readdir(DATA_SAVE_PATH, sort=true)[end]
        @test isfile(joinpath(DATA_SAVE_PATH, latest_file))

        #test if compression really reduces the size
        compressed_file_size = filesize(joinpath(DATA_SAVE_PATH, latest_file))
        @test compressed_file_size < original_file_size
    end
    
    """
    Test decompress_data function:
    This test case tests the 'decompress_data' function. It decompresses the 
    latest compressed file in the data directory and compares the resulting data 
    with the original JSON data. The test is successful if the decompressed data 
    matches the original data, showing that the decompression process was successful.
    """

    @testset "Test decompress_data function" begin

        latest_file = readdir(DATA_SAVE_PATH, sort=true)[end]
        decompressed_json = decompress_data(joinpath(DATA_SAVE_PATH, latest_file))
        decompressed_data = JSON.parse(decompressed_json)
        @test decompressed_data == original_data
    end

    rm(temp_file_path)  #Clean up the temp file
end
