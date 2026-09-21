using Test
include("../src/logging.jl")  #Here are the logging function

```
	Unittests for the logging function

```

@testset "Test Logging" begin
    write_log("test", "this is a test.")
    @testset "Test Logging " begin
	@test isfile("folder_to_ignore/logs/test.log")
    end
    rm("folder_to_ignore/logs/test.log")
end
