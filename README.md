# Chili flutter storage implementation

Repository class to handle in-memory data

## Usage:

1. Add this to pubspec.yaml:

```
  chili_flutter_storage_impl:
    git:
      url: https://github.com/ChiliLabs/chili-flutter-storage-impl.git
      ref: 0.0.5
```

2. For shared preferences - create shared prefs instance in main.dart

```
import 'package:chili_flutter_storage_impl/chili_flutter_storage_impl.dart';

final sharedPrefs = await SharedPreferences.getInstance();
```

3. For secure storage - create repository

```
import 'package:chili_flutter_storage_impl/chili_flutter_storage_impl.dart';

final secureKeyValueStorage = SecureKeyValueStorage(
  const FlutterSecureStorage(),
  onError: (ex, st) {
    Fimber.e('Operation with secure storage failed: $ex', stacktrace: st);
  },
);
```
