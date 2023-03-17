local scope = import './scope.libsonnet';

{
  case:: scope.EventScope + scope.VariableScope + {
    local me = self,

    // by default, disable cookies
    disableCookies:: true,

    // by default, do not chase redirects
    followRedirects:: false,

    // by default, do not add delay
    delay:: null,

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
    ] + (
      // add request delay
      if (std.type(me.delay) == 'number')
      then [{
        listen: 'prerequest',
        script: 'setTimeout(function(){}, %d);' % me.delay,
        type: 'text/javascript',
      }]
      else []
    ),
  },
}
