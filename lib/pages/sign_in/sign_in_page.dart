import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/pages/sign_in/sign_in_page_notifier.dart';
import 'package:labo_flutter/utils/app_colors.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(signInPageNotifierProvider);
    final _formKey = GlobalKey<FormState>();
    final _passwordFocusNode = FocusNode();

    return Scaffold(
      appBar: AppBar(
        title: const Text('サインイン'),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Container(
          padding: const EdgeInsets.all(24),
          child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                TextFormField(
                  initialValue: pageNotifier.email,
                  style: TextStyle(
                    color: AppColors().textPrimary,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'メールアドレス',
                    hintText: 'メールアドレスを入力してください',
                  ),
                  validator: pageNotifier.emptyValidator,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context)
                        .requestFocus(_passwordFocusNode); // 変更
                  },
                  onSaved: (value) {
                    pageNotifier.email = value ?? '';
                  },
                ),
                TextFormField(
                  initialValue: pageNotifier.password,
                  focusNode: _passwordFocusNode,
                  obscureText: !pageNotifier.shouldShowPassword,
                  style: TextStyle(
                    color: AppColors().textPrimary,
                  ),
                  decoration: InputDecoration(
                    labelText: 'パスワード',
                    hintText: 'パスワードを入力してください',
                    suffixIcon: IconButton(
                      icon: Icon(pageNotifier.shouldShowPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: pageNotifier.togglePasswordVisible,
                    ),
                  ),
                  validator: pageNotifier.emptyValidator,
                  onSaved: (value) {
                    pageNotifier.password = value ?? '';
                  },
                ),
                Container(
                  // エラー文言表示エリア
                  margin: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                  child: Text(
                    pageNotifier.message,
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
                              final errorMessage = await pageNotifier
                                  .signinWithEmailAndPassword();

                              if (errorMessage == null) {
                                // ログインに成功した場合
                                const didLogin = true;
                                Navigator.of(context).pop<bool>(didLogin);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('ログインしました'),
                                  ),
                                );
                              } else {
                                pageNotifier.setMessage(errorMessage);
                              }
                            }
                          },
                          child: const Text('ログイン'),
                        )))
              ])),
        )),
      ),
    );
  }
}
