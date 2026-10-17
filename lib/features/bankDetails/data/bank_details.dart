/// The business's bank account, shown to customers paying by bank transfer.
class BankDetails {
  const BankDetails({
    required this.accountHolderName,
    required this.bankName,
    required this.accountNumber,
    required this.ifsc,
    this.branch,
  });

  final String accountHolderName;
  final String bankName;
  final String accountNumber;
  final String ifsc;
  final String? branch;

  Map<String, dynamic> toJson() => {
    'accountHolderName': accountHolderName,
    'bankName': bankName,
    'accountNumber': accountNumber,
    'ifsc': ifsc,
    if (branch != null) 'branch': branch,
  };

  factory BankDetails.fromJson(Map<String, dynamic> json) => BankDetails(
    accountHolderName: json['accountHolderName'] as String? ?? '',
    bankName: json['bankName'] as String? ?? '',
    accountNumber: json['accountNumber'] as String? ?? '',
    ifsc: json['ifsc'] as String? ?? '',
    branch: json['branch'] as String?,
  );

  /// Indian IFSC: 4 letters, a zero, then 6 letters/digits (e.g. HDFC0001234).
  static final ifscPattern = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');
}
