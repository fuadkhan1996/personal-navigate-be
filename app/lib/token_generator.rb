# frozen_string_literal: true

class TokenGenerator
  def initialize
    @key_generator = ActiveSupport::CachingKeyGenerator.new(
      ActiveSupport::KeyGenerator.new(Rails.application.credentials[:secret_key_base])
    )

    @digest = 'SHA256'
  end

  def digest(column, value)
    return if value.blank?

    OpenSSL::HMAC.hexdigest(@digest, key_for(column), value.to_s)
  end

  def generate(column)
    key = key_for(column)
    raw = friendly_token
    enc = OpenSSL::HMAC.hexdigest(@digest, key, raw)
    [raw, enc]
  end

  def friendly_token(length = 20)
    rlength = (length * 3) / 4
    SecureRandom.urlsafe_base64(rlength).tr('lIO0', 'sxyz')
  end

  private

  def key_for(column)
    @key_generator.generate_key("Invitation Flow: #{column}")
  end
end
