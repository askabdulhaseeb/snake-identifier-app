import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/auth_methods.dart';
import '../../database/snake_api.dart';
import '../../enum/venomous_type.dart';
import '../../models/edit_history.dart';
import '../../models/snake.dart';
import '../../providers/snake_provider.dart';
import '../../utilities/custom_validator.dart';
import '../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../widgets/custom_widgets/custom_title_textformfield.dart';
import '../../widgets/custom_widgets/show_loading.dart';
import '../../widgets/custom_widgets/text_tag_widget.dart';
import '../main_screen/main_screen.dart';

class EditSnakeScreen extends StatefulWidget {
  const EditSnakeScreen({required this.snake, Key? key}) : super(key: key);
  final Snake snake;

  @override
  State<EditSnakeScreen> createState() => _EditSnakeScreenState();
}

class _EditSnakeScreenState extends State<EditSnakeScreen> {
  late TextEditingController _name;
  late TextEditingController _scientificName;
  late TextEditingController _length;
  final TextEditingController _tag = TextEditingController();
  final TextEditingController _property = TextEditingController();
  late List<String> tags;
  late List<String> properties;
  VenomousLevel level = VenomousLevel.dangerouslyVenomous;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.snake.name);
    _scientificName = TextEditingController(text: widget.snake.scientificName);
    _length =
        TextEditingController(text: widget.snake.averageLengthCM.toString());
    tags = widget.snake.tags;
    properties = widget.snake.properties;
    level = widget.snake.level;
  }

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  List<VenomousLevel> venomous = <VenomousLevel>[
    VenomousLevel.dangerouslyVenomous,
    VenomousLevel.mildlyVenomous,
    VenomousLevel.cautionVenomous,
    VenomousLevel.venomous,
    VenomousLevel.nonVenomous,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Snake')),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: key,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 8),
                        const Text(
                          'Venomous Level',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Tap to switch the Venomous Level',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          alignment: WrapAlignment.start,
                          children: venomous
                              .map((VenomousLevel e) => GestureDetector(
                                    onTap: () => setState(() {
                                      level = e;
                                    }),
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      margin: const EdgeInsets.only(
                                          right: 8, bottom: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: e == level
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey.shade300,
                                        ),
                                      ),
                                      child: Text(
                                        e.title,
                                        style: TextStyle(color: e.color),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
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
                      onPressed: () {
                        if (_tag.text.trim().isEmpty) return;
                        tags.add(_tag.text.trim());
                        _tag.clear();
                        setState(() {});
                      },
                      icon: const Icon(Icons.done),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    children: tags
                        .map((String e) => TextTagWidget(
                              text: e,
                              onDelete: () => setState(() {
                                tags.removeWhere(
                                    (String element) => element == e);
                              }),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: CustomTitleTextFormField(
                        controller: _property,
                        title: 'Property',
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (_property.text.trim().isEmpty) return;
                        properties.add(_property.text.trim());
                        _property.clear();
                        setState(() {});
                      },
                      icon: const Icon(Icons.done),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    children: properties
                        .map((String e) => TextTagWidget(
                              text: e,
                              onDelete: () => setState(() {
                                properties.removeWhere(
                                    (String element) => element == e);
                              }),
                            ))
                        .toList(),
                  ),
                ),
                _isLoading
                    ? const ShowLoading()
                    : CustomElevatedButton(
                        title: 'Update Snake',
                        onTap: () async {
                          if (!key.currentState!.validate()) return;
                          setState(() {
                            _isLoading = true;
                          });
                          widget.snake.name = _name.text.trim();
                          widget.snake.scientificName =
                              _scientificName.text.trim();
                          widget.snake.averageLengthCM =
                              double.parse(_length.text.trim());
                          widget.snake.level = level;
                          widget.snake.tags = tags;
                          widget.snake.properties = properties;
                          widget.snake.history.add(EditHistory());
                          await SnakeAPI().updateSnake(widget.snake);
                          // ignore: use_build_context_synchronously
                          Provider.of<SnakeProvider>(context, listen: false)
                              .refresh();
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              MainScreen.routeName,
                              (Route<dynamic> route) => false);
                        },
                      ),
                SizedBox(height: MediaQuery.of(context).size.height / 2)
              ],
            ),
          ),
        ),
      ),
    );
  }
}