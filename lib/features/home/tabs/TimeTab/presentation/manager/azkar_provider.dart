import 'package:flutter/material.dart';
class AzkarProvider extends ChangeNotifier {
  String? _selectedAzkarType;

  String? get selectedAzkarType => _selectedAzkarType;

  void setSelectedAzkarType(String type) {
    _selectedAzkarType = type;
    notifyListeners();
  }
}