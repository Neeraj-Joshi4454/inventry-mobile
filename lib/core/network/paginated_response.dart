/// Mirrors the backend's `{ data: [...], meta: { page, limit, total,
/// totalPages } }` list envelope (see backend/src/utils/apiResponse.ts).
/// A plain generic class rather than a Freezed model — Freezed generics add
/// ceremony this doesn't need since nothing here requires copyWith/equality.
class PaginatedResponse<T> {
  const PaginatedResponse({required this.items, required this.page, required this.totalPages});

  final List<T> items;
  final int page;
  final int totalPages;

  bool get hasNextPage => page < totalPages;

  factory PaginatedResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    final data = json['data'] as List<dynamic>? ?? [];
    final meta = json['meta'] as Map<String, dynamic>?;
    return PaginatedResponse(
      items: data.map((e) => fromJsonT(e as Map<String, dynamic>)).toList(),
      page: (meta?['page'] as num?)?.toInt() ?? 1,
      totalPages: (meta?['totalPages'] as num?)?.toInt() ?? 1,
    );
  }
}
