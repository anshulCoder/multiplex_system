class MoviesCatalogueRepository
  include Elasticsearch::Persistence::Repository
  include Elasticsearch::Persistence::Repository::DSL

  client Elasticsearch::Client.new(url: ENV['ELASTICSEARCH_URL'], log: true)

  index_name "#{Rails.env}_movies_catalogue"
  document_type "movies_catalogue"
  klass MoviesCatalogue

  settings number_of_shards: 3,
          analysis: {
            filter: {
            gramFilter: {
              type: "edge_ngram",
              min_gram: 1,
              max_gram: 20,
              token_chars: [
                "letter",
                "digit"
              ]
            }},
            analyzer: {
              final: {
                type: "custom",
                tokenizer: "keyword",
                filter: "lowercase"
              },
              egde_ngram_analyzer: {
                type: "custom",
                tokenizer: "standard",
                filter: [
                  "lowercase",
                  "gramFilter"
                ]
              }
            }
          }
  mappings do
    indexes :id, type: 'integer'
    indexes :name, type: 'text', analyzer: 'standard', fields: {raw: {type: "keyword"}}
    indexes :name_suggest, type: 'text', analyzer: 'egde_ngram_analyzer', search_analyzer: 'standard'
    indexes :rating, type: "float"
    indexes :release_date, type: 'date'

    indexes :show_timings, type: 'nested' do
      indexes :id, type: 'integer', index: true
      indexes :start_datetime, type: 'date', index: true
      indexes :end_datetime, type: 'date', index: true
      indexes :screen_id, type: 'integer'
      indexes :screen_name, type: 'text'
      indexes :multiplex_name, type: 'text', index: true
    end
    indexes :is_active, type: 'boolean'
  end

  def deserialize(document)
    document['_source']
  end

  def search_movie_by_name(term, page, per_page)
    must_conditions = [{term: {"is_active": true}}]
    must_conditions << {match_phrase_prefix: {"name_suggest": term.downcase}} if term.present?
    search({
      _source: ["id", "name", "rating", "release_date"],
      query: {
        bool: {
          must: must_conditions
        }
      },
      sort: [
        {"_score": {order: 'desc'}}
      ],
      size: per_page.to_i,
      from: (page.to_i - 1) * per_page.to_i
    })
  end

  def fetch_show_timings(movie_id)
    search({
      _source: ["name", "show_timings"],
      query: {
        bool: {
          must: [{term: {"id": movie_id}}]
        }
      }
    }).results
  end
end