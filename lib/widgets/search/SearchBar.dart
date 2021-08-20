import 'package:flutter/material.dart';
import 'package:pharmassist/providers/NetworkNotifier.dart';
import 'package:provider/provider.dart';

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
    final device = MediaQuery.of(context).size;
    return Container(
      height: device.height * 0.075,
      margin: const EdgeInsets.only(top: 0, bottom: 20, left: 10, right: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(6),
        ),
        boxShadow: const[
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
                  Provider.of<NetworkNotifier>(context, listen: false)
                      .setIsConnected()
                      .then((snap) {
                    if (Provider.of<NetworkNotifier>(context, listen: false)
                        .getIsConnected) {
                      setState(() {
                        _category = value;
                        widget.setCategory(value);
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: const Text(
                            'Please check your network connection',
                          ),
                          duration: const Duration(seconds: 1, milliseconds: 200),
                        ),
                      );
                    }
                  });
                },
                icon: _category == null
                    ? const Icon(Icons.category)
                    : _category == 'noFilter'
                        ? const Icon(Icons.category)
                        : _category == 'pharms'
                            ? const Icon(Icons.local_pharmacy)
                            : const Icon(Icons.store),
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
                width: device.width * 0.03,
              ),
            ],
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              style: TextStyle(fontSize: 18),
              decoration: const InputDecoration(
                contentPadding:const EdgeInsets.only(bottom: 10),
                border: InputBorder.none,
                labelText: 'Search here',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelStyle:const TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 17,
                ),
              ),
            ),
          ),
          Row(
            children: [
              // PopupMenuButton(
              //   onSelected: (value) {
              //     setState(() {
              //       _filter = value;
              //       widget.setFilter(value);
              //     });
              //   },
              //   icon: Icon(Icons.filter_alt),
              //   itemBuilder: (BuildContext ctx) => [
              //     PopupMenuItem(
              //       value: 'noFilter',
              //       child: Text(
              //         'No filter',
              //         style: TextStyle(
              //           fontFamily: 'poppins',
              //           fontSize: 13,
              //           color:
              //               _filter == 'noFilter' ? Colors.red : Colors.black,
              //         ),
              //       ),
              //     ),
              //     PopupMenuItem(
              //       value: 'town',
              //       child: Text(
              //         'Town',
              //         style: TextStyle(
              //           fontFamily: 'poppins',
              //           fontSize: 13,
              //           color: _filter == 'town' ? Colors.red : Colors.black,
              //         ),
              //       ),
              //     ),
              //     PopupMenuItem(
              //       value: 'dist',
              //       child: Text(
              //         'District',
              //         style: TextStyle(
              //           fontFamily: 'poppins',
              //           fontSize: 13,
              //           color: _filter == 'dist' ? Colors.red : Colors.black,
              //         ),
              //       ),
              //     ),
              //     PopupMenuItem(
              //       value: 'state',
              //       child: Text(
              //         'State',
              //         style: TextStyle(
              //           fontFamily: 'poppins',
              //           fontSize: 13,
              //           color: _filter == 'state' ? Colors.red : Colors.black,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              IconButton(
                onPressed: () {
                  Provider.of<NetworkNotifier>(context, listen: false)
                      .setIsConnected()
                      .then((snap) {
                    if (Provider.of<NetworkNotifier>(context, listen: false)
                        .getIsConnected) {
                      setState(() {
                        _query = _controller.text;
                      });
                      widget.setQuery(_query, _category, null);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            'Please check your network connection',
                          ),
                          duration: Duration(seconds: 1, milliseconds: 200),
                        ),
                      );
                    }
                  });
                  FocusScope.of(context).unfocus();
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
