class SearchPlace {
  final String detail;
  final String place;

  SearchPlace({required this.place, required this.detail});

  factory SearchPlace.fromJson(Map<String, dynamic> json) {
    return SearchPlace(
      detail: json['description'],
      place: json['place_id'],
    );
  }
}
