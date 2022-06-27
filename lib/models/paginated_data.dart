class PaginatedData<T> {
  final List<T> data;
  final int page;
  final int total;
  final int limit;

  const PaginatedData({
    required this.data,
    required this.page,
    required this.total,
    required this.limit,
  });

  factory PaginatedData.fromJson(Map<String, dynamic> json,
          List<T> Function(List<dynamic>) dataParser) =>
      PaginatedData(
        data: dataParser(json['data']),
        page: json['page'] as int,
        total: json['total'] as int,
        limit: json['limit'] as int,
      );
}
