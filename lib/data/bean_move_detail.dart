import 'dart:convert' show json;

class MovieDetail {

  Object collection;
  Object current_season;
  Object do_count;
  Object episodes_count;
  Object seasons_count;
  int collect_count;
  int comments_count;
  int photos_count;
  int ratings_count;
  int reviews_count;
  int wish_count;
  bool has_schedule;
  bool has_ticket;
  bool has_video;
  String alt;
  String douban_site;
  String id;
  String mainland_pubdate;
  String mobile_url;
  String original_title;
  String pubdate;
  String schedule_url;
  String share_url;
  String subtype;
  String summary;
  String title;
  String website;
  String year;
  List<String> aka;
  List<dynamic> blooper_urls;
  List<dynamic> bloopers;
  List<cast> casts;
  List<dynamic> clip_urls;
  List<dynamic> clips;
  List<String> countries;
  List<director> directors;
  List<String> durations;
  List<String> genres;
  List<String> languages;
  List<photo> photos;
  List<popular_comment> popular_comments;
  List<popular_review> popular_reviews;
  List<String> pubdates;
  List<String> tags;
  List<String> trailer_urls;
  List<trailer> trailers;
  List<video> videos;
  List<writer> writers;
  image images;
  rate rating;

  getTitleDescTop(){
    StringBuffer sb=new StringBuffer();
    if(original_title!=title){
      sb.write(original_title);
    }
    sb.write('($year)');
    return sb.toString();
  }

  getTitleDescBottom(){
    StringBuffer sb=new StringBuffer();
    for(var i=0;i<countries.length;i++){
      sb.write('${i==0?'':'/'}${countries[i]}');
    }
    for(var i=0;i<genres.length;i++){
      sb.write('/${genres[i]}');
    }
    sb.write('/上映时间：${pubdates[0]}');
    sb.write('/片长：${durations[0]}');
    return sb.toString();
  }

  getDetailDesc(){
      StringBuffer sb=new StringBuffer();
      for(var i=0;i<directors.length;i++){
        sb.write('${i==0?'':'/'}${directors[i].name}');
      }
      for(var i=0;i<genres.length;i++){
        sb.write('/${genres[i]}');
      }
      sb.write('/${year}');
      return sb.toString();
  }

  getCollectPeopleCount(){
    return (collect_count/1000.0).toStringAsFixed(1);
  }

  getWishPeopleCount(){
    return (wish_count/1000.0).toStringAsFixed(1);
  }

  MovieDetail.fromParams({this.collection, this.current_season, this.do_count, this.episodes_count, this.seasons_count, this.collect_count, this.comments_count, this.photos_count, this.ratings_count, this.reviews_count, this.wish_count, this.has_schedule, this.has_ticket, this.has_video, this.alt, this.douban_site, this.id, this.mainland_pubdate, this.mobile_url, this.original_title, this.pubdate, this.schedule_url, this.share_url, this.subtype, this.summary, this.title, this.website, this.year, this.aka, this.blooper_urls, this.bloopers, this.casts, this.clip_urls, this.clips, this.countries, this.directors, this.durations, this.genres, this.languages, this.photos, this.popular_comments, this.popular_reviews, this.pubdates, this.tags, this.trailer_urls, this.trailers, this.videos, this.writers, this.images, this.rating});

  factory MovieDetail(jsonStr) => jsonStr == null ? null : jsonStr is String ? new MovieDetail.fromJson(json.decode(jsonStr)) : new MovieDetail.fromJson(jsonStr);

