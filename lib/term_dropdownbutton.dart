import 'package:flutter/material.dart';

class TermDropdown extends StatelessWidget {
  final List<String> terms;
  final String selectedTerm;
  final Function(String) onChanged;

  const TermDropdown({
    super.key,
    required this.terms,
    required this.selectedTerm,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedTerm,
      isExpanded: true,
      items: terms.map((term) {
        return DropdownMenuItem<String>(
          value: term,
          child: Text(term),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          onChanged(newValue);
        }
      },
    );
  }
}
