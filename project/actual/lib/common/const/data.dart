import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

// localhost
// final emulatorIp = '127.0.0.1:3000';
final emulatorIp = '192.168.0.127:3000';
final simulatorIp = '10.0.2.2:3000';

final ip = Platform.isIOS ? simulatorIp : emulatorIp;


final storage = FlutterSecureStorage();