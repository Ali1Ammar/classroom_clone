import 'package:auto_route/auto_route.dart';
import 'package:colleage/api/http_error.dart';
import 'package:colleage/modal/user.dart';
import 'package:colleage/service/auth_service.dart';
import 'package:colleage/shared/pref.dart';
import 'package:colleage/shared/theme.dart';
import 'package:colleage/shared/user_enum.dart';
import 'package:colleage/state/global.dart';
import 'package:colleage/state/signin.dart';
import 'package:colleage/widget/clip_wave.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:loading_animations/loading_animations.dart';
import '../shared/routes.gr.dart';

class LoginPage extends StatefulWidget {
  //final LoginState state;

  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();
  final _emailformKey = GlobalKey<FormFieldState>();

  final _passformKey = GlobalKey<FormFieldState>();

  final _emailFocuse = FocusNode();
  final _passwordFocuse = FocusNode();
  // final _emailCont = TextEditingController();
  // final _passwordCont = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    // TODO: implement dispose
    _emailFocuse.dispose();
    _passwordFocuse.dispose();
    // _emailCont.dispose();
    // _passwordCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // floatingActionButton: FloatingActionButton(onPressed: () async {
      // //  print( await SharedPerf.getUser() );
      // SharedPerf.clearUser();
      // },),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,

            //  autovalidate: true,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                FlutterLogo(size: 140, colors: ThemeConfig.mainColors),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "جامعتي",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  key: _emailformKey,
                  focusNode: _emailFocuse,
                  textDirection: TextDirection.ltr,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: "الايميل",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "هذا حقل مطلوب";
                    }
                    if (!EmailValidator.validate(val)) {
                      return "الرجاء ادخال ايميل صحيح";
                    }
                    return null;
                  },
                  onFieldSubmitted: (email) {
                    if (_emailformKey.currentState.validate()) {
                      _emailFocuse.unfocus();
                      _passwordFocuse.requestFocus();
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 20,
                ),
                StatefulBuilder(
                  builder: (context, StateSetter setState) => TextFormField(
                    focusNode: _passwordFocuse,
                    key: _passformKey,
                    onFieldSubmitted: (password) {
                      if (_passformKey.currentState.validate()) {
                        _passwordFocuse.unfocus();
                      }
                    },
                    textDirection: TextDirection.ltr,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: Icon(_obscureText ? Icons.lock : Icons.lock_open),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      labelText: "كلمة السر",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    validator: (val) {
                      if (val.length < 6) {
                        return "يجب ان يحوي 6 حروف على اقل";
                      } else {
                        return null;
                      }
                    },
                    obscureText: _obscureText,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.maxFinite,
                  child: FlatButton(
                      color: ThemeConfig.mainColors,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        if (!_formKey.currentState.validate())
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(content: Text("الرجاء ملء حقول اعلاه")));
                        else {
                          _scaffoldKey.currentState
                              .showSnackBar(SnackBar(content: Text("بدء")));
                          final Future<User> callAuth = Auth.login(
                              _emailformKey.currentState.value,
                              _passformKey.currentState.value);

                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (contextnew) {
                                callAuth.then((value) {
                                  print(value.toJson());
                                  print("This user from login page");
                                  ExtendedNavigator.of(contextnew).pop();
                                  ExtendedNavigator.of(context)
                                      .pushNamedAndRemoveUntil(
                                          Routes.home, (route) => false);
                                }).catchError((error) {
                                  ExtendedNavigator.of(contextnew).pop();
                                  if (error is DioError &&
                                      error.error is ToArabicStringError) {
                                    showErrorToArabicStringError(
                                        error.error, context);
                                  } else {
                                    print(error);
                                  
                                    print(error.stackTrace);
                                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                                        content: Text(
                                            "حدث خطا ما الرجاء اعادة  محاولة")));
                                  }
                                });
                                return LoadingFlipping.square(
                                  size: 70,
                                  borderColor: ThemeConfig.mainColors,
                                );
                              });
                        }
                      },
                      child: Text(
                        "تسجيل دخول",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Text(
                    "لا تمتلك حساب , انشئ حساب جديد",
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    ExtendedNavigator.of(context)
                        .pushSignin(state: SigninState());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
