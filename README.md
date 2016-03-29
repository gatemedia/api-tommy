# ApiTommy
[![Build Status](https://travis-ci.org/gatemedia/api-tommy.svg?branch=master)](https://travis-ci.org/gatemedia/api-tommy)

ApiTommy is an opinionated little tool used to generate a wiki page documenting your APIs based on Rails/Rails-api.

Basically, you document your classes using a standard. There is no modification in your code.
You then run this tool and it will automatically generate and update your github wiki.

This tool depends on rdoc 4.2.x

# Compatibility
* rails 5.x
* rdoc 4.2.x

This gem is built against:
* ruby 2.0.0
* ruby 2.1.3
* ruby 2.2.2
* ruby 2.3.0

Other versions may or may not work.

## Installation

Add this line to your application's Gemfile:

    gem 'api_tommy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install api_tommy

## Usage

Here is the requirements in order to have an happy tommy (pun intended):

* The best place to document your API is your controllers.
* Each class/method is documented using [TomDoc](http://tomdoc.org/).
* For the class comments, here is the usage of each [TomDoc](http://tomdoc.org/) section:
  * Description: Will describe your API and the returned objects
  * Returns: Not used.
  * Arguments: Will describe each field of your objects
  * Examples: Will provide examples of your object
  * Raises: Not used.
* For the method comments, here is the usage of each [TomDoc](http://tomdoc.org/) section:
  * Description: Will describe your method with its constraints. The first sentence will be used
    as a title for the wiki.
  * Returns: Will describe the structure returned. Is it an array? A single object?
  * Arguments: Will describe each parameter accepted by the method.
  * Examples: Examples of how do you call your API method.
  * Raises: Will describe what exceptions can occur. Ideally, it should be http codes(eg 400, 404, ...).
* You are using Ruby 1.9.3.
* You are using Rails 3.x or 4.
* Your project is hosted on github and has a wiki.

Let's see an example. Here a really simple API documented controller:

```ruby
# This is the cars API. It provides ways to search and get cars.
# Cars are simple json objects with these fields:
#
# brand - the brand of the car
# model - the model of the car
# horsepower - the horse power of the car
# year - the year of the car
#
# Examples
#
# {
#   "car": {
#     "brand": "Mini",
#     "model": "Cooper S",
#     "horsepower": 400,
#     "year": 2050
#   }
# }
class CarsController < ApplicationController

  # Get all cars. This method will return all available cars
  #
  # Examples
  #
  # GET /cars.json
  #
  # Returns all cars as an array under the `cars` field.
  # Raises 500 if an error occurs
  def index
    render :json => Car.all
  end

  # Get a car. This method will return the given car's id.
  #
  # id - the car's id as a string.
  #
  # Examples
  #
  # GET /cars/1237.json
  #
  # Return the given car under the `car`field.
  # Raises 404 if the car can't be found.
  # Raises 500 if an error occurs
  def show
    render :json => Car.find(params[:id])
  end
end
```

On the root of the project, you can then run the following command:
```
rdoc --format apitommy app/controllers/cars_controller.rb
```

This will lead to a page ```API``` in your project wiki, containing this markup:
```markdown
# Cars

This is the cars API. It provides ways to search and get cars. Cars are simple json objects with these fields:

### Fields

| Name | Description
| --- | ---
| brand | the brand of the car
| model | the model of the car
| horsepower | the horse power of the car
| year | the year of the car

### Examples

{
  "car": {
    "brand": "Mini",
    "model": "Cooper S",
    "horsepower": 400,
    "year": 2050
  }
}

## Get all cars

Get all cars. This method will return all available cars

Returns all cars as an array under the `cars` field.

### Examples

GET /cars.json

### Errors

500 if an error occurs

## Get a car

Get a car. This method will return the given car's id.

Return the given car under the `car`field.

### Parameters

| Name | Description
| --- | ---
| id | the car's id as a string.

### Examples

GET /cars/1237.json

### Errors

404 if the car can't be found.

500 if an error occurs
```

## Options

When running ```rdoc --format apitommy```, these options are available:
* ```--filename FILENAME```: the name of the wiki page. ```API``` by default.
* ```--header HEADER```: if you wish to include a header on the wiki page. Optionnal.
* ```--footer FOOTER```: if you wish to include a footer on the wiki page. Optionnal.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
