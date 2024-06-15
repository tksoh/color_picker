import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class ColorPickerPage extends StatefulWidget {
  final Color? selectedColor;
  final void Function(Color)? onSelected;

  const ColorPickerPage({super.key, this.selectedColor, this.onSelected});

  @override
  State<ColorPickerPage> createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {
  Color screenPickerColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Picker'),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        buildPicker(),
        if (widget.onSelected != null) ...[
          const SizedBox(height: 20),
          buildSelectButton(),
        ],
      ],
    );
  }

  Widget buildSelectButton() {
    return ElevatedButton(
      onPressed: () => widget.onSelected?.call(screenPickerColor),
      child: const Text('Select'),
    );
  }

  Widget buildPicker() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Card(
          elevation: 2,
          child: ColorPicker(
            color: widget.selectedColor ?? screenPickerColor,
            onColorChanged: (Color color) =>
                setState(() => screenPickerColor = color),
            width: 44,
            height: 44,
            borderRadius: 22,
            heading: Text(
              'Select color',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            subheading: Text(
              'Select color shade',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
      ),
    );
  }
}
