module Ida
  class TokenFactory

    def self.create(type, value)
      class_lookup[type].new(value)
    end

    private

    def self.class_lookup
      {
        :number => Ida::Tokens::Number
      }
    end

  end
end
