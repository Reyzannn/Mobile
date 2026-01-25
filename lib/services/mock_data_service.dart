class MockDataService {
  // Data statistik dummy
  static Map<String, dynamic> getStatistik() {
    return {
      'total_sekbid': 10,
      'total_program_kerja': 5,
      'total_kritik_saran': 1,
      'proker_baru_7hari': 1,
    };
  }

  // Data program kerja dummy
  static List<Map<String, dynamic>> getProgramKerja() {
    return [
      {
        'id': 1,
        'nama_program': 'Mengadakan ngaji bersama',
        'sekbid': '1',
        'status': 'ONGOING',
        'tanggal': '21 Jan 2026',
        'status_color': 'orange',
      },
      {
        'id': 2,
        'nama_program': 'Mengadakan Jalan Sehat',
        'sekbid': '7',
        'status': 'COMPLETED',
        'tanggal': '17 Agu 2025',
        'status_color': 'green',
      },
      {
        'id': 3,
        'nama_program': 'Mengawasi dan Membantu Ekstrakurikuler PMR',
        'sekbid': '7',
        'status': 'COMPLETED',
        'tanggal': '24 Nov 2025',
        'status_color': 'green',
      },
      {
        'id': 4,
        'nama_program': 'Pembagian Tablet Tambah Darah',
        'sekbid': '7',
        'status': 'COMPLETED',
        'tanggal': '14 Nov 2025',
        'status_color': 'green',
      },
      {
        'id': 5,
        'nama_program': 'Pelaksanaan Classmeet',
        'sekbid': '7',
        'status': 'COMPLETED',
        'tanggal': '17 Des 2025',
        'status_color': 'green',
      },
    ];
  }

  // Data user dummy
  static Map<String, dynamic> getUserData() {
    return {
      'nama': 'Admin OSIS',
      'jabatan': 'Admin',
      'kelas': 'XII IPA 3',
      'email': 'admin@osis.smktag.sch.id',
      'username': 'admin',
      'foto': null,
    };
  }
}
