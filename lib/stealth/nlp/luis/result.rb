# frozen_string_literal: true

module Stealth
  module Nlp
    module Luis
      class Result < Stealth::Nlp::Result

        ENTITY_MAP = {
          'money' => :currency, 'number' => :number, 'email' => :email,
          'percentage' => :percentage, 'Calendar.Duration' => :duration,
          'geographyV2' => :geo, 'age' => :age, 'phonenumber' => :phone,
          'ordinalV2' => :ordinal, 'url' => :url, 'dimension' => :dimension,
          'temperature' => :temp, 'keyPhrase' => :key_phrase, 'name' => :name,
          'datetimeV2' => :datetime
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
          parsed_result&.dig('prediction', 'intents', top_intent, 'score')
        end

        def raw_entities
          parsed_result&.dig('prediction', 'entities')
        end

        def entities
          return {} if raw_entities.blank?
          _entities = {}

          raw_entities.each do |type, values|
            if ENTITY_MAP[type]
              _entities[ENTITY_MAP[type]] = values
            else
              # A custom entity
              _entities[type.to_sym] = values
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
          @top_intent ||= begin
            matched_intent = parsed_result&.dig('prediction', 'topIntent')
            _intent_score = parsed_result&.dig('prediction', 'intents', matched_intent, 'score')

            if Stealth.config.luis.intent_threshold.is_a?(Numeric)
              if _intent_score > Stealth.config.luis.intent_threshold
                matched_intent
              else
                Stealth::Logger.l(
                  topic: :nlp,
                  message: "Ignoring intent match. Does not meet threshold (#{Stealth.config.luis.intent_threshold})"
                )
                'None' # can't be nil or this doesn't get memoized
              end
            else
              matched_intent
            end
          end
        end

      end
    end
  end
end
