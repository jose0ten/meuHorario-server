module Types
  class QueryType < Types::BaseObject

    field :test_field, String, null: false, description: "An example field added by the generator"

    def test_field

      'Oi rs'

    end

    #return JSON.parse(text)['time'][0]['turmas'][0]
  end
end

