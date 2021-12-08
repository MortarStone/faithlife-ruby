# frozen_string_literal: true

require 'oauth'
require 'oauth/request_proxy/typhoeus_request'
require 'rubygems'
require 'active_support/inflector'
require 'typhoeus'
require 'json'
require 'plissken'
require 'awrence'

require_relative 'endpoints/campaigns'
require_relative 'endpoints/fund_groupings'
require_relative 'endpoints/funds'
require_relative 'endpoints/gift_schedules'
require_relative 'endpoints/gifts'
require_relative 'endpoints/givers'
require_relative 'endpoints/pledges'
require_relative 'response_handler'
