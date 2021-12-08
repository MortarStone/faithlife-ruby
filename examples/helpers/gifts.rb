# frozen_string_literal: true

def print_gifts(list)
  print_list('gift', 'id', list[:gifts], list[:next])
end

def print_gift(item)
  print_item('gift', item[:gift])
end

def gift_columns
  %i[
    id
    created
    amount
    paymentKind
  ]
end
