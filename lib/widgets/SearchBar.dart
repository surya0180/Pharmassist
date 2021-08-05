import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar(this.setQuery, this.setCategory, this.setFilter, {Key key})
      : super(key: key);

  final Function setQuery, setCategory, setFilter;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String _query, _category, _filter;
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: Colors.black12,
            offset: Offset(2, 3),
            spreadRadius: 1,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              PopupMenuButton(
                onSelected: (value) {
                  setState(() {
                    _category = value;
                    widget.setCategory(value);
                  });
                },
                icon: _category == null
                    ? Icon(Icons.category)
                    : _category == 'noFilter'
                        ? Icon(Icons.category)
                        : _category == 'pharms'
                            ? Icon(Icons.local_pharmacy)
                            : Icon(Icons.store),
                itemBuilder: (BuildContext ctx) => [
                  const PopupMenuItem(
                    value: 'noFilter',
                    child: Text(
                      'No filter',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'pharms',
                    child: Text(
                      'Pharmacist',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'medic',
                    child: Text(
                      'Stores',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 10),
                border: InputBorder.none,
                labelText: 'Search here',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelStyle: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 17,
                ),
              ),
            ),
          ),
          Row(
            children: [
              PopupMenuButton(
                onSelected: (value) {
                  setState(() {
                    _filter = value;
                    widget.setFilter(value);
                  });
                },
                icon: Icon(Icons.filter_alt),
                itemBuilder: (BuildContext ctx) => [
                  PopupMenuItem(
                    value: 'noFilter',
                    child: Text(
                      'No filter',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 13,
                        color:
                            _filter == 'noFilter' ? Colors.red : Colors.black,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'town',
                    child: Text(
                      'Town',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 13,
                        color: _filter == 'town' ? Colors.red : Colors.black,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'dist',
                    child: Text(
                      'District',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 13,
                        color: _filter == 'dist' ? Colors.red : Colors.black,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'state',
                    child: Text(
                      'State',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 13,
                        color: _filter == 'state' ? Colors.red : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _query = _controller.text;
                  });
                  widget.setQuery(_query, _category, _filter);
                  FocusScope.of(context).unfocus();
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
