import 'package:intl/intl.dart';

class DateTimeHelper {
  // UI Date format: MM/DD/YYYY
  static final DateFormat _uiDateFormat = DateFormat('MM/dd/yyyy');

  // UI Time format: hh:mm a (12-hour format)
  static final DateFormat _uiTimeFormat = DateFormat('hh:mm a');

  // ISO format for API: yyyy-MM-ddTHH:mm:ss.SSSZ
  static final DateFormat _isoDateTimeFormat = DateFormat(
    "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
  );

  // API Date format: yyyy-MM-dd
  static final DateFormat _apiDateFormat = DateFormat('yyyy-MM-dd');

  /// Converts UI date (MM/DD/YYYY) and time (hh:mm a) to ISO UTC format
  /// Example: convertToIsoUtc("10/02/2025", "2:05 PM") → "2025-10-02T14:05:00.000Z"
  static String convertToIsoUtc(String uiDate, String uiTime) {
    try {
      // Parse UI date
      final date = _uiDateFormat.parse(uiDate);

      // Parse UI time
      final time = _uiTimeFormat.parse(uiTime);

      // Combine date and time
      final combinedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
        time.second,
      );

      // Convert to UTC and format as ISO string
      final utcDateTime = combinedDateTime.toUtc();
      return _isoDateTimeFormat.format(utcDateTime);
    } catch (e) {
      throw Exception('Failed to convert date/time to ISO format: $e');
    }
  }

  /// Converts ISO UTC datetime string to UI date format (MM/DD/YYYY)
  /// Example: convertIsoToUiDate("2025-10-02T14:05:00.000Z") → "10/02/2025"
  static String convertIsoToUiDate(String isoDateTime) {
    try {
      final dateTime = DateTime.parse(isoDateTime);
      return _uiDateFormat.format(dateTime);
    } catch (e) {
      throw Exception('Failed to convert ISO date to UI format: $e');
    }
  }

  /// Converts ISO UTC datetime string to UI time format (hh:mm a)
  /// Example: convertIsoToUiTime("2025-10-02T14:05:00.000Z") → "2:05 PM"
  static String convertIsoToUiTime(String isoDateTime) {
    try {
      final dateTime = DateTime.parse(isoDateTime);
      return _uiTimeFormat.format(dateTime);
    } catch (e) {
      throw Exception('Failed to convert ISO time to UI format: $e');
    }
  }

  /// Converts UI date (MM/DD/YYYY) to API date format (yyyy-MM-dd)
  /// Example: convertUiToApiDate("10/02/2025") → "2025-10-02"
  static String convertUiToApiDate(String uiDate) {
    try {
      final date = _uiDateFormat.parse(uiDate);
      return _apiDateFormat.format(date);
    } catch (e) {
      throw Exception('Failed to convert UI date to API format: $e');
    }
  }

  /// Converts API date (yyyy-MM-dd) to UI date format (MM/DD/YYYY)
  /// Example: convertApiToUiDate("2025-10-02") → "10/02/2025"
  static String convertApiToUiDate(String apiDate) {
    try {
      final date = _apiDateFormat.parse(apiDate);
      return _uiDateFormat.format(date);
    } catch (e) {
      throw Exception('Failed to convert API date to UI format: $e');
    }
  }

  /// Gets current date in UI format (MM/DD/YYYY)
  static String getCurrentUiDate() {
    return _uiDateFormat.format(DateTime.now());
  }

  /// Gets current time in UI format (hh:mm a)
  static String getCurrentUiTime() {
    return _uiTimeFormat.format(DateTime.now());
  }

  /// Validates if a string is in valid UI date format (MM/DD/YYYY)
  static bool isValidUiDate(String dateString) {
    try {
      _uiDateFormat.parseStrict(dateString);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Validates if a string is in valid UI time format (hh:mm a)
  static bool isValidUiTime(String timeString) {
    try {
      _uiTimeFormat.parseStrict(timeString);
      return true;
    } catch (e) {
      return false;
    }
  }
}
