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

### Standalone

```crystal
require "crikey"

Crikey.to_html([:div, [:span, "Hello"]])
#=> "<div><span>Hello</span></div>"
```

### with Kilt

Example with Kemal:

```crystal
require "kilt/crikey"

get "/users" do
  users = [{name: "Samantha", id: 7}, {name: "Mikey", id: 24}] # this would be the result of a db call
  render "src/views/users.crikey"
end
```
(in users.crikey)
```crystal
[:div, {id: "users"},
  users.map do |user|
    [:div, {class: "user"},
      [:span, user[:id]],
      [:span, {style: "color: red"},
        user[:name]]]
  end
]
```
And you will get
```html
<div id="users">
  <div class="user">
    <span>7</span>
    <span style="color: red">Samantha</span>
  </div>
  <div class="user">
    <span>24</span>
    <span style="color: red">Mikey</span>
  </div>
</div>
```
It's just data!

## Contributing

1. Fork it ( https://github.com/domgetter/crikey/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [domgetter](https://github.com/domgetter) Dominic Muller - creator, maintainer
