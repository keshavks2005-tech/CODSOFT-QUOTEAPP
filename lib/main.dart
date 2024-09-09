import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quotes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuoteScreen(),
    );
  }
}

class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  String _currentQuote = _getRandomQuote();
  List<String> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Quotes'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: _showFavorites,
          ),
        ],
      ),

      body: Center(

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _currentQuote,
                style: TextStyle(fontSize: 26, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 22),
              ElevatedButton(
                onPressed: _refreshQuote,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                child: Text('Get another Quote'),
              ),
              SizedBox(height: 10),
              ElevatedButton(

                onPressed: _shareQuote,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                child: Text('Share Quote'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addToFavorites,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                child: Text('Add to Favorites'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _getRandomQuote() {
    final quotes = [
      "The only way to do great work is to love what you do. - Steve Jobs",
      "Life is what happens when you're busy making other plans. - John Lennon",
      "The purpose of our lives is to be happy. - Dalai Lama",
      "Get busy living or get busy dying. - Stephen King",
      "Success is not the key to happiness. Happiness is the key to success. If you love what you are doing, you will be successful. - Albert Schweitzer",
      "The best way to predict the future is to invent it. - Alan Kay",
      "Your time is limited, so don’t waste it living someone else’s life. - Steve Jobs",
      "The greatest glory in living lies not in never falling, but in rising every time we fall. - Nelson Mandela",
      "In three words I can sum up everything I've learned about life: it goes on. - Robert Frost",
      "Life is short, and it is up to you to make it sweet. - Sarah Louise Delany",
      "To be yourself in a world that is constantly trying to make you something else is the greatest accomplishment. - Ralph Waldo Emerson",
      "Do not go where the path may lead, go instead where there is no path and leave a trail. - Ralph Waldo Emerson",
      "To live is the rarest thing in the world. Most people exist, that is all. - Oscar Wilde",
      "Be yourself; everyone else is already taken. - Oscar Wilde",
      "Two things are infinite: the universe and human stupidity; and I’m not sure about the universe. - Albert Einstein",
      "Be the change that you wish to see in the world. - Mahatma Gandhi",
      "The only impossible journey is the one you never begin. - Tony Robbins",
      "Life is really simple, but we insist on making it complicated. - Confucius",
      "Success usually comes to those who are too busy to be looking for it. - Henry David Thoreau",
      "The best revenge is massive success. - Frank Sinatra",
      "To live is the rarest thing in the world. Most people exist, that is all. - Oscar Wilde",
      "Life is not measured by the number of breaths we take, but by the moments that take our breath away. - Unknown",
      "The journey of a thousand miles begins with one step. - Lao Tzu",
      "Act as if what you do makes a difference. It does. - William James",
      "Success is not final, failure is not fatal: It is the courage to continue that counts. - Winston Churchill",
      "Life isn’t about finding yourself. Life is about creating yourself. - George Bernard Shaw",
      "Success is not how high you have climbed, but how you make a positive difference to the world. - Roy T. Bennett",
      "Your life does not get better by chance, it gets better by change. - Jim Rohn",
      "Success is going from failure to failure without losing your enthusiasm. - Winston Churchill",
      "Believe you can and you're halfway there. - Theodore Roosevelt",
      "The way to get started is to quit talking and begin doing. - Walt Disney",
      "You only live once, but if you do it right, once is enough. - Mae West",
      "The only limit to our realization of tomorrow is our doubts of today. - Franklin D. Roosevelt",
      "Don’t watch the clock; do what it does. Keep going. - Sam Levenson",
      "It does not matter how slowly you go as long as you do not stop. - Confucius",
      "Your limitation—it’s only your imagination.",
      "Push yourself, because no one else is going to do it for you.",
      "Great things never come from comfort zones.",
      "Dream it. Wish it. Do it.",
      "Success doesn’t just find you. You have to go out and get it.",
      "The harder you work for something, the greater you’ll feel when you achieve it.",
      "Dream bigger. Do bigger.",
      "Don’t stop when you’re tired. Stop when you’re done.",
      "Wake up with determination. Go to bed with satisfaction.",
      "Do something today that your future self will thank you for.",
      "Little things make big days.",
      "It’s going to be hard, but hard does not mean impossible.",
      "Don’t wait for opportunity. Create it.",
      "Success doesn’t just find you. You have to go out and get it.",
      "The harder you work for something, the greater you’ll feel when you achieve it.",
      "Dream bigger. Do bigger.",
      "Don’t stop when you’re tired. Stop when you’re done.",
      "Wake up with determination. Go to bed with satisfaction.",
      "Do something today that your future self will thank you for.",
      "Little things make big days.",
      "It’s going to be hard, but hard does not mean impossible.",
      "Don’t wait for opportunity. Create it.",
      "Great things never come from comfort zones.",
      "Dream it. Wish it. Do it.",
      "Success doesn’t just find you. You have to go out and get it.",
      "The harder you work for something, the greater you’ll feel when you achieve it.",
      "Dream bigger. Do bigger.",
      "Don’t stop when you’re tired. Stop when you’re done.",
      "Wake up with determination. Go to bed with satisfaction.",
      "Do something today that your future self will thank you for.",
      "Little things make big days.",
      "It’s going to be hard, but hard does not mean impossible.",
      "Don’t wait for opportunity. Create it.",
      "Success doesn’t just find you. You have to go out and get it.",
      "The harder you work for something, the greater you’ll feel when you achieve it.",
      "Dream bigger. Do bigger.",
      "Don’t stop when you’re tired. Stop when you’re done.",
      "Wake up with determination. Go to bed with satisfaction.",
      "Do something today that your future self will thank you for.",
      "Little things make big days.",
      "It’s going to be hard, but hard does not mean impossible.",
      "Don’t wait for opportunity. Create it.",
      "Success doesn’t just find you. You have to go out and get it.",
      "Great things never come from comfort zones.",
      "Dream it. Wish it. Do it.",
      "The harder you work for something, the greater you’ll feel when you achieve it.",
      "Dream bigger. Do bigger.",
      "Don’t stop when you’re tired. Stop when you’re done.",
      "Wake up with determination. Go to bed with satisfaction.",
      "Do something today that your future self will thank you for.",
      "Little things make big days.",
      "It’s going to be hard, but hard does not mean impossible.",
      "Don’t wait for opportunity. Create it."

    ];
    quotes.shuffle();
    return quotes.last;
  }

  void _refreshQuote() {
    setState(() {
      _currentQuote = _getRandomQuote();
    });
  }

  void _shareQuote() {
    Share.share(_currentQuote);
  }

  void _addToFavorites() async {
    if (!_favorites.contains(_currentQuote)) {
      setState(() {
        _favorites.add(_currentQuote);
      });
      await _saveFavorites();
    }
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _favorites = prefs.getStringList('favorites') ?? [];
    });
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', _favorites);
  }

  void _showFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoritesScreen(favorites: _favorites),
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  final List<String> favorites;

  FavoritesScreen({required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,

      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Favorites'),
      ),

      body: ListView.builder(

        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favorites[index],style:TextStyle(color: Colors.red),),
          );
        },
      ),
    );
  }
}
