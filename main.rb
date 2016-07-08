require 'optparse'

require_relative 'helpers/file_handle'

include FileHandle

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: docs2md.rb [option]"

  opts.on("--if f", "Input file to convert") {|v|
    options[:input] = v
  }

  opts.on("--of f", "Output file converted") {|v|
    options[:output] = v
  }

end.parse!
raise OptionParser::MissingArgument if options[:input].nil?


if __FILE__ == $0
  file_id = FileHandle.get_file_id(options[:input])
  html_file = FileHandle.download_file(file_id, options[:output])
end
