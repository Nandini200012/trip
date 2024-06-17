import 'package:flutter/material.dart';

import '../api_services/promo_codes_api/show-promocodes_api.dart';

class PrromoCodesWidget extends StatefulWidget {
  final List<CodeData> promoCodes;

  PrromoCodesWidget({Key key, this.promoCodes}) : super(key: key);

  @override
  _PrromoCodesWidgetState createState() => _PrromoCodesWidgetState();
}

class _PrromoCodesWidgetState extends State<PrromoCodesWidget> {
  List<CodeData> _filteredPromoCodes = [];

  @override
  void initState() {
    super.initState();
    _filteredPromoCodes = widget.promoCodes;
  }

  void _filterPromoCodes(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        _filteredPromoCodes = widget.promoCodes;
      } else {
        _filteredPromoCodes = widget.promoCodes
            .where((codeData) => codeData.promoCode
                .toLowerCase()
                .contains(searchText.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _filteredPromoCodes.isNotEmpty
        ? Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  color: Color.fromARGB(255, 60, 70, 126),
                  child: Text(
                    "Promo Codes",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 252, 250, 250),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    onChanged: _filterPromoCodes,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Promo Code',
                    ),
                  ),
                ),
                Expanded(
                  child: _filteredPromoCodes.isEmpty
                      ? Center(child: Text('No promo codes found'))
                      : ListView.builder(
                          itemCount: _filteredPromoCodes.length,
                          itemBuilder: (context, index) {
                            final code = _filteredPromoCodes[index].promoCode;
                            final discount =
                                _filteredPromoCodes[index].discount;
                            return ListTile(
                              title: Text(code.toUpperCase()),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Congratulations! Promo Discount of $discount% applied successfully."),
                                  Text("Terms & Conditions apply",
                                      style: TextStyle(color: Colors.blue)),
                                ],
                              ),
                              trailing: Icon(Icons.card_giftcard),
                            );
                          },
                        ),
                ),
              ],
            ),
          )
        : SizedBox();
  }
}
