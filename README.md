# Bremen

**Bremen** provides common search interface for some music websites. it supports YouTube, SoundCloud, MixCloud and Nicovideo

## Installation

Add this line to your application's Gemfile:

    gem 'bremen'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bremen

## Setting

As far as Soundcloud concerned, you need to set consumer key before using.

    Bremen::Soundcloud.consumer_key = 'your_consumer_key'

## Usage

### Retrieving a single track

call `.find` method with uid(unique key) or url.

    Bremen::Youtube.find('XXXXXXXXXXX')
    Bremen::Youtube.find('http://www.youtube.com/watch?v=XXXXXXXXXXX')
    Bremen::Soundcloud.find('1111111')
    Bremen::Soundcloud.find('http://soundcloud.com/author/title')
    Bremen::Mixcloud.find('/author/title/')
    Bremen::Mixcloud.find('http://www.mixcloud.com/author/title/')
    Bremen::Nicovideo.find('sm1111111')
    Bremen::Nicovideo.find('http://www.nicovideo.jp/watch/sm1111111')

### Retrieving multiple tracks

call `.search` method with keyword.

    Bremen::Youtube.find(keyword: 'Perfume')

#### Optional params

You can add optional parameters for filtering. But not supports all official API's filters.

    Bremen::Youtube.find(keyword: 'KyaryPamyuPamyu', order: 'relevance', limit: 10)

### Track object

Retrieving methods return Track object(s).

attribute  |                      |
-----------|----------------------|
uid        | unique key in a site |
url        |                      |
title      |                      |
author     |                      |
length     | duration of track    |
created_at | released datetime    |
updated_at | modified datetime    |

## API References

- [Reference Guide: Data API Protocol - YouTube — Google Developers](https://developers.google.com/youtube/2.0/reference#Searching_for_videos)
- [Docs - API - Reference - SoundCloud Developers](http://developers.soundcloud.com/docs/api/reference#tracks)
- [API documentation | Mixcloud](http://www.mixcloud.com/developers/documentation/#search)

## Supported versions

- Ruby 1.9.3 or higher

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
