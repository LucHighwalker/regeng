### Characters

Use the 'to', 'through' or '-' indicator for ranges.
You can also use the 'and' indicator for ranges if the characters are preceeded with 'between' or 'from'.

```ruby
Regeng.new 'character e to z'
Regeng.new 'character e through z'
Regeng.new 'character e-z'
Regeng.new 'character between e and z'
Regeng.new 'character from e and z'
=> /[E-Ze-z]/
```

Using 'and' as an indicator without 'between' or 'from' will result in exact matches.

```ruby
Regeng.new 'character s o e and z'
=> /[SOEZsoez]/
```

Pluralizing 'character' will result in multiples.

```ruby
Regeng.new 'characters e through z'
=> /[E-Ze-z]+/
```

Indicate 'any character(s)'

```ruby
Regeng.new 'any characters'
=> /[A-Za-z]+/
```

Use an 'uppercase' or 'lowercase' modifier

```ruby
Regeng.new 'any uppercase character e through z'
=> /[E-Z]/
Regeng.new 'any lowercase character e through z'
=> /[e-z]/
```