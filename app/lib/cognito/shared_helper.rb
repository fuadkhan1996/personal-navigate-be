# frozen_string_literal: true

module Cognito
  module SharedHelper
    private

    def hash_sha256(buf)
      a = Digest::SHA256.hexdigest(buf)
      raise unless a.size == 64

      a
    end

    def hex_hash(hex_string)
      hash_sha256(hex_to_bytes(hex_string))
    end

    def hex_to_bytes(hex_string)
      [hex_string].pack('H*')
    end

    def bytes_to_hex(bytes)
      bytes.unpack1('H*')
    end

    def hex_to_long(hex_string)
      hex_string.to_i(16)
    end

    def long_to_hex(long_num)
      long_num.to_s(16)
    end

    def get_random(nbytes)
      random_hex = bytes_to_hex(SecureRandom.bytes(nbytes))
      hex_to_long(random_hex)
    end

    def pad_hex(long_int)
      hash_str = long_int.is_a?(String) ? long_int : long_to_hex(long_int)

      if hash_str.size.odd?
        hash_str = "0#{hash_str}"
      elsif '89ABCDEFabcdef'.include?(hash_str[0])
        hash_str = "00#{hash_str}"
      end

      hash_str
    end

    def generate_random_small_a
      random_long_int = get_random(128)
      random_long_int % @big_n
    end
  end
end
