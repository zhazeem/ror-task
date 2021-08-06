class JsonWebToken
  def self.encode(payload, expiration = ENV['JWT_REMEMBER'], secret_key = ENV['JWT_SECRET'], encryption_method = ENV['JWT_METHOD'])
    payload = payload.dup
    payload['exp'] = expiration.to_i.months.from_now.to_i
    JWT.encode(payload, secret_key, encryption_method)
  end

  def self.decode(token, secret_key = ENV['JWT_SECRET'], encryption_method = ENV['JWT_METHOD'])
    JWT.decode(token, secret_key, encryption_method)
  end
end