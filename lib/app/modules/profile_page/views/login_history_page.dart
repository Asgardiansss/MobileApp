import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/service/session_service.dart';

class LoginHistoryPage extends StatefulWidget {
  const LoginHistoryPage({super.key});

  @override
  State<LoginHistoryPage> createState() => _LoginHistoryPageState();
}

class _LoginHistoryPageState extends State<LoginHistoryPage> {
  final sessionService = SessionService();

  // late Future<List<Map<String, dynamic>>> _loginHistoryFuture;

  Future<List<Map<String, dynamic>>>? _loginHistoryFuture;

  @override
  void initState() {
    super.initState();

    // PENTING: initialize date formatting dulu
    initializeDateFormatting('id_ID', null).then((_) {
      setState(() {
        _loginHistoryFuture = _cleanAndLoadLoginHistory();
      });
    });
  }

  Future<List<Map<String, dynamic>>> _cleanAndLoadLoginHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList('login_history') ?? [];

    final cleanList = <String>[];

    for (var item in rawList) {
      try {
        final decoded = jsonDecode(item);
        if (decoded is Map<String, dynamic> &&
            decoded.containsKey('time_login') &&
            decoded.containsKey('device') &&
            decoded.containsKey('ip_address')) {
          DateTime.parse(decoded['time_login']); // validasi format tanggal
          cleanList.add(item);
        }
      } catch (_) {
        // skip jika error decode atau format
      }
    }

    await prefs.setStringList('login_history', cleanList);
    return cleanList.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
  }

  Future<void> _clearLoginHistory() async {
    await sessionService.cleanLoginHistory();
    setState(() {
      _loginHistoryFuture = Future.value([]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsDark.primary,
      appBar: AppBar(
        backgroundColor: AppColorsDark.primary,
        title: const Text('Login History', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.redAccent),
            tooltip: 'Hapus Semua Riwayat',
            onPressed: () {
              Get.defaultDialog(
                backgroundColor: AppColorsDark.primary,
                title: 'Hapus Riwayat',
                titleStyle: const TextStyle(color: Colors.white),
                middleText: 'Yakin ingin menghapus semua login history?',
                middleTextStyle: const TextStyle(color: Colors.white70),
                cancel: TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('Batal', style: TextStyle(color: Colors.white)),
                ),
                confirm: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () async {
                    await _clearLoginHistory();
                    Get.back();
                    Get.snackbar('Berhasil', 'Riwayat login telah dihapus',
                        colorText: Colors.white,
                        backgroundColor: Colors.green,
                        snackPosition: SnackPosition.TOP);
                  },
                  child: const Text('Hapus'),
                ),
              );
            },
          ),
        ],
      ),
      body: _loginHistoryFuture == null
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : FutureBuilder<List<Map<String, dynamic>>>(
        future: _loginHistoryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error memuat data: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white70)),
            );
          }

          final history = snapshot.data ?? [];

          if (history.isEmpty) {
            return const Center(
              child: Text("Belum ada riwayat login.",
                  style: TextStyle(color: Colors.white70)),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: history.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = history[index];
              return _buildLoginHistoryCard(item);
            },
          );
        },
      ),

    );
  }

  Widget _buildLoginHistoryCard(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColorsDark.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0xFF575757), offset: Offset(-2, -2), blurRadius: 1),
          BoxShadow(color: Color(0xFF000000), offset: Offset(2, 2), blurRadius: 1),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.login, color: Colors.greenAccent),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _formatDateTime(item['time_login']),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColorsDark.teksPrimary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.devices, 'Perangkat', item['device'] ?? 'Tidak diketahui'),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.location_on_outlined, 'IP Address', item['ip_address'] ?? 'Tidak diketahui'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: AppColorsDark.teksPrimary),
          ),
        ),
      ],
    );
  }

  String _formatDateTime(String? dateTime) {
    if (dateTime == null) return 'Tidak diketahui';

    try {
      final dt = DateTime.parse(dateTime).toLocal();
      return DateFormat('EEEE, dd MMM yyyy – HH:mm', 'id_ID').format(dt);
    } catch (e) {
      return 'Format tanggal tidak valid';
    }
  }
}
