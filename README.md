# Frontier Generators

Use the Frontier Generators on the [Frontier Template](https://github.com/thefrontiergroup/rails-template) to quickly spin up CRUD interfaces.

By default, you get:
- Models with validations
- Factories for models using [FFaker](https://github.com/ffaker/ffaker). Factoried attributes take validations into account.
- Index, new, edit, destroy actions
- Authorization via [Pundit](https://github.com/elabs/pundit) policies
- Feature and unit tests for all of the above
- Empty seed rake task

## Important Caveat: In Progress

This gem is a work in progress. I make it for my own use to make my job easier. Some features I've implemented are in a "good enough" state. I use GitHub issues to manage my task list. If you find a deficiency, add an issue.

Once this gem is in 1.0, I will push an actual gem. Things I want in place before I go to 1.0 are:

- Support for sorting via Ransack
- Support for searching via Ransack
- Support for has_many associations
- Support for has_and_belongs_to_many associations

## Important Caveat: Pairing with Rails Template

This gem is specifically made to be paired with the [Frontier Template](https://github.com/thefrontiergroup/rails-template). Technology choices in these generators are completely dependent on what is in the latest version of Frontier Template.

If you want to use this gem in another rails project, you'd need to rewrite some of the output of the generators.

When I use these generators in other rails projects I only enable the model and seeds generators.

## Installing

Add the following to the development group in your Gemfile:

`gem 'frontier_generators', github: "thefrontiergroup/frontier_generators"`

## Basic Usage

You can create a YAML specification of your entities that you can pass directly to any of the generators. EG:

```
rails g frontier_scaffold /path/to/yml
```

## Model Options

You can define a model with some options as follows:

```yaml
model_name:
  # Use CanCanCan instead of Pundit (`pundit` by default)
  authorization: cancancan
  # Do not generate factory. `false` by default.
  skip_factory: true
  # Do not generate model. `false` by default.
  skip_model: true
  # Do not generate policies. `false` by default.
  skip_policies: true
  # Do not generate a blank seed rake task for this model. `false` by default.
  skip_seeds: true
  # Do not create controller, routes, views, or specs for the above. `false` by default.
  skip_ui: true
  # Or skip specific controllers, views and specs
  skip_ui: [create, index, update, delete]
  # Adds support to soft delete for this model (acts_as_paranoid). `true` by default
  soft_delete: true
```

## Namespaces and nested routes

You can specify a set of namespaces or a collection of models that your generated controller will be nested under using the `controller_prefixes` option.

NOTE: Support for nested resources is a WIP.

Missing features:
- routes
- controllers (use nested resources to find resoures)
- controller specs (pass nested resources through in subject. This will be a whole shitload of work)

```yaml
model_name:
  # Example: A single namespace
  #
  # Controller: Admin::ModelNamesController
  # Route:      admin_model_names_path (admin/model_names)
  # Views:      views/admin/model_names
  controller_prefixes: [:admin]

  # Example: A single nested resource
  #
  # Controller: Client::ModelNamesController
  # Route:      client_model_names_path(@client) (client/:id/model_names)
  # Views:      views/client/model_names
  controller_prefixes: [@client]

  # Example: A namespace and a nested resource
  #
  # Controller: Admin::Client::ModelNamesController
  # Route:      admin_client_model_names_path(@client) (admin/client/:id/model_names)
  # Views:      views/admin/client/model_names
  controller_prefixes: [:admin, @client]
```

## Attributes

You can specify which attributes should be on your model thusly:

```yaml
model_name:
  attributes:
    attribute_name:
      # Set primary to true if you want this attribute to be used for #to_s and for
      # checks in the feature specs. Chooses first attribute by default.
      primary: true
      # Set to false if you don't want this attribute to be represented on the index
      # Note: This is true by default
      show_on_index: false
      # Set to false to prevent this attribute being used in the form
      # Note: this is true by default
      show_on_form: false
      # Add in support for sorting on this attribute using Ransack.
      sortable: true

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
      # Optional - this will use this model in factories and in the model
      class_name: "User"
      # One of inline or select
      form_type: "inline"
      attributes:
        # This should be a collection similar to the above. Show all the attributes and their type that you want to show in the inline form
      type: "belongs_to"
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
        # Or, uniquenss can support the scope argument
        uniqueness:
          scope: user_id
```
