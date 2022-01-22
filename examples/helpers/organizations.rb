# frozen_string_literal: true

def print_organizations(list)
  print_list('organization', 'recordId', list[:objects], list[:next])
end

def print_organization(item)
  print_item('organization', item[:objects])
end

def organization_columns
  %i[
    recordId
  ]
end
