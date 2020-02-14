require 'dry-struct'

module Types
  include Dry::Types()
end

class MoviesCatalogue < Dry::Struct

  attribute :id, Types::Strict::Integer
  attribute :name, Types::String
  attribute :name_suggest, Types::String
  attribute :rating, Types::Float
  attribute :release_date, Types::Date
  attribute :show_timings, Types::Array
  attribute :is_active, Types::Bool

end
