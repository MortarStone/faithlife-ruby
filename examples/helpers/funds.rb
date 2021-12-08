# frozen_string_literal: true

def print_funds(list)
  print_list('fund', 'id', list[:objects], list[:next])
end

def print_fund(item)
  print_item('fund', item[:objects])
end

def fund_columns
  %i[
    id
    name
    isVisible
    status
    description
  ]
end
