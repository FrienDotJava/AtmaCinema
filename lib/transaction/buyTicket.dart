import 'package:flutter/material.dart';
import 'package:tubes/entity/Film.dart';
import 'package:tubes/client/FilmClient.dart';

class MovieShowtimePage extends StatefulWidget {
  final Film movie;

  const MovieShowtimePage({
    required this.movie,
    Key? key,
  }) : super(key: key);

  @override
  State<MovieShowtimePage> createState() => _MovieShowtimePageState();
}

class _MovieShowtimePageState extends State<MovieShowtimePage> {
  int selectedDateIndex = 0;
  DateTime? selectedDate;
  String? selectedTime;
  Map<String, dynamic> filmSchedule = {}; // Untuk menyimpan jadwal film

  @override
  void initState() {
    super.initState();
    selectedDate =
        DateTime.now(); // Biar tanggal awal di view adalah tanggal hari ini
    selectedDateIndex =
        0; // Menyeting index tanggal yang dipilih adalah tanggal hari ini
    _loadFilmSchedule();
  }

  // Fungsi untuk memuat jadwal film dari API
  void _loadFilmSchedule() async {
    try {
      var scheduleData = await FilmClient.getFilmSchedule(widget.movie.id_film);
      print("Schedule data received: $scheduleData");
      setState(() {
        filmSchedule = scheduleData; // Untuk nyimpan data jadwal film
      });
    } catch (e) {
      print('Error fetching schedule: $e');
    }
  }

  // Untuk mendapatkan nama bulan berdasarkan angka bulan
  String _getMonth(int month) {
    List<String> months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[month - 1];
  }

  // Bagian membuat UI dari list showtimes yang didapat dari API dengan button button
  Widget _buildShowtimesList() {
    if (filmSchedule.isEmpty) {
      return Center(
          child: CircularProgressIndicator()); // Buat loading biar gak null
    }

    // List untuk menyimpan showtimes
    List<String> showtimes = [];

    // Melakukan iterasi pada data jadwal film
    filmSchedule.forEach((key, value) {
      // Mengecek apakah value merupakan list
      if (value is List) {
        // Perulangan tiap item di list
        for (var item in value) {
          // Pengecekan apakah item merupakan map dan memiliki key 'jam_tayang'
          if (item is Map && item.containsKey('jam_tayang')) {
            showtimes.add(item['jam_tayang']
                .toString()); // Menambahkan jam tayang ke list showtimes
          }
        }
      } else {
        print("Unexpected data for key $key: $value");
      }
    });

    // Mengecek apakah showtimes kosong
    if (showtimes.isEmpty) {
      return Center(child: Text('No showtimes available.'));
    }

    // Proses membuat button button showtimes
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 16.0,
      runSpacing: 16.0,
      children: showtimes.map((showtime) {
        return Container(
          width: 180,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                selectedTime = showtime;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  selectedTime == showtime ? Colors.amber : Colors.grey[800],
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: selectedTime == showtime
                      ? Colors.amber
                      : Colors.grey[600]!,
                  width: 2.0,
                ),
              ),
              elevation: 5,
            ),
            child: Text(
              showtime,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.movie.judul_film,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ini Bagian Detail Dari Film
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        widget.movie.poster,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.movie.judul_film,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.access_time,
                                  color: Colors.grey, size: 14),
                              const SizedBox(width: 4),
                              Text("${widget.movie.durasi} min",
                                  style: const TextStyle(color: Colors.white)),
                              const SizedBox(width: 16),
                              const Icon(Icons.visibility,
                                  color: Colors.grey, size: 14),
                              const SizedBox(width: 4),
                              Text("${widget.movie.rating_umur}",
                                  style: TextStyle(color: Colors.white)),
                              const SizedBox(width: 16),
                              const Icon(Icons.theaters,
                                  color: Colors.grey, size: 14),
                              const SizedBox(width: 4),
                              Text("Regular 2D",
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text("${widget.movie.genre}",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Bagian Pemilihan Tanggal
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      DateTime date = DateTime.now().add(Duration(days: index));
                      bool isSelected = selectedDateIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDateIndex = index;
                            selectedDate = date;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF0A2038)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Text(
                              "${date.day} ${_getMonth(date.month)}",
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // Showtimes section with styled buttons
                Text(
                  'Showtimes',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 8),
                _buildShowtimesList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
