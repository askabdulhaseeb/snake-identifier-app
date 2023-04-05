import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../database/snake_api.dart';
import '../../enum/venomous_type.dart';
import '../../models/snake.dart';
import '../../providers/snake_provider.dart';
import '../../utilities/custom_validator.dart';
import '../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../widgets/custom_widgets/custom_file_image_box.dart';
import '../../widgets/custom_widgets/custom_title_textformfield.dart';
import '../../widgets/custom_widgets/custom_toast.dart';
import '../../widgets/custom_widgets/show_loading.dart';
import '../../widgets/custom_widgets/text_tag_widget.dart';

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

  File? file;

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
      appBar: AppBar(title: const Text('Add')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: key,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                CustomFileImageBox(
                  file: file,
                  onTap: () => onImagePick(),
                ),
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
                        title: 'Add Snake',
                        onTap: () async {
                          if (!key.currentState!.validate()) return;
                          if (file == null) {
                            CustomToast.errorToast(message: 'Select Photo');
                            setState(() {
                              _isLoading = false;
                            });
                            return;
                          }
                          setState(() {
                            _isLoading = true;
                          });
                          final String? url =
                              await SnakeAPI().uploadPhoto(file: file!);
                          if (file == null) {
                            CustomToast.errorToast(
                                message: 'Photo Upload issue');
                            setState(() {
                              _isLoading = false;
                            });
                            return;
                          }
                          final Snake snake = Snake(
                            name: _name.text.trim(),
                            scientificName: _scientificName.text.trim(),
                            imageURL: <String>[url!],
                            averageLengthCM:
                                double.tryParse(_length.text.trim()) ?? 0.0,
                            tags: tags,
                            level: level,
                            properties: properties,
                          );
                          await SnakeAPI().add(snake);
                          // ignore: use_build_context_synchronously
                          Provider.of<SnakeProvider>(context, listen: false)
                              .refresh();
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        },
                      ),
                SizedBox(height: MediaQuery.of(context).size.height / 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onImagePick() async {
    final bool isGranted = await _request();
    if (!isGranted) return null;
    final FilePickerResult? temp = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);
    if (temp == null) return;
    setState(() {
      file = File(temp.paths.first!);
    });
  }

  Future<bool> _request() async {
    await <Permission>[Permission.photos].request();
    final PermissionStatus status1 = await Permission.photos.status;
    return status1.isGranted;
  }
}
