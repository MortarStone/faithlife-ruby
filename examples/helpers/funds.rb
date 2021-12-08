# frozen_string_literal: true

def print_funds(list)
  print_list('fund', 'id', list[:funds], list[:next])
end

def print_fund(item)
  print_item('fund', item[:fund])
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
