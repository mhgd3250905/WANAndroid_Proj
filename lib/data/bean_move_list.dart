import 'dart:convert' show json;

class MovieList {

  int count;
  int start;
  int total;
  String title;
  List<subject> subjects;

  static getDetailDesc(subject detail){
    StringBuffer sb=new StringBuffer();
    for(var i=0;i<detail.directors.length;i++){
      sb.write('${i==0?'':'/'}${detail.directors[i].name}');
    }
    for(var i=0;i<detail.genres.length;i++){
      sb.write('/${detail.genres[i]}');
    }
    sb.write('/${detail.year}');
    return sb.toString();
  }

  MovieList.fromParams({this.count, this.start, this.total, this.title, this.subjects});

  factory MovieList(jsonStr) => jsonStr == null ? null : jsonStr is String ? new MovieList.fromJson(json.decode(jsonStr)) : new MovieList.fromJson(jsonStr);

  MovieList.fromJson(jsonRes) {
    count = jsonRes['count'];
    start = jsonRes['start'];
    total = jsonRes['total'];
    title = jsonRes['title'];
    subjects = jsonRes['subjects'] == null ? null : [];

    for (var subjectsItem in subjects == null ? [] : jsonRes['subjects']){
      subjects.add(subjectsItem == null ? null : new subject.fromJson(subjectsItem));
    }
  }

  @override
  String toString() {
    return '{"count": $count,"start": $start,"total": $total,"title": ${title != null?'${json.encode(title)}':'null'},"subjects": $subjects}';
  }
}

class subject {

  int collect_count;
  bool has_video;
  String alt;
  String id;
  String mainland_pubdate;
  String original_title;
  String subtype;
  String title;
  String year;
  List<cast> casts;
  List<director> directors;
  List<String> durations;
  List<String> genres;
  List<String> pubdates;
  image images;
  rate rating;

  subject.fromParams({this.collect_count, this.has_video, this.alt, this.id, this.mainland_pubdate, this.original_title, this.subtype, this.title, this.year, this.casts, this.directors, this.durations, this.genres, this.pubdates, this.images, this.rating});

  subject.fromJson(jsonRes) {
    collect_count = jsonRes['collect_count'];
    has_video = jsonRes['has_video'];
    alt = jsonRes['alt'];
    id = jsonRes['id'];
    mainland_pubdate = jsonRes['mainland_pubdate'];
    original_title = jsonRes['original_title'];
    subtype = jsonRes['subtype'];
    title = jsonRes['title'];
    year = jsonRes['year'];
    casts = jsonRes['casts'] == null ? null : [];

    for (var castsItem in casts == null ? [] : jsonRes['casts']){
      casts.add(castsItem == null ? null : new cast.fromJson(castsItem));
    }

    directors = jsonRes['directors'] == null ? null : [];

    for (var directorsItem in directors == null ? [] : jsonRes['directors']){
      directors.add(directorsItem == null ? null : new director.fromJson(directorsItem));
    }

    durations = jsonRes['durations'] == null ? null : [];

    for (var durationsItem in durations == null ? [] : jsonRes['durations']){
      durations.add(durationsItem);
    }

    genres = jsonRes['genres'] == null ? null : [];

    for (var genresItem in genres == null ? [] : jsonRes['genres']){
      genres.add(genresItem);
    }

    pubdates = jsonRes['pubdates'] == null ? null : [];

    for (var pubdatesItem in pubdates == null ? [] : jsonRes['pubdates']){
      pubdates.add(pubdatesItem);
    }

    images = jsonRes['images'] == null ? null : new image.fromJson(jsonRes['images']);
    rating = jsonRes['rating'] == null ? null : new rate.fromJson(jsonRes['rating']);
  }

