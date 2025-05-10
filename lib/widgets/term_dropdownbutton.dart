import 'package:flutter/material.dart';

class TermDropdown extends StatelessWidget {
  final List<String> terms;
  final String selectedTerm;
  final Function(String) onChanged;
  final String title;

  const TermDropdown({
    super.key,
    required this.terms,
    required this.selectedTerm,
    required this.onChanged,
    this.title = "📅 Dönem Seçiniz",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedTerm,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
              isExpanded: true,
              style: const TextStyle(fontSize: 16, color: Colors.black),
              dropdownColor: Colors.white,
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
            ),
          ),
        ),
      ],
    );
  }
}
