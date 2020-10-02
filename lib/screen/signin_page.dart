import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:colleage/api/department.dart';
import 'package:colleage/api/http_error.dart';
import 'package:colleage/service/auth_service.dart';
import 'package:colleage/shared/stage.dart';
import 'package:colleage/shared/theme.dart';
import 'package:colleage/shared/user_enum.dart';
import 'package:colleage/state/signin.dart';
import 'package:colleage/widget/AnimatedHideShow.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animations/loading_animations.dart';
import '../shared/routes.gr.dart';

class SigninPage extends StatefulWidget {
  final SigninState state;

  const SigninPage({Key key, this.state}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();
  final _emailFocuse = FocusNode();
  final _nameFocuse = FocusNode();
  final _passwordFocuse = FocusNode();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailformKey = GlobalKey<FormFieldState>();
  final _nameformKey = GlobalKey<FormFieldState>();
  final _passformKey = GlobalKey<FormFieldState>();
  final borderRadius25 = BorderRadius.circular(25.0);
  @override
  void dispose() {
    // TODO: implement dispose
    _emailFocuse.dispose();
    _passwordFocuse.dispose();
    _nameFocuse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                FlutterLogo(size: 80, colors: ThemeConfig.mainColors),
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
                  focusNode: _nameFocuse,
                  textDirection: TextDirection.ltr,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "الاسم كامل",
                    border: OutlineInputBorder(
                      borderRadius: borderRadius25,
                    ),
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "هذا حقل مطلوب";
                    }
                    return null;
                  },
                  onFieldSubmitted: (email) {
                    if (_nameformKey.currentState.validate()) {
                      _nameFocuse.unfocus();
                      _emailFocuse.requestFocus();
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  key: _nameformKey,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  focusNode: _emailFocuse,
                  textDirection: TextDirection.ltr,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: "الايميل",
                    border: OutlineInputBorder(
                      borderRadius: borderRadius25,
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
                  key: _emailformKey,
                ),
                SizedBox(
                  height: 20,
                ),
                StatefulBuilder(
                  builder: (context, StateSetter setState) => TextFormField(
                    key: _passformKey,
                    focusNode: _passwordFocuse,
                    onFieldSubmitted: (email) {
                      if (_passformKey.currentState.validate())
                        _passwordFocuse.unfocus();
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
                        borderRadius: borderRadius25,
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
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Observer(builder: (_) {
                  return Card(
                    // shape: RoundedRectangleBorder(),
                    //   color: Colors.white,
                    child: Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                            canvasColor: Theme.of(context).primaryColor),
                        child: DropdownButtonFormField(
                            style: TextStyle(color: Colors.white),
                            validator: (dep) {
                              if (dep == null)
                                return widget.state.departments == null
                                    ? "الرجاء انتضار تحميل اقسام واختيار احدها"
                                    : "الرجاء اختيار قسم";
                              return null;
                            },
                            isExpanded: true,
                            hint: widget.state.departments == null
                                ? Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Text(
                                        "اختر قسمك",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                      LoadingFlipping.square(
                                        borderColor: Colors.white,
                                      )
                                    ],
                                  )
                                : AutoSizeText(
                                    "اختر قسمك",
                                    style: TextStyle(color: Colors.white),
                                  ),
                            iconEnabledColor: Colors.white,
                            items: widget.state.departments
                                ?.map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                        e.name,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ))
                                ?.toList(),
                            onChanged: (val) {
                              widget.state.department = val;
                            }),
                      ),
                    ),
                  );
                }),
                Observer(builder: (_) {
                  return Card(
                    child: Row(
                      children: [
                        Expanded(child: buildRadioListTile(UserType.student)),
                        Expanded(child: buildRadioListTile(UserType.teacher)),
                      ],
                    ),
                  );
                }),
                Observer(
                  builder: (context) => AnimatedHideShow(
                    isShow: widget.state.typeChecked == UserType.student,
                    firstBuilder: (context) => Card(
                      child: Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: DropdownButton<int>(
                            dropdownColor: ThemeConfig.mainColors,
                            isExpanded: true,
                            focusColor: ThemeConfig.mainColors,
                            hint: Text("اختر مرحلتك",
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                            value: widget.state.stage,
                            items: List.generate(
                                4,
                                (i) => DropdownMenuItem(
                                    value: i + 1,
                                    child: Text(
                                      intToStageString(i + 1),
                                      style: TextStyle(color: Colors.white),
                                    ))),
                            onChanged: (val) {
                              setState(() {
                                widget.state.stage = val;
                              });
                            }),
                      ),
                    ),
                  ),
                ),
                Observer(builder: (_) {
                  return Row(
                    children: <Widget>[
                      FlatButton.icon(
                          onPressed: () async {
                            final picker = ImagePicker();

                            final pickedFile = await picker.getImage(
                                source: ImageSource.gallery);
                            widget.state.avatar = pickedFile;
                          },
                          icon: Icon(Icons.file_upload),
                          label: Text("اختيار صوره")),
                      if (widget.state.avatar != null)
                        Image.file(
                          File(widget.state.avatar.path),
                          height: 50,
                          width: 50,
                        )
                    ],
                  );
                }),
                Container(
                  width: double.maxFinite,
                  child: FlatButton(
                      color: ThemeConfig.mainColors,
                      shape:
                          RoundedRectangleBorder(borderRadius: borderRadius25),
                      onPressed: () {
                        if (!_formKey.currentState.validate() ||
                            widget.state.typeChecked == null ||
                            widget.state.avatar == null ||
                            (widget.state.typeChecked == UserType.student &&
                                widget.state.stage == null))
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(content: Text("الرجاء ملء حقول اعلاه")));
                        else {
                          _scaffoldKey.currentState
                              .showSnackBar(SnackBar(content: Text("بدء")));
                          final Future callAuth = widget.state.register(
                            _nameformKey.currentState.value,
                            _emailformKey.currentState.value,
                            _passformKey.currentState.value,
                          );

                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (contextalert) {
                                callAuth.then((value) {
                                  ExtendedNavigator.of(contextalert).pop();
                                  ExtendedNavigator.of(context)
                                      .pushNamedAndRemoveUntil(
                                          Routes.home, (route) => false);
                                }).catchError((error) {
                                  if (error is DioError &&
                                      error.error is ToArabicStringError) {
                                    ExtendedNavigator.of(context).pop();
                                    showErrorToArabicStringError(
                                        error.error, context);
                                  } else {
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
                        "تسجيل حساب جديد",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Text("لديك حساب , سجل دخول",
                      style: TextStyle(fontSize: 16)),
                  onTap: () {
                    ExtendedNavigator.of(context).pushLogin();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRadioListTile(UserType type) {
    return Card(
      color: Colors.white,
      child: RadioListTile(
        value: type,

        groupValue: widget.state.typeChecked,
        onChanged: widget.state.checkType,
        //  activeColor: Colors.white,

        title: Text(
          type.toArString(),
        ),
      ),
    );
  }
}
