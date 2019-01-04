### Numbers

Use either the 'number' or 'digit' keywords.

Use the 'to', 'through' or '-' indicator for ranges.
You can also use the 'and' indicator for ranges if the numbers are preceeded with 'between' or 'from'.

```ruby
Regeng.new 'number 2 to 4'
Regeng.new 'number 2 through 4'
Regeng.new 'number 2-4'
Regeng.new 'number between 2 and 4'
Regeng.new 'number from 2 and 4'
=> /[2-4]/
```

Using the 'and' keyword will result in exact matches.

```ruby
Regeng.new 'number 2 1 5 and 4'
=> /[2154]/
```

Pluralizing 'number' will result in multiples.

```ruby
Regeng.new 'numbers 2 through 4'
=> /[2-4]+/
```

Indicate 'any number(s)'

```ruby
Regeng.new 'any numbers'
=> /[0-9]+/
```

Regeng supports multiples of 10s. Currently both numbers must have the same amount of zeros.

```ruby
Regeng.new 'number between 400 and 600'
=> /(4[0-9][0-9])|(5[0-9][0-9])|(600)/
```