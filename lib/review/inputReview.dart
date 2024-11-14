import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int _rating = 0;

  void _setRating(int rating) {
    setState(() {
      _rating = rating;
    });
  }

  Widget _buildStar(int index) {
    return SizedBox(
      width: 45.0,
      child: IconButton(
        icon: Icon(
          index < _rating ? Icons.star : Icons.star_outlined,
          color: index < _rating ? Colors.yellow : Colors.white,
        ),
        iconSize: 50.0,
        onPressed: () => _setRating(index + 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF04031E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF04031E),
        title: const Text('Review', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF000B6D),
                Color(0xFF000000),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          width: 400,
          height: 800,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(5.0),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg',
                  height: 120,
                  fit: BoxFit
                      .cover,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                "AVENGERS: INFINITY WAR",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) => _buildStar(index)),
              ),
              SizedBox(height: 8.0),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Write your review description here...",
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 12.0),
              SizedBox(
                width: 360.0,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text("SAVE REVIEW"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
