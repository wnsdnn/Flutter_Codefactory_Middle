import 'dart:io';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

// loclahost
final simulatorIp = '10.0.2.2:3000';
final emulatorIp = '192.168.0.2:3000';

final ip = Platform.isIOS == true ? simulatorIp : emulatorIp;

