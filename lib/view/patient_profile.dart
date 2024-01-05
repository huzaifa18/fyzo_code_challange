import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../utils/utils.dart';

final statusProvider = StateProvider<bool>((ref) => true);

// I would recommend using HookConsumerWidget instead, as it's less boilerplate code.
class PatientProfile extends HookConsumerWidget {
  const PatientProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(statusProvider);

    // Because we're using the HookConsumerWidget now, we have to use hooks to keep track of the details
    final nameController = useTextEditingController();
    final dobController = useTextEditingController();
    final selectedDate = useState<DateTime>(DateTime.now());

    // It would make sense to extract these values into a StateNotifier, so we could still somewhat use the functions previously written below.
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
                      child: Stack(
                        fit: StackFit.loose,
                        children: <Widget>[
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
                                    image: ExactAssetImage('assets/images/profile.jpeg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
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
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // We have a lot of similar paddings here, it would make senes to put the padding around the Column instead
                    Padding(
                        padding: const EdgeInsets.only(
                          left: 25.0,
                          right: 25.0,
                          top: 25.0,
                        ),
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
                            // I prefer using collection if statements, as they're more readable.
                            if (status) Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                GestureDetector(
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
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
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
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                          left: 25.0,
                          right: 25.0,
                          top: 2.0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Flexible(
                              child: TextField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  hintText: "Enter Your Name",
                                ),
                                enabled: !status,
                                autofocus: !status,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 25.0,
                        right: 25.0,
                        top: 25.0,
                      ),
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
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 25.0,
                        right: 25.0,
                        top: 2.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Flexible(
                            child: TextField(
                              focusNode: AlwaysDisabledFocusNode(),
                              controller: dobController,
                              decoration: const InputDecoration(hintText: "Enter DOB"),
                              enabled: !status,
                              onTap: () async {
                                final DateTime? newSelectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate.value,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(), // Last Date should be DateTime.now()
                                );
                                if (newSelectedDate != null && newSelectedDate != selectedDate.value) {
                                  selectedDate.value = newSelectedDate;
                                  dobController
                                    ..text = DateFormat.yMMMd().format(newSelectedDate)
                                    ..selection = TextSelection.fromPosition(TextPosition(
                                        offset: dobController.text.length,
                                        affinity: TextAffinity.upstream,
                                      ),
                                    );
                                }
                              },
                            ),
                          ),
                          // Collection-if also allows us to avoid dummy widgets in the widget tree that would be necessary when using ternary operators.
                          if (isBirthdayToday(selectedDate.value) && dobController.text.isNotEmpty) ...[
                            const Flexible(
                              child: Icon(
                                  Icons.cake,
                                  size: 16.0,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (status == false) Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        // mainAxisAlignment: MainAxisAlignment.start, // This is already the default
                        children: <Widget>[
                          // If both widgets have the same flex we don't have to specify it
                          Expanded(
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