  MovieDetail.fromJson(jsonRes) {
    collection = jsonRes['collection'];
    current_season = jsonRes['current_season'];
    do_count = jsonRes['do_count'];
    episodes_count = jsonRes['episodes_count'];
    seasons_count = jsonRes['seasons_count'];
    collect_count = jsonRes['collect_count'];
    comments_count = jsonRes['comments_count'];
    photos_count = jsonRes['photos_count'];
    ratings_count = jsonRes['ratings_count'];
    reviews_count = jsonRes['reviews_count'];
    wish_count = jsonRes['wish_count'];
    has_schedule = jsonRes['has_schedule'];
    has_ticket = jsonRes['has_ticket'];
    has_video = jsonRes['has_video'];
    alt = jsonRes['alt'];
    douban_site = jsonRes['douban_site'];
    id = jsonRes['id'];
    mainland_pubdate = jsonRes['mainland_pubdate'];
    mobile_url = jsonRes['mobile_url'];
    original_title = jsonRes['original_title'];
    pubdate = jsonRes['pubdate'];
    schedule_url = jsonRes['schedule_url'];
    share_url = jsonRes['share_url'];
    subtype = jsonRes['subtype'];
    summary = jsonRes['summary'];
    title = jsonRes['title'];
    website = jsonRes['website'];
    year = jsonRes['year'];
    aka = jsonRes['aka'] == null ? null : [];

    for (var akaItem in aka == null ? [] : jsonRes['aka']){
      aka.add(akaItem);
    }

    blooper_urls = jsonRes['blooper_urls'] == null ? null : [];

    for (var blooper_urlsItem in blooper_urls == null ? [] : jsonRes['blooper_urls']){
      blooper_urls.add(blooper_urlsItem);
    }

    bloopers = jsonRes['bloopers'] == null ? null : [];

    for (var bloopersItem in bloopers == null ? [] : jsonRes['bloopers']){
      bloopers.add(bloopersItem);
    }

    casts = jsonRes['casts'] == null ? null : [];

    for (var castsItem in casts == null ? [] : jsonRes['casts']){
      casts.add(castsItem == null ? null : new cast.fromJson(castsItem));
    }

    clip_urls = jsonRes['clip_urls'] == null ? null : [];

    for (var clip_urlsItem in clip_urls == null ? [] : jsonRes['clip_urls']){
      clip_urls.add(clip_urlsItem);
    }

    clips = jsonRes['clips'] == null ? null : [];

    for (var clipsItem in clips == null ? [] : jsonRes['clips']){
      clips.add(clipsItem);
    }

    countries = jsonRes['countries'] == null ? null : [];

    for (var countriesItem in countries == null ? [] : jsonRes['countries']){
      countries.add(countriesItem);
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

    languages = jsonRes['languages'] == null ? null : [];

    for (var languagesItem in languages == null ? [] : jsonRes['languages']){
      languages.add(languagesItem);
    }

    photos = jsonRes['photos'] == null ? null : [];

    for (var photosItem in photos == null ? [] : jsonRes['photos']){
      photos.add(photosItem == null ? null : new photo.fromJson(photosItem));
    }

    popular_comments = jsonRes['popular_comments'] == null ? null : [];

    for (var popular_commentsItem in popular_comments == null ? [] : jsonRes['popular_comments']){
      popular_comments.add(popular_commentsItem == null ? null : new popular_comment.fromJson(popular_commentsItem));
    }

    popular_reviews = jsonRes['popular_reviews'] == null ? null : [];

    for (var popular_reviewsItem in popular_reviews == null ? [] : jsonRes['popular_reviews']){
      popular_reviews.add(popular_reviewsItem == null ? null : new popular_review.fromJson(popular_reviewsItem));
    }

    pubdates = jsonRes['pubdates'] == null ? null : [];

    for (var pubdatesItem in pubdates == null ? [] : jsonRes['pubdates']){
      pubdates.add(pubdatesItem);
    }

    tags = jsonRes['tags'] == null ? null : [];

    for (var tagsItem in tags == null ? [] : jsonRes['tags']){
      tags.add(tagsItem);
    }

    trailer_urls = jsonRes['trailer_urls'] == null ? null : [];

    for (var trailer_urlsItem in trailer_urls == null ? [] : jsonRes['trailer_urls']){
      trailer_urls.add(trailer_urlsItem);
    }

    trailers = jsonRes['trailers'] == null ? null : [];

    for (var trailersItem in trailers == null ? [] : jsonRes['trailers']){
      trailers.add(trailersItem == null ? null : new trailer.fromJson(trailersItem));
    }

    videos = jsonRes['videos'] == null ? null : [];

    for (var videosItem in videos == null ? [] : jsonRes['videos']){
      videos.add(videosItem == null ? null : new video.fromJson(videosItem));
    }

    writers = jsonRes['writers'] == null ? null : [];

    for (var writersItem in writers == null ? [] : jsonRes['writers']){
      writers.add(writersItem == null ? null : new writer.fromJson(writersItem));
    }

    images = jsonRes['images'] == null ? null : new image.fromJson(jsonRes['images']);
    rating = jsonRes['rating'] == null ? null : new rate.fromJson(jsonRes['rating']);
  }

  @override
  String toString() {
    return '{"collection": $collection,"current_season": $current_season,"do_count": $do_count,"episodes_count": $episodes_count,"seasons_count": $seasons_count,"collect_count": $collect_count,"comments_count": $comments_count,"photos_count": $photos_count,"ratings_count": $ratings_count,"reviews_count": $reviews_count,"wish_count": $wish_count,"has_schedule": $has_schedule,"has_ticket": $has_ticket,"has_video": $has_video,"alt": ${alt != null?'${json.encode(alt)}':'null'},"douban_site": ${douban_site != null?'${json.encode(douban_site)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"mainland_pubdate": ${mainland_pubdate != null?'${json.encode(mainland_pubdate)}':'null'},"mobile_url": ${mobile_url != null?'${json.encode(mobile_url)}':'null'},"original_title": ${original_title != null?'${json.encode(original_title)}':'null'},"pubdate": ${pubdate != null?'${json.encode(pubdate)}':'null'},"schedule_url": ${schedule_url != null?'${json.encode(schedule_url)}':'null'},"share_url": ${share_url != null?'${json.encode(share_url)}':'null'},"subtype": ${subtype != null?'${json.encode(subtype)}':'null'},"summary": ${summary != null?'${json.encode(summary)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"website": ${website != null?'${json.encode(website)}':'null'},"year": ${year != null?'${json.encode(year)}':'null'},"aka": $aka,"blooper_urls": $blooper_urls,"bloopers": $bloopers,"casts": $casts,"clip_urls": $clip_urls,"clips": $clips,"countries": $countries,"directors": $directors,"durations": $durations,"genres": $genres,"languages": $languages,"photos": $photos,"popular_comments": $popular_comments,"popular_reviews": $popular_reviews,"pubdates": $pubdates,"tags": $tags,"trailer_urls": $trailer_urls,"trailers": $trailers,"videos": $videos,"writers": $writers,"images": $images,"rating": $rating}';
  }
}

class rate {

  int max;
  int min;
  double average;
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

  int getDetailTotal(){
    return (detial_1+detial_2+detial_3+detial_4+detial_5).toInt();
  }

   double getDetailIndexRate(int index){
    double sum=detial_1+detial_2+detial_3
        +detial_4+detial_5;
    double rate=0.0;
    switch(index){
      case 1:
        rate=detial_1/sum;
        break;
      case 2:
        rate=detial_2/sum;
        break;
      case 3:
        rate=detial_3/sum;
        break;
      case 4:
        rate=detial_4/sum;
        break;
      case 5:
        rate=detial_5/sum;
        break;
    }
    return rate;
  }

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

class writer {

  String alt;
  String id;
  String name;
  String name_en;
  avatar avatars;

  writer.fromParams({this.alt, this.id, this.name, this.name_en, this.avatars});

  writer.fromJson(jsonRes) {
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

class video {

  bool need_pay;
  String sample_link;
  String video_id;
  source_item source;

  video.fromParams({this.need_pay, this.sample_link, this.video_id, this.source});

  video.fromJson(jsonRes) {
    need_pay = jsonRes['need_pay'];
    sample_link = jsonRes['sample_link'];
    video_id = jsonRes['video_id'];
    source = jsonRes['source'] == null ? null : new source_item.fromJson(jsonRes['source']);
  }

  @override
  String toString() {
    return '{"need_pay": $need_pay,"sample_link": ${sample_link != null?'${json.encode(sample_link)}':'null'},"video_id": ${video_id != null?'${json.encode(video_id)}':'null'},"source": $source}';
  }
}

class source_item {

  String literal;
  String name;
  String pic;

  source_item.fromParams({this.literal, this.name, this.pic});

  source_item.fromJson(jsonRes) {
    literal = jsonRes['literal'];
    name = jsonRes['name'];
    pic = jsonRes['pic'];
  }

  @override
  String toString() {
    return '{"literal": ${literal != null?'${json.encode(literal)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"pic": ${pic != null?'${json.encode(pic)}':'null'}}';
  }
}

class trailer {

  String alt;
  String id;
  String medium;
  String resource_url;
  String small;
  String subject_id;
  String title;

  trailer.fromParams({this.alt, this.id, this.medium, this.resource_url, this.small, this.subject_id, this.title});

  trailer.fromJson(jsonRes) {
    alt = jsonRes['alt'];
    id = jsonRes['id'];
    medium = jsonRes['medium'];
    resource_url = jsonRes['resource_url'];
    small = jsonRes['small'];
    subject_id = jsonRes['subject_id'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"alt": ${alt != null?'${json.encode(alt)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"medium": ${medium != null?'${json.encode(medium)}':'null'},"resource_url": ${resource_url != null?'${json.encode(resource_url)}':'null'},"small": ${small != null?'${json.encode(small)}':'null'},"subject_id": ${subject_id != null?'${json.encode(subject_id)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'}}';
  }
}

class popular_review {

  String alt;
  String id;
  String subject_id;
  String summary;
  String title;
  author_item author;
  rate rating;

  popular_review.fromParams({this.alt, this.id, this.subject_id, this.summary, this.title, this.author, this.rating});

  popular_review.fromJson(jsonRes) {
    alt = jsonRes['alt'];
    id = jsonRes['id'];
    subject_id = jsonRes['subject_id'];
    summary = jsonRes['summary'];
    title = jsonRes['title'];
    author = jsonRes['author'] == null ? null : new author_item.fromJson(jsonRes['author']);
    rating = jsonRes['rating'] == null ? null : new rate.fromJson(jsonRes['rating']);
  }

  @override
  String toString() {
    return '{"alt": ${alt != null?'${json.encode(alt)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"subject_id": ${subject_id != null?'${json.encode(subject_id)}':'null'},"summary": ${summary != null?'${json.encode(summary)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"author": $author,"rating": $rating}';
  }
}



class author_item {

  String alt;
  String avatar;
  String id;
  String name;
  String signature;
  String uid;

  author_item.fromParams({this.alt, this.avatar, this.id, this.name, this.signature, this.uid});

  author_item.fromJson(jsonRes) {
    alt = jsonRes['alt'];
    avatar = jsonRes['avatar'];
    id = jsonRes['id'];
    name = jsonRes['name'];
    signature = jsonRes['signature'];
    uid = jsonRes['uid'];
  }

  @override
  String toString() {
    return '{"alt": ${alt != null?'${json.encode(alt)}':'null'},"avatar": ${avatar != null?'${json.encode(avatar)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"signature": ${signature != null?'${json.encode(signature)}':'null'},"uid": ${uid != null?'${json.encode(uid)}':'null'}}';
  }
}

class popular_comment {

  int useful_count;
  String content;
  String created_at;
  String id;
  String subject_id;
  author_item author;
  rate rating;

  getUserfulCountDesc(){
    return (useful_count/1000.0).toStringAsFixed(1);
  }

  popular_comment.fromParams({this.useful_count, this.content, this.created_at, this.id, this.subject_id, this.author, this.rating});

  popular_comment.fromJson(jsonRes) {
    useful_count = jsonRes['useful_count'];
    content = jsonRes['content'];
    created_at = jsonRes['created_at'];
    id = jsonRes['id'];
    subject_id = jsonRes['subject_id'];
    author = jsonRes['author'] == null ? null : new author_item.fromJson(jsonRes['author']);
    rating = jsonRes['rating'] == null ? null : new rate.fromJson(jsonRes['rating']);
  }

  @override
  String toString() {
    return '{"useful_count": $useful_count,"content": ${content != null?'${json.encode(content)}':'null'},"created_at": ${created_at != null?'${json.encode(created_at)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"subject_id": ${subject_id != null?'${json.encode(subject_id)}':'null'},"author": $author,"rating": $rating}';
  }
}




class photo {

  String alt;
  String cover;
  String icon;
  String id;
  String image;
  String thumb;

  photo.fromParams({this.alt, this.cover, this.icon, this.id, this.image, this.thumb});

  photo.fromJson(jsonRes) {
    alt = jsonRes['alt'];
    cover = jsonRes['cover'];
    icon = jsonRes['icon'];
    id = jsonRes['id'];
    image = jsonRes['image'];
    thumb = jsonRes['thumb'];
  }

  @override
  String toString() {
    return '{"alt": ${alt != null?'${json.encode(alt)}':'null'},"cover": ${cover != null?'${json.encode(cover)}':'null'},"icon": ${icon != null?'${json.encode(icon)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"image": ${image != null?'${json.encode(image)}':'null'},"thumb": ${thumb != null?'${json.encode(thumb)}':'null'}}';
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



