# Decorator CSV

This is a simple gem that lets you generate CSVs using the decorator pattern.

## Requirements

This gem uses Draper as the decorator.

The decorator requires the following methods and constants to be available:

+ ```#as_csv_row```
+ ```CSV_HEADER_ROW```

## How To Use

Firstly setup your Draper decorator with the required methods and constants. For example

```ruby
class PersonDecorator < Draper::Decorator

  decorate :person

  CSV_HEADER_ROW = ['First Name', 'Last Name', 'Age']

  def as_csv_row
    [
      source.first_name,
      source.last_name,
      source.age
    ]
  end

end

```

Then call the generate method:

```ruby
people = [person, another_person, third_person]
csv = DecoratedCSV.generate(PersonDecorator, people)
```
