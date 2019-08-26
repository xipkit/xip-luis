# frozen_string_literal: true

module Stealth
  module Dialogflow
    class Result < Stealth::NlpResult

      def intent_id
        @result
          &.query_result
          &.intent
          &.name
          &.split('/')
          &.last
      end

      def intent
        @result
          &.query_result
          &.intent
          &.display_name
      end

      def intent_score
        @result
          &.query_result
          &.intent_detection_confidence
      end

      # Sentiment score between -1.0 (negative sentiment) and 1.0 (positive sentiment)
      def sentiment_score
        @result
          &.query_result
          &.sentiment_analysis_result
          &.query_text_sentiment
          &.score
      end

      # :postive, :negative, :neutral
      def sentiment
        if sentiment_score >= -0.05 && sentiment_score <= 0.05
          :neutral
        elsif sentiment_score < -0.05
          :negative
        elsif sentiment_score > 0.05
          :positive
        end
      end

    end
  end
end
