# frozen_string_literal: true

require 'csv'
require_relative '../lib/cli'
require_relative '../lib/bouncer'

users_file_path = File.join(File.dirname(__FILE__), '..', 'data', 'users.db')
bouncer = Bouncer.new(users_file_path)
cli = CLI.new(nil, bouncer)

cli.start
