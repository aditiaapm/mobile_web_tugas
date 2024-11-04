import 'package:flutter/material.dart';
import 'akun_service.dart';
import 'akun.dart';

class DeleteAkunScreen extends StatelessWidget {
  final Akun akun;

  // ignore: use_super_parameters
  const DeleteAkunScreen({Key? key, required this.akun}) : super(key: key);

  Future<void> _deleteAkun(BuildContext context) async {
    final akunService = AkunService();
    try {
      await akunService.deleteAkun(akun.id);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Akun berhasil dihapus!')),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: const Text('Apakah Anda yakin ingin menghapus akun ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteAkun(context);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hapus Akun')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Apakah Anda yakin ingin menghapus akun ini?'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _confirmDelete(context),
              child: const Text('Hapus Akun'),
            ),
          ],
        ),
      ),
    );
  }
}
