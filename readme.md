# TimeTrello

## Installation
Add this line to your application's Gemfile:

```ruby
  gem 'correios-sro'
```

And then execute:

```console
bundle
```

Or install it yourself as:

```console
gem install timetrello
```


## Usage

You can use `TimeTrello` class itself.

### Trello



### Ruby

```ruby
require 'timetrello'

timetrello = TimeTrello.new 'public_key', 'member_token', ':clock12: '
tasks = timetrello.getTasks 'board_id', filters: {startDate: '', endDate: ''}

tasks.each do |task|
  # ...
end
```

## Methods

### `getTasks`

#### Options

| Option | Type | Description | Example |
|---|:---:|---|---|
| **startDate** | `String` or`Date` | Start date of search. Default is 30 days ago. | `'2016-04-01'` |
| **endDate** | `String` or`Date` | End date of search. Default is now. | `'1st Apr 2016 04:05:06+03:30'` |
| **members** | `String`  or `Array` | Show tasks only those members (usernames). All by default. | `['tom', 'dick', 'harry']` |
| **labels** | `String`or `Array` | Show tasks only those labels. All by default. | `['Label 1', 'Label 2']` |

#### Response

`Array` with filtered "card tasks".

```
[{
  card_id: 123456,
  card_name: 'Name of cards.',
  total_minutes: 200,
  time_board: [
    {id: 123456, member: 'tom', minutes: 50, end_time: 12345678, comment: ''},
    {id: 123456, member: 'tom', minutes: 50, end_time: 12345678, comment: ''},
    {id: 123456, member: 'tom', minutes: 50, end_time: 12345678, comment: ''}
  ]
}]
```
