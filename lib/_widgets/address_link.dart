import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AddressLink extends StatelessWidget {

  final String address;

  AddressLink(this.address);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: address,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/address/$address');
          },
          child: Text(
            '${address.substring(0, 8)}...${address.substring(address.length - 4, address.length)}',
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),
    );
  }
}
