# frozen_string_literal: true

def print_fund_groupings(list)
  print_list('fund_grouping', 'id', list[:objects], list[:next])
end

def print_fund_grouping(item)
  print_item('fund_grouping', item[:objects])
end

def fund_grouping_columns
  %i[
    id
    name
  ]
end
