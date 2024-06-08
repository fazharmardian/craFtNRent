import 'package:flutter/material.dart';
import '../../model/item.dart';
import 'item_rent.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class ItemMenu extends StatefulWidget {
  const ItemMenu({Key? key}) : super(key: key);

  @override
  State<ItemMenu> createState() => _ItemMenuState();
}

class _ItemMenuState extends State<ItemMenu> {
  List<Item> items = [];
  List<Item> filteredItems = [];
  List<String> itemTypes = ['All'];
  bool isLoading = true;
  String errorMessage = '';
  final TextEditingController searchController = TextEditingController();
  int currentPage = 1;
  int itemsPerPage = 10;

  Future<void> fetchItems() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.252.17/craftnrent/ApiV1/user/get_item.php'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          items = data.map((item) => Item.fromJson(item)).toList();
          filteredItems = items;
          isLoading = false;
          itemTypes.addAll(items.map((item) => item.type).toSet());
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load items';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  Future<void> initializeItems() async {
    await fetchItems();
  }

  @override
  void initState() {
    super.initState();
    initializeItems();
    searchController.addListener(() {
      filterItems();
    });
  }

  void filterItems() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = items.where((item) {
        final itemName = item.name.toLowerCase();
        final itemBrand = item.brand.toLowerCase();
        return itemName.contains(query) || itemBrand.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int totalItems = filteredItems.length;
    final int totalPages = (totalItems / itemsPerPage).ceil();
    final int startIndex = (currentPage - 1) * itemsPerPage;
    final int endIndex = startIndex + itemsPerPage;
    final List<Item> currentPageItems = filteredItems.sublist(startIndex, endIndex < totalItems ? endIndex : totalItems);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0D47A1),
              Color.fromRGBO(0, 0, 0, 1),
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 65),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.only(left: 20),
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(.1),
                ),
                child: TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white.withOpacity(.3),
                    ),
                    border: InputBorder.none,
                    hintText: "Find Your Item...",
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(.3),
                      fontSize: 12,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                height: 30,
                child: ListView.builder(
                  itemCount: itemTypes.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final bool isSelected = filteredItems.isEmpty && index == 0 ||
                        filteredItems.isNotEmpty && filteredItems[0].type == itemTypes[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          filteredItems = index == 0
                              ? items
                              : items.where((item) => item.type == itemTypes[index]).toList();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          itemTypes[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.white.withOpacity(0.4),
                            fontWeight: FontWeight.w300,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                height: 30,
                child: ListView.builder(
                  itemCount: totalPages,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          currentPage = index + 1;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: currentPage == index + 1 ? Colors.black87 : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: currentPage == index + 1 ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : filteredItems.isEmpty
                        ? Center(child: Text(errorMessage, style: const TextStyle(color: Colors.white)))
                        : GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 3 / 4,
                            ),
                            itemCount: currentPageItems.length,
                            itemBuilder: (context, index) {
                              final item = currentPageItems[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ItemRent(
                                        id: item.id,
                                        name: item.name,
                                        brand: item.brand,
                                        image: item.image,
                                        stock: item.stock,
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 10,
                                  color: Colors.white.withOpacity(.1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: LayoutBuilder(
                                            builder: (context, constraints) {
                                              return Image.network(
                                                'http://192.168.252.17/craftnrent/gambar/${item.image}',
                                                fit: BoxFit.cover,
                                                width: constraints.maxWidth,
                                                height: constraints.maxWidth / (16 / 9),
                                                errorBuilder: (context, error, stackTrace) {
                                                  return Container(
                                                    color: Colors.grey,
                                                    child: const Icon(Icons.error, color: Colors.red),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          item.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          item.brand,
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(.5),
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Text(
                                              "Stock: ",
                                              style: TextStyle(
                                                color: Color.fromRGBO(13, 71, 161, 1),
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${item.stock}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],

                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
