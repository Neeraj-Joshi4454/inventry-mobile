import 'package:freezed_annotation/freezed_annotation.dart';

part 'audit_log_entry.freezed.dart';

@freezed
abstract class AuditLogEntry with _$AuditLogEntry {
  const factory AuditLogEntry({
    required String id,
    required String action,
    required String entityType,
    required String actorRole,
    required DateTime createdAt,
  }) = _AuditLogEntry;

  factory AuditLogEntry.fromJson(Map<String, dynamic> json) {
    return AuditLogEntry(
      id: (json['_id'] ?? json['id']).toString(),
      action: json['action'] as String,
      entityType: json['entityType'] as String,
      actorRole: json['actorRole'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
