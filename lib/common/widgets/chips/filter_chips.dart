import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterChipsBar<T> extends StatelessWidget {
  final Rx<T> selectedValue;
  final List<T> items;
  final String Function(T)? labelBuilder;
  final void Function(T)? onChanged;

  const FilterChipsBar({
    super.key,
    required this.selectedValue,
    required this.items,
    this.labelBuilder,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Obx(() {
        final current = selectedValue.value;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: items.map((item) {
              final isActive = item == current;

              final String label =
                  labelBuilder != null ? labelBuilder!(item) : item.toString();

              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: isActive
                        ? (isDark ? Colors.blue.shade500 : Colors.blue.shade600)
                        : (isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade200),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            )
                          ]
                        : [],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {
                      selectedValue.value = item;
                      if (onChanged != null) onChanged!(item);
                    },
                    child: Text(
                      label,
                      style: TextStyle(
                        color: isActive
                            ? Colors.white
                            : (isDark ? Colors.grey[300] : Colors.black87),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }),
    );
  }
}
