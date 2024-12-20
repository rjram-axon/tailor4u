import 'package:flutter/material.dart';

class SortAndFilterPage extends StatefulWidget {
  final String selectedSortOption;
  final bool inStockFilter;
  final bool onSaleFilter;
  final Function(String sortOption, bool inStock, bool onSale) onApply;

  SortAndFilterPage({
    required this.selectedSortOption,
    required this.inStockFilter,
    required this.onSaleFilter,
    required this.onApply,
  });

  @override
  _SortAndFilterPageState createState() => _SortAndFilterPageState();
}

class _SortAndFilterPageState extends State<SortAndFilterPage> {
  late String selectedSortOption;
  late bool inStockFilter;
  late bool onSaleFilter;

  @override
  void initState() {
    super.initState();
    selectedSortOption = widget.selectedSortOption;
    inStockFilter = widget.inStockFilter;
    onSaleFilter = widget.onSaleFilter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sort & Filter")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sort By",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            DropdownButton<String>(
              value: selectedSortOption,
              items: [
                DropdownMenuItem(value: 'price_asc', child: Text("Price: Low to High")),
                DropdownMenuItem(value: 'price_desc', child: Text("Price: High to Low")),
                DropdownMenuItem(value: 'rating', child: Text("Top Rated")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedSortOption = value!;
                });
              },
              isExpanded: true,
            ),
            SizedBox(height: 16),
            Text(
              "Filters",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            CheckboxListTile(
              title: Text("In Stock"),
              value: inStockFilter,
              onChanged: (value) {
                setState(() {
                  inStockFilter = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text("On Sale"),
              value: onSaleFilter,
              onChanged: (value) {
                setState(() {
                  onSaleFilter = value!;
                });
              },
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                widget.onApply(selectedSortOption, inStockFilter, onSaleFilter);
                Navigator.pop(context);
              },
              child: Text("Apply"),
            ),
          ],
        ),
      ),
    );
  }
}
