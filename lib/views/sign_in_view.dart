import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/utils/app_colors.dart';

final _loginModelProvider =
    ChangeNotifierProvider.autoDispose((ref) => _LoginModel());

class _LoginModel extends ChangeNotifier {
  _LoginModel();

  String email = '';
  String password = '';
  String message = '';
  bool shouldShowPassword = false;

  void setMessage(String value) {
    //エラーメッセージ設定
    message = value;
    notifyListeners();
  }

  void togglePasswordVisible() {
    shouldShowPassword = !shouldShowPassword;
    notifyListeners();
  }

  String? emptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '入力してください';
    }
    return null;
  }

  Future<String?> signinWithEmailAndPassword() async {
    String? errorMessage;
    try {
      final _ = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, // ken@example.com
          password: password); // test1234
      return errorMessage;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else {
        errorMessage = '$e';
      }
      return errorMessage;
    }
  }
}

class SignInView extends HookWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginModel = useProvider(_loginModelProvider);
    final _formKey = GlobalKey<FormState>();
    final _passwordFocusNode = FocusNode();

    return Scaffold(
      appBar: AppBar(
        title: const Text('サインイン'),
      ),
      body: Center(
          child: Container(
        padding: const EdgeInsets.all(24),
        child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              TextFormField(
                initialValue: loginModel.email,
                style: TextStyle(
                  color: AppColors().textPrimary,
                ),
                decoration: const InputDecoration(
                  labelText: 'メールアドレス',
                  hintText: 'メールアドレスを入力してください',
                ),
                validator: loginModel.emptyValidator,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_passwordFocusNode); // 変更
                },
                onSaved: (value) {
                  context.read(_loginModelProvider).email = value ?? '';
                },
              ),
              TextFormField(
                initialValue: loginModel.password,
                focusNode: _passwordFocusNode,
                obscureText: !loginModel.shouldShowPassword,
                style: TextStyle(
                  color: AppColors().textPrimary,
                ),
                decoration: InputDecoration(
                  labelText: 'パスワード',
                  hintText: 'パスワードを入力してください',
                  suffixIcon: IconButton(
                    icon: Icon(loginModel.shouldShowPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: loginModel.togglePasswordVisible,
                  ),
                ),
                validator: loginModel.emptyValidator,
                onSaved: (value) {
                  context.read(_loginModelProvider).password = value ?? '';
                },
              ),
              Container(
                // エラー文言表示エリア
                margin: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                child: Text(
                  loginModel.message,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
              ),
              Container(
                  width: double.infinity,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            final errorMessage =
                                await loginModel.signinWithEmailAndPassword();

                            if (errorMessage == null) {
                              // ログインに成功した場合
                              Navigator.of(context).pop();
                            } else {
                              loginModel.setMessage(errorMessage);
                            }
                          }
                        },
                        child: const Text('ログイン'),
                      )))
            ])),
      )),
    );
  }
}
