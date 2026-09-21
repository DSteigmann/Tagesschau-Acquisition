using Test
include("../src/request.jl")  #Here are the request function
include("../src/path.jl")

```
	Unittests for the request function
```
@testset "Test Request" begin
	response = tagesschau_api_Authorise("https://www.tagesschau.de/api2/homepage/")
    @testset "Test Request HTTP-Response " begin
	    @test typeof(response) == HTTP.Messages.Response
    end


    @testset "Test Request connection refused " begin
	    @test_throws HTTP.ConnectError tagesschau_api_Authorise("http://127.0.0.200")
    end



end
