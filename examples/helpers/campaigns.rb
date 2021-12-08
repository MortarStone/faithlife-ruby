# frozen_string_literal: true

def print_campaigns(list)
  print_list('campaign', 'id', list[:campaigns], list[:next])
end

def print_campaign(item)
  print_item('campaign', item[:campaign])
end

def campaign_columns
  %i[
    id
    name
    type
  ]
end
