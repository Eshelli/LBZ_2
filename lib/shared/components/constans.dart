import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lbz/Screens/filter/filter.dart';
import 'package:lbz/shared/network/remote/dio_helper.dart';
import 'package:http_parser/http_parser.dart';

var taxonomySlug;
var taxonomy;
var categorySlug;
var category;
var token;
var lang;
Map<String, dynamic> filter = {};
Map<String, dynamic> editAd = {};
var sectionIndex;

var dioHelper = DioHelper();
const kDefaultPadding = 20.0;

// Future<dynamic> uploadImage(List<File> file) async {
//   print(file);
//
//   List<MultipartFile> multiFiles = [];
//   for(int i = 0; i < file.length; i++) {
//     String name = file[i].path.split('/').last;
//     multiFiles.add(await MultipartFile.fromFile(
//       file[i].path,
//       filename: name,
//     ));
//   }
//   // print(file);
//   // List<MapEntry<String, MultipartFile>> list = [];
//   // file.forEach((element) async {
//   //   var value = MapEntry(
//   //     "imgFile",
//   //     await MultipartFile.fromFile(element),
//   //   );
//   //   print(value);
//   //   list.add(value);
//   // });
//   // data.files.addAll(list);
//   return multiFiles;
// }
Future<dynamic> uploadImagesPost(package_id,List<XFile> file) async {
  print(file);
  Map<String,dynamic> map = {
    "package_id": package_id
  };
  // filter.forEach((key, value) {
  //   if(value is String){
  //     map.addIf(value.isNotEmpty, "$key[]", value);
  //   }else{
  //   value.forEach((v){
  //     map.addIf(value.isNotEmpty, "$key[]", v);
  //   });}
  // });
  // print(map);
  map.addAll(filter);
  filter.forEach((key1, value) {
    if(key1.startsWith('attribute_')){
      if(value.isEmpty){
        map.remove(key1);
      }
    }
  });
  for (var element in file) {
    String name = element.path
        .split('/')
        .last;
    map.addIf(true,"images[]",await MultipartFile.fromFile(
      element.path,
      filename: name,
    ));
  }
  print(map);
  var data = FormData.fromMap(map);
  return data;
}

Future<dynamic> uploadImagesEditAd(category,String title, String des, String price, phone, location,List<dynamic> file, List<dynamic> removedImages) async {
  print(category);
  Map<String,dynamic> map = {
    "category": category,
    "city_id": "1",
    "title": title,
    "description": des,
    "price": price,
    "phone_number": phone,
    "location": location,
    if(removedImages.isNotEmpty)
      "removed_images[]": removedImages,
    "_method" : "put",
  };
  // map.addAll(filter);
  // filter.forEach((key1, value) {
  //   if(key1.startsWith('attribute_')){
  //     if(value.isEmpty){
  //       map.remove(key1);
  //     }
  //   }
  // });
  map.addAll(editAd);
print(map);
  for (var element in file) {
    if(element is XFile){
    String name = element.path
        .split('/')
        .last;
    map.addIf(true,"images[]",await MultipartFile.fromFile(
      element.path,
      filename: name,
    ));
    }
  }
  print(map);
  var data = FormData.fromMap(map);
  return data;
}
Future<dynamic> uploadImageProfile(XFile file) async {
  String name = file.path
      .split('/')
      .last;
  var data = FormData.fromMap({
    "avatar" : await MultipartFile.fromFile(
      file.path,
      filename: name,
    ),
    "_method" : "put"
  });
  return data;
}
