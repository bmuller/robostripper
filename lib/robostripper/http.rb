require 'httparty'
require 'nokogiri'

module Robostripper
  module HTTP
    HEADERS = {
      'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
      'Accept-Charset' => 'ISO-8859-1,utf-8;q=0.7,*;q=0.3',
      'Accept-Language' => 'en-US,en;q=0.8',
      'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.101 Safari/537.11'
    }

    def self.get(url)
      response = HTTParty.get(url, :headers => HEADERS)
      if response.code != 200
        raise "Got response code of #{response.code} for #{url}"
      end
      Nokogiri::HTML response.body
    end
  end
end
