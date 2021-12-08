# frozen_string_literal: true

def print_pledges(list)
  print_list('pledge', 'id', list[:pledges], list[:next])
end

def print_pledge(item)
  print_item('pledge', item[:pledge])
end

def pledge_columns
  %i[
    id
    groupId
    giverId
    campaignId
    amountGiven
    amountPledged
    deleted
    created
  ]
end
