# frozen_string_literal: true

require_relative 'helper'

gifts = @client.gifts(
  from: Date.new(2020, 12, 1),
  to: Date.new(2020, 12, 31)
)
print_gifts(gifts)
