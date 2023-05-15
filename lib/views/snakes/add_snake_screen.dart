import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../database/snake_api.dart';
import '../../enum/venomous_type.dart';
import '../../models/snake.dart';
import '../../providers/snake_provider.dart';
import '../../utilities/custom_validator.dart';
import '../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../widgets/custom_widgets/custom_file_image_box.dart';
import '../../widgets/custom_widgets/custom_network_change_img_box.dart';
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
  final TextEditingController _decription = TextEditingController();
  final TextEditingController _length = TextEditingController();
  final TextEditingController _diet = TextEditingController();
  final TextEditingController _habitat = TextEditingController();
  final TextEditingController _coolStuff = TextEditingController();
  final TextEditingController _tag = TextEditingController();
  final TextEditingController _property = TextEditingController();
  VenomousLevel level = VenomousLevel.dangerouslyVenomous;
  bool _isLoading = false;

  final List<String> tags = <String>[];
  final List<String> properties = <String>[];

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  File? file;
  File? scaleFile;
  File? image1;
  File? image2;
  File? image3;
  File? image4;

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
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                  controller: _scientificName,
                  title: 'Scientific Name',
                  readOnly: _isLoading,
                  validator: (String? value) =>
                      CustomValidator.lessThen3(value),
                ),
                CustomTitleTextFormField(
                  controller: _name,
                  title: 'Snake Name',
                  readOnly: _isLoading,
                  validator: (String? value) =>
                      CustomValidator.lessThen3(value),
                ),
                CustomTitleTextFormField(
                  controller: _decription,
                  title: 'Description',
                  readOnly: _isLoading,
                  validator: (String? value) => null,
                ),
                CustomTitleTextFormField(
                  controller: _length,
                  title: 'Average Length in CM',
                  keyboardType: TextInputType.number,
                  readOnly: _isLoading,
                  validator: (String? value) => CustomValidator.isEmpty(value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => onScaleChoose(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text('Choose Snake Scale'),
                      ),
                    ),
                    CustomFileImageBox(
                      file: scaleFile,
                      title: 'Choose Scale',
                      onTap: () => onScaleChoose(),
                    ),
                  ],
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
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 14),
                      const Text(
                        'Other Images Section',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CustomNetworkChangeImageBox(
                            url: '',
                            file: image1,
                            title: 'Add Photo',
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? temp = await picker.pickImage(
                                  source: ImageSource.gallery);
                              if (temp == null) return;
                              setState(() {
                                image1 = File(temp.path);
                              });
                            },
                          ),
                          CustomNetworkChangeImageBox(
                            url: '',
                            file: image2,
                            title: 'Add Photo',
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? temp = await picker.pickImage(
                                  source: ImageSource.gallery);
                              if (temp == null) return;
                              setState(() {
                                image2 = File(temp.path);
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CustomNetworkChangeImageBox(
                            url: '',
                            file: image3,
                            title: 'Add Photo',
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? temp = await picker.pickImage(
                                  source: ImageSource.gallery);
                              if (temp == null) return;
                              setState(() {
                                image3 = File(temp.path);
                              });
                            },
                          ),
                          CustomNetworkChangeImageBox(
                            url: '',
                            file: image4,
                            title: 'Add Photo',
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? temp = await picker.pickImage(
                                  source: ImageSource.gallery);
                              if (temp == null) return;
                              setState(() {
                                image4 = File(temp.path);
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CustomTitleTextFormField(
                  controller: _diet,
                  title: 'Diet',
                  readOnly: _isLoading,
                  validator: (String? value) => null,
                ),
                CustomTitleTextFormField(
                  controller: _habitat,
                  title: 'Habitat',
                  readOnly: _isLoading,
                  validator: (String? value) => null,
                ),
                CustomTitleTextFormField(
                  controller: _coolStuff,
                  title: 'Cool Stuff',
                  readOnly: _isLoading,
                  validator: (String? value) => null,
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
                        onTap: () async => onAdd(),
                      ),
                SizedBox(height: MediaQuery.of(context).size.height / 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onAdd() async {
    if (!key.currentState!.validate()) return;
    if (file == null) {
      CustomToast.errorToast(message: 'Select Photo');
      setState(() {
        _isLoading = false;
      });
      return;
    }
    if (file == null) {
      CustomToast.errorToast(message: 'Select Snake Scale');
      setState(() {
        _isLoading = false;
      });
      return;
    }
    if (image1 == null || image2 == null || image3 == null || image4 == null) {
      CustomToast.errorToast(message: 'Select Other Images');
      setState(() {
        _isLoading = false;
      });
      return;
    }
    setState(() {
      _isLoading = true;
    });
    final String? url = await SnakeAPI().uploadPhoto(file: file!);
    final String? scaleURL = await SnakeAPI().uploadPhoto(file: scaleFile!);
    final String? image1URL = await SnakeAPI().uploadPhoto(file: image1!);
    final String? image2URL = await SnakeAPI().uploadPhoto(file: image2!);
    final String? image3URL = await SnakeAPI().uploadPhoto(file: image3!);
    final String? image4URL = await SnakeAPI().uploadPhoto(file: image4!);
    if (file == null || scaleURL == null) {
      CustomToast.errorToast(message: 'Photo Upload issue');
      setState(() {
        _isLoading = false;
      });
      return;
    }
    final Snake snake = Snake(
      name: _name.text.trim(),
      scientificName: _scientificName.text.trim(),
      description: _decription.text.trim(),
      imageURL: <String>[url!],
      averageLengthCM: double.tryParse(_length.text.trim()) ?? 0.0,
      scaleURL: scaleURL,
      image1: image1URL,
      image2: image2URL,
      image3: image3URL,
      image4: image4URL,
      diet: _diet.text.trim(),
      habitat: _habitat.text.trim(),
      coolStuff: _coolStuff.text.trim(),
      tags: tags,
      level: level,
      properties: properties,
    );
    await SnakeAPI().add(snake);
    // ignore: use_build_context_synchronously
    Provider.of<SnakeProvider>(context, listen: false).refresh();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  onScaleChoose() async {
    // final bool isGranted = await _request();
    // if (!isGranted) return null;
    final ImagePicker picker = ImagePicker();
    final XFile? temp = await picker.pickImage(source: ImageSource.gallery);
    if (temp == null) return;
    setState(() {
      scaleFile = File(temp.path);
    });
  }

  onImagePick() async {
    // final bool isGranted = await _request();
    // if (!isGranted) return null;
    final ImagePicker picker = ImagePicker();
    final XFile? temp = await picker.pickImage(source: ImageSource.gallery);
    if (temp == null) return;
    setState(() {
      file = File(temp.path);
    });
  }

  Future<bool> _request() async {
    await <Permission>[Permission.photos].request();
    final PermissionStatus status1 = await Permission.photos.status;
    return status1.isGranted;
  }
}
