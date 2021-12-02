local test = import '../../postman.libsonnet';

test.suite {
  name: 'Request Body',

  item: [
    test.case {
      name: 'Raw',
      request: test.POST('https://{{httpbin}}/anything') +
               test.body.raw('hello!'),
      tests: |||
        pm.test("Raw data", function () {
          pm.expect(pm.response.json().data).to.equal('hello!');
        });
      |||,
    },

    test.case {
      name: 'Json',
      request: test.POST('https://{{httpbin}}/anything') +
               test.body.json({
                 bohemian: 'rhapsody',
                 third: 'symphony',
               }),
      tests: |||
        pm.test("Json data", function () {
          pm.expect(pm.response.json().json.bohemian).to.equal('rhapsody');
          pm.expect(pm.response.json().json.third).to.equal('symphony');
        });
      |||,
    },

    test.case {
      name: 'Urlencoded',
      request: test.POST('https://{{httpbin}}/anything') +
               test.body.urlencoded([
                 { key: 'easy', value: 'come' },
                 { key: 'easy', value: 'go' },
               ]),
      tests: |||
        pm.test("Urlencoded data", function () {
          pm.expect(pm.response.json().form.easy[0]).to.equal('come');
          pm.expect(pm.response.json().form.easy[1]).to.equal('go');
        });
      |||,
    },
  ],
}
