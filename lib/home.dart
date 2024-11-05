import 'package:dummy_server/about.dart';
import 'package:dummy_server/contact.dart';
import 'package:dummy_server/cart.dart';
import 'package:flutter/material.dart';
import 'akun_service.dart';
import 'update.dart';
import 'delete.dart';
import 'akun.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final AkunService akunService = AkunService();
  final Cart cart = Cart();

  late TabController _tabController;
  Akun? currentAkun;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    currentAkun = Akun(nama: "User", email: "", id: '', password: '', name: '');
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selamat Datang'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person), // Ganti ikon menjadi ikon profil
            onPressed: () {
              if (currentAkun != null) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Pilih Tindakan'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.edit),
                            title: const Text('Perbarui Akun'),
                            onTap: () {
                              Navigator.pop(context); // Tutup dialog
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateAkunScreen(akun: currentAkun!),
                                ),
                              );
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.delete),
                            title: const Text('Hapus Akun'),
                            onTap: () {
                              Navigator.pop(context); // Tutup dialog
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DeleteAkunScreen(akun: currentAkun!),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Akun tidak tersedia.')),
                );
              }
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Home'),
            Tab(text: 'About'),
            Tab(text: 'Contact'),
            Tab(icon: Icon(Icons.shopping_cart)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildHomeContent(),
          AboutPage(),
          ContactPage(),
          _buildCartContent(),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.5,
            child: Image.asset(
              'images/bg3.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Produk Sepatu',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    ShoesItem(name: 'Nike', price: 899000, image: 'images/foto1.jpeg', cart: cart),
                    ShoesItem(name: 'Adidas', price: 799000, image: 'images/foto2.webp', cart: cart),
                    ShoesItem(name: 'Mizuno', price: 999000, image: 'images/foto3.webp', cart: cart),
                    ShoesItem(name: 'Specs', price: 699000, image: 'images/foto4.jpg', cart: cart),
                    ShoesItem(name: 'Ortuseight', price: 599000, image: 'images/foto5.webp', cart: cart),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCartContent() {
    return cart.itemCount > 0
        ? ListView.builder(
            itemCount: cart.itemCount,
            itemBuilder: (context, index) {
              final item = cart.items[index];
              return ListTile(
                leading: Image.asset(item.image, height: 50, width: 50, fit: BoxFit.cover),
                title: Text(item.name),
                subtitle: Text('Rp${item.price} - Ukuran: ${item.size}'),
              );
            },
          )
        : const Center(
            child: Text('Keranjang Anda kosong'),
          );
  }
}

class ShoesItem extends StatefulWidget {
  final String name;
  final int price;
  final String image;
  final Cart cart;
  const ShoesItem({super.key, required this.name, required this.price, required this.image, required this.cart});

  @override
  // ignore: library_private_types_in_public_api
  _ShoesItemState createState() => _ShoesItemState();
}

class _ShoesItemState extends State<ShoesItem> {
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(widget.image, height: 80, width: 80, fit: BoxFit.cover),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Rp${widget.price}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        hint: const Text("Pilih Ukuran"),
                        value: selectedSize,
                        isExpanded: true,
                        items: <String>['38', '39', '40', '41', '42', '43'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedSize = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedSize != null) {
                          widget.cart.addItem(ShoeItem(
                            name: widget.name,
                            price: widget.price,
                            image: widget.image,
                            size: selectedSize!,
                          ));

                          (context.findAncestorStateOfType<_HomeScreenState>() as _HomeScreenState).setState(() {});

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${widget.name} - Ukuran: $selectedSize ditambahkan ke keranjang')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Silakan pilih ukuran terlebih dahulu.')),
                          );
                        }
                      },
                      child: const Text('Tambahkan ke Keranjang'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
