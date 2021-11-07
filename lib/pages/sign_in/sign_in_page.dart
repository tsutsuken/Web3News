import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/pages/sign_in/sign_in_page_notifier.dart';
import 'package:labo_flutter/utils/app_colors.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.read(signInPageNotifierProvider);
    final email =
        ref.watch(signInPageNotifierProvider.select((value) => value.email));
    final emailFocusNode = useFocusNode();
    final password =
        ref.watch(signInPageNotifierProvider.select((value) => value.password));
    final shouldShowPassword = ref.watch(
        signInPageNotifierProvider.select((value) => value.shouldShowPassword));
    final passwordFocusNode = useFocusNode();
    final message =
        ref.watch(signInPageNotifierProvider.select((value) => value.message));

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
                  initialValue: email,
                  focusNode: emailFocusNode,
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
                        .requestFocus(passwordFocusNode); // 変更
                  },
                  onChanged: (value) {
                    pageNotifier.setEmail(value);
                  },
                ),
                TextFormField(
                  initialValue: password,
                  focusNode: passwordFocusNode,
                  obscureText: !shouldShowPassword,
                  style: TextStyle(
                    color: AppColors().textPrimary,
                  ),
                  decoration: InputDecoration(
                    labelText: 'パスワード',
                    hintText: 'パスワードを入力してください',
                    suffixIcon: IconButton(
                      icon: Icon(shouldShowPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: pageNotifier.togglePasswordVisible,
                    ),
                  ),
                  validator: pageNotifier.emptyValidator,
                  onChanged: (value) {
                    pageNotifier.setPassword(value);
                  },
                ),
                Container(
                  // エラー文言表示エリア
                  margin: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                  child: Text(
                    message,
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
