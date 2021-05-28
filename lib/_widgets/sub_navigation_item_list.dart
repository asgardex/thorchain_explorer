import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SubNavigationItemList extends StatelessWidget {
  final List<SubNavigationItem> items;

  SubNavigationItemList(this.items);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: items,
          ),
          SizedBox(
            height: 18,
          )
        ],
      ),
    );
  }
}

class SubNavigationItem extends HookWidget {
  final String path;
  final String label;
  final bool active;

  SubNavigationItem(
      {required this.path, required this.label, this.active = false});

  @override
  Widget build(BuildContext context) {
    final hover = useState<bool>(false);

    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(active ? 0.2 : 0),
              borderRadius: BorderRadius.circular(4)),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onHover: (evnt) {
              if (hover.value == false) {
                hover.value = true;
              }
            },
            onExit: (event) {
              if (hover.value == true) {
                hover.value = false;
              }
            },
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, path);
              },
              child: Text(
                label,
                style: TextStyle(
                    color: (active || hover.value == true)
                        ? Colors.white
                        : Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        )
      ],
    );
  }
}
