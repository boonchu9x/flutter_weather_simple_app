import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../const.dart';

class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  BuildContext context;
  final TextEditingController textEditingController;
  final Function leadingOnPress;
  final Function searchOnPress;

  SearchBar({
    Key key,
    this.context,
    this.textEditingController,
    this.leadingOnPress,
    this.searchOnPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(top: 28.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black54,
                ),
                onPressed: leadingOnPress,
              ),
              Expanded(
                child: TextField(
                  autofocus: false,
                  //not focus to textfield
                  controller: textEditingController,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    fontSize: textNormal,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: InputDecoration.collapsed(
                    hintText: 'Tìm kiếm thành phố',
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    ),
                    border: InputBorder.none, //no input border
                  ),
                  maxLines: 1,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.search_outlined,
                  color: Colors.black54,
                ),
                onPressed: searchOnPress,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(120.0);
}
