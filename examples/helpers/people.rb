# frozen_string_literal: true

def print_people(list)
  print_list('person', 'recordId', list[:objects], list[:next])
end

def print_person(item)
  print_item('person', item[:objects])
end

def person_columns
  %i[
    recordId
  ]
end
