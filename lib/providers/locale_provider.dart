import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppLocale { en, ne }

class LocaleNotifier extends Notifier<AppLocale> {
  @override
  AppLocale build() {
    return AppLocale.en;
  }

  void toggleLocale() {
    state = state == AppLocale.en ? AppLocale.ne : AppLocale.en;
  }

  void setLocale(AppLocale locale) {
    state = locale;
  }

  String translate(String key) {
    final Map<String, Map<AppLocale, String>> dict = {
      'dashboard': {AppLocale.en: 'Dashboard', AppLocale.ne: 'ड्यासबोर्ड'},
      'schedule': {AppLocale.en: 'Schedule & Availability', AppLocale.ne: 'तालिका र उपलब्धता'},
      'bookings': {AppLocale.en: 'Bookings & Sessions', AppLocale.ne: 'बुकिङ र सत्रहरू'},
      'patients': {AppLocale.en: 'Patients Directory', AppLocale.ne: 'बिरामी विवरण'},
      'account': {AppLocale.en: 'Account Settings', AppLocale.ne: 'खाता सेटिङहरू'},
      'available': {AppLocale.en: 'Available', AppLocale.ne: 'उपलब्ध'},
      'busy': {AppLocale.en: 'Busy / Off', AppLocale.ne: 'व्यस्त / बन्द'},
      'report_issue': {AppLocale.en: 'Report an Issue', AppLocale.ne: 'समस्या दर्ता'},
    };
    return dict[key]?[state] ?? key;
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, AppLocale>(LocaleNotifier.new);
