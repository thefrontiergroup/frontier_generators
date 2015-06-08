# Frontier Generators

Use the Frontier Generators on the [Frontier Template](https://github.com/thefrontiergroup/rails-template) to quickly spin up CRUD interfaces.

You can create a YAML specification of your entities that you can pass directly to any of the generators. EG:

```
rails g frontier_scaffold /path/to/yml
```

## Supported Data-Types

You can set the type of the attribute with the following:

```yaml
model_name:
  attributes:
    attribute_name:
      type: "string"
```

### Attributes

- datetime
- date
- decimal
- enum
- integer
- string

### Associations

- belongs_to

#### Extra arguments

##### class_name

Associations can set class_name, which will set it on the association and use it when determining the factory and fields.

EG:

```yaml
model_name:
  attributes:
    attribute_name:
      type: "belongs_to"
      class_name: "User"
```
