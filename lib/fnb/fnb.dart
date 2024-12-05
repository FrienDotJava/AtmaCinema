import 'package:flutter/material.dart';
import 'package:tubes/client/MakananMinumanClient.dart';
import 'package:tubes/entity/MakananMinuman.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class FnBPage extends StatefulWidget {
  const FnBPage({Key? key}) : super(key: key);

  @override
  _FnBPageState createState() => _FnBPageState();
}

class _FnBPageState extends State<FnBPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<Makananminuman>> _bundleItems;
  late Future<List<Makananminuman>> _foodItems;
  late Future<List<Makananminuman>> _drinkItems;
  String? token;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadItems();
    _tabController.addListener(_onTabChanged);
  }

  void _loadItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    debugPrint('$token');
    if (token != null) {
      setState(() {
        _bundleItems = MakananMinumanClient.fetchByKategori('bundle', token!);
        _foodItems = MakananMinumanClient.fetchByKategori('makanan', token!);
        _drinkItems = MakananMinumanClient.fetchByKategori('minuman', token!);
      });
    } else {
      print('Token not found');
    }
  }

  void _onTabChanged() {
    setState(() {});
  }

  void _performSearch(String query) {
    if (token != null) {
      String category = _getCategoryByIndex(_tabController.index);
      setState(() {
        _searchQuery = query;
        _bundleItems = MakananMinumanClient.search(query, 'bundle', token!);
        _foodItems = MakananMinumanClient.search(query, 'makanan', token!);
        _drinkItems = MakananMinumanClient.search(query, 'minuman', token!);
      });
    }
  }

  String _getCategoryByIndex(int index) {
    switch (index) {
      case 1:
        return 'makanan';
      case 2:
        return 'minuman';
      default:
        return 'bundle';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text(
          'FnB',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(24.0),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.search, color: Colors.white54),
                        onPressed: () {},
                      ),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: (query) {
                            _performSearch(query);
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search...',
                            hintStyle: TextStyle(color: Colors.white54),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.mic, color: Colors.white54),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                tabs: const [
                  Tab(text: 'Bundle'),
                  Tab(text: 'Food'),
                  Tab(text: 'Drink'),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildFutureBuilder(_bundleItems),
            _buildFutureBuilder(_foodItems),
            _buildFutureBuilder(_drinkItems),
          ],
        ),
      ),
    );
  }

  Widget _buildFutureBuilder(Future<List<Makananminuman>> items) {
    return FutureBuilder(
      future: items,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No items available.'));
        } else {
          return _buildItemList(snapshot.data!);
        }
      },
    );
  }

  Widget _buildItemList(List<Makananminuman> items) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return FnBItemCard(item: items[index]);
      },
    );
  }
}

class FnBItemCard extends StatelessWidget {
  final Makananminuman item;

  const FnBItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedPrice = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ')
        .format(item.harga_item);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      item.gambar,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.nama_item,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          item.deskripsi_item,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Text(
                formattedPrice,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
