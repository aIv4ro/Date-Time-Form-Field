library date_time_form_field;

import 'package:flutter/material.dart';

class DateFormField extends StatefulWidget {
  const DateFormField({
    Key? key,
    this.padding = EdgeInsets.zero,
    this.textEditingController,
    this.decoration,
    this.validator,
    this.onChanged,
    this.formatDate,
    this.initialValue,
    this.initialDate,
    this.firstDate,
    this.lastDate,
  }) : super(key: key);

  final EdgeInsets padding;
  final TextEditingController? textEditingController;
  final InputDecoration? decoration;
  final FormFieldValidator<String>? validator;
  final Function(DateTime? value)? onChanged;
  final String Function(DateTime? value)? formatDate;
  final DateTime? initialValue;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  State<DateFormField> createState() => _DateFormFieldState();
}

class _DateFormFieldState extends State<DateFormField> {
  late final TextEditingController controller;
  late final DateTime initialDate;
  late final DateTime firstDate;
  late final DateTime lastDate;

  @override
  void initState() {
    super.initState();
    controller = widget.textEditingController ?? TextEditingController();
    initialDate = widget.initialDate ?? DateTime.now();
    firstDate = widget.firstDate ?? DateTime.now();
    lastDate = widget.lastDate ??
        DateTime.now().add(
          const Duration(days: 365 * 5),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: TextFormField(
        controller: controller,
        decoration: widget.decoration,
        validator: widget.validator,
        initialValue: widget.formatDate?.call(widget.initialDate),
        readOnly: true,
        onTap: _showDateTimePicker,
      ),
    );
  }

  void _showDateTimePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    final localePickedDate = pickedDate?.toLocal();

    widget.onChanged?.call(localePickedDate);
    controller.text = widget.formatDate?.call(localePickedDate) ??
        localePickedDate.toString();
  }
}
