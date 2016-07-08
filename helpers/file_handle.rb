require "json"
require "open-uri"
require "yaml"

module FileHandle
  CONFIG = YAML.load_file('config/config.yml')

  def get_file_id(filename)
    file = File.read(filename)
    data_hash = JSON.parse(file)
    file_id = data_hash['doc_id']
  end

  def download_file(fileid, filename)
    base_url = CONFIG['docs_url']
    endpoint = base_url % {:file_id => fileid}
    puts endpoint

    open(filename, 'wb') do |file|
      file << open(endpoint).read
    end
  end

end
