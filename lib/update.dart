import 'package:flutter/material.dart';
import 'akun_service.dart';
import 'akun.dart';

class UpdateAkunScreen extends StatefulWidget {
  final Akun akun;

  // ignore: use_super_parameters
  const UpdateAkunScreen({Key? key, required this.akun}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UpdateAkunScreenState createState() => _UpdateAkunScreenState();
}

class _UpdateAkunScreenState extends State<UpdateAkunScreen> {
  final AkunService akunService = AkunService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.akun.name;
    emailController.text = widget.akun.email;
  }

  Future<void> _updateAkun() async {
    // Validasi input
    if (nameController.text.isEmpty || emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama dan Email tidak boleh kosong!')),
      );
      return;
    }

    try {
      await akunService.updateAkun(widget.akun.id, nameController.text, emailController.text);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Akun berhasil diperbarui!')),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Akun')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateAkun,
              child: const Text('Perbarui Akun'),
            ),
          ],
        ),
      ),
    );
  }
}
