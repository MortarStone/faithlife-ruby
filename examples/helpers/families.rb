# frozen_string_literal: true

def print_families(list)
  print_list('family', 'recordId', list[:objects], list[:next])
end

def print_family(item)
  print_item('family', item[:objects])
end

def family_columns
  %i[
    recordId
  ]
end
