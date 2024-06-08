import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/returning.dart';

class ReturnDetail extends StatefulWidget {
  final Returning item;

  const ReturnDetail({super.key, required this.item});

  @override
  State<ReturnDetail> createState() => _ReturnDetailState();
}

class _ReturnDetailState extends State<ReturnDetail> {
  Future<void> _returnItem() async {
    final response = await http.post(
      Uri.parse('http://192.168.252.17/craftnrent/ApiV1/user/return.php'),
      body: {
        'rent_id': widget.item.rentId,
        'id_user': widget.item.userId,
        'id_item': widget.item.itemId,
        'total_request': widget.item.total,
        'return_date': widget.item.returnDate,
      },
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Returning Request Sent Successfully",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
      );
      Navigator.pop(context);
    } else {
      print('Failed to send returning request');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: ClipRRect(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      'http://192.168.252.17/craftnrent/gambar/${widget.item.itemImage}',
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
                    widget.item.itemName,
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.item.itemBrand,
                    style: TextStyle(
                      fontSize: 17,
                      color: Color.fromRGBO(13, 71, 161, 0.5),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Request: ',
                          style: TextStyle(
                            color: Color.fromRGBO(13, 71, 161, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.item.total,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Must Return at: ',
                          style: TextStyle(
                            color: Color.fromRGBO(13, 71, 161, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.item.returnDate,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
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
                        decoration: const BoxDecoration(
                          color:Color.fromRGBO(13, 71, 161, 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: TextButton(
                          onPressed: _returnItem,
                          child: const Text(
                            "Return Now",
                            style: TextStyle(
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