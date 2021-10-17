import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/pages/common_webview_page.dart';
import 'package:labo_flutter/pages/sign_up/sign_up_page_notifier.dart';
import 'package:labo_flutter/providers/user_change_notifier_provider.dart';
import 'package:labo_flutter/utils/app_colors.dart';

class SignUpPage extends HookConsumerWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpPageNotifier = ref.watch(signUpPageNotifierProvider);
    final _userNotifier = ref.watch(userChangeNotifierProvider);
    final _formKey = GlobalKey<FormState>();
    final _passwordFocusNode = FocusNode();

    return Scaffold(
      appBar: AppBar(
        title: const Text('新規登録'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: signUpPageNotifier.email,
                    style: TextStyle(
                      color: AppColors().textPrimary,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'メールアドレス',
                      hintText: 'メールアドレスを入力してください',
                    ),
                    validator: signUpPageNotifier.emptyValidator,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_passwordFocusNode); // 変更
                    },
                    onSaved: (value) {
                      signUpPageNotifier.email = value ?? '';
                    },
                  ),
                  TextFormField(
                    initialValue: signUpPageNotifier.password,
                    focusNode: _passwordFocusNode,
                    obscureText: !signUpPageNotifier.shouldShowPassword,
                    style: TextStyle(
                      color: AppColors().textPrimary,
                    ),
                    decoration: InputDecoration(
                      labelText: 'パスワード',
                      hintText: 'パスワードを入力してください',
                      suffixIcon: IconButton(
                        icon: Icon(signUpPageNotifier.shouldShowPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: signUpPageNotifier.togglePasswordVisible,
                      ),
                    ),
                    validator: signUpPageNotifier.emptyValidator,
                    onSaved: (value) {
                      signUpPageNotifier.password = value ?? '';
                    },
                  ),
                  Container(
                    // エラー文言表示エリア
                    margin: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                    child: Text(
                      signUpPageNotifier.message,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            await EasyLoading.show(
                                maskType: EasyLoadingMaskType.black);
                            await signUpPageNotifier.signUpAndRefreshToken(
                              onSuccess: () async {
                                await EasyLoading.dismiss();
                                _userNotifier.refreshCurrentUser();
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('新規登録しました'),
                                  ),
                                );
                              },
                              onError: (errorMessage) async {
                                await EasyLoading.dismiss();
                                signUpPageNotifier.setMessage(errorMessage);
                              },
                            );
                          }
                        },
                        child: const Text('新規登録'),
                      ),
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: '新規登録ボタンをタップすると、',
                      style: TextStyle(color: AppColors().textPrimary),
                      children: [
                        TextSpan(
                          text: '利用規約',
                          style: const TextStyle(
                            color: AppColors.primary,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<String?>(
                                  builder: (context) => const CommonWebviewPage(
                                    title: '利用規約',
                                    url:
                                        'https://policies.google.com/terms?hl=ja&fg=1',
                                  ),
                                  fullscreenDialog: true,
                                ),
                              );
                            },
                        ),
                        const TextSpan(text: 'および'),
                        TextSpan(
                          text: 'プライバシーポリシー',
                          style: const TextStyle(
                            color: AppColors.primary,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<String?>(
                                  builder: (context) => const CommonWebviewPage(
                                    title: 'プライバシーポリシー',
                                    url:
                                        'https://policies.google.com/privacy?hl=ja&fg=1',
                                  ),
                                  fullscreenDialog: true,
                                ),
                              );
                            },
                        ),
                        const TextSpan(text: 'に同意したものとみなします'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
