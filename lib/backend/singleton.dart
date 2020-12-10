import 'package:flutter/cupertino.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class Singleton extends ChangeNotifier {
  TextEditingController headerController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<Asset> assets = List<Asset>();
  List selectedEvents;
}