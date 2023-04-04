import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utilities/custom_validator.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    required TextEditingController controller,
    this.textInputAction = TextInputAction.done,
    Key? key,
  })  : _controller = controller,
        super(key: key);
  final TextEditingController _controller;
  final TextInputAction? textInputAction;
  @override
  PasswordTextFormFieldState createState() => PasswordTextFormFieldState();
}

class PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _notVisible = true;
  void _onListener() => setState(() {});
  @override
  void initState() {
    widget._controller.addListener(_onListener);
    super.initState();
  }

  @override
  void dispose() {
    widget._controller.removeListener(_onListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextFormField(
        controller: widget._controller,
        obscureText: _notVisible,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: widget.textInputAction,
        cursorColor: Theme.of(context).colorScheme.secondary,
        validator: (String? value) => CustomValidator.password(value),
        decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey.shade400),
          suffixIcon: IconButton(
            onPressed: () => setState(() {
              _notVisible = !_notVisible;
            }),
            splashRadius: 16,
            icon: (_notVisible == true)
                ? const Icon(CupertinoIcons.eye)
                : const Icon(CupertinoIcons.eye_slash),
          ),
          focusColor: Theme.of(context).primaryColor,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
