# frozen_string_literal: true

require 'csv'
require_relative '../lib/cli'
require_relative '../lib/bouncer'
require_relative '../lib/librarian'

users_file_path = File.join(File.dirname(__FILE__), '..', 'data', 'users.db')
books_file_path = File.join(File.dirname(__FILE__), '..', 'data', 'books.csv')
borrowed_file_path = File.join(File.dirname(__FILE__), '..', 'data', 'borrowed_books.db')

librarian = Librarian.new(books_file_path, borrowed_file_path)
bouncer = Bouncer.new(users_file_path)
cli = CLI.new(librarian, bouncer)

cli.start
