class AppServices {
  static String getBaseUrl() {
    return 'http://192.168.198.46:5000';
  }

  static String getLoginEndpoint() {
    return '${getBaseUrl()}/login';
  }

  static String getRegistEndpoint() {
    return '${getBaseUrl()}/register';
  }

  static String getAuthEndpoint() {
    return '${getBaseUrl()}/auth';
  }

  static String getDetectEndpoint() {
    return '${getBaseUrl()}/detect';
  }

  static String getUserEndpoint() {
    return '${getBaseUrl()}/profile';
  }
}
