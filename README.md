# Frontier Generators

Use the Frontier Generators on the [Frontier Template](https://github.com/thefrontiergroup/rails-template) to quickly spin up CRUD interfaces.

## Installing

Add the following to the development group in your Gemfile:

`gem 'frontier_generators', github: "git@github.com:thefrontiergroup/frontier_generators.git"`

## Basic Usage

You can create a YAML specification of your entities that you can pass directly to any of the generators. EG:

```
rails g frontier_scaffold /path/to/yml
```

Frontier Generators also provides unit and feature specs where applicable.

## Model Options

You can define a model with some options as follows:

```yaml
model_name:
  # Do not generate a blank seed rake task for this model. `false` by default.
  skip_seeds: true
  # Do not create controller, routes, views, or specs for the above. `false` by default.
  skip_ui: true
  # Or skip specific controllers, views and specs
  skip_ui: [create, index, update, delete]
  # Adds support to soft delete for this model (acts_as_paranoid). `true` by default
  soft_delete: true
```

## Attributes

You can specify which attributes should be on your model thusly:

```yaml
model_name:
  soft_delete: false
  skip_ui: false # true by default (only used by scaffold generator)
  attributes:
    attribute_name:
      # Set primary to true if you want this attribute to be used for #to_s and for
      # checks in the feature specs. Chooses first attribute by default.
      primary: true
      # Set to false if you don't want this attribute to be represented on the index
      # Note: This is true by default
      show_on_index: false

      # Choose one of the following
      type: boolean
      type: datetime
      type: date
      type: decimal
      type: integer
      type: string
      type: text

      # enum should also provide enum_options
      type: enum
      enum_options: ['admin', 'public']
```

## Associations

You can add validations the same way you would add an attribute. Currently supported:

EG:

```yaml
model_name:
  attributes:
    attribute_name:
      type: "belongs_to"
      # Optional - this will use this model in factories and in the model
      class_name: "User"
```

## Validations

You can add validations to your models. This will provide implementations and specs when generated.

Frontier currently supports the following validations:

```yaml
model_name:
  attributes:
    attribute_name:
      validates:
        inclusion: [1,2,3,4]
        length:
          minimum: 0
          maximum: 666
          is: 100
          # in and within are aliases for eachother
          in: 0..100
          within: 0..100
        numericality: true
        # Or, numericality can use one or more args
        numericality:
          allow_nil: true
          greater_than: 0
          greater_than_or_equal_to: 0
          equal_to: 0
          less_than: 100
          less_than_or_equal_to: 100
          only_integer: true
        presence: true
        uniqueness: true
```
