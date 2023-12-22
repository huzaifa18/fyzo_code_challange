import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../utils/shared_prefs.dart';
import '../utils/utils.dart';

final statusProvider = StateProvider<bool>((ref) => true);

class PatientProfile extends ConsumerStatefulWidget {
  const PatientProfile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PatientProfileState();
}

class _PatientProfileState extends ConsumerState<PatientProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(statusProvider);

    return Scaffold(
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 250.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Stack(fit: StackFit.loose, children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: 140.0,
                                  height: 140.0,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: ExactAssetImage(
                                          'assets/images/profile.jpeg'),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ],
                          ),
                          const Padding(
                              padding: EdgeInsets.only(top: 90.0, right: 100.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 25.0,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              )),
                        ]),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Personal Information',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  status ? _getEditIcon() : Container(),
                                ],
                              )
                            ],
                          )),
                      const Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Name',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    hintText: "Enter Your Name",
                                  ),
                                  enabled: !status,
                                  autofocus: !status,
                                ),
                              ),
                            ],
                          )),
                      const Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Date of Birth',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  focusNode: AlwaysDisabledFocusNode(),
                                  controller: _dobController,
                                  decoration: const InputDecoration(
                                      hintText: "Enter DOB"),
                                  enabled: !status,
                                    onTap: () {
                                      _selectDate(context);
                                    }
                                ),
                              ),
                              isBirthdayToday(_selectedDate) && _dobController.text.isNotEmpty ? const Flexible(child: Icon(
                                Icons.cake,
                                size: 16.0,
                              )): Container()
                            ],
                          )),
                      !status ? _getActionButtons() : Container(),
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
}

  _selectDate(BuildContext context) async {
    final DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2024));
    if (newSelectedDate != null && newSelectedDate != _selectedDate) {
        _selectedDate = newSelectedDate;
        _dobController
          ..text = DateFormat.yMMMd().format(_selectedDate)
          ..selection = TextSelection.fromPosition(TextPosition(
              offset: _dobController.text.length,
              affinity: TextAffinity.upstream));
    }
  }

  Widget _getActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: ElevatedButton(
                child: const Text("Save"),
                onPressed: () {
                  ref.read(statusProvider.notifier).state = true;
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  ref.read(statusProvider.notifier).state = true;
                },
                child: const Text("Cancel"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: const CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        ref.read(statusProvider.notifier).state = false;
      },
    );
  }
}