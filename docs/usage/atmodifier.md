### At Modifier

The 'at' modifier can be used to indicate the start or end of a line or string.

```ruby
Regeng.new 'any characters at start of line'
=> /^[A-Za-z]+/
Regeng.new 'any characters at end of line'
=> /$[A-Za-z]+/
Regeng.new 'any characters at start of string'
=> /\A[A-Za-z]+/
Regeng.new 'any characters at end of string'
=> /\z[A-Za-z]+/
```