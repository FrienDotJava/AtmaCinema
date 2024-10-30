import 'package:flutter/material.dart';

class FnBPage extends StatefulWidget {
  const FnBPage({Key? key}) : super(key: key);

  @override
  _FnBPageState createState() => _FnBPageState();
}

class _FnBPageState extends State<FnBPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                    color: const Color(0x1F1F1F),
                    borderRadius: BorderRadius.circular(24.0),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.search, color: Colors.white54),
                        onPressed: () {
                          //buat search nanti
                        },
                      ),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.mic, color: Colors.white54),
                        onPressed: () {
                          // buat voice search nanti
                        },
                      ),
                    ],
                  ),
                ),
              ),
              TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                tabs: [
                  _buildTab("Bundle", isSelected: _tabController.index == 0),
                  _buildTab("Food", isSelected: _tabController.index == 1),
                  _buildTab("Drink", isSelected: _tabController.index == 2),
                ],
                onTap: (index) {
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF000000), Color(0xFF000B6D)],
            stops: [0.3, 0.7],
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildItemList(_bundles),
            _buildItemList(_foods),
            _buildItemList(_drinks),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String label, {required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.black,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.black : Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildItemList(List<Item> items) {
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
  final Item item;

  const FnBItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'images/bg4.jpg',
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
                      item.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  item.price,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Item {
  final String title;
  final String description;
  final String price;

  Item({required this.title, required this.description, required this.price});
}

final List<Item> _bundles = [
  Item(
      title: 'Atma Bundle 1',
      description: 'Atma Popcorn Small + Soft Drink Small',
      price: 'Rp 45.000'),
  Item(
      title: 'Atma Bundle 2',
      description: 'Atma Popcorn Medium + Soft Drink Small',
      price: 'Rp 60.000'),
  Item(
      title: 'Atma Bundle 3',
      description: 'Atma Popcorn Large + Soft Drink Small',
      price: 'Rp 75.000'),
  Item(
      title: 'Atma Bundle 4',
      description: 'Atma Snack Platter + Atma Tea',
      price: 'Rp 100.000'),
];

final List<Item> _foods = [
  Item(
      title: 'Atma Popcorn Small',
      description: 'Small-sized popcorn',
      price: 'Rp 30.000'),
  Item(
      title: 'Atma Popcorn Medium',
      description: 'Medium-sized popcorn',
      price: 'Rp 45.000'),
  Item(
      title: 'Atma Popcorn Large',
      description: 'Large-sized popcorn',
      price: 'Rp 60.000'),
  Item(
      title: 'Atma Snack Platter',
      description: 'Delicious snack platter',
      price: 'Rp 70.000'),
];

final List<Item> _drinks = [
  Item(
      title: 'Soft Drink Small',
      description: 'Refreshing soft drink',
      price: 'Rp 15.000'),
  Item(
      title: 'Soft Drink Large',
      description: 'Large refreshing drink',
      price: 'Rp 25.000'),
  Item(title: 'Milo', description: 'Medium Sized Milo', price: 'Rp 35.000'),
  Item(
      title: 'Atma Tea', description: 'Authentic Atma tea', price: 'Rp 20.000'),
];
