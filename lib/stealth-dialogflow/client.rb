# frozen_string_literal: true

module Stealth
  class Dialogflow

    LANGUAGE_CODE = ENV['DIALOGFLOW_LANGUAGE_CODE'] || 'en-US'

    def self.client
      Google::Cloud::Dialogflow.configure do |config|
        config.project_id  = ENV['DIALOGFLOW_PROJECT']
        config.credentials = File.join(Stealth.root, 'config', 'dialogflow.json')
      end
      @client ||= Google::Cloud::Dialogflow::Sessions.new(version: :v2)
    end

  end
end
