# frozen_string_literal: true

def print_gift_schedules(list)
  print_list('gift_schedule', 'id', list[:objects], list[:next])
end

def print_gift_schedule(item)
  print_item('gift_schedule', item[:objects])
end

def gift_schedule_columns
  %i[
    id
    amount
    start
    end
    status
  ]
end
