import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/utils/app_colors.dart';

final _signUpModelProvider =
    ChangeNotifierProvider.autoDispose((ref) => _SignUpModel());

class _SignUpModel extends ChangeNotifier {
  _SignUpModel();

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

  Future<String?> signUp() async {
    String? errorMessage;
    try {
      final _ = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return errorMessage;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }
      return errorMessage;
    }
  }
}

class SignUpView extends HookWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpModel = useProvider(_signUpModelProvider);
    final _formKey = GlobalKey<FormState>();
    final _passwordFocusNode = FocusNode();

    return Scaffold(
      appBar: AppBar(
        title: const Text('新規登録'),
      ),
      body: Center(
          child: Container(
        padding: const EdgeInsets.all(24),
        child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              TextFormField(
                initialValue: signUpModel.email,
                style: TextStyle(
                  color: AppColors().textPrimary,
                ),
                decoration: const InputDecoration(
                  labelText: 'メールアドレス',
                  hintText: 'メールアドレスを入力してください',
                ),
                validator: signUpModel.emptyValidator,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_passwordFocusNode); // 変更
                },
                onSaved: (value) {
                  context.read(_signUpModelProvider).email = value ?? '';
                },
              ),
              TextFormField(
                initialValue: signUpModel.password,
                focusNode: _passwordFocusNode,
                obscureText: !signUpModel.shouldShowPassword,
                style: TextStyle(
                  color: AppColors().textPrimary,
                ),
                decoration: InputDecoration(
                  labelText: 'パスワード',
                  hintText: 'パスワードを入力してください',
                  suffixIcon: IconButton(
                    icon: Icon(signUpModel.shouldShowPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: signUpModel.togglePasswordVisible,
                  ),
                ),
                validator: signUpModel.emptyValidator,
                onSaved: (value) {
                  context.read(_signUpModelProvider).password = value ?? '';
                },
              ),
              Container(
                // エラー文言表示エリア
                margin: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                child: Text(
                  signUpModel.message,
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
                            final errorMessage = await signUpModel.signUp();
                            if (errorMessage == null) {
                              // 成功した場合
                              const didSignUp = true;
                              Navigator.of(context).pop(didSignUp);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('新規登録しました'),
                                ),
                              );
                            } else {
                              signUpModel.setMessage(errorMessage);
                            }
                          }
                        },
                        child: const Text('新規登録'),
                      )))
            ])),
      )),
    );
  }
}