  @override
  String toString() {
    return '{"collect_count": $collect_count,"has_video": $has_video,"alt": ${alt != null?'${json.encode(alt)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"mainland_pubdate": ${mainland_pubdate != null?'${json.encode(mainland_pubdate)}':'null'},"original_title": ${original_title != null?'${json.encode(original_title)}':'null'},"subtype": ${subtype != null?'${json.encode(subtype)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"year": ${year != null?'${json.encode(year)}':'null'},"casts": $casts,"directors": $directors,"durations": $durations,"genres": $genres,"pubdates": $pubdates,"images": $images,"rating": $rating}';
  }
}

class rate {

  int max;
  int min;
  var average;
  String stars;
  detail details;

  rate.fromParams({this.max, this.min, this.average, this.stars, this.details});

  rate.fromJson(jsonRes) {
    max = jsonRes['max'];
    min = jsonRes['min'];
    average = jsonRes['average'];
    stars = jsonRes['stars'];
    details = jsonRes['details'] == null ? null : new detail.fromJson(jsonRes['details']);
  }

  @override
  String toString() {
    return '{"max": $max,"min": $min,"average": $average,"stars": ${stars != null?'${json.encode(stars)}':'null'},"details": $details}';
  }
}

class detail {

  var detial_1;
  var detial_2;
  var detial_3;
  var detial_4;
  var detial_5;

  detail.fromParams({this.detial_1, this.detial_2, this.detial_3, this.detial_4, this.detial_5});

  detail.fromJson(jsonRes) {
    detial_1 = jsonRes['1'];
    detial_2 = jsonRes['2'];
    detial_3 = jsonRes['3'];
    detial_4 = jsonRes['4'];
    detial_5 = jsonRes['5'];
  }

  @override
  String toString() {
    return '{"1": $detial_1,"2": $detial_2,"3": $detial_3,"4": $detial_4,"5": $detial_5}';
  }
}

class image {

  String large;
  String medium;
  String small;

  image.fromParams({this.large, this.medium, this.small});

  image.fromJson(jsonRes) {
    large = jsonRes['large'];
    medium = jsonRes['medium'];
    small = jsonRes['small'];
  }

  @override
  String toString() {
    return '{"large": ${large != null?'${json.encode(large)}':'null'},"medium": ${medium != null?'${json.encode(medium)}':'null'},"small": ${small != null?'${json.encode(small)}':'null'}}';
  }
}

class director {

  String alt;
  String id;
  String name;
  String name_en;
  avatar avatars;

  director.fromParams({this.alt, this.id, this.name, this.name_en, this.avatars});

  director.fromJson(jsonRes) {
    alt = jsonRes['alt'];
    id = jsonRes['id'];
    name = jsonRes['name'];
    name_en = jsonRes['name_en'];
    avatars = jsonRes['avatars'] == null ? null : new avatar.fromJson(jsonRes['avatars']);
  }

  @override
  String toString() {
    return '{"alt": ${alt != null?'${json.encode(alt)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"name_en": ${name_en != null?'${json.encode(name_en)}':'null'},"avatars": $avatars}';
  }
}

class avatar {

  String large;
  String medium;
  String small;

  avatar.fromParams({this.large, this.medium, this.small});

  avatar.fromJson(jsonRes) {
    large = jsonRes['large'];
    medium = jsonRes['medium'];
    small = jsonRes['small'];
  }

  @override
  String toString() {
    return '{"large": ${large != null?'${json.encode(large)}':'null'},"medium": ${medium != null?'${json.encode(medium)}':'null'},"small": ${small != null?'${json.encode(small)}':'null'}}';
  }
}

class cast {

  String alt;
  String id;
  String name;
  String name_en;
  avatar avatars;

  cast.fromParams({this.alt, this.id, this.name, this.name_en, this.avatars});

  cast.fromJson(jsonRes) {
    alt = jsonRes['alt'];
    id = jsonRes['id'];
    name = jsonRes['name'];
    name_en = jsonRes['name_en'];
    avatars = jsonRes['avatars'] == null ? null : new avatar.fromJson(jsonRes['avatars']);
  }

  @override
  String toString() {
    return '{"alt": ${alt != null?'${json.encode(alt)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"name_en": ${name_en != null?'${json.encode(name_en)}':'null'},"avatars": $avatars}';
  }
}



