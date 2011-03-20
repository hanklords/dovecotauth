# -*- encoding: utf-8 -*-

lib = File.expand_path('..', __FILE__)
$:.unshift lib unless $:.include?(lib)

require "dovecotauth"

Gem::Specification.new do |s|
  s.name = "dovecotauth"
  s.summary = "Ruby client to dovecot-auth"
  s.author = "Maël Clérambault"
  s.email =  "mael@clerambault.fr"
  s.homepage = "http://hanklords.github.com/dovecotauth"
  s.files = %w(dovecotauth.rb)
  s.require_paths = %w(.)
  s.version = DovecotAuth::VERSION
end
