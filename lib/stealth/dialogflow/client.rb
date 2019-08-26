# frozen_string_literal: true

module Stealth
  module Dialogflow
    class Client

      LANGUAGE_CODE = ENV['DIALOGFLOW_LANGUAGE_CODE'] || 'en-US'

      def initialize(project_id:, session_id: nil)
        @project_id = Stealth.env.dialogflow.project_id
        @session_id = obfuscate_session_id(session_id)
      end

      def self.client
        @client ||= Google::Cloud::Dialogflow::Sessions.new(
          version: :v2,
          credentials: File.join(Stealth.root, 'config', 'dialogflow.json')
        )
      end

      def session
        Dialogflow.client.class.session_path(@project_id, @session_id)
      end

      def detect_intent(query:)
        query_input = { text: { text: query, language_code: LANGUAGE_CODE } }

        result = Dialogflow.client.detect_intent(session, query_input)
        Result.new(result: result)
      end

      def detect_speech_intent(audio_file:, audio_config: nil)
        unless audio_config.present?
          audio_config = {
            audio_encoding:    :AUDIO_ENCODING_LINEAR_16,
            sample_rate_hertz: 16_000,
            language_code:     LANGUAGE_CODE
          }
        end
        query_input = { audio_config: audio_config }

        result = Dialogflow.client.detect_intent(
          session,
          query_input,
          input_audio: audio_file
        )
        Result.new(result: result)
      end

      private

      def obfuscate_session_id(session_id)
        if session_id.nil?
          SecureRandom.hex(10)
        else

        end
      end

    end
  end
end
