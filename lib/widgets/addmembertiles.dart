import 'package:flutter/material.dart';


// ignore: must_be_immutable
class AddMemberTiles extends StatefulWidget {
  final String memberName;
  AddMemberTiles({this.memberName});
  bool _toBeAdded = false;

  @override
  _AddMemberTilesState createState() => _AddMemberTilesState();
}

class _AddMemberTilesState extends State<AddMemberTiles> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CircleAvatar(radius: 40.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Text(
              widget.memberName,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Checkbox(
              value: widget._toBeAdded,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (val) {
                setState(() {
                  widget._toBeAdded = val;
                });
              })
        ],
      ),
    );
  }
}
