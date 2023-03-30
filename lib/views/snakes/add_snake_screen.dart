import 'package:flutter/material.dart';

import '../../database/snake_api.dart';
import '../../enum/venomous_type.dart';
import '../../models/snake.dart';
import '../../utilities/custom_validator.dart';
import '../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../widgets/custom_widgets/custom_textformfield.dart';
import '../../widgets/custom_widgets/custom_title_textformfield.dart';
import '../../widgets/custom_widgets/show_loading.dart';

class AddSnakeScreen extends StatefulWidget {
  const AddSnakeScreen({super.key});
  static const String routeName = '/add-snake';

  @override
  State<AddSnakeScreen> createState() => _AddSnakeScreenState();
}

class _AddSnakeScreenState extends State<AddSnakeScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _scientificName = TextEditingController();
  final TextEditingController _length = TextEditingController();
  final TextEditingController _tag = TextEditingController();
  final TextEditingController _property = TextEditingController();
  VenomousLevel level = VenomousLevel.dangerouslyVenomous;
  bool _isLoading = false;

  final List<String> tags = <String>[];
  final List<String> properties = <String>[];

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: key,
            child: Column(
              children: <Widget>[
                CustomTitleTextFormField(
                  controller: _name,
                  title: 'Snake Name',
                  readOnly: _isLoading,
                  validator: (String? value) =>
                      CustomValidator.lessThen3(value),
                ),
                CustomTitleTextFormField(
                  controller: _scientificName,
                  title: 'Scientific Name',
                  readOnly: _isLoading,
                  validator: (String? value) =>
                      CustomValidator.lessThen3(value),
                ),
                CustomTitleTextFormField(
                  controller: _length,
                  title: 'Average Length in CM',
                  keyboardType: TextInputType.number,
                  readOnly: _isLoading,
                  validator: (String? value) => CustomValidator.isEmpty(value),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: CustomTitleTextFormField(
                        controller: _tag,
                        title: 'Tag',
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.done),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: CustomTitleTextFormField(
                        controller: _property,
                        title: 'Property',
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.done),
                    ),
                  ],
                ),
                _isLoading
                    ? const ShowLoading()
                    : CustomElevatedButton(
                        title: 'Add Snake',
                        onTap: () async {
                          if (!key.currentState!.validate()) return;
                          setState(() {
                            _isLoading = true;
                          });
                          final Snake snake = Snake(
                            name: _name.text.trim(),
                            scientificName: _scientificName.text.trim(),
                            imageURL: <String>[],
                            averageLengthCM:
                                double.tryParse(_length.text.trim()) ?? 0.0,
                            tags: tags,
                            level: level,
                            properties: properties,
                          );
                          await SnakeAPI().add(snake);
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
