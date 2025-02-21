import 'package:flutter/material.dart';
import 'package:blog_app/utils/shared_prefs.dart';
import 'package:blog_app/utils/dummy_data.dart'; // Import dummy data
import 'login_screen.dart';
import 'blog_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Use blogs from dummy_data.dart
  final List<Map<String, String>> blogs = dummyBlogs;

  Future<bool> _checkLoginStatus() async {
    return await SharedPrefs.getLoginState();
  }

  Future<void> _logout(BuildContext context) async {
    await SharedPrefs.clearLoginState();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()), // Show loading indicator while checking login
          );
        }

        if (snapshot.hasData && snapshot.data == true) {
          return Scaffold(
            appBar: AppBar(
  title: const Text('All Blogs'),
  actions: [
    IconButton(
      icon: const Icon(Icons.book),
      tooltip: 'My Blogs',
      onPressed: () {
        Navigator.pushNamed(context, '/myBlogs'); // Navigate to MyBlogsScreen
      },
    ),
    IconButton(
      icon: const Icon(Icons.logout),
      tooltip: 'Logout',
      onPressed: () => _logout(context),
    ),
  ],
),

            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: blogs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlogDetailScreen(blog: blogs[index]),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.article,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  blogs[index]['title']!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'By ${blogs[index]['author']!}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return const LoginScreen(); // If not logged in, redirect to LoginScreen
        }
      },
    );
  }
}
