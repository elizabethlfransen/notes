import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings.g.dart';

class SharedPreferencesSettingsStorage extends SettingsStorage {
  final _prefs = SharedPreferencesAsync();

  @override
  Future<String?> getString(String key) {
    return _prefs.getString(key);
  }

  @override
  Future<void> setString(String key, String value) {
    return _prefs.setString(key, value);
  }
}

class InMemorySettingsStorage extends SettingsStorage {
  final _storage = <String, dynamic>{};

  @override
  Future<String?> getString(String key) async => _storage[key];

  @override
  Future<void> setString(String key, String value) async =>
      _storage[key] = value;
}

/// A [SettingsStorage] which has fallback providers to fetch.
class BackedSettingsStorage extends SettingsStorage {
  final List<SettingsStorage> providers;

  BackedSettingsStorage(this.providers);

  Future<T?> _get<T>(
    String key,
    Future<T?> Function(SettingsStorage storage, String key) getValue,
  ) async {
    for (var provider in providers) {
      try {
        return await getValue(provider, key);
      } catch (error, stacktrace) {
        Logger(
          provider.runtimeType.toString(),
        ).warning("Failed to fetch key from provider", error, stacktrace);
      }
    }
    throw StateError("Unable to fetch setting '$key' from any provider");
  }

  Future<void> _set<T>(
    String key,
    T value,
    Future<void> Function(SettingsStorage storage, String key, T value)
    setValue,
  ) async {
    // set value to all providers
    var keySuccessfullySet = false;
    for (var provider in providers) {
      try {
        await setValue(provider, key, value);
        keySuccessfullySet = true;
      } catch (error, stacktrace) {
        Logger(
          provider.runtimeType.toString(),
        ).warning("Failed to set key for provider", error, stacktrace);
      }
    }
    if (!keySuccessfullySet) {
      throw StateError("Unable to set setting '$key' for any provider");
    }
  }

  @override
  Future<String?> getString(String key) =>
      _get(key, (provider, key) => provider.getString(key));

  @override
  Future<void> setString(String key, String value) => _set(
    key,
    value,
    (provider, key, value) => provider.setString(key, value),
  );
}

abstract class SettingsStorage {
  Future<String?> getString(String key);

  Future<void> setString(String key, String value);

  Future<T?> getEnum<T extends Enum>(String key, Map<String, T> names) async {
    final rawValue = await getString(key);
    if (rawValue == null) return null;
    return names[rawValue] ??
        (throw Exception(
          "Stored setting (key='$key', value='$rawValue') is an unknown enum variant",
        ));
  }

  Future<void> setEnum<T extends Enum>(String key, T value) =>
      setString(key, value.name);
}

@riverpod
SettingsStorage settingsStorage(Ref ref) => BackedSettingsStorage([
  SharedPreferencesSettingsStorage(),
  InMemorySettingsStorage(),
]);

extension<T> on Future<T?> {
  Future<T> orDefault(T value) async {
    return ((await this) ?? value);
  }
}

@riverpod
class ThemeModeSetting extends _$ThemeModeSetting {
  static final _settingKey = "themeMode";

  @override
  Future<ThemeMode> build() => ref
      .read(settingsStorageProvider)
      .getEnum(_settingKey, ThemeMode.values.asNameMap())
      .orDefault(ThemeMode.system);

  Future<void> set(ThemeMode mode) async {
    // manually update the state to get instant feedback
    state = AsyncData(mode);
    await ref.read(settingsStorageProvider).setEnum(_settingKey, mode);
  }
}
