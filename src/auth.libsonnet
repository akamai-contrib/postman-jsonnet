{
  /**
   * These mixins can be added to a suite or to a request.
   */
  auth:: {
    /**
     * Adds basic authentication parameters.
     */
    basic(user='{{user}}', password='{{password}}'):: {
      auth: {
        type: 'basic',
        basic: [
          {
            key: 'password',
            value: password,
            type: 'string',
          },
          {
            key: 'username',
            value: user,
            type: 'string',
          },
        ],
      },
    },

    /**
     * Adds edgegrid authentication parameters.
     */
    edgegrid(clientSecret='{{clientSecret}}', clientToken='{{clientToken}}', accessToken='{{accessToken}}'):: {
      auth: {
        type: 'edgegrid',
        edgegrid: [
          {
            key: 'clientSecret',
            value: clientSecret,
            type: 'string',
          },
          {
            key: 'clientToken',
            value: clientToken,
            type: 'string',
          },
          {
            key: 'accessToken',
            value: accessToken,
            type: 'string',
          },
        ],
      },
    },

    /**
     * Handy for explicitly disabling auth for a given request.
     */
    noauth():: {
      auth: {
        type: 'noauth',
      },
    },
  },
}
