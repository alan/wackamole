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
require 'sinatra'                                                                              
require File.join(File.dirname(__FILE__), %w[lib app.rb])                                      
run Sinatra::Application