# Bremen

Bremen provides common search interface for some music websites. it supports YouTube, SoundCloud, MixCloud and Nicovideo

## Installation

Add this line to your application's Gemfile:

    gem 'bremen'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bremen

## Usage

Just call `.find` metod with keyword.

### YouTube/MixCloud/Nicovideo

    Bremen::Youtube.find(keyword: 'Perfume')

### SoundCloud

Before searching, you need to set consumer key.

    Bremen::Soundcloud.consumer_key = 'your_consumer_key'
    Bremen::Soundcloud.find(keyword: 'KyaryPamyuPamyu')

### Optional Params

You can add optional parameters for filtering. But not supports all official API's filters.

    Bremen::Youtube.find(keyword: 'capsule', order: 'relevance', limit: 10)

## API References

- [Reference Guide: Data API Protocol - YouTube — Google Developers](https://developers.google.com/youtube/2.0/reference#Searching_for_videos)
- [Docs - API - Reference - SoundCloud Developers](http://developers.soundcloud.com/docs/api/reference#tracks)
- [API documentation | Mixcloud](http://www.mixcloud.com/developers/documentation/#search)

## Supported versions

- Ruby 1.9.2 or higher

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
