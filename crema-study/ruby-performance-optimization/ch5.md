# Chapter 5. Learn to Optimize with the Profiler

### Profiling is a craft

- There’s nothing deterministic except for the general routine of profile, guess, optimize, then profile again and repeat.

### Pick Low-Hanging Fruit

- Do a bottom-up search for caller graph? (Start with leaves)
- Tackle the easiest problem first?
- Could mean both

```ruby
def parse_col(col)
  if col =~ /^\d+$/
    col.to_i
  elsif col =~ /^\d{4}-\d{2}-\d{2}$/
    Date.parse(col)
  else
    col
  end
end
```

- This is the method with the longest *self* time.
- Can we optimize this?
    1. **Maybe** we can skip the `Date.parse` call because we are already extracting the date format from the string.
    2. **Maybe** we can reduce the number of regexes by combining 2 regexes into 1.
    3. **Maybe** calling the method too many times itself is the main problem and we can't do much about it.
- We can check whether these three statements are true, independently.
    - Turns out that 1 is true, and 2, 3 is false
    - We would never know unless we profile

### Take a Step Back

- Now take a look at this method

```ruby
def parse_row(row)
  row.split(",").map! { |col| parse_col(col) }
end
```

- We are currently delegating the "type reference" role to `#parse_col`... but we already know the "type"s of the split elements, since they are always in a predefined order
- Make use of this fact to optimize this method

```ruby
def parse_row(row)
  col1, col2, col3 = row.split(",")
  [
      col1.to_i,
      col2,
      Date.new(col3[0,4].to_i, col3[5,2].to_i, col3[8,2].to_i)
  ]
end
```

### Caveats

- Always test before & after optimization.
- Always check whether your optimization actually sped up the code.
    - With profiler
    - Without profiler (to see real world effects)