import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/pages/common_webview_page.dart';
import 'package:labo_flutter/pages/sign_up/sign_up_page_notifier.dart';
import 'package:labo_flutter/providers/user_change_notifier_provider.dart';
import 'package:labo_flutter/utils/app_colors.dart';

class SignUpPage extends HookConsumerWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(signUpPageNotifierProvider);
    final _userNotifier = ref.watch(userChangeNotifierProvider);
    final email =
        ref.watch(signUpPageNotifierProvider.select((value) => value.email));
    final emailFocusNode = useFocusNode();
    final password =
        ref.watch(signUpPageNotifierProvider.select((value) => value.password));
    final shouldShowPassword = ref.watch(
        signUpPageNotifierProvider.select((value) => value.shouldShowPassword));
    final passwordFocusNode = useFocusNode();
    final message =
        ref.watch(signUpPageNotifierProvider.select((value) => value.message));

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
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await EasyLoading.show(
                                maskType: EasyLoadingMaskType.black);
                            await pageNotifier.signUpAndRefreshToken(
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
                                pageNotifier.setMessage(errorMessage);
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
                                  settings: const RouteSettings(
                                      name: 'CommonWebviewPage'),
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
                                  settings: const RouteSettings(
                                      name: 'CommonWebviewPage'),
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
