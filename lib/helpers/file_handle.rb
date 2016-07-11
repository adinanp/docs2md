require "json"
require "yaml"
require "open-uri"
require "nokogiri"
require "reverse_markdown"

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
    return file_id
  end

  def html_to_md(file_name)
    file = download_file(file_name)
    file_s = Nokogiri::HTML(open("#{file}.html"))
    to_markdown = ReverseMarkdown.convert file_s.css('span').to_s
    puts to_markdown.inspect
  end

  private :get_file_id, :download_file
end
