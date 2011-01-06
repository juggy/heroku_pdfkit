require 'rubygems'
require 'bundler'
require 'bundler/setup'
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'pdfkitapp'

run HerokuPdfKit::GenApp.new