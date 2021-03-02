local constants = import './constants.libsonnet';
local auth = import './auth.libsonnet';

{
  request:: {
    url: error 'url is required',
    method: error 'method is required',

    header: [],

    body: {},
  },

  GET(url):: $.request { method: 'GET', url: url },
  POST(url):: $.request { method: 'POST', url: url },
  PUT(url):: $.request { method: 'PUT', url: url },
  DELETE(url):: $.request { method: 'DELETE', url: url },
  OPTIONS(url):: $.request { method: 'OPTIONS', url: url },
  HEAD(url):: $.request { method: 'HEAD', url: url },
  PATCH(url):: $.request { method: 'PATCH', url: url },

  /******************************************************************
   * MIXINS
   *
   * These are used to add facets to requests/suites.
   */

  /**
   * Set the body of the request.
   */
  body:: {
    raw(value):: {
      body+: {
        mode: 'raw',
        raw: value,
      },
    },

    json(value, contentType='application/json; charset=utf-8'):: {
      body+: {
        mode: 'raw',
        raw: std.manifestJson(value),
      },
    } + $.header('Content-Type', contentType),

    urlencoded(kv):: {
      body+: {
        mode: 'urlencoded',
        urlencoded: [pair for pair in kv],
      },
    },

    formdata(formParameterList):: {
      body+: {
        mode: 'formdata',
        formdata: [formParameter for formParameter in formParameterList],
      },
    },

    file(name, content):: {
      body+: {
        mode: 'file',
        file: {
          src: name,
          content: content,
        },
      },
    },

    graphql(data):: {
      body+: {
        mode: 'graphql',
        graphql: data,
      },
    },
  },

  /**
   * Adds basic authentication parameters to a suite or a request.
   *
   * @deprecated use `test.auth.basic(user, password)` instead.
   */
  basicAuth(user='{{user}}', password='{{password}}'):: auth.auth.basic(user, password),

  /**
   * Adds a header to a request.
   * If {name} is an object, then treats it as a mapping of header
   * names to values.
   */
  header(name, value=null)::
    if std.type(name) == 'object'
    then {
      header+: [
        {
          key: k,
          value: name[k],
        }
        for k in std.objectFields(name)
      ],
    }
    else {
      header+: [
        {
          key: name,
          value: value,
        },
      ],
    },

  /**
   * Sets a cookie on the request.
   */
  cookie(name, value):: self.header('Cookie', '%s=%s' % [name, value]),
}
