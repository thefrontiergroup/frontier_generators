if defined?(SeedHelper)
  SeedHelper.create_seed_task(<%= model.name.as_symbol_collection %>) do

    # TODO: Put your seeds in here.

  end
end
