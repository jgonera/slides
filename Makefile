serve:
	@echo 'Starting a server at http://localhost:3000/'
	@ruby -rwebrick -e'WEBrick::HTTPServer.new(:Port => 3000, :DocumentRoot => Dir.pwd).start'
