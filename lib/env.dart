enum Environment{
  dev,
  test,
  pro
}

class AppEnvironment {
  static late Map<String, dynamic> _config;
  static String get baseUrl =>  _config['API_URL'] ?? '';

  static void setAppEnvironment(Environment env) {
    switch (env) {
      case Environment.dev:
        _config = _Config.debugConstants;
        break;
      case Environment.test:
        _config = _Config.testConstants;
        break;
      case Environment.pro:
        _config = _Config.prodConstants;
        break;
      default:
        _config = _Config.debugConstants;
    }
  }

  static get apiUrl {
    return _config[_Config.API_URL];
  }
  static get messageUrl {
    return _config[_Config.MESSAGE_URL];
  }
  static get clientId {
    return _config[_Config.CLIENT_ID];
  }
  static get redirectUrl {
    return _config[_Config.REDIRECT_URL];
  }
  static get networkType {
    return _config[_Config.NETWORK_TYPE];
  }

  static get gameApiUrl {
    return _config[_Config.GAME_API];
  }

}

class _Config {
  // ignore: constant_identifier_names
  static const API_URL = 'API_URL';
  static const MESSAGE_URL = 'MESSAGE_URL';
  static const CLIENT_ID = '';
  static const REDIRECT_URL = '/';
  static const NETWORK_TYPE = 'NETWORK_TYPE';
  static const GAME_API = 'GAME_API';

  static Map<String, dynamic> debugConstants = {
    API_URL: 'https://script.google.com/macros/s/AKfycbxfMvArts3d5RVLLmcJEIgTiSS-euYAc9WYHod1vaf29Iy247PObxsWd0c5oXTrred_/exec',
    MESSAGE_URL: '',
    CLIENT_ID: '',
    REDIRECT_URL: 'script.google.com',
    // NETWORK_TYPE: NetworkType.TESTNET,
    GAME_API: '/macros/s/AKfycbxfMvArts3d5RVLLmcJEIgTiSS-euYAc9WYHod1vaf29Iy247PObxsWd0c5oXTrred_/exec'
  };

  static Map<String, dynamic> testConstants = {
    API_URL: 'https://script.google.com/macros/s/AKfycbxfMvArts3d5RVLLmcJEIgTiSS-euYAc9WYHod1vaf29Iy247PObxsWd0c5oXTrred_/exec',
    MESSAGE_URL: '',
    CLIENT_ID: '',
    REDIRECT_URL: '',
    // NETWORK_TYPE: NetworkType.TESTNET,
    GAME_API: ''
  };

  static Map<String, dynamic> prodConstants = {
    API_URL: 'https://script.google.com/macros/s/AKfycbxfMvArts3d5RVLLmcJEIgTiSS-euYAc9WYHod1vaf29Iy247PObxsWd0c5oXTrred_/exec',
    MESSAGE_URL: '',
    CLIENT_ID: '',
    REDIRECT_URL: '',
    // NETWORK_TYPE: NetworkType.MAINNET,
    GAME_API: ''
  };
}