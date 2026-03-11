# frozen_string_literal: true

class InvalidUsernameError < StandardError
  def initialize(msg = 'Username error')
    super(msg)
  end
end
