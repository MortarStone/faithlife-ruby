# frozen_string_literal: true

def print_pledges(list)
  print_list('pledge', 'id', list)
end

def print_pledge(item)
  print_item('pledge', item)
end

def pledge_columns
  %i[
    id
    firstname
    lastname
    status
    family_id
    gender
    date_added
    date_modified
  ]
end
