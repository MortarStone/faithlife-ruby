# frozen_string_literal: true

require 'pry'
require 'active_support/inflector'
require_relative '../lib/faithlife'
require_relative 'helpers/campaigns'
require_relative 'helpers/families'
require_relative 'helpers/fund_groupings'
require_relative 'helpers/funds'
require_relative 'helpers/gift_schedules'
require_relative 'helpers/gifts'
require_relative 'helpers/givers'
require_relative 'helpers/people'
require_relative 'helpers/pledges'

require 'dotenv'
Dotenv.load('../.env')

@client = Faithlife::Client.new(
  group_id: ENV['GROUP_ID'],
  consumer_key: ENV['CONSUMER_KEY'],
  consumer_secret: ENV['CONSUMER_SECRET'],
  oauth_token: ENV['OAUTH_TOKEN'],
  oauth_secret: ENV['OAUTH_SECRET'],
  environment: ENV['ENVIRONMENT']
)

def print_no_access_message
  puts 'Unless something has recently changed, we do not have access to this table or the table does not exist.'
end

def print_list(object_name, pk_id_name, list, next_code)
  if list.nil? || list.empty?
    puts 'Nothing found'
  else
    headers = column_headers(object_name)
    puts "There were #{list.count} #{object_name.pluralize} found"
    puts
    puts print_column_headers(headers)
    list.each_with_index do |item, index|
      print_row(index, item, headers)
    end
    puts
    print_duplicates(pk_id_name, list)
    puts
    puts "Next: #{next_code}"
    puts
  end
end

def column_headers(object_name)
  send("#{object_name}_columns")
end

def print_column_headers(headers)
  headers = [:index] + headers
  puts headers.join(' :: ')
end

def print_row(index, item, column_headers)
  cells = [index]
  column_headers.each do |header|
    value = item[header]
    # value = value.to_digits if value.class == BigDecimal
    cells << value
  end
  puts cells.join(' :: ')
end

def print_item(object_name, item)
  puts
  if item.nil?
    puts 'Item not found'
  else
    column_headers(object_name).each do |header|
      value = item[header]
      # value = value.to_digits if value.class == BigDecimal
      puts "#{header}: #{value}"
    end
  end
end

def print_duplicates(pk_id_name, list)
  counts = {}
  list.each do |item|
    id = item[pk_id_name]
    counts[id] ||= 0
    counts[id] += 1
  end

  duplicates = counts.select { |_key, value| value > 1 }.keys - [nil]
  puts "There are #{duplicates.count} duplicates: #{duplicates.inspect}"
end
