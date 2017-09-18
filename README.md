# Night Mapper

NightMapper is a small and simple ORM (Object/Relational Mapper) written in Ruby. It provides a minimal way to query and access data.

### Key Features

Model classes that inherit `NightMapper` inherit a number of ORM features:

- `belongs_to` and `has_many` gives access to many-to-one and one-to-many database relations.
- the `NightMapper::all` returns an array of all of a model class' instances.
- the `NightMapper::find(id)` method returns the data object by primary key `id`.
- the `NightMapper#save` method inserts or updates the related row in the database based on whether or not the `id` is present.
- basic searchability of database tables is enabled by the  method by passing in params to `NightMapper#where`.
- by calling `self.finalize!` at the end of your model class definition, attribute accessors are created according to the columns in the database table.

### Features
- `NightMapper::columns` returns the column names of a table
- `NightMapper::table_name` gets table name
- `NightMapper::table_name=` sets table name according to the string input
- `NightMapper#save` inserts or updates related row in database
- `NightMapper#insert` creates a new row in the database
- `NightMapper#update` updates a row in the database with the attributes given
- `NightMapper#attributes` returns attributes hash where keys are the column names and values are the input
- `NightMapper#attribute_values` returns an array of attribute values
- `has_one_through` provides access to a one-to-one relationship through a join table

### Setup Instructions

1. `git clone https://github.com/iamedcarl/night-mapper.git`
2. `cd night-mapper`
3. Run `bundle install`
4. Open your Ruby developer console (ie. irb or pry)
5. Make an SQL database.
6. Create a ruby file that will inherit `NightMapper` with the appropriate database relationships (see example below).
7. Make sure to call finalize! at the end of your subclass definition, otherwise the getter/setter methods don't get defined.

### Example Usage

```ruby
# '/sports.rb'

require_relative '../lib/night_mapper'

class Player < NightMapper
  belongs_to :team
  has_one_through :city, :team, :city

  finalize!
end

class Team < NightMapper
  belongs_to :city
  has_many :players

  finalize!
end

class City < NightMapper
  has_many :teams

  finalize!
end
```

## Running the Sports Demo App

1. `git clone https://github.com/iamedcarl/night-mapper.git`
2. `cd night-mapper`
3. Run `bundle install`
4. Open your Ruby developer console (ie. irb or pry)
5. `load 'demo/sports.rb'`
