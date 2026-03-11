# frozen_string_literal: true

require 'io/console'
require_relative 'invalid_username_error'

class CLI
  def initialize(librarian, bouncer)
    @librarian = librarian
    @bouncer = bouncer
  end

  def start
    print_welcome
    return print_goodbye unless authorize

    print_menu
    print_goodbye
  end

  private

  def print_menu
    puts 'What would you like to do?'
    puts
    puts '1. List available books'
    puts '2. Borrow a book'
    puts '3. Return a book'
    puts '4. Exit'
    puts
    print 'Your choice: '
    gets.chomp
  end

  def print_welcome
    puts 'Hey! Welcome to the Library!'
    puts
  end

  def print_goodbye
    puts
    puts 'Bye! Hope to see you again :3'
  end

  def authorize
    username = prompt('Please enter your username: ')
    return true if @bouncer.login_user(username)

    signup
  end

  def signup
    print 'Seems like you are not registered yet... Would you like to sign up? '
    loop do
      return false unless confirm_dialog

      username = prompt('What should we call you? ')
      return true if @bouncer.create_user(username)
    rescue InvalidUsernameError => e
      puts
      puts e.message
      print 'Would you like to try another one? '
    end
  end

  def prompt(message)
    print message
    gets.chomp
  end

  def confirm_dialog
    print '[Y/n] '
    option = char.downcase
    puts
    case option
    when 'n'
      false
    else
      true
    end
  end

  def char
    input = $stdin.getch
    control_c_code = "\u0003"
    exit(1) if input == control_c_code
    input
  end
end
