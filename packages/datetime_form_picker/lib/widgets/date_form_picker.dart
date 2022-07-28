import 'package:flutter/material.dart';

class DateFormPicker extends StatelessWidget {
  final void Function(DateTime)? onPicked;
  final DateController? controller;
  const DateFormPicker({Key? key, this.onPicked, this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    if (controller!._date != null) {
      String d = controller!._date!.day.toString().padLeft(2, '0');
      String m = controller!._date!.month.toString().padLeft(2, '0');
      String y = controller!._date!.year.toString();
      textController.text = '$d/$m/$y';
    }
    return TextFormField(
      controller: textController,
      validator: (input) {
        return input != null && input.isNotEmpty
            ? null
            : 'Date must be provided';
      },
      onTap: () async {
        var date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(4747),
        );
        if (date != null) {
          String d = date.day.toString().padLeft(2, '0');
          String m = date.month.toString().padLeft(2, '0');
          String y = date.year.toString();
          textController.text = '$d/$m/$y';
          if (controller != null) controller!.date = date;
        }
      },
      readOnly: true,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.date_range_outlined),
        labelText: 'Pick a date',
      ),
    );
  }
}

class DateController extends ChangeNotifier {
  DateTime? _date;

  DateController({DateTime? date}): _date = date;

  DateTime? get date => _date;
  set date(newDate) {
    _date = newDate;
    notifyListeners();
  }
}
