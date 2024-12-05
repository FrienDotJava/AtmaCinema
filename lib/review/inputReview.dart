import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:tubes/client/ReviewClient.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int _rating = 0;
  final TextEditingController _reviewController = TextEditingController();
  final int _idFilm = 5; // Example film ID
  final int _idUser = 13; // Example user ID
  final String _token =
      "39|Ki25V66u6yciXtkCRntTRdFCJN0AQm7fG25bHlXXd2424518"; // Replace with your actual token

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

  Future<void> _saveReview() async {
    String description = _reviewController.text;

    if (_rating == 0 || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please provide a rating and write a review."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      bool success = await ReviewClient.storeReview(
        _idFilm,
        _idUser,
        _rating,
        description,
        _token,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Review successfully added!"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(); // Close the current screen
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to add review."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error occurred: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
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
            color: Colors.black,
            borderRadius: BorderRadius.circular(16.0),
          ),
          width: 400,
          height: 800,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500/RYMX2wcKCBAr24UyPD7xwmjaTn.jpg',
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                "AVENGERS",
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
                controller: _reviewController,
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
                  onPressed: _saveReview,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text("SAVE REVIEW"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
