import 'package:flutter/material.dart';
import 'movie.dart';
import 'payment.dart';

class MovieShowtimePage extends StatefulWidget {
  final Movie movie;

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
  String? selected2DTime;
  String? selected3DTime;
  String selectedCinemaFormat = "Regular 2D";

  @override
  void initState() {
    super.initState();
    //Ini biar kalau kita buka halaman ini, tanggalnya langsung keiisi di indeks pertama
    selectedDate = DateTime.now(); //Ni buat isi isi aja (Kalau gaada error)
    selectedDateIndex = 0; // Pilih hari pertama
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
          widget.movie.title,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
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
                          widget.movie.posterUrl,
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
                              widget.movie.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: const [
                                Icon(Icons.access_time,
                                    color: Colors.grey, size: 14),
                                SizedBox(width: 4),
                                Text("1h 20m",
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(width: 16),
                                Icon(Icons.visibility,
                                    color: Colors.grey, size: 14),
                                SizedBox(width: 4),
                                Text("17+",
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(width: 16),
                                Icon(Icons.theaters,
                                    color: Colors.grey, size: 14),
                                SizedBox(width: 4),
                                Text("2D",
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text("Action, Sci-Fi",
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Ini bagian pemilihan tanggal
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        DateTime date =
                            DateTime.now().add(Duration(days: index));
                        bool isSelected = selectedDateIndex == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDateIndex = index;
                              selectedDate =
                                  date; // Untuk menyimpan tanggal yang dipilih
                              selected2DTime = null;
                              selected3DTime = null;
                            });
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
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
                                  color:
                                      isSelected ? Colors.white : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // Untuk waktu tayang dan harga sesuai 2D atau 3D
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A2038),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Regular 2D",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        Text("Rp 50.000",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Ini untuk membuat tombol waktu tayang dengan menggunakan fungsi _buildShowtimeButtons
                    // Ini bagian untuk menampilkan waktu tayang 2D
                    _buildShowtimeButtons(
                        ["11:00", "13:00", "15:00", "17:00", "19:00", "21:00"],
                        is2D: true),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Regular 3D",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        Text("Rp 60.000",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Ini untuk membuat tombol waktu tayang dengan menggunakan fungsi _buildShowtimeButtons
                    // Ini bagian untuk menampilkan waktu tayang 3D
                    // Kalau mau modifikasi tinggal sama kek atas
                    _buildShowtimeButtons(["11:00", "15:00", "19:00"],
                        is2D: false),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membuat tombol waktu tayang
  Widget _buildShowtimeButtons(List<String> times, {required bool is2D}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 4.5,
      ),
      itemCount: times.length,
      itemBuilder: (context, index) {
        String time = times[index];
        bool isSelected =
            is2D ? selected2DTime == time : selected3DTime == time;

        return ElevatedButton(
          onPressed: () {
            setState(() {
              if (is2D) {
                selected2DTime = time;
                selected3DTime = null;
                selectedCinemaFormat = "Regular 2D";
              } else {
                selected3DTime = time;
                selected2DTime = null;
                selectedCinemaFormat = "Regular 3D";
              }
            });
            _showTicketSelectionModal(time);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? Colors.amber : Colors.white,
            foregroundColor: isSelected ? Colors.black : Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text(time, style: const TextStyle(fontSize: 14)),
        );
      },
    );
  }

  // Fungsi untuk menampilkan modal pembelian tiket
  void _showTicketSelectionModal(String time) {
    int seatCount = 1;
    double ticketPrice =
        selectedCinemaFormat == "Regular 3D" ? 60000.0 : 50000.0;
    double totalPrice = ticketPrice * seatCount;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black87,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          widget.movie.posterUrl,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.movie.title,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              "${selectedDate != null ? '${selectedDate!.day} ${_getMonth(selectedDate!.month)} 2024' : 'Date not selected'} - $time",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Text("100 seat(s) available",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.white),
                        onPressed: () {
                          if (seatCount > 1) {
                            setModalState(() {
                              seatCount--;
                              totalPrice = ticketPrice * seatCount;
                            });
                          }
                        },
                      ),
                      Text("$seatCount",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.white),
                        onPressed: () {
                          if (seatCount < 100) {
                            setModalState(() {
                              seatCount++;
                              totalPrice = ticketPrice * seatCount;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Payment(
                          //Untuk membawa data ke halaman selanjutnya (Payment)
                          movie: widget.movie,
                          ticketCount: seatCount,
                          ticketPrice: ticketPrice,
                          totalPrice: totalPrice,
                          selectedTime: time,
                          selectedCinemaFormat: selectedCinemaFormat,
                          selectedDate: selectedDate!,
                        ),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 48),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text("CONTINUE",
                        style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Fungsi untuk mengubah angka bulan menjadi nama bulan
  String _getMonth(int month) {
    const months = [
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
}
