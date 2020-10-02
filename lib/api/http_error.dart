import 'package:auto_route/auto_route.dart';
import 'package:colleage/state/global.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ErrorInterceptors extends Interceptor {
  @override
  Future onError(DioError err) async {
    print("error");
    print(err.message);
    if (err.response?.statusCode == 422) throw InvaildData();
        if (err.response?.statusCode == 403) throw EmailExist();
    return super.onError(err);
  }

  @override
  Future onResponse(Response response) {
    // TODO: implement onResponse
    // print("response");
    // print(response.data);
    return super.onResponse(response);
  }

  @override
  Future onRequest(RequestOptions options) {
   if( options.extra["hastoken"] == true){
     options.headers["Authorization"] = "bearer ${Global().me.token}";
   }
    // TODO: implement onRequest
    print("onRequest1");
    return super.onRequest(options);
  }
}

class InvaildData with ToArabicStringError implements Exception {

  String toArabicStringError() {
    return "الرجاء التاكد من معلومات المدخلة";
  }
}
class EmailExist with ToArabicStringError implements Exception {

  String toArabicStringError() {
    return "ايميل مستخدم";
  }
}

mixin ToArabicStringError {
  String toArabicStringError();
}
Future showErrorToArabicStringError(ToArabicStringError error, BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("يوجد خطا ما"),
            content: Text(error.toArabicStringError()),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    ExtendedNavigator.of(context).pop();
                  },
                  child: Text("اغلاق"))
            ],
          ));
}
