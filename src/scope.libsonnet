{
  EventScope:: {
    tests:: [],
    pre:: [],

    local me = self,

    event: [
      {
        listen: 'prerequest',
        script: {
          exec: me.pre,
        },
        type: 'text/javascript',
      },
    ] + [
      {
        listen: 'test',
        script: {
          exec: me.tests,
        },
        type: 'text/javascript',
      },
    ],
  },

  VariableScope:: {
    vars:: {},

    local me = self,

    variable: [
      {
        key: name,
        value: me.vars[name],
      }
      for name in std.objectFields(me.vars)
    ],
  },
}
