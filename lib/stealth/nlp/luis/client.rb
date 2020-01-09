# frozen_string_literal: true

module Stealth
  module Nlp
    module Luis
      class Client < Stealth::Nlp::Client

        ENDPOINT = ENV['LUIS_ENDPOINT'] || 'westus.api.cognitive.microsoft.com'

        def initialize(subscription_key: nil, app_id: nil, tz_offset: 0)
          begin
            @subscription_key = subscription_key || Stealth.config.luis.subscription_key
            @app_id = app_id || Stealth.config.luis.app_id
            @tz_offset = tz_offset || Stealth.config.luis.tz_offset
            @slot = Stealth.env.development? ? 'staging' : 'production'
          rescue NoMethodError
            raise(
              Stealth::Errors::ConfigurationError,
              'A `luis` configuration key must be specified directly or in `services.yml`'
            )
          end
        end

        def endpoint
          "https://#{ENDPOINT}/luis/prediction/v3.0/apps/#{@app_id}/slots/#{@slot}/predict"
        end

        def client
          @client ||= begin
            headers = {
              'Content-Type' => 'application/json'
            }
            HTTP.timeout(connect: 15, read: 60).headers(headers)
          end
        end

        def understand(query:)
          params = {
            'datetimeReference'   => @tz_offset,
            'subscription-key'    => @subscription_key,
            'query'               => query
          }

          Stealth::Logger.l(
            topic: :nlp,
            message: 'Performing NLP lookup via Microsoft LUIS'
          )
          result = client.get(endpoint, params: params)
          Result.new(result: result)
        end

      end
    end
  end
end

ENTITY_TYPES = %i(number currency email percentage phone age
                        url ordinal geo dimension temp datetime duration)
