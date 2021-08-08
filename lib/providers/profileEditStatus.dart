import 'package:flutter/cupertino.dart';

class ProfileEditStatus with ChangeNotifier {
  bool isEditing = false;

  setIsEditingTrue() {
    isEditing = true;
    notifyListeners();  
  }

  setIsEditingFalse() {
    isEditing = false;
    notifyListeners();
  }

  get getIsEditingStatus {
    return isEditing;
  }

  clearState() {
    isEditing = false;
    notifyListeners();
  }
}