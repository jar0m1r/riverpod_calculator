import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_calculator/services/application/lifecycle_service.dart';

final lifecycleServiceProvider =
    StreamProvider((ref) => LifecycleService().stream);
