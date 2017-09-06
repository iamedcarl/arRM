# Night Mapper

NightMapper is a small and simple ORM (Object/Relational Mapper) written in Ruby. It provides a minimal way to query and access data.

### Key Features

Model classes that inherit `NightMapper` inherit a number of ORM features:

- the `NightMapper::all` returns an array of all of a model class' instances.
- the `NightMapper::find(id)` method returns the data object by primary key `id`.
- the `NightMapper#save` method inserts or updates the related row in the database based on whether or not the `id` is present.
- basic searchability of database tables is enabled by the  method by passing in params to `NightMapper#where`.
- by calling `self.finalize!` at the end of your model class definition, attribute accessors are created according to the columns in the database table.

### Example Usage

```ruby
# '/sports.rb'

require_relative 'lib/night_mapper'

class Player < NightMapper
  # add associations
  finalize!
end
```

## Running the Sports Demo App

Up-to-date versions of [Ruby](https://www.ruby-lang.org/en/) and [Bundler](http://bundler.io)

1. `git clone https://github.com/iamedcarl/night-mapper.git`
2. `cd night-mapper`
3. Run `bundle install`
4. Open your Ruby developer console (ie. irb or pry)
5. `load 'sports.rb'`

### Features
- `NightMapper::all`
- `NightMapper::find(id)`
- `NightMapper::table_name`
- `NightMapper::table_name=`
- `NightMapper::columns`
- `NightMapper#save`
- `NightMapper#where`
