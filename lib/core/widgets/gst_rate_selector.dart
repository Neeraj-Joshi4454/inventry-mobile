import 'package:flutter/material.dart';

/// GST slab picker shown on each purchase/sale line — GST is chosen per
/// transaction line, not stored on the product.
class GstRateSelector extends StatelessWidget {
  const GstRateSelector({super.key, required this.value, required this.onChanged});

  static const rates = [0.0, 5.0, 12.0, 18.0, 28.0];

  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('GST', style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(width: 8),
        Expanded(
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final rate in rates)
                ChoiceChip(
                  label: Text('${rate.toStringAsFixed(0)}%'),
                  selected: value == rate,
                  visualDensity: VisualDensity.compact,
                  onSelected: (_) => onChanged(rate),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
