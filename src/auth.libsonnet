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
     * Handy for explicitly disabling auth for a given request.
     */
    noauth():: {
      auth: {
        type: 'noauth',
      },
    },
  },
}
