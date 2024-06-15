import 'package:flutter/material.dart';

class ColorPickerDialog extends StatefulWidget {
  final Widget? title;
  final List<Color> colors;
  final Color initColor;
  final Function(Color?)? onSelected;

  const ColorPickerDialog({
    super.key,
    required this.colors,
    required this.initColor,
    this.title,
    this.onSelected,
  });

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    final index = widget.colors.indexOf(widget.initColor);
    if (index >= 0) selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    final actions = [
      TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop('Cancel');
          }),
      TextButton(
          child: const Text('Select'),
          onPressed: () {
            final color =
                selectedIndex == null ? null : widget.colors[selectedIndex!];
            widget.onSelected?.call(color);
            Navigator.of(context).pop('Select');
          }),
    ];

    final container = SizedBox(
      width: double.maxFinite,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 50,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: widget.colors.length,
        itemBuilder: (context, index) {
          final color = widget.colors[index];
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(5),
              backgroundColor: color,
            ),
            onPressed: () {
              selectedIndex = index;
              setState(() {});
            },
            child: Icon(
              Icons.check,
              color: index == selectedIndex
                  ? contrastColor(color)
                  : Colors.transparent,
            ),
          );
        },
      ),
    );

    return AlertDialog(
      title: widget.title ?? const Text('Color Picker'),
      content: container,
      actions: actions,
    );
  }

  Color contrastColor(Color color) =>
      switch (ThemeData.estimateBrightnessForColor(color)) {
        Brightness.dark => Colors.white,
        Brightness.light => Colors.black
      };
}
