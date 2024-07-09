import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async {
    await dotenv.load(
      fileName: fileName,
    );
  }

  // Supabase
  static String get fileName {
    if (kReleaseMode) return '.env.production';
    return '.env.development';
  }

  static String get urlBase =>
      dotenv.env['SUPABASE_URL'] ?? 'Not SUPABASE_URL especified';

  static String get anonKey =>
      dotenv.env['SUPABASE_ANON_KEY'] ?? 'Not SUPABASE_ANON_KEY especified';

  static String get firebaseApiKey =>
      dotenv.env['FIREBASE_API_KEY'] ?? 'Not FIREBASE_API_KEY especified';

  static String get firebaseAppId =>
      dotenv.env['FIREBASE_APP_ID'] ?? 'Not FIREBASE_APP_ID especified';

  static String get firebaseMessagingSenderId =>
      dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ??
      'Not FIREBASE_MESSAGING_SENDER_ID especified';

  static String get firebaseProjectId =>
      dotenv.env['FIREBASE_PROJECT_ID'] ?? 'Not FIREBASE_PROJECT_ID especified';

  static String get mapboxAccessToken =>
      dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? 'Not MAPBOX_ACCESS_TOKEN especified';
}
