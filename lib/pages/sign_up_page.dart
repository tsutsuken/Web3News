import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labo_flutter/pages/common_webview_page.dart';
import 'package:labo_flutter/providers/user_change_notifier_provider.dart';
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

  Future<void> signUpAndRefreshToken({
    required VoidCallback onSuccess,
    required Function(String errorMessage) onError,
  }) async {
    debugPrint('signUpAndRefreshToken');
    final errorMessage = await _signUp();
    if (errorMessage != null) {
      onError(errorMessage);
    }

    _waitTokenRefresh(
      onSuccess: () {
        onSuccess();
      },
      onError: () {
        onError('トークンの取得に失敗しました');
      },
    );
  }

  Future<String?> _signUp() async {
    debugPrint('_signUp');
    String? errorMessage;
    try {
      final _ = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return errorMessage;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorMessage = '推測されにくいパスワードを設定してください';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'このメールアドレスで作成されたアカウントがすでに存在します';
      }
      return errorMessage;
    }
  }

  void _waitTokenRefresh({
    required VoidCallback onSuccess,
    required VoidCallback onError,
  }) {
    debugPrint('_waitTokenRefresh');
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      onError();
    }

    // （Firebase Functionsでセットされる）トリガーを監視して、CustomClaimの反映を待ち、トークンを更新する
    final triggerRef =
        FirebaseFirestore.instance.collection('user_meta').doc(userId);
    triggerRef.snapshots().listen((documentSnapshot) {
      if (documentSnapshot.exists) {
        debugPrint('refresh idToken by trigger');
        // トークンを強制更新する
        FirebaseAuth.instance.currentUser?.getIdToken(true);
        onSuccess();
      } else {
        debugPrint('trigger not exists');
      }
    });
  }
}

class SignUpPage extends HookConsumerWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpModel = ref.watch(_signUpModelProvider);
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
                      FocusScope.of(context)
                          .requestFocus(_passwordFocusNode); // 変更
                    },
                    onSaved: (value) {
                      ref.read(_signUpModelProvider).email = value ?? '';
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
                      ref.read(_signUpModelProvider).password = value ?? '';
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
                            await signUpModel.signUpAndRefreshToken(
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
                                signUpModel.setMessage(errorMessage);
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
