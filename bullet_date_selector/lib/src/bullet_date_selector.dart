
import 'package:bullet_date_selector/src/localized_texts.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

/// A customizable widget that displays a list of quick-select buttons for date selection
/// along with a date picker. By default, it uses a fixed list of slots. If the user wishes,
/// they can supply their own slot list.
class BulletDateSelector extends StatefulWidget {
  /// Callback to notify the parent when a new date is selected.
  final ValueChanged<DateTime> onDateSelected;

  /// Optional custom list of slot values 
  ///  If not provided, the default list
  /// [1, 3, 5, 7, 10, 14, 15, 30, 45] is used.
  final List<int>? customSlotList;

  /// The vertical gap between sections in the widget.
  final double gap;

  /// The maximum height for the list portion of the widget.
  /// Defaults to 200.0, so that not all slots are visible at once.
  final double listHeight;

  /// The optional title text for the calendar part of the widget.
  /// Defaults to the localized title.
  final String? titleText;

  /// Controls whether the title text should be shown.
  /// Defaults to true.
  final bool showTitleText;

  /// Optional text style for the title text. If not provided, the widget uses the theme's style.
  final TextStyle? titleTextStyle;

  /// Controls whether the helper text should be shown.
  /// Defaults to true.
  final bool showHelperText;

  /// Optional helper text override. If not provided, the widget uses the localized helper text.
  final String? helperText;

  /// Optional text style for the helper text. If not provided, the widget uses the theme's style.
  final TextStyle? helperTextStyle;

  /// Optional button color for quick-select buttons. If not provided, defaults to theme's primary color.
  final Color? buttonColor;

  /// Optional text style for the slot text (displayed on the quick-select buttons).
  /// If not provided, defaults to the theme's style (titleMedium).
  final TextStyle? slotTextStyle;

  /// Optional ButtonStyle for the slot buttons. This allows full customization of the button style.
  final ButtonStyle? slotButtonStyle;

  /// Optional text style for the calendar date text.
  final TextStyle? dateTextStyle;

  /// Creates a [BulletDateSelector] widget.
  ///
  /// The [onDateSelected] parameter is required. The other parameters have default values:
  /// - [gap] defaults to 8.0,
  /// - [listHeight] defaults to 200.0,
  /// - [showTitleText] defaults to true,
  /// - [showHelperText] defaults to true.
  const BulletDateSelector({
    super.key,
    required this.onDateSelected,
    this.customSlotList,
    this.gap = 8.0,
    this.listHeight = 200.0,
    this.titleText,
    this.showTitleText = true,
    this.titleTextStyle,
    this.showHelperText = true,
    this.helperText,
    this.helperTextStyle,
    this.buttonColor,
    this.slotTextStyle,
    this.slotButtonStyle,
    this.dateTextStyle,
  });

  @override
  State<BulletDateSelector> createState() => _BulletDateSelectorState();
}

class _BulletDateSelectorState extends State<BulletDateSelector> {
  late DateTime _selectedDueDate;

  // Fixed default list of slots.
  static const List<int> _defaultSlots = [1, 3, 5, 7, 10, 14, 15, 30, 45];

  @override
  void initState() {
    super.initState();
    _selectedDueDate = DateTime.now();
  }

  /// Returns the custom slot list if provided, otherwise the fixed default list.
  List<int> _generateSlots() {
    return widget.customSlotList ?? _defaultSlots;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // For the buttons, we still use 5% of the screen height.
    final double buttonHeight = screenHeight * 0.05;
    final slots = _generateSlots();

    // Get localized texts based on the current locale.
    final supportedLanguage = getSupportedLanguage(context);
    final texts = localizedValues[supportedLanguage]!;

    // Use theme's text styles.
    final textTheme = Theme.of(context).textTheme;
    final dateTextStyle = widget.dateTextStyle ?? textTheme.titleMedium;
    final formattedDate = DateFormat.yMd().format(_selectedDueDate);

    return Column(
      children: [
        // Slot list with fixed height .
        SizedBox(
          height: widget.listHeight,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              for (final slot in slots)
                Padding(
                  padding: EdgeInsets.only(top: widget.gap),
                  child: _buildSlotButton(slot, buttonHeight, textTheme, texts, supportedLanguage),
                ),
            ],
          ),
        ),

        // Optional title text.
        widget.showTitleText
            ? Padding(
              padding: EdgeInsets.only(top: widget.gap),
              child: Text(widget.titleText ?? texts.title, style: widget.titleTextStyle ?? textTheme.titleMedium),
            )
            : const SizedBox.shrink(),

        // Date picker button wrapped with a tooltip.
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Tooltip(
              message: texts.tooltip,
              child: TextButton(onPressed: _pickDate, child: Text(formattedDate, style: dateTextStyle)),
            ),
          ],
        ),

        // Optional helper text.
        widget.showHelperText
            ? Text(widget.helperText ?? texts.helper, style: widget.helperTextStyle ?? textTheme.titleMedium)
            : const SizedBox.shrink(),
      ],
    );
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDueDate = pickedDate;
      });
      widget.onDateSelected(pickedDate);
    }
  }
  //Function to define every item of the list

  Widget _buildSlotButton(
    int slot,
    double buttonHeight,
    TextTheme textTheme,
    LocalizedTexts texts,
    SupportedLanguage language,
  ) {
    // For English, add an "s" if the slot is greater than 1.
    String dayText;
    if (language == SupportedLanguage.english) {
      dayText = slot > 1 ? '${texts.day}s' : texts.day;
    } else {
      // For other languages (e.g., Turkish for now), use the provided text as-is.
      dayText = texts.day;
    }
    return ElevatedButton(
      onPressed: () {
        final newDate = DateTime.now().add(Duration(days: slot));
        setState(() {
          _selectedDueDate = newDate;
        });
        widget.onDateSelected(newDate);
      },
      style:
          widget.slotButtonStyle ??
          ElevatedButton.styleFrom(
            maximumSize: Size.fromHeight(buttonHeight),
            backgroundColor: widget.buttonColor ?? Theme.of(context).colorScheme.primary,
          ),
      child: Text('$slot $dayText', style: widget.slotTextStyle ?? textTheme.titleMedium),
    );
  }
}