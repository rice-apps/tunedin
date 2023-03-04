import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../http/api_client.dart';

final httpProvider = Provider<ApiClient>((ref) => ApiClient());
