import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ItemRent extends StatefulWidget {
  final String id;
  final String name;
  final String brand;
  final String image;
  final String stock;

  const ItemRent({
    Key? key,
    required this.id,
    required this.name,
    required this.brand,
    required this.image,
    required this.stock,
  }) : super(key: key);

  @override
  _ItemRentState createState() => _ItemRentState();
}

class _ItemRentState extends State<ItemRent> {
  String? userId;
  int itemCount = 0;
  DateTime? returnDate;
  final TextEditingController itemCountController = TextEditingController();

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });
  }

  Future<void> _initializePage() async {
    await _loadUserId();
  }

  @override
  void initState() {
    super.initState();
    _initializePage();
    itemCountController.text = itemCount.toString();
  }

  @override
  void dispose() {
    itemCountController.dispose();
    super.dispose();
  }

  Future<void> _rentItem() async {
    if (userId == null) {
      return;
    }

    if (itemCount <= 0 || returnDate == null) {
      return;
    }

    final response = await http.post(
      Uri.parse('http://192.168.252.17/craftnrent/ApiV1/user/lent.php'),
      body: {
        'id_user': userId,
        'id_item': widget.id,
        'total_request': itemCount.toString(),
        'return_date': returnDate.toString(),
      },
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Renting Request Sent Successfully",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
      );
      Navigator.pop(context);
    } else {
      print('Failed to send borrowing request');
    }
  }

  void _updateItemCount(String value) {
    final int? count = int.tryParse(value);
    if (count != null && count >= 0 && count <= int.parse(widget.stock)) {
      setState(() {
        itemCount = count;
      });
    } else {
      itemCountController.text = itemCount.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      'http://192.168.252.17/craftnrent/gambar/${widget.image}',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(13, 71, 161, 0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios_outlined,
                                color: Colors.white.withOpacity(.5),
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Details",
                    style: TextStyle(
                      color: Color.fromRGBO(13, 71, 161, .5),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.brand,
                    style: TextStyle(
                      fontSize: 17,
                      color: Color.fromRGBO(13, 71, 161, 0.5),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Total Item: ',
                              style: TextStyle(
                                color: Color.fromRGBO(13, 71, 161, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: widget.stock,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            color: Colors.white,
                            onPressed: itemCount > 0
                                ? () {
                                    setState(() {
                                      itemCount--;
                                      itemCountController.text = itemCount.toString();
                                    });
                                  }
                                : null,
                          ),
                          SizedBox(
                            width: 40,
                            child: TextFormField(
                              controller: itemCountController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                              ),
                              onChanged: _updateItemCount,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            color: Colors.white,
                            onPressed: itemCount < int.parse(widget.stock)
                                ? () {
                                    setState(() {
                                      itemCount++;
                                      itemCountController.text = itemCount.toString();
                                    });
                                  }
                                : null,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text(
                        "Return at: ",
                        style: TextStyle(
                          color: Color.fromRGBO(13, 71, 161, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: returnDate != null
                                  ? '${returnDate!.year}-${returnDate!.month}-${returnDate!.day}'
                                  : 'Select return date',
                              hintStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  final now = DateTime.now();
                                  final lastSelectableDate = now.add(Duration(days: 7));
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: now,
                                    firstDate: now,
                                    lastDate: lastSelectableDate,
                                  );
                                  if (selectedDate != null) {
                                    setState(() {
                                      returnDate = selectedDate;
                                    });
                                  }
                                },
                                icon: Icon(Icons.calendar_today),
                                color: Colors.white,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(top: 12)
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: itemCount > 0 && returnDate != null
                              ? const Color.fromRGBO(13, 71, 161, 1)
                              : const Color.fromRGBO(13, 71, 161, 0.5),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: TextButton(
                          onPressed: itemCount > 0 && returnDate != null
                              ? _rentItem
                              : null,
                          child: Text(
                            itemCount > 0 && returnDate != null
                                ? "Rent Now"
                                : "Rent Now",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
