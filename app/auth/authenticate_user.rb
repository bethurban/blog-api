class AuthenticateUser

  def initialize(name, email, password)
    @name = name
    @email = email
    @password = password
  end

  #Service entry point
  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_reader :email, :password

  #Verify user credentials
  def user
    user = User.find_by(email: email)
    return user if user && user.authenticate(password)
    #Raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end

end
