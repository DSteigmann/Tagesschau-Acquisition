using Test

@testset "Complete Testset" begin
	cd("../");
	println(pwd());
	@testset "Test Compression and Decompression" begin
        include("test_compression.jl")
	include("test_requests.jl")
	include("test_logging.jl")
    end
end
