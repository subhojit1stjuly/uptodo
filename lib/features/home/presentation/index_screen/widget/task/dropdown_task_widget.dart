import 'package:flutter/material.dart';

/// DropdownTaskWidget
class DropdownTaskWidget<T> extends StatefulWidget {
  /// DropdownTaskWidget constructor
  const DropdownTaskWidget({
    required this.dropdownMenuEntries,
    required this.initialSelection,
    required this.onSelected,
    super.key,
  });

  /// List of dropdown menu entries
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;

  /// Initial selection
  final T initialSelection;

  /// Callback when item is selected
  final void Function(T?) onSelected;

  @override
  State<DropdownTaskWidget<T>> createState() => _DropdownTaskWidgetState<T>();
}

class _DropdownTaskWidgetState<T> extends State<DropdownTaskWidget<T>> {
  late T dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialSelection;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      initialSelection: widget.initialSelection,
      onSelected: (T? value) {
        // This is called when the user selects an item.
        setState(() {
          if (value != null) {
            dropdownValue = value;
          }
          widget.onSelected(value);
        });
      },
      dropdownMenuEntries: widget.dropdownMenuEntries,
    );
  }
}
