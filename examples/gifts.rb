# frozen_string_literal: true

require_relative 'helper'

gifts = @client.gifts(
  from: '2019-02-25T00:00:00Z',
  to: '2019-05-25T00:00:00Z'
)
print_gifts(gifts)
