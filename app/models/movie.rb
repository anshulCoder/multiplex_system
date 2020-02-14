class Movie < ApplicationRecord
	has_many :show_timings

	validates_presence_of :name, uniqueness: true
	validates_presence_of :release_date

	include Elasticsearch::Model
	include Elasticsearch::Model::Callbacks

	index_name    "movies_#{Rails.env}"
	document_type "movie"

	after_commit do |movie|
		movie.reload.__elasticsearch__.index_document
	end

	settings analysis: {
              filter: {
                autocomplete_filter: {
                  type: "edge_ngram",
                  min_gram: 2,
                  max_gram: 20
              }},
              analyzer: {
                autocomplete: {
                  type: "custom",
                  tokenizer: "standard",
                  filter: ["lowercase", "autocomplete_filter"]
            },
            whitespace_analyzer: {
               type: "custom",
               tokenizer: "whitespace",
               filter: [
                  "lowercase",
                  "asciifolding"
               ]
            }
          }
    } do
	settings index: { number_of_shards: 3 } do
	  mapping do
	    indexes :id, index: true
	    indexes :name, type: 'text', analyzer: "standard", fields: {raw: {type: "keyword"}}
	    indexes :name_suggest, type: 'completion', analyzer: "autocomplete", search_analyzer: "whitespace_analyzer"
	    indexes :rating, type: "float"
	    indexes :release_date, type: 'date'
	  end
	end
  end


	def as_indexed_json(options = {})
	    result = as_json(only: [:id, :name, :rating, :release_date]
	    	).merge({"name_suggest" =>
		      {
		        "input" => name.split(" ")
		      }
		    })
	end
end
