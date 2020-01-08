# frozen_string_literal: true

module Stealth
  module Nlp
    module Luis
      class Result < Stealth::Nlp::Result

        @@entity_map = {
          'money' => :currency, 'number' => :number, 'email' => :email,
          'percentage' => :percentage, 'Calendar.Duration' => :duration,
          'geographyV2' => :geo, 'age' => :age, 'phonenumber' => :phone,
          'ordinalV2' => :ordinal, 'url' => :url, 'dimension' => :dimension,
          'temperature' => :temp, 'keyPhrase' => :key_phrase, 'name' => :name
        }

        def initialize(result:)
          @result = result
          if result.status.success?
            Stealth::Logger.l(
              topic: :nlp,
              message: 'NLP lookup successful'
            )
            parsed_result
          else
            Stealth::Logger.l(
              topic: :nlp,
              message: "NLP lookup FAILED: (#{result.status.code}) #{result.body.to_s}"
            )
          end
        end

        # Sample JSON result:
        # {
        #   "query": "I make between $5400 and $9600 per month",
        #   "prediction": {
        #     "topIntent": "None",
        #     "intents": {
        #       "None": {
        #         "score": 0.5345857
        #       }
        #     },
        #     "entities": {
        #       "money": [
        #         {
        #           "number": 5400,
        #           "units": "Dollar"
        #         },
        #         {
        #           "number": 9600,
        #           "units": "Dollar"
        #         }
        #       ],
        #       "number": [
        #         5400,
        #         9600
        #       ]
        #     },
        #     "sentiment": {
        #       "label": "positive",
        #       "score": 0.7805586
        #     }
        #   }
        # }
        def parsed_result
          @parsed_result ||= MultiJson.load(result.body.to_s)
        end

        def intent
          top_intent&.to_sym
        end

        def intent_score
          parsed_result&.dig('prediction', 'intents', top_intent)
        end

        def raw_entities
          parsed_result&.dig('prediction', 'entities')
        end

        def entities
          return {} if raw_entities.blank?
          _entities = {}

          ENTITY_TYPES = %i(number currency email percentage phone age
                        url ordinal geo dimension temp datetime duration)

          raw_entities.each do |type, values|
            case type
            when 'money'
              _entities[:currency] = values
            when 'number'
              _entities[:number] = values
            when 'email'
              _entities[:email] = values
            when 'percentage'
              _entities[:percentage] = values
            when 'Calendar.Duration'
              _entities[:duration] = values
            when 'geographyV2'
              _entities[:geo] = values
            when 'age'
              _entities[:age] = values
            when 'phonenumber'
              _entities[:phone] = values
            when 'ordinalV2'
              _entities[:ordinal] = values
            when 'url'
              _entities[:url] = values
            when 'dimension'
              _entities[:dimension] = values
            when 'temperature'
              _entities[:temp] = values
            when 'keyPhrase'
              _entities[:key_phrase] = values
            when 'personName'
              _entities[:name] = values
            end
          end

          _entities
        end

        def sentiment_score
          parsed_result&.dig('prediction', 'sentiment', 'score')
        end

        def sentiment
          parsed_result&.dig('prediction', 'sentiment', 'label')&.to_sym
        end

        private

        def top_intent
          parsed_result&.dig('prediction', 'topIntent')
        end

      end
    end
  end
end
