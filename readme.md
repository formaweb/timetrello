# TimeTrello

Time Trello is a simple gem that can interpret special trello comments. Those
comments are then converted to a record type that makes it easy to integrate a
time tracking application with Trello.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'timetrello'
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

You use the module directly.

### Trello

All time tracking annotations must follow the specification below in order to be
understood and consolidated by Time Trello.

**PREFIX** **TIME** [**START_DATE**] "**COMMENT**"

See some valid examples:

- :clock12: 0:35
- :clock12: 102:22 "A comment example."
- :clock12: 00:05 [2016-04-01]
- :clock12: 007:59 [2012-03-17 21:50Z] "Other comment example."

The default prefix which identifies the proper comment is :clock12:
(`:clock12:`) emoticon. If no start date is provided through the comment, the
comment timestamp is used.

### Ruby

```ruby
require 'time_trello'

TimeTrello.initialize('your trello public key here', 'your trello token here', ':clock12:')
tasks = TimeTrello.find_all(Time.new(2012, 1, 1), Time.new(2016, 4, 1), 'Board ID you want to evaluate')

tasks.each do |task|
  # ...
end
```

## Methods

### `initialize`

Initializes the Time Trello subsystem, providing information necessary for its
proper workings.

#### Parameters
```ruby
TimeTrello.initialize(public_key, token, prefix=':clock12:')
```
| Parameter | Type | Description |
|---|:---:|---|
| **public_key** | `String` | Your Trello developer key |
| **token** | `String` | The connection token provided by Trello due to its authorization process |
| **prefix** | `String` | Prefix to use for comment detection. Defaults to `:clock12:` |

### `find_all`

Queries Trello, parsing comments which have the required format for consolidation.

#### Parameters

```ruby
TimeTrello.find_all (start_date, end_date, board_id, &filter)
```

| Parameter | Type | Description |
|---|:---:|---|
| **start_date** | `Time` | Start date to use for limiting the result set |
| **end_date** | `Time` | End date to use for limiting the result set |
| **board_id** | `String` | Trello's board identification to query for |
| **filter** | `Proc` | Block to use for extra data filtering |

The `filter` block receives as parameter an instance of
TimeTrello::ActivityRecord. It must return a boolean:

- `true`: the entry will be on the final result set
- `false`: the entry will de discarded from final result set

See the `example.rb` file for a usage example.
