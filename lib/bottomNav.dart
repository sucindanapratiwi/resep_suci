import 'package:flutter/material.dart';
import 'home.dart';
import 'profile.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  void _onTaped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                autofocus: true,
                onChanged: (query) {
                  setState(() {}); // Memperbarui tampilan berdasarkan input
                },
              )
            : const Text(
                'Resepkue_suci',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
        backgroundColor: Colors.green.shade800,
        elevation: 5,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                }
              });
            },
          ),
        ],
      ),
      body: Center(
        child: _selectedIndex == 0
            ? MyHome() // Meneruskan query
            : Profile(),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: IconButton(
                  icon: const Icon(Icons.home, size: 30),
                  color:
                      _selectedIndex == 0 ? Colors.green.shade800 : Colors.grey,
                  onPressed: () {
                    _onTaped(0);
                  },
                ),
              ),
              const Spacer(),
              Expanded(
                child: IconButton(
                  icon: const Icon(Icons.person, size: 30),
                  color:
                      _selectedIndex == 1 ? Colors.green.shade800 : Colors.grey,
                  onPressed: () {
                    _onTaped(1);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
