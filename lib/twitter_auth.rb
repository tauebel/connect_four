require 'twitter'
require 'tweetstream'

YOUR_CONSUMER_KEY = "OEHzHZUkg4GxRukhjlBcA"
YOUR_CONSUMER_SECRET = "FEeb1XDuK5bXUioNJeDwYH2yJy4maUc8BkQshVfFI"
YOUR_OAUTH_TOKEN = "921984714-3s6dWValM3bpOXzXBkKgc2eHD94C9y97HokLfXM6"
YOUR_OAUTH_TOKEN_SECRET = "YNBAyCChPAqK1EHCx9IICOBHP0ESnAz3rLRuFHQzw"

class TwitterAuth

  def initialize
    config_twitter
    config_tweet_stream
  end

  def config_twitter
    Twitter.configure do |config|
      config.consumer_key = YOUR_CONSUMER_KEY
      config.consumer_secret = YOUR_CONSUMER_SECRET
      config.oauth_token = YOUR_OAUTH_TOKEN
      config.oauth_token_secret = YOUR_OAUTH_TOKEN_SECRET
    end
  end

  def config_tweet_stream
    TweetStream.configure do |config|
      config.consumer_key = YOUR_CONSUMER_KEY
      config.consumer_secret = YOUR_CONSUMER_SECRET
      config.oauth_token = YOUR_OAUTH_TOKEN
      config.oauth_token_secret = YOUR_OAUTH_TOKEN_SECRET
      config.auth_method = :oauth
    end
  end

end