require "json"
require "yaml"
require "open-uri"

module FileHandle
  CONFIG = YAML.load_file('config/config.yml')

  def get_file_id(file_name)
    file = File.read(file_name)
    data_hash = JSON.parse(file)
    file_id = data_hash['doc_id']
  end

  def download_file(file_name)
    file_id = get_file_id(file_name)
    base_url = CONFIG['docs_url']
    endpoint = base_url % {:file_id => file_id}

    open("#{file_id}.html", 'wb') do |file|
      file << open(endpoint).read
    end
  end

  def html_to_md(filename)
  end

  private :get_file_id
end
