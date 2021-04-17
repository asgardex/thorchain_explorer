import 'package:flutter/material.dart';
import 'package:thorchain_explorer/_const/callbacks.dart';

class Paginator extends StatelessWidget {
  final int offset;
  final int limit;
  final int totalCount;
  final IntCallback updateOffset;

  Paginator({this.offset, this.limit, this.totalCount, this.updateOffset});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 30,
          alignment: Alignment.center,
          child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: (offset != 0) ? () => updateOffset(0) : null,
            child: Icon(Icons.first_page),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Container(
          width: 30,
          alignment: Alignment.center,
          child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: (offset - limit >= 0)
                  ? () {
                      updateOffset(offset - limit);
                    }
                  : null,
              child: Icon(Icons.navigate_before)),
        ),
        SizedBox(
          width: 4,
        ),
        Text("Page ${(offset / limit) + 1} of ${(totalCount / limit).ceil()}"),
        SizedBox(
          width: 4,
        ),
        Container(
          width: 30,
          alignment: Alignment.center,
          child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: (offset + limit <= (totalCount).ceil())
                  ? () {
                      updateOffset(offset + limit);
                    }
                  : null,
              child: Icon(Icons.navigate_next)),
        ),
        SizedBox(
          width: 4,
        ),
        Container(
          width: 30,
          alignment: Alignment.center,
          child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: (offset != limit * ((totalCount / limit).ceil() - 1))
                ? () {
                    updateOffset(limit * ((totalCount / limit).ceil() - 1));
                  }
                : null,
            child: Icon(Icons.last_page),
          ),
        ),
      ],
    );
  }
}
