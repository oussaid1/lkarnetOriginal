import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'item/item.dart';

/// a class to represent a backup of items in the database in a json format
/// this class is used to backup the database to a json file
class Backup {
  /// the date of the backup
  DateTime? date;

  /// the items in the backup
  List<ItemModel> items = [];

  /// the constructor for the backup class
  Backup({required this.date, required this.items});

  /// the toJson method for the backup class
  /// this method is used to convert the backup to a json format
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date!.toIso8601String();
    data['items'] = this.items.map((x) => x.toMap()).toList();
    return data;
  }

  /// the fromJson method for the backup class
  /// this method is used to convert a json format to a backup
  Backup.fromJson(Map<String, dynamic> json) {
    this.date = DateTime.parse(json['date']);
    this.items =
        json['items'].map<ItemModel>((x) => ItemModel.fromJson(x)).toList();
  }

  /// a function to stroe the backup to a json file in the backup folder in the app directory with the name of the date of the backup and the extension .json
  Future<void> store() async {
    final String path =
        '${(await getApplicationDocumentsDirectory()).path}/backup/${this.date!.toIso8601String()}.json';
    final File file = File(path);
    await file.writeAsString(json.encode(this.toJson()));
  }

  /// a function to load the backup from a json file in the backup folder in the app directory with the name of the date of the backup and the extension .json
  /// this function is used to load the backup from a json file
  static Future<Backup> load(String date) async {
    final String path =
        '${(await getApplicationDocumentsDirectory()).path}/backup/${date}.json';
    final File file = File(path);
    final String jsonString = await file.readAsString();
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return Backup.fromJson(jsonMap);
  }

  /// store the list of items  in excel format in the backup folder in the app directory with the name of the date of the backup and the extension .xlsx
  /// this function is used to store the list of items in excel format
  Future<void> storeExcel() async {
    final String path =
        '${(await getApplicationDocumentsDirectory()).path}/backup/${this.date!.toIso8601String()}.xlsx';
    final File file = File(path);
    await file.writeAsString(this.toExcel());
  }

  /// toExcel method for the backup class
  /// this method is used to convert the backup to a excel format
  String toExcel() {
    String excel = 'Date,Item,Quantifier,Quantity,Price,Shop,Date Bought\n';
    for (ItemModel item in items) {
      excel +=
          '${this.date!.toIso8601String()},${item.itemName},${item.quantifier},${item.quantity},${item.itemPrice},${item.shopName},${item.dateBought.toIso8601String()}\n';
    }
    return excel;
  }
}
