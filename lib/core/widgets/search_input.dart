import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';

/// Search field for list screens: leading search icon, a clear button that
/// appears once there's text, and `search` keyboard action.
class SearchInput extends StatefulWidget {
  const SearchInput({super.key, required this.controller, required this.onChanged, required this.hintText});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final hasText = widget.controller.text.isNotEmpty;
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      textInputAction: TextInputAction.search,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Icon(Icons.search, size: AppSizes.icon),
        suffixIcon: hasText
            ? IconButton(
                icon: const Icon(Icons.close, size: AppSizes.iconSm),
                tooltip: 'Clear search',
                onPressed: () {
                  widget.controller.clear();
                  widget.onChanged('');
                },
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: 12),
      ),
    );
  }
}
