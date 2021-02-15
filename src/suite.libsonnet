local scope = import './scope.libsonnet';

{
  suite:: scope.EventScope + scope.VariableScope + {
    local me = self,

    name: error 'name is required',

    // array of cases or suites
    item: [],

    info: {
      name: me.name,
      schema: 'https://schema.getpostman.com/json/collection/v2.1.0/collection.json',
    },
  },
}
