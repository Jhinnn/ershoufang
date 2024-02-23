import 'package:ershoufang/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SortWidget extends StatefulWidget {
  final Function(int, bool) onConditionsTap;
  final List<String> titles;
  const SortWidget({super.key, required this.titles, required this.onConditionsTap});

  @override
  State<SortWidget> createState() => _SortWidgetState();
}

class _SortWidgetState extends State<SortWidget> {
  int selectedIndex = 0;
  bool upDown = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(width: 1, color: AppColors.bgColor))),
      child: Row(children: createSortWidget()),
    );
  }

  List<Widget> createSortWidget() {
    return List.generate(widget.titles.length, (index) {
      return SortItemWidget(
        isSelected: selectedIndex == index,
        title: widget.titles[index],
        upDown: upDown,
        index: index,
        onTap: (value, index) {
          if (selectedIndex == index) {
            upDown = !upDown;
          } else {
            upDown = true;
          }
          selectedIndex = index;
          setState(() {});

          widget.onConditionsTap(index, upDown);
        },
      );
    });
  }
}

class SortItemWidget extends StatelessWidget {
  final Function(String, int) onTap;
  final bool isSelected;
  final String title;
  final int index;
  final bool upDown;
  const SortItemWidget({super.key, required this.isSelected, required this.title, required this.upDown, required this.onTap, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      color: isSelected ? AppColors.bgColor : Colors.white,
      width: 90,
      child: Center(
        child: InkWell(
          onTap: () => onTap(title, index),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontSize: 14),
              ),
              isSelected && index != 1 && index != 0
                  ? Icon(
                      upDown ? Icons.arrow_upward : Icons.arrow_downward,
                      color: Colors.white,
                      size: 12,
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
