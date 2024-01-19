import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

// localhost
// 회사 ip
final emulatorIp = '192.168.0.127:3000';
// 배화여대 ip
// final emulatorIp = '172.16.111.101:3000';
// 집 ip
// final emulatorIp = '192.168.0.2:3000';
final simulatorIp = '10.0.2.2:3000';

final ip = Platform.isIOS ? simulatorIp : emulatorIp;
