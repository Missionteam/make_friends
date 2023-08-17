import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const List<Widget> fruits = <Widget>[
  Text(
    '全て',
    style: TextStyle(fontSize: 10),
  ),
  Text(
    '今日',
    style: TextStyle(fontSize: 10),
  ),
  Text(
    '明日以降',
    style: TextStyle(fontSize: 10),
  )
];

class SegmentedButton extends ConsumerStatefulWidget {
  final List<Widget> items;
  final List<bool> initialSelected;
  final Color selectedBorderColor;
  final Color selectedColor;
  final Color fillColor;
  final Color color;

  SegmentedButton({
    Key? key,
    required this.items,
    this.initialSelected = const <bool>[true, false, false],
    this.selectedBorderColor = const Color.fromARGB(255, 158, 158, 158),
    this.selectedColor = const Color.fromARGB(255, 103, 103, 103),
    this.fillColor = const Color.fromARGB(255, 181, 207, 255),
    this.color = const Color.fromARGB(255, 103, 103, 103),
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SegmentedButtonState();
}

class SegmentedButtonState extends ConsumerState<SegmentedButton> {
  late List<bool> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.initialSelected);
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      direction: Axis.horizontal,
      onPressed: (int index) {
        setState(() {
          for (int i = 0; i < _selectedItems.length; i++) {
            _selectedItems[i] = i == index;
          }
        });
      },
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      selectedBorderColor: widget.selectedBorderColor,
      selectedColor: widget.selectedColor,
      fillColor: widget.fillColor,
      color: widget.color,
      constraints: const BoxConstraints(
        minHeight: 26.0,
        minWidth: 80.0,
      ),
      isSelected: _selectedItems,
      children: widget.items,
    );
  }
}
