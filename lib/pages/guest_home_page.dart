  import 'package:flutter/material.dart';

class GuestHomePage extends StatefulWidget {
  const GuestHomePage({super.key});

  @override
  State<GuestHomePage> createState() => _GuestHomePageState();
}

class _GuestHomePageState extends State<GuestHomePage> {
  Widget buildHotelCard(String name, String city, String price) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/hotel-detail'),
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.only(right: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.grey[300],
                child: const Icon(Icons.image, size: 50),
              ),
              const SizedBox(height: 8),
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  const Icon(Icons.location_pin, color: Colors.red, size: 16),
                  Text(city),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Lorem ipsum dolor sit amet...',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(price,
                  style: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLocationCard(String name) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/location-detail'),
      child: Card(
        margin: const EdgeInsets.only(right: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 120,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Icon(Icons.location_pin, color: Colors.red, size: 30),
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionHeader(String title, {required VoidCallback onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: onTap,
          child: const Text("See All", style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Greeting section
          Row(
            children: [
              const CircleAvatar(radius: 24, backgroundColor: Colors.grey),
              const SizedBox(width: 10),
              const Expanded(
                child: Text('Hi, John Doe',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
              IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
            ],
          ),
          const SizedBox(height: 20),

          // Hotels Section
          sectionHeader("Hotels", onTap: () {
            Navigator.pushNamed(context, '/all-hotels');
          }),
          const SizedBox(height: 10),
          SizedBox(
            height: 230,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                buildHotelCard("Hotel A", "Surabaya", "Rp 2.000.000,00 / Night"),
                buildHotelCard("Hotel B", "Jakarta", "Rp 2.300.000,00 / Night"),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Location Section
          sectionHeader("Location", onTap: () {
            Navigator.pushNamed(context, '/all-locations');
          }),
          const SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                buildLocationCard("Surabaya"),
                buildLocationCard("Jakarta"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
