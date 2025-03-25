import 'package:flutter/material.dart';

/// Enum representing the supported languages.
enum SupportedLanguage { english, turkish }

/// A class that holds the localized text values.
class LocalizedTexts {  // New field for tooltip text

  const LocalizedTexts({
    required this.title,
    required this.helper,
    required this.day,
    required this.tooltip,
  });
  final String title;
  final String helper;
  final String day;
  final String tooltip;
}

/// Mapping between SupportedLanguage and their corresponding texts.
const Map<SupportedLanguage, LocalizedTexts> localizedValues = {
  SupportedLanguage.english: LocalizedTexts(
    title: 'Due Date:',
    helper: 'Tap on the date to select from the calendar',
    day: 'day',
    tooltip: 'Tap to select a date',
  ),
  SupportedLanguage.turkish: LocalizedTexts(
    title: 'Bitiş Tarihi:',
    helper: 'Tarihe basarak takvim üzerinden tarih seçimi yapabilirsiniz',
    day: 'gün',
    tooltip: 'Tarih seçmek için dokunun',
  ),
};

/// Helper function to determine the supported language based on the current locale.
SupportedLanguage getSupportedLanguage(BuildContext context) {
  final code = Localizations.localeOf(context).languageCode;
  switch (code) {
    case 'tr':
      return SupportedLanguage.turkish;
    default:
      return SupportedLanguage.english;
  }
}
