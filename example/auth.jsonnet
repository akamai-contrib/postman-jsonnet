local test = import '../postman.libsonnet';

test.suite {
  name: 'Auth',

  item: [
    import './auth/basic.jsonnet',
  ],
}
