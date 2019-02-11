module Types
  class TimeslotsType < BaseObject
    field :day, Integer, null:false
    field :starting_hour, Integer, null: false
    field :ending_hour, Integer, null: false
  end
end
