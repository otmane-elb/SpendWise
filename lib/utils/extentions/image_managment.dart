import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

Future<Uint8List> fileToBytes(String path) async {
  return await File(path).readAsBytes();
}

Future<XFile?> pickImage() async {
  final ImagePicker picker = ImagePicker();
  return await picker.pickImage(source: ImageSource.gallery);
}

Future<String> processImage(XFile file) async {
  final inputImage = InputImage.fromFilePath(file.path);
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  final RecognizedText recognizedText =
      await textRecognizer.processImage(inputImage);

  String extractedText = recognizedText.text;
  print(extractedText);
  RegExp regex = RegExp(r'(\d+\.\d{2})');
  final matches = regex.allMatches(extractedText);

  if (matches.isNotEmpty) {
    return matches.last.group(0)!;
  } else {
    return '0.00';
  }
}

Future<String> extractTextFromImage(XFile file) async {
  final inputImage = InputImage.fromFilePath(file.path);
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  final RecognizedText recognizedText =
      await textRecognizer.processImage(inputImage);

  String extractedText = recognizedText.text;
  return extractedText;
}

Future<String> processImagenew(XFile file) async {
  final String extractedText = await extractTextFromImage(file);
  List<String> lines = extractedText.split('\n');
  print(lines);

  // Extract total amount
  String totalAmount = extractTotalAmount(lines);
  // Extract date
  String date = extractDateFromText(lines);

  print('Total Amount: $totalAmount');
  print('Date: $date');

  return 'Total Amount: $totalAmount, Date: $date';
}

String extractTotalAmount(List<String> lines) {
  // Define regex patterns to match amounts and common keywords
  RegExp amountPattern = RegExp(
      r'\b\d+([.,]\d{1,2})?\b'); // Adjusted to match comma or dot as decimal separator
  RegExp keywordPattern = RegExp(
      r'\b(TOTAL|AMOUNT|MONTANT|TOTAL AMOUNT|AMOUNT DUE)\b',
      caseSensitive: false);

  // Define a variable to store the found total amount
  String totalAmount = '0.00';

  // Iterate through each line to find the total amount
  for (int i = 0; i < lines.length; i++) {
    String line = lines[i].trim();

    // Check if the line contains any of the keywords
    if (keywordPattern.hasMatch(line)) {
      // If the next line matches the amount pattern, use it
      if (i + 1 < lines.length && amountPattern.hasMatch(lines[i + 1])) {
        totalAmount = amountPattern.firstMatch(lines[i + 1])!.group(0)!;
        break;
      }
    }

    // Check if the current line itself matches the amount pattern
    if (amountPattern.hasMatch(line)) {
      totalAmount = amountPattern.firstMatch(line)!.group(0)!;
    }
  }

  // Convert the amount to the standard format
  totalAmount =
      totalAmount.replaceAll(',', '.'); // Ensure decimal separator is a dot
  totalAmount = totalAmount.replaceAll(' ', ''); // Remove any spaces
  return totalAmount;
}

String extractDateFromText(List<String> lines) {
  // Define regex patterns to match common date formats
  RegExp datePattern = RegExp(
      r'\b(?:\d{1,2}[/-]\d{1,2}[/-]\d{2,4}|\d{2,4}[/-]\d{1,2}[/-]\d{1,2})\b');

  // Define a variable to store the found date
  String date = DateFormat('EEE, dd MMM yyyy').format(DateTime.now());

  // Iterate through each line to find the date
  for (int i = 0; i < lines.length; i++) {
    String line = lines[i].trim();

    // Check if the line matches the date pattern
    if (datePattern.hasMatch(line)) {
      String matchedDate = datePattern.firstMatch(line)!.group(0)!;
      // Parse the matched date into a DateTime object and then format it
      DateTime parsedDate;
      if (matchedDate.contains('-')) {
        parsedDate = parseDateWithCentury(matchedDate, 'yyyy-MM-dd');
      } else if (matchedDate.contains('/')) {
        parsedDate = parseDateWithCentury(matchedDate, 'dd/MM/yyyy');
      } else {
        continue;
      }
      date = DateFormat('EEE, dd MMM yyyy').format(parsedDate);
      break;
    }
  }

  return date;
}

DateTime parseDateWithCentury(String dateStr, String format) {
  DateFormat dateFormat = DateFormat(format);
  DateTime parsedDate = dateFormat.parse(dateStr);

  if (parsedDate.year < 100) {
    int year = parsedDate.year;
    if (year < 50) {
      year += 2000; // assume 20xx for years < 50
    } else {
      year += 1900; // assume 19xx for years >= 50
    }
    parsedDate = DateTime(year, parsedDate.month, parsedDate.day);
  }

  return parsedDate;
}
