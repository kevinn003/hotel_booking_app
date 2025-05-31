import 'package:flutter/material.dart';

class GuestHomePage extends StatefulWidget {
  const GuestHomePage({super.key});

  @override
  State<GuestHomePage> createState() => _GuestHomePageState();
}

class _GuestHomePageState extends State<GuestHomePage> {
  final Set<String> _wishlist = {};

  void _toggleWishlist(String hotelName) {
    setState(() {
      if (_wishlist.contains(hotelName)) {
        _wishlist.remove(hotelName);
      } else {
        _wishlist.add(hotelName);
      }
    });
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
          const _GreetingHeader(),
          const SizedBox(height: 20),
          _SectionHeader(
            title: "Hotels",
            onTap: () => Navigator.pushNamed(context, '/all-hotels'),
          ),
          const SizedBox(height: 10),
          _HotelListView(
            wishlist: _wishlist,
            onToggleWishlist: _toggleWishlist,
          ),
          const SizedBox(height: 20),
          _SectionHeader(
            title: "Location",
            onTap: () => Navigator.pushNamed(context, '/all-locations'),
          ),
          const SizedBox(height: 10),
          const _LocationListView(),
        ],
      ),
    );
  }
}

// ----------------------------- COMPONENTS -----------------------------

class _GreetingHeader extends StatelessWidget {
  const _GreetingHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(radius: 24, backgroundColor: Colors.grey),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            'Hi, John Doe',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _SectionHeader({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
}

class _HotelListView extends StatelessWidget {
  const _HotelListView({
    required this.wishlist,
    required this.onToggleWishlist,
  });

  final Set<String> wishlist;
  final Function(String) onToggleWishlist;

  @override
  Widget build(BuildContext context) {
    final hotels = [
      ["Hotel A", "Surabaya", "Rp 2.000.000,00 / Night"],
      ["Hotel B", "Jakarta", "Rp 2.300.000,00 / Night"],
      ["Hotel C", "Malang", "Rp 2.300.000,00 / Night"],
      ["Hotel D", "Yogyakarta", "Rp 2.300.000,00 / Night"],
    ];

    return SizedBox(
      height: 250,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: hotels.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, index) {
          final h = hotels[index];
          final isWishlisted = wishlist.contains(h[0]);

          return _HotelCard(
            name: h[0],
            city: h[1],
            price: h[2],
            isWishlisted: isWishlisted,
            onWishlistToggle: () => onToggleWishlist(h[0]),
          );
        },
      ),
    );
  }
}

class _HotelCard extends StatelessWidget {
  final String name;
  final String city;
  final String price;
  final bool isWishlisted;
  final VoidCallback onWishlistToggle;

  const _HotelCard({
    required this.name,
    required this.city,
    required this.price,
    required this.isWishlisted,
    required this.onWishlistToggle,
  });

   @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/hotel-detail'),
      child: Card(
        elevation: 2,
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

              // Judul + lokasi + ikon favorit
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            const Icon(Icons.location_pin,
                                color: Colors.red, size: 16),
                            const SizedBox(width: 4),
                            Text(city),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isWishlisted
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: isWishlisted ? Colors.red : Colors.grey,
                    ),
                    onPressed: onWishlistToggle,
                  ),
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
}

class _LocationListView extends StatelessWidget {
  const _LocationListView();

  @override
  Widget build(BuildContext context) {
    final locations = ["Surabaya", "Jakarta", "Malang", "Yogyakarta"];

    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: locations.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, index) {
          return _LocationCard(name: locations[index]);
        },
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  final String name;

  const _LocationCard({required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/location-detail'),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 120,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_pin, color: Colors.red, size: 30),
              Text(name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
