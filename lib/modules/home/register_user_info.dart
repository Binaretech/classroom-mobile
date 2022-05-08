import 'dart:io';
import 'dart:typed_data';

import 'package:classroom_mobile/lang/lang.dart';
import 'package:classroom_mobile/repository/user_repository.dart';
import 'package:classroom_mobile/utils/validation.dart';
import 'package:classroom_mobile/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

/// Form data to be submitted to the server
class RequestData {
  String? name;
  String? lastname;
}

class RegisterUserInfo extends StatefulWidget {
  final UserRepository repository;
  const RegisterUserInfo({Key? key, required this.repository})
      : super(key: key);

  @override
  _RegisterUserInfoState createState() => _RegisterUserInfoState();
}

class _RegisterUserInfoState extends State<RegisterUserInfo> {
  final _formKey = GlobalKey<FormState>();
  final RequestData _userData = RequestData();

  bool loading = false;

  Uint8List? avatarImage;

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }

    final user = await widget.repository.storeUserData(
      name: _userData.name!,
      lastname: _userData.lastname!,
      avatar: await _getImageFile(),
    );

    Navigator.of(context).pop(user);
  }

  Future<File?> _getImageFile() async {
    if (avatarImage == null) {
      return null;
    }

    try {
      final tempDir = await getTemporaryDirectory();
      final tempPath = path.join(tempDir.path, 'avatar.png');

      final file = await File(tempPath).writeAsBytes(avatarImage!);

      return file;
    } catch (e) {
      return null;
    }
  }

  void _onTapAvatar() async {
    final source = await _selectImageSource();

    if (source == null) {
      return;
    }

    _pickImage(source);
  }

  void _pickImage(ImageSource source) {
    final picker = ImagePicker();
    picker.pickImage(source: source).then((value) async {
      if (value != null) {
        final bytes = await value.readAsBytes();

        setState(() {
          avatarImage = bytes;
        });
      }
    });
  }

  Future<ImageSource?> _selectImageSource() async {
    final source = await showDialog<ImageSource>(
        context: context,
        builder: (context) {
          final lang = Lang.of(context);
          final iconColor = Theme.of(context).primaryColor;

          return SimpleDialog(
            title: Text(lang.trans('messages.image source', capitalize: true)),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ImageSource.camera);
                },
                child: Row(
                  children: [
                    Icon(Icons.camera_alt, color: iconColor),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child:
                          Text(lang.trans('messages.camera', capitalize: true)),
                    ),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
                child: Row(
                  children: [
                    Icon(Icons.image, color: iconColor),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                          lang.trans('messages.gallery', capitalize: true)),
                    ),
                  ],
                ),
              ),
            ],
          );
        });

    return source;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final lang = Lang.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 41),
        child: SafeArea(
          child: Column(
            children: [
              loading ? const LinearProgressIndicator() : Container(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  lang.trans('views.register_user_info.title'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 36,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Avatar(
                      image: avatarImage == null
                          ? null
                          : Image.memory(avatarImage!),
                      onTap: _onTapAvatar,
                      radius: 75.0,
                      iconSize: 80.0,
                    ),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: TextFormField(
                        onSaved: (value) => _userData.name = value,
                        validator: rules([requiredRule]),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          label: Text(
                            lang.trans('attributes.name', capitalize: true),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: TextFormField(
                        onSaved: (value) => _userData.lastname = value,
                        validator: rules([requiredRule]),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          label: Text(
                            lang.trans('attributes.lastname', capitalize: true),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(theme.primaryColor),
                  ),
                  onPressed: !loading ? _submit : null,
                  child: Text(
                    lang.trans('messages.continue').toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: theme.typography.white.button!.color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
