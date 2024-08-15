import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
          child: AppBar(
            backgroundColor: Colors.black,
            title: const Center(
              child: Text(
                'NoteSwap',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle:
                        const TextStyle(color: Color.fromARGB(255, 79, 79, 79)),
                    prefixIcon: const Icon(Icons.search,
                        color: Color.fromARGB(255, 79, 79, 79)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 224, 224, 224),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text('Explore our Library',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLibraryOption(
                  Icons.library_books, 
                  'Available Notes', 
                  () {
                    // Action for Available Notes
                    print("Available Notes Clicked");
                  }
                ),
                _buildLibraryOption(
                  Icons.av_timer, 
                  'Newly added', 
                  () {
                    // Action for Newly added
                    print("Newly added Clicked");
                  }
                ),
                _buildLibraryOption(
                  Icons.local_offer, 
                  'Top selling', 
                  () {
                    // Action for Top selling
                    print("Top selling Clicked");
                  }
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            Text('Explore the Departments',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10.0),
            SizedBox(
              height: MediaQuery.of(context).size.width / 3 * 1.2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        // Action for Department
                        print("Department $index Clicked");
                      },
                      child: _buildDepartmentCard(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text('Get handwritten Notes',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10.0),
            SizedBox(
              height: MediaQuery.of(context).size.width / 3 * 1.2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        // Action for Handwritten Notes
                        print("Handwritten Note $index Clicked");
                      },
                      child: _buildDepartmentCard(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40.0),
            _buildRequestSection(context),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _selectedIndex == 0 ? Colors.purple : Colors.grey,
              size: 36,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _selectedIndex == 1 ? Colors.purple : Colors.grey,
              size: 36,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 36,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              color: _selectedIndex == 3 ? Colors.purple : Colors.grey,
              size: 36,
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: _selectedIndex == 4 ? Colors.purple : Colors.grey,
              size: 36,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.purple,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildLibraryOption(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100.0,
        height: 80.0,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30.0, color: Colors.black),
            const SizedBox(height: 5.0),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildDepartmentCard() {
    return Container(
      width: MediaQuery.of(context).size.width / 3 - 16, // 16 for padding
      height: (MediaQuery.of(context).size.width / 3 - 16) * 1.5,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Icon(Icons.image, size: 40.0, color: Colors.grey[700]),
    );
  }

  Widget _buildRequestSection(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Can't Find what you're Looking For?",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFAA80E0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 20.0),
              ),
              child: const Text(
                'Make a request !',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Colors.black,
        secondary: Colors.purple,
      ),
    ),
    home: FeedScreen(),
  ));
}
