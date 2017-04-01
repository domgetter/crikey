# crikey

Crikey is a templating engine inspired by [Hiccup](https://github.com/weavejester/hiccup).  It is focused on mapping snippets of view code and logic to data structures available in the language.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  crikey:
    github: domgetter/crikey
```

## Usage

```crystal
require "crikey"

[:div, [:span, "Hello"]].to_html
#=> "<div><span>Hello</span></div>"
```

## Contributing

1. Fork it ( https://github.com/domgetter/crikey/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [domgetter](https://github.com/domgetter) Dominic Muller - creator, maintainer
