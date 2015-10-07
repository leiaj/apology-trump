require "dotenv"
require 'twitter'

Dotenv.load

class ApologyTrump

  attr_reader :client

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["CONSUMER_KEY"]
      config.consumer_secret = ENV["CONSUMER_SECRET"]
      config.access_token = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
    end

  end

  def trump_tweets
    client.user_timeline("realDonaldTrump")
  end

  def trump_most_recent
    trump_tweets.first.full_text
  end

  def apologize
    tweet = apology_tweet(trump_most_recent)
    tweet = tweet[0..136] + "..." if tweet.length > 140
    client.update(tweet) unless tweet == most_recent
  end

  def apology_tweet(tweet_text)
    "The following remark was out of line and I apologize RT @realDonaldTrump: #{tweet_text}"
  end

  def user_timeline
    client.user_timeline
  end

  def most_recent
    client.user_timeline.first.full_text
  end

end

ApologyTrump.new.apologize

