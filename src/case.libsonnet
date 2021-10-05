local scope = import './scope.libsonnet';

{
  case:: scope.EventScope + scope.VariableScope + {
    local me = self,

    // by default, disable cookies
    disableCookies:: true,

    // by default, do not chase redirects
    followRedirects:: false,

    name: error 'name is required',

    request: error 'request is required',

    protocolProfileBehavior: {
      disableCookies: me.disableCookies,
      followRedirects: me.followRedirects,
    },

    event+: [
      // log request and response headers for all cases
      {
        listen: 'test',
        script: {
          exec: |||
            //console.log("Request Headers", pm.request.headers);
            //console.log("Response Headers", pm.response.headers);
          |||,
        },
        type: 'text/javascript',
      },
    ],
  },
}
