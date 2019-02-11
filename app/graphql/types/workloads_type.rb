module Types
  class WorkloadsType < BaseObject

    field :classroom, Integer, null: false
    field :lab, Integer, null: false
    field :total, Integer, null: false

  end
end
