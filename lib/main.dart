// Flutter application demonstrating the `showTimePicker` TAB focus issue in web

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart'; // Required for SemanticsFlag

void main() {
  runApp(TimePickerDemoApp());
  SemanticsBinding.instance.ensureSemantics();
}

class TimePickerDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Picker TAB Focus Demo',
      home: TimePickerDemoPage(),
    );
  }
}

class TimePickerDemoPage extends StatefulWidget {
  @override
  _TimePickerDemoPageState createState() => _TimePickerDemoPageState();
}

class _TimePickerDemoPageState extends State<TimePickerDemoPage> {
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Picker TAB Focus Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  initialEntryMode: TimePickerEntryMode.inputOnly,
                );
                if (time != null) {
                  setState(() {
                    _selectedTime = time;
                  });
                }
              },
              child: Text('Show Time Picker'),
            ),
            if (_selectedTime != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('Selected time: ${_selectedTime!.format(context)}'),
              ),
          ],
        ),
      ),
    );
  }
}

/*
Instructions:
1. Create a new Flutter project: `flutter create time_picker_demo`
2. Replace the contents of `lib/main.dart` with this code.
3. Run on web to reproduce the issue:
   `flutter run -d chrome --web-renderer canvaskit`
4. Click the button, focus hours, press TAB, and observe whether minutes are highlighted.
*/
