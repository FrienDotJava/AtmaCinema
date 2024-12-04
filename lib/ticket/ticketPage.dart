import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes/client/TiketClient.dart';
import 'package:tubes/entity/Tiket.dart';
import 'package:tubes/transaction/ticketDetails.dart';
import 'package:intl/intl.dart';

class TiketPage extends StatefulWidget {
  const TiketPage({Key? key}) : super(key: key);

  @override
  _TiketPageState createState() => _TiketPageState();
}

class _TiketPageState extends State<TiketPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Future<List<Tiket>>? _onProgressTickets;
  Future<List<Tiket>>? _historyTickets;
  String? token;
  int? userId;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadTickets();
  }

  void _loadTickets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userId = prefs.getInt('user_id');

    if (token != null && userId != null) {
      setState(() {
        _onProgressTickets = TiketClient.fetchByUser(userId!, token!);
        _historyTickets = TiketClient.fetchByUser(
            userId!, token!); // Update this with actual logic for history
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Tickets", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "On Progress"),
            Tab(text: "History"),
          ],
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(color: Colors.grey, width: 1),
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
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search tickets...',
                        hintStyle: TextStyle(color: Colors.white54),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTicketListView(_onProgressTickets),
                _buildTicketListView(_historyTickets),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketListView(Future<List<Tiket>>? ticketList) {
    return FutureBuilder<List<Tiket>>(
      future: ticketList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No tickets available.'));
        } else {
          final filteredTickets = snapshot.data!
              .where((tiket) =>
                  tiket.nomor_kursi.toString().contains(_searchQuery))
              .toList();

          return ListView.builder(
            itemCount: filteredTickets.length,
            itemBuilder: (context, index) {
              return _buildTicketCard(filteredTickets[index]);
            },
          );
        }
      },
    );
  }

  Widget _buildTicketCard(Tiket tiket) {
    final formattedPrice = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ')
        .format(tiket.nomor_kursi);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.grey, width: 2.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  '/images/bg2.jpg',
                  width: 80,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tiket #${tiket.id_tiket}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Seat: ${tiket.nomor_kursi}',
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formattedPrice,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieTicketDetails(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Details"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
