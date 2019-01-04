### Except Modifier

The 'except' modifier can be used to exclude matches. 

```ruby
Regeng.new 'any character except e through z'
=> /[^E-Ze-z]/
```