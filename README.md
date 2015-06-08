# Frontier Generators

Use the Frontier Generators on the [Frontier Template](https://github.com/thefrontiergroup/rails-template) to quickly spin up CRUD interfaces.

You can create a YAML specification of your entities that you can pass directly to any of the generators. EG:

```
rails g frontier_scaffold /path/to/yml
```

## Supported Data-Types

### Attributes

- datetime
- date
- decimal
- enum
- integer
- string

### Associations

- belongs_to
