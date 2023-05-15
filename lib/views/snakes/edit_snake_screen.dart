import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../database/snake_api.dart';
import '../../enum/venomous_type.dart';
import '../../models/edit_history.dart';
import '../../models/snake.dart';
import '../../providers/snake_provider.dart';
import '../../utilities/custom_validator.dart';
import '../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../widgets/custom_widgets/custom_network_change_img_box.dart';
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
  File? file;
  File? scaleFile;
  File? image1;
  File? image2;
  File? image3;
  File? image4;

  VenomousLevel level = VenomousLevel.dangerouslyVenomous;
  bool _isLoading = false;
  bool _isDeleting = false;

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
      appBar: AppBar(
        title: const Text('Edit Snake'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    StatefulBuilder(builder: (BuildContext context, setState) {
                  return Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text(
                            'Delete Snake',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(16),
                            child: Divider(),
                          ),
                          const Text(
                            'Do you ready want to delete this snake, once you delete it, we might remove all detail about this snake forever',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                          _isDeleting
                              ? const ShowLoading()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: CustomElevatedButton(
                                        title: 'Cancel',
                                        textColor:
                                            Theme.of(context).primaryColor,
                                        bgColor: Colors.transparent,
                                        border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onTap: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: CustomElevatedButton(
                                        title: 'Delete',
                                        bgColor: Colors.red,
                                        onTap: () async {
                                          try {
                                            setState(() {
                                              _isDeleting = true;
                                            });
                                            await SnakeAPI()
                                                .deleteSnake(widget.snake.sid);
                                            if (!mounted) return;
                                            await Provider.of<SnakeProvider>(
                                                    context,
                                                    listen: false)
                                                .refresh();
                                            if (!mounted) return;
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    MainScreen.routeName,
                                                    (Route<dynamic> route) =>
                                                        false);
                                          } catch (e) {
                                            setState(() {
                                              _isDeleting = false;
                                            });
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                )
                        ],
                      ),
                    ),
                  );
                }),
              );
            },
            child: const Text(
              'Delete Snake',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: key,
            child: Column(
              children: <Widget>[
                CustomNetworkChangeImageBox(
                  url: widget.snake.imageURL[0],
                  file: file,
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? temp =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (temp == null) return;
                    setState(() {
                      file = File(temp.path);
                    });
                  },
                ),
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
                    CustomNetworkChangeImageBox(
                      url: widget.snake.scaleURL,
                      file: scaleFile,
                      onTap: () async => await onScaleChoose(),
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
                            url: widget.snake.image1,
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
                            url: widget.snake.image2,
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
                            url: widget.snake.image3,
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
                            url: widget.snake.image4,
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
                        onTap: () async => onUpdate(),
                      ),
                SizedBox(height: MediaQuery.of(context).size.height / 2)
              ],
            ),
          ),
        ),
      ),
    );
  }

  onUpdate() async {
    if (!key.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
    });
    if (file != null) {
      final String? url = await SnakeAPI().uploadPhoto(file: file!);
      if (url != null) widget.snake.imageURL[0] = url;
    }
    if (scaleFile != null) {
      final String? url = await SnakeAPI().uploadPhoto(file: scaleFile!);
      if (url != null) widget.snake.scaleURL = url;
    }
    if (image1 != null) {
      final String? url = await SnakeAPI().uploadPhoto(file: image1!);
      if (url != null) widget.snake.image1 = url;
    }
    if (image2 != null) {
      final String? url = await SnakeAPI().uploadPhoto(file: image2!);
      if (url != null) widget.snake.image2 = url;
    }
    if (image3 != null) {
      final String? url = await SnakeAPI().uploadPhoto(file: image3!);
      if (url != null) widget.snake.image3 = url;
    }
    if (image4 != null) {
      final String? url = await SnakeAPI().uploadPhoto(file: image4!);
      if (url != null) widget.snake.image4 = url;
    }

    widget.snake.name = _name.text.trim();
    widget.snake.scientificName = _scientificName.text.trim();
    widget.snake.averageLengthCM = double.parse(_length.text.trim());
    widget.snake.level = level;
    widget.snake.tags = tags;
    widget.snake.properties = properties;
    widget.snake.history.add(EditHistory());
    await SnakeAPI().updateSnake(widget.snake);
    // ignore: use_build_context_synchronously
    Provider.of<SnakeProvider>(context, listen: false).refresh();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushNamedAndRemoveUntil(
        MainScreen.routeName, (Route<dynamic> route) => false);
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
}
