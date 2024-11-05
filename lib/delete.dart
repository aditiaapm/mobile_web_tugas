import 'package:flutter/material.dart';
import 'akun_service.dart';
import 'akun.dart';

class DeleteAkunScreen extends StatelessWidget {
  final Akun akun;

  // ignore: use_super_parameters
  DeleteAkunScreen({Key? key, required this.akun}) : super(key: key);

  final AkunService akunService = AkunService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hapus Akun')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Anda yakin ingin menghapus akun ini?'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await akunService.deleteAkun(akun.id);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gagal menghapus akun: $e')),
                  );
                }
              },
              child: const Text('Hapus Akun'),
            ),
          ],
        ),
      ),
    );
  }
}
