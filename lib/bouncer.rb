# frozen_string_literal: true

require_relative 'invalid_username_error'

class Bouncer
  def initialize(users_file_path)
    @users_file_path = users_file_path
    @usernames = load_usernames
    @logged_in_user = nil
  end

  def login_user(username)
    return false unless @usernames.include?(username)

    @logged_in_user = username
  end

  def create_user(username)
    validate_username(username)
    @usernames << username
    save_username(username)
    login_user(username)
  end

  private

  def load_usernames
    return [] unless File.exist?(@users_file_path)

    File.readlines(@users_file_path).map(&:chomp)
  end

  def save_username(username)
    File.write(@users_file_path, "#{username}\n", mode: 'a')
  end

  def validate_username(username)
    raise InvalidUsernameError, 'This username is already taken' if @usernames.include?(username)
    raise InvalidUsernameError, 'Your username should be longer than 3 characters' unless username.length > 3
  end
end
