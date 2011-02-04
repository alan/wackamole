#------------
# Wackamole Sessions Options
# 
# @@options defines where Wackamole puts its sessions, which can be either mongo or memcache
# if @@options is not defined mongo at localhost:27017 is used
#
# For customized sessions with Mongo uncomment and modify this line:
# @@options={:protocol=>"mongo", :host=>"localhost", :port=>"11211", :db_name=>"wackamole_session", :cltn_name=>"sessions"}
#
# For Memcache session uncomment and modify this line:
# @@options={:protocol=>"memcached", :host=>"localhost", :port=>"11211", :namespace=>"wackamole_session"}
#
#------------

require 'rubygems'
require "bundler/setup"                                                                            
require 'sinatra'                                                                              

config_path = File.expand_path(File.join(File.dirname(__FILE__), 'zones.yml.erb'))
host = ENV['MONGO_HOST']
port = ENV['MONGO_PORT']
@@options={:protocol=>"mongo", :host => host, :port => port, 
           :db_name=>"mole_rubyfuza_production_mdb", :cltn_name=>"rack_sessions", :config_path => config_path,
           :user => ENV['MONGO_USER'], :password => ENV['MONGO_PASS']}

require File.expand_path( File.join(File.dirname(__FILE__), %w[lib app.rb]) )


run Sinatra::Application