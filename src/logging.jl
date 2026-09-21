begin
	include("path.jl")
	import Dates
	using Dates
	
	#const global LOGGING_PATH = "folder_to_ignore/logs"

	"""
	description write_log - writes log to logfiles
	@parameter message_type - String - represents the loglevel (warn, info, error and debug)
	@info - String - the message that will be logged
	"""
	function write_log(message_type::String ,info::String)
		path = LOGGING_PATH * message_type * ".log";	
		dt = DateTime(Dates.now());
		dt = Dates.format(dt, "yyyy-mm-dd HH:MM:SS");

		open(path, "a+") do f
			write(f, dt * " " * info * "\n")
		end
		
	end

end
