import 'package:flutter/material.dart';

class MovieReviewPage extends StatelessWidget {
  const MovieReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title:
            const Text("Movie Review", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0A2038),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCombinedRatingAndReviewSummary(),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      _buildReview(
                        reviewerName: "Frendy Suhendro",
                        daysAgo: "3 days ago",
                        rating: 5,
                        reviewText:
                            "The Avengers (2012) is an exciting superhero team-up, blending action, humor, and stunning visuals. Directed by Joss Whedon, it unites Iron Man, Captain America, Thor, and others to battle Loki and an alien invasion. A must-watch for MCU fans!",
                      ),
                      Divider(color: Colors.white.withOpacity(0.2)),
                      _buildReview(
                        reviewerName: "Citra Susanti",
                        daysAgo: "3 days ago",
                        rating: 5,
                        reviewText:
                            "The Avengers (2012) is a thrilling superhero film that brings together Marvel's top heroes to stop Loki's invasion. With sharp dialogue, dynamic action, and great character chemistry, it’s a fun, fast-paced blockbuster and a highlight of the MCU.",
                      ),
                      Divider(color: Colors.white.withOpacity(0.2)),
                      _buildReview(
                        reviewerName: "Richard Sugeno",
                        daysAgo: "3 days ago",
                        rating: 5,
                        reviewText:
                            "In The Avengers (2012), Marvel brings its top heroes together for the first time. Iron Man, Captain America, Thor, and others are united to fight a common enemy. It's a defining moment for superhero cinema!",
                      ),
                      Divider(color: Colors.white.withOpacity(0.2)),
                      _buildReview(
                        reviewerName: "Linda Hartanto",
                        daysAgo: "4 days ago",
                        rating: 4,
                        reviewText:
                            "An iconic movie that set the tone for superhero team-ups. The chemistry between the characters and the action scenes are amazing. Some pacing issues, but overall a great experience!",
                      ),
                      Divider(color: Colors.white.withOpacity(0.2)),
                      _buildReview(
                        reviewerName: "Michael Gunawan",
                        daysAgo: "5 days ago",
                        rating: 4,
                        reviewText:
                            "A well-done film with a lot of humor and heart. The Avengers shows what happens when you bring together different heroes with their unique personalities and quirks. Loved it!",
                      ),
                      Divider(color: Colors.white.withOpacity(0.2)),
                      _buildReview(
                        reviewerName: "Siti Nur Aisyah",
                        daysAgo: "6 days ago",
                        rating: 5,
                        reviewText:
                            "One of my favorite movies of all time! The story, the characters, and the action sequences are top-notch. This movie redefined superhero movies for me.",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCombinedRatingAndReviewSummary() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.star, color: Colors.yellow, size: 48),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "4.8/5",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Container(
          width: 1,
          height: 48,
          color: Colors.white.withOpacity(0.5),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "243 User Ratings",
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
            Text(
              "122 User Reviews",
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReview({
    required String reviewerName,
    required String daysAgo,
    required int rating,
    required String reviewText,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('images/google.png'),
            radius: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reviewerName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  daysAgo,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: List.generate(
                    rating,
                    (index) =>
                        const Icon(Icons.star, color: Colors.yellow, size: 16),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  reviewText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
