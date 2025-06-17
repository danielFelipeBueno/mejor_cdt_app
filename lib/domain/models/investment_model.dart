class Investment {
  final double amount;
  final double rate;
  final DateTime startDate;
  final DateTime endDate;
  final double roi;
  final bool status;
  final String id;
  final String bankName;
  final DateTime createdAt;

  Investment({
    required this.amount,
    required this.rate,
    required this.startDate,
    required this.endDate,
    required this.roi,
    required this.status,
    required this.id,
    required this.bankName,
    required this.createdAt,
  });

  factory Investment.fromJson(Map<String, dynamic> json) {
    return Investment(
      amount: json['amount'],
      rate: (json['rate'] as num).toDouble(),
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      roi: json['roi'],
      status: json['status'],
      id: json['id'],
      bankName: json['bank_name'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  factory Investment.fromDatabase(Map<String, dynamic> map) {
    return Investment(
      amount: (map['amount'] as num).toDouble(),
      rate: (map['rate'] as num).toDouble(),
      startDate: DateTime.parse(map['start_date']),
      endDate: DateTime.parse(map['end_date']),
      roi: (map['roi'] as num).toDouble(),
      status: map['status'] == 1,
      id: map['id'],
      bankName: map['bank_name'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'rate': rate,
      'start_date': startDate.toIso8601String().split('T').first,
      'end_date': endDate.toIso8601String().split('T').first,
      'roi': roi,
      'status': status,
      'id': id,
      'bank_name': bankName,
      'created_at': createdAt.toIso8601String().split('T').first,
    };
  }

  Map<String, dynamic> toDatabase() {
    return {
      'amount': amount,
      'rate': rate,
      'start_date': startDate.toIso8601String().split('T').first,
      'end_date': endDate.toIso8601String().split('T').first,
      'roi': roi,
      'status': status ? 1 : 0,
      'id': id,
      'bank_name': bankName,
      'created_at': createdAt.toIso8601String().split('T').first,
    };
  }

  @override
  String toString() => 'Investment(id: $id, amount: $amount)';
}
