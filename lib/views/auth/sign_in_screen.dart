// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utilities/custom_validator.dart';
import '../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../widgets/custom_widgets/custom_shadow_bg_widget.dart';
import '../../../widgets/custom_widgets/custom_textformfield.dart';
import '../../../widgets/custom_widgets/password_textformfield.dart';
import '../../../widgets/custom_widgets/show_loading.dart';
import '../../providers/mail_auth_provider.dart';
import '../main_screen/main_screen.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  static const String routeName = '/signin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 100),
                    SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: FittedBox(
                        child: Text(
                          'EcoHerp',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'EcoHerp helps you to identifier different types of snakes and also can compare them',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                     CustomShadowBgWidget(
                      child: Consumer<MailAuthProvider>(
                        builder: (
                          BuildContext context,
                          MailAuthProvider mailAuthPro,
                          _,
                        ) {
                          return Form(
                            key: mailAuthPro.loginKey,
                            child: Column(
                              children: <Widget>[
                                CustomTextFormField(
                                  controller: mailAuthPro.email,
                                  hint: 'Email Address',
                                  autoFocus: true,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (String? value) =>
                                      CustomValidator.email(value),
                                ),
                                PasswordTextFormField(
                                    controller: mailAuthPro.password),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      // TODO: Forget password
                                    },
                                    child: const Text(
                                      'Forget Password?',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                                mailAuthPro.isLoading
                                    ? const ShowLoading()
                                    : CustomElevatedButton(
                                        title: 'Sign In'.toUpperCase(),
                                        onTap: () =>
                                            mailAuthPro.onLogin(context),
                                      ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall,
                          children: <TextSpan>[
                            const TextSpan(text: '''Don't have an account? '''),
                            TextSpan(
                              text: 'Register Now',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context)
                                    .pushNamed(SignUpScreen.routeName),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomElevatedButton(
                      title: 'Skip Login for now',
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(MainScreen.routeName);
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
