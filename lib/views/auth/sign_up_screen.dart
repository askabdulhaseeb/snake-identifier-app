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

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  static const String routeName = '/signup';

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
                          'Australian snake identification',
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
                        'Australian snake identification helps you sell the stuff you want to the people you want.',
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
                            key: mailAuthPro.registerKey,
                            child: Column(
                              children: <Widget>[
                                CustomTextFormField(
                                  controller: mailAuthPro.name,
                                  hint: 'Full Name',
                                  autoFocus: true,
                                  keyboardType: TextInputType.name,
                                  validator: (String? value) =>
                                      CustomValidator.isEmpty(value),
                                ),
                                CustomTextFormField(
                                  controller: mailAuthPro.email,
                                  hint: 'Email Address',
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (String? value) =>
                                      CustomValidator.email(value),
                                ),
                                PasswordTextFormField(
                                    controller: mailAuthPro.password),
                                mailAuthPro.isLoading
                                    ? const ShowLoading()
                                    : CustomElevatedButton(
                                        title: 'Sign Up'.toUpperCase(),
                                        onTap: () =>
                                            mailAuthPro.register(context),
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
                            const TextSpan(
                                text: '''Already have an account? '''),
                            TextSpan(
                                text: 'Sign In',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.of(context).pop()),
                          ],
                        ),
                      ),
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
