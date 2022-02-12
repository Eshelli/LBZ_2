import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:lbz/Logics/app_logic/app_controller.dart';
import 'package:lbz/commen_models/errors_models.dart';
import 'package:lbz/shared/components/constans.dart';
import '../../../all_controllers.dart';

class DioHelper {
  static late Dio dio;
  late MessageError msg;
  var allController = Get.find<ALlControllers>();

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.libozzle.ly/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
      options: Options(
        validateStatus: (status) {
          if (status != null) {
            print(status);
            allController.stateIs.value = status;
          }
          return status! < 500;
        },

        headers: {
          Headers.contentTypeHeader: "application/json",
          Headers.acceptHeader: "application/json",
          "Authorization": "Bearer ${token.toString()}",
          "X-Localization": lang
        },
      ),
    ).catchError((onError) {
      print(onError);
      print(allController.stateIs.value);
      // if (onError is DioError) {
      //   allController.stateIs.value = 0;
      //   print(allController.stateIs.value);
      // }
    });
  }

  Future<Response> putData({required String url,
    dynamic data,
    dynamic query,
  }) async {
    return dio.put(
        url,
        data: data,
        queryParameters: query,
        options: Options(
          validateStatus: (status) {
            if (status != null) {
              allController.stateIs.value = status;
            }
            return status! < 500;
          },
          headers: {
            Headers.contentTypeHeader: "application/json",
            Headers.acceptHeader: "application/json",
            "Authorization": "Bearer ${token.toString()}",
            "X-Localization": lang
          },
        )
    ).catchError((onError) {
      if (onError is DioError) {
        allController.stateIs.value = 0;
      }
    });
  }

  Future<Response> postData({required String url,
    dynamic data,Map<String, dynamic>? query}) async {
    return dio.post(
        url,
        data: data,
        queryParameters: query,
        options: Options(
          validateStatus: (status) {
            if (status != null) {
              allController.stateIs.value = status;
            }
            return status! < 500;
          },
          headers: {
            Headers.contentTypeHeader: "application/json",
            Headers.acceptHeader: "application/json",
            "Authorization": "Bearer ${token.toString()}",
            "X-Localization": lang
          },
        )
    );
    }

        Future<Response> deleteData(
        {
        required String url,
        Map<String, dynamic>? query,
        })
    async{
      return await dio.delete(
        url,
        queryParameters: query,
        options: Options(
          validateStatus: (status) {
            if (status != null) {
              allController.stateIs.value = status;
            }
            return status! < 500;
          },
          headers: {
            Headers.contentTypeHeader: "application/json",
            Headers.acceptHeader: "application/json",
            "Authorization": "Bearer ${token.toString()}",
            "X-Localization": lang
          },
        ),
      );
    }
  }
