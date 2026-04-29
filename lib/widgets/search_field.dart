import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final void Function(String query) onChanged;
  final String hint;

  const SearchField({super.key, required this.onChanged, required this.hint});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
    margin: const .only(bottom: 16),
    padding: const .symmetric(horizontal: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: .circular(12),
      border: .all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: .03),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: TextField(
      controller: controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        icon: Icon(Icons.search, color: Colors.grey.shade600),
        hintText: widget.hint,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        border: .none,
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.clear, size: 20, color: Colors.grey.shade600),
                onPressed: () {
                  controller.clear();
                  widget.onChanged('');
                },
              )
            : null,
        contentPadding: const .symmetric(vertical: 14),
      ),
    ),
  );
}
