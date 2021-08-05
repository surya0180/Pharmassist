import 'package:flutter/material.dart';

class StoreSearchResult extends StatelessWidget {
  const StoreSearchResult({
    this.name,
    this.storeId,
    Key key,
  }) : super(key: key);

  final String name;
  final String storeId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black26),
        ),
      ),
      child: InkWell(
        onTap: () {},
        splashColor: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: 73,
          padding: EdgeInsets.only(left: 14, right: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.title,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Store-Id:  $storeId',
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
