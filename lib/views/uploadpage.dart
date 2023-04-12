import 'dart:ffi';

import 'package:ff_project/config.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/routes.dart';
import 'components/buttons.dart';
import 'components/texts.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File? _image;
  PickedFile? _pickedFile;
  final _picker = ImagePicker();
  DateTime? _selectedDate;
  // Implementing the image picker
  Future<void> _pickImage() async {
    _pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      setState(() {
        _image = File(_pickedFile!.path);
      });
    }
  }

  // TextEditingController emailcontroller = TextEditingController();
  TextEditingController eventnamecontroller = TextEditingController();
  TextEditingController durationcontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: titleText(text: 'Create Event', color: primaryColor),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(35),
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[300],
                  child: _pickedFile != null
                      ? Image.file(
                          File(_pickedFile!.path),
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                      : const Text('Please select an image'),
                ),
                const SizedBox(height: 35),
                elevatedButton(
                  text: 'Select An Image',
                  sizeHeight: 35.0,
                  sizeWidth: 60.0,
                  function: () => _pickImage(),
                ),
                const SizedBox(height: 35),
                TextField(
                  controller: eventnamecontroller,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 1)),
                    hintText: 'Event name',
                    filled: true,
                    fillColor: const Color.fromARGB(255, 225, 225, 225),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                TextField(
                  controller: locationcontroller,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 1)),
                    hintText: 'Location',
                    filled: true,
                    fillColor: const Color.fromARGB(255, 225, 225, 225),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                TextField(
                  controller: datecontroller,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 1)),
                    hintText: 'Date (YYYY-MM-DD)',
                    filled: true,
                    fillColor: const Color.fromARGB(255, 225, 225, 225),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                TextField(
                  controller: timecontroller,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 1)),
                    hintText: 'Time (HH:MM:SS)',
                    filled: true,
                    fillColor: const Color.fromARGB(255, 225, 225, 225),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                TextField(
                  controller: durationcontroller,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 1)),
                    hintText: 'Duration (DD HH:MM:SS)',
                    filled: true,
                    fillColor: const Color.fromARGB(255, 225, 225, 225),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                TextField(
                  controller: descriptioncontroller,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 1)),
                    hintText: 'Description',
                    filled: true,
                    fillColor: const Color.fromARGB(255, 225, 225, 225),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                elevatedButton(
                  text: 'Upload event',
                  function: () => _uploadEvent(context),
                ),
              ]),
            ),
          ),
        ));
  }

  Future<void> _uploadEvent(context) async {
    if (eventnamecontroller.text.isEmpty ||
        locationcontroller.text.isEmpty ||
        datecontroller.text.isEmpty ||
        durationcontroller.text.isEmpty ||
        timecontroller.text.isEmpty ||
        descriptioncontroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: const Text('Fill all the fileds'),
        action: SnackBarAction(
          textColor: primaryColor,
          label: 'Ok',
          onPressed: () {},
        ),
      ));
    } else {
      try {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Posting Event'),
          duration: Duration(seconds: 1),
        ));

        SharedPreferences _prefs = await SharedPreferences.getInstance();
        String _token = (_prefs.getString('token') ?? '');
        int _id = (_prefs.getInt('id') ?? 0);
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('$Api_url/gallary/event/'),
        );
        if (_image != null) {
          request.files.add(await http.MultipartFile.fromPath(
            'image',
            _image!.path,
          ));
        }
        request.fields['event_name'] = eventnamecontroller.text;
        request.fields['location'] = locationcontroller.text;
        request.fields['date'] = datecontroller.text;
        request.fields['time'] = timecontroller.text;
        request.fields['duration'] = durationcontroller.text;
        request.fields['discription'] = descriptioncontroller.text;
        request.fields['organizer'] = _id.toString();

        request.headers['Authorization'] = 'token $_token';

        var response = await request.send();
        if (response.statusCode == 201) {
          // Upload successful
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Event uploaded successfully')),
          );
          Get.toNamed(RoutesClass.getDashBoardRoute());
        } else {
          // Upload failed
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Event upload failed')),
          );
        }
      } catch (e) {
        // Error occurred while uploading
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error occurred while uploading')),
        );
        throw e;
      }
    }
  }
}
