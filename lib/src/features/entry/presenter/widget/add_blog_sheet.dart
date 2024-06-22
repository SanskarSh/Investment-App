import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddBlogSheet extends StatefulWidget {
  const AddBlogSheet({super.key});

  @override
  _AddBlogSheetState createState() => _AddBlogSheetState();
}

class _AddBlogSheetState extends State<AddBlogSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  File? _image;
  String? imageUrl;

  Future<void> getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemp = File(image.path);
    if (mounted) {
      setState(() {
        _image = imageTemp;
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;
    final url =
        Uri.parse("https://api.cloudinary.com/v1_1/dnvgev9ch/image/upload");
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 's0lznuyb'
      ..files.add(await http.MultipartFile.fromPath('file', _image!.path));
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      if (mounted) {
        setState(() {
          imageUrl = jsonMap['url'];
        });
      }
    } else {
      if (mounted) {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(
            message: 'Failed to upload image',
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_image != null) {
        await _uploadImage();
      }
      if (mounted) {
        if (imageUrl == null) {
          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.error(
              message: 'Failed to upload image',
            ),
          );
        } else {
          print(imageUrl);
          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.success(message: 'Blog added successfully'),
          );
          Navigator.of(context).pop();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 24),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add a new blog',
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    const SizedBox(height: 32),
                    GestureDetector(
                      onTap: getImage,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        height: 250,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: _image != null
                                ? FileImage(_image!)
                                : const AssetImage(
                                    'assets/image/image_placeholder.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        alignment: Alignment.topRight,
                        child: Icon(
                          Ionicons.create_outline,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        hintText: 'Title',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _contentController,
                      decoration: const InputDecoration(
                        hintText: 'Content',
                      ),
                      maxLines: null, // Set maxLines to null for a textarea
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the content';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Add Blog',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      )),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
