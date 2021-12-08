# frozen_string_literal: true

def print_givers(list)
  print_list('giver', 'id', list[:givers], list[:next])
end

def print_giver(item)
  print_item('giver', item[:giver])
end

def giver_columns
  %i[
    id
    name
    groupId
    kind
  ]
end
