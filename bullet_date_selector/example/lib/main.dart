import 'package:flutter/material.dart';
import 'package:bullet_date_selector/bullet_date_selector.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bullet Date Selector Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BulletDateSelector(
          // REQUIRED: Called whenever a date is selected.
          onDateSelected: (date) {
            setState(() => _selectedDate = date);
          },

          // OPTIONAL: Supply a custom list of slot values if you don’t want the default list.
          customSlotList: [2, 5, 9, 12],

          // OPTIONAL: Vertical space between slots/title/helper.
          gap: 12.0,

          // OPTIONAL: The maximum height for the slot list.
          listHeight: 150.0,

          // OPTIONAL: A custom title for the calendar portion.
          titleText: 'Select a Due Date',

          // OPTIONAL: Whether to show the title text.
          showTitleText: true,

          // OPTIONAL: Style override for the title text.
          titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),

          // OPTIONAL: Whether to show helper text.
          showHelperText: true,

          // OPTIONAL: A custom helper text message.
          helperText: 'Tap a button or choose from the calendar',

          // OPTIONAL: Style override for the helper text.
          helperTextStyle: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),

          // OPTIONAL: Button color for quick-select slots.
          buttonColor: Colors.orangeAccent,

          // OPTIONAL: Text style for each slot button.
          slotTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),

          // OPTIONAL: Fully customize the slot buttons’ appearance.
          slotButtonStyle: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            // For example, you can specify a minimum or maximum size:
            minimumSize: const Size(60, 40),
          ),

          // OPTIONAL: Text style for the date shown on the calendar button.
          dateTextStyle: const TextStyle(fontSize: 16, color: Colors.green),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_selectedDate != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Selected date: $_selectedDate')));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No date selected')));
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
