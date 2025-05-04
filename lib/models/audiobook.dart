import 'package:just_audio/just_audio.dart';

class Audiobook {
  final String title;
  final String author;
  final String coverUrl;
  final String audioUrl;
  final String documentUrl;
  final String? description;
  final int? duration;
  final String? category;
  final DateTime? publishedDate;
  final String number;
  final List<String> subParts;

  Audiobook({
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.audioUrl,
    required this.documentUrl,
    this.description,
    this.duration,
    this.category,
    this.publishedDate,
    required this.number,
    this.subParts = const [],
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'author': author,
        'coverUrl': coverUrl,
        'audioUrl': audioUrl,
        'documentUrl': documentUrl,
        'description': description,
        'duration': duration,
        'category': category,
        'publishedDate': publishedDate?.toIso8601String(),
        'number': number,
        'subParts': subParts,
      };

  factory Audiobook.fromJson(Map<String, dynamic> json) => Audiobook(
        title: json['title'],
        author: json['author'],
        coverUrl: json['coverUrl'],
        audioUrl: json['audioUrl'],
        documentUrl: json['documentUrl'],
        description: json['description'],
        duration: json['duration'],
        category: json['category'],
        publishedDate: json['publishedDate'] != null
            ? DateTime.parse(json['publishedDate'])
            : null,
        number: json['number'],
        subParts: json['subParts'] as List<String>? ?? [],
      );

  Audiobook copyWith({
    String? title,
    String? author,
    String? coverUrl,
    String? audioUrl,
    String? documentUrl,
    String? description,
    int? duration,
    String? category,
    DateTime? publishedDate,
    String? number,
    List<String>? subParts,
  }) {
    return Audiobook(
      title: title ?? this.title,
      author: author ?? this.author,
      coverUrl: coverUrl ?? this.coverUrl,
      audioUrl: audioUrl ?? this.audioUrl,
      documentUrl: documentUrl ?? this.documentUrl,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      category: category ?? this.category,
      publishedDate: publishedDate ?? this.publishedDate,
      number: number ?? this.number,
      subParts: subParts ?? this.subParts,
    );
  }

  AudioSource getAudioSource() {
    if (audioUrl.startsWith('assets/')) {
      final assetPath = audioUrl.replaceFirst('assets/', '');
      return AudioSource.asset(assetPath);
    }
    return AudioSource.uri(Uri.parse(audioUrl));
  }

  static final List<Audiobook> sampleAudiobooks = _generateSampleAudiobooks();

  static List<Audiobook> _generateSampleAudiobooks() {
    const baseProperties = {
      'author': 'ቅዱስ ዳዊት',
      'coverUrl': 'assets/images/mezmure dawit.jpg',
      'category': 'መዝሙር',
    };

    const mezmurData = <Map<String, dynamic>>[
      {'number': '፩', 'description': 'ብፁዕ ብእሲ ዘኢሖረ በምክረ ረሠይዓን።', 'duration': '180'},
      {'number': '፪', 'description': 'ለምንት አንገሠው አሕዛብ። ወሕዝብኒ ተባህሉ ከንቶ።', 'duration': '240'},
      {'number': '፫', 'description': 'እግዚኦ በውስተ ምንት ተባዝኁ እለ ያሥዕሩኒ።', 'duration': '200'},
      {'number': '፬', 'description': 'በጸውዕኩ ተወከፍከኒ አምላከ ጽድቅየ።', 'duration': '210'},
      {'number': '፭', 'description': 'ቃልየ በእዝንከ ስማዕ እግዚኦ።', 'duration': '195'},
      {'number': '፮', 'description': 'እግዚኦ በመዓትከ ኢትቅሥፈኒ።', 'duration': '205'},
      {'number': '፯', 'description': 'እግዚኦ አምላኪየ ዲቤከ ተወከልኩ።', 'duration': '215'},
      {'number': '፰', 'description': 'እግዚኦ እግዚእነ መፍቀሬ ስምከ።', 'duration': '190'},
      {'number': '፱', 'description': 'እሴብሐከ እግዚኦ በኵሉ ልብየ።', 'duration': '200'},
      {'number': '፲', 'description': 'እትወከል እግዚኦ ዲቤከ።', 'duration': '185'},
      {'number': '፲፩', 'description': 'አድኅነኒ እግዚኦ እስመ አኅለቀ ጻድቅ።', 'duration': '195'},
      {'number': '፲፪', 'description': 'እስከ ማእዜኑ እግዚኦ ትረስየኒ ወስከ ማእዜኑ ታርሕቅ ገጸከ እምኔየ።', 'duration': '200'},
      {'number': '፲፫', 'description': 'ይቤ እኁድ በልቡ አልቦ አምላክ።', 'duration': '185'},
      {'number': '፲፬', 'description': 'እግዚኦ መኑ ያኅድር ውስተ ማኅደሪከ።', 'duration': '190'},
      {'number': '፲፭', 'description': 'ዕቀበኒ እግዚኦ እስመ ዲቤከ ተወከልኩ።', 'duration': '205'},
      {'number': '፲፮', 'description': 'ስምዕ እግዚኦ ጽድቅየ።', 'duration': '195'},
      {'number': '፲፯', 'description': 'አፈቅረከ እግዚኦ ኃይልየ።', 'duration': '210'},
      {'number': '፲፰', 'description': 'ሰማያት ይነግሩ ስብሐተ እግዚአብሔር።', 'duration': '220'},
      {'number': '፲፱', 'description': 'ይስማዕከ እግዚአብሔር በዕለተ ምንዳቤከ።', 'duration': '200'},
      {'number': '፳', 'description': 'እግዚኦ በኃይልከ ይትፌሣሕ ንጉሥ።', 'duration': '195'},
          // ... previous mezmurs ...
    {'number': '፳፩', 'description': 'አምላኪየ አምላኪየ ተመይጠኒ።', 'duration': '200'},
    {'number': '፳፪', 'description': 'እግዚአብሔር ይርዓየኒ ወአልቦ ዘየኀጽረኒ።', 'duration': '185'},
    {'number': '፳፫', 'description': 'ለእግዚአብሔር ምድር ወምልአ።', 'duration': '190'},
    {'number': '፳፬', 'description': 'ኀቤከ እግዚኦ አንሣእኩ ነፍስየ።', 'duration': '195'},
    {'number': '፳፭', 'description': 'ፍትሕ ኢየ እግዚኦ እስመ አነ በየውሀትየ ሖርኩ።', 'duration': '210'},
    {'number': '፳፮', 'description': 'እግዚአብሔር ብርሃንየ ወመድኃንየ።', 'duration': '200'},
    {'number': '፳፯', 'description': 'ኀቤከ እግዚኦ እጸርኅ አምላኪየ።', 'duration': '195'},
    {'number': '፳፰', 'description': 'አምጽኡ ለእግዚአብሔር ደቂቀ አምላክ።', 'duration': '185'},
    {'number': '፳፱', 'description': 'አልዕለከ እግዚኦ እስመ ተወከፍከኒ።', 'duration': '190'},
    {'number': '፴', 'description': 'ዲቤከ እግዚኦ ተወከልኩ።', 'duration': '200'},
    {'number': '፴፩', 'description': 'ብፁዓን እለ ተኀድገ ለሙ አበሳሆሙ።', 'duration': '195'},
    {'number': '፴፪', 'description': 'ተፈሥሑ ጻድቃን በእግዚአብሔር።', 'duration': '185'},
    {'number': '፴፫', 'description': 'እባርኮ ለእግዚአብሔር በኵሉ ጊዜ።', 'duration': '190'},
    {'number': '፴፬', 'description': 'ኰንን እግዚኦ ለእለ ይኴንኑኒ።', 'duration': '200'},
    {'number': '፴፭', 'description': 'ይቤ ጌጋይ ለኃጥእ በማእከለ ልቡ።', 'duration': '195'},
    {'number': '፴፮', 'description': 'ኢትቅንእ እንተ እኩያን።', 'duration': '185'},
    {'number': '፴፯', 'description': 'እግዚኦ በመዓትከ ኢትቅሥፈኒ።', 'duration': '190'},
    {'number': '፴፰', 'description': 'እቤ እዕቀብ ፍኖትየ።', 'duration': '200'},
    {'number': '፴፱', 'description': 'ተስፋ ገበርኩ እግዚአብሔርሃ።', 'duration': '195'},
    {'number': '፵', 'description': 'ብፁዕ ዘያስተናብብ ለነዳይ ወለምስኪን።', 'duration': '185'},
    // ... remaining mezmurs ...
      {'number': '፵፩', 'description': 'በከመ ይፈቅድ አይል ኀበ ነቅዐ ማይ።', 'duration': '190'},
      {'number': '፵፪', 'description': 'ፍትሕ ኢየ እግዚኦ ወኰንን ኵነኔየ።', 'duration': '195'},
      {'number': '፵፫', 'description': 'አምላክ በእזንነ ሰማዕነ።', 'duration': '200'},
      {'number': '፵፬', 'description': 'አፈልፈለ ልብየ ቃለ ሠናየ።', 'duration': '185'},
      {'number': '፵፭', 'description': 'አምላክነ ስደተ ወኃይለ።', 'duration': '190'},
      {'number': '፵፮', 'description': 'አሕዛብ ኵልክሙ አጥብዕዎ እደዊክሙ።', 'duration': '195'},
      {'number': '፵፯', 'description': 'ዐቢይ እግዚአብሔር ወስቡሕ ጥቀ።', 'duration': '200'},
      {'number': '፵፰', 'description': 'ስምዑ ዘንተ አሕዛብ ኵልክሙ።', 'duration': '185'},
      {'number': '፵፱', 'description': 'አምላከ አማልክት እግዚአብሔር ተናገረ።', 'duration': '190'},
      {'number': '፶', 'description': 'ተሣሃለኒ አምላክ በከመ ዐቢይ ምሕረትከ።', 'duration': '195'},
      {'number': '፶፩', 'description': 'ምንት ትትመክሕ በእከይ ኃያል።', 'duration': '200'},
      {'number': '፶፪', 'description': 'ይቤ እኁድ በልቡ አልቦ አምላክ።', 'duration': '185'},
      {'number': '፶፫', 'description': 'አምላክ በስምከ አድኅነኒ።', 'duration': '190'},
      {'number': '፶፬', 'description': 'አጽምእ እግዚኦ ጸሎትየ።', 'duration': '195'},
      {'number': '፶፭', 'description': 'ተሣሃለኒ አምላክ እስመ ረገጸኒ ሰብእ።', 'duration': '200'},
      {'number': '፶፮', 'description': 'ተሣሃለኒ አምላክ ተሣሃለኒ።', 'duration': '185'},
      {'number': '፶፯', 'description': 'እመኒ ጽድቀ ትነብቡ።', 'duration': '190'},
      {'number': '፶፰', 'description': 'አድኅነኒ እምፀርየ አምላኪየ።', 'duration': '195'},
      {'number': '፶፱', 'description': 'አምላክ ገሰጽከነ ወሰደድከነ።', 'duration': '200'},
      {'number': '፷', 'description': 'ስማዕ አምላክ ጸሎትየ።', 'duration': '185'},
      {'number': '፷፩', 'description': 'አኮኑ ለእግዚአብሔር ትትገዛዕ ነፍስየ።', 'duration': '190'},
      {'number': '፷፪', 'description': 'አምላክ አምላኪየ ኀቤከ አግህር።', 'duration': '195'},
      {'number': '፷፫', 'description': 'ስማዕ አምላክ ቃልየ እንዘ እጼሊ ኀቤከ።', 'duration': '200'},
      {'number': '፷፬', 'description': 'ለከ ይደሉ ስብሐት አምላክ በጽዮን።', 'duration': '185'},
      {'number': '፷፭', 'description': 'እልል በሉ ለእግዚአብሔር ኵላ ምድር።', 'duration': '190'},
      {'number': '፷፮', 'description': 'አምላክ ይሣሃለነ ወይባርከነ።', 'duration': '195'},
      {'number': '፷፯', 'description': 'ይትነሣእ እግዚአብሔር ወይዘረዉ ጸላእቱ።', 'duration': '200'},
      {'number': '፷፰', 'description': 'አድኅነኒ አምላክ እስመ ቦአ ማይ እስከ ነፍስየ።', 'duration': '185'},
      {'number': '፷፱', 'description': 'አምላክ ርድአኒ።', 'duration': '190'},
      {'number': '፸', 'description': 'ዲቤከ እግዚኦ ተወከልኩ።', 'duration': '195'},
      {'number': '፸፩', 'description': 'አምላክ ፍትሐከ ለንጉሥ ሀብ።', 'duration': '200'},
      {'number': '፸፪', 'description': 'ሠናይ አምላክ ለእስራኤል።', 'duration': '185'},
      {'number': '፸፫', 'description': 'እግዚኦ ለምንት ገሰጽከነ እስከ ፍጻሜ።', 'duration': '190'},
      {'number': '፸፬', 'description': 'ነአኵተከ አምላክ ነአኵተከ።', 'duration': '195'},
      {'number': '፸፭', 'description': 'ያእምርዎ ለአምላክ በይሁዳ።', 'duration': '200'},
      {'number': '፸፮', 'description': 'በቃልየ ኀበ እግዚአብሔር ጸራኅኩ።', 'duration': '185'},
      {'number': '፸፯', 'description': 'ስምዕ ሕዝብየ ሕግየ።', 'duration': '190'},
      {'number': '፸፰', 'description': 'አምላክ በጽሑ አሕዛብ ውስተ ርስትከ።', 'duration': '195'},
      {'number': '፸፱', 'description': 'ዘትሬዒ እስራኤልሃ ስማዕ።', 'duration': '200'},
      {'number': '፹', 'description': 'ተፈሥሑ ለአምላክ ረዳኢነ።', 'duration': '185'},
      {'number': '፹፩', 'description': 'እግዚአብሔር ቆመ በጉባኤ አማልክት።', 'duration': '190'},
      {'number': '፹፪', 'description': 'አምላክ መኑ ይመስለከ።', 'duration': '195'},
      {'number': '፹፫', 'description': 'እፎ ያማስኑ ማኅደርከ።', 'duration': '200'},
      {'number': '፹፬', 'description': 'ባረክከ እግዚኦ ምድረከ።', 'duration': '185'},
      {'number': '፹፭', 'description': 'አጽምእ እግዚኦ እዝንከ ወስማዕኒ።', 'duration': '190'},
      {'number': '፹፮', 'description': 'መሠረቱ ውስተ አድባር ቅዱሳን።', 'duration': '195'},
      {'number': '፹፯', 'description': 'እግዚኦ አምላከ መድኃንየ።', 'duration': '200'},
      {'number': '፹፰', 'description': 'ምሕረቶ ለእግዚአብሔር ለዓለም እዜምር።', 'duration': '185'},
      {'number': '፹፱', 'description': 'እግዚኦ መድኃኒት ኮንከነ እምትውልድ እስከ ትውልድ።', 'duration': '190'},
      {'number': '፺', 'description': 'ዘይነብር በረድኤተ ልዑል።', 'duration': '195'},
      {'number': '፺፩', 'description': 'ሠናይ ውእቱ ይትአመን እግዚአብሔር።', 'duration': '200'},
      {'number': '፺፪', 'description': 'እግዚአብሔር ነግሠ ሥርዐተ ለብሰ።', 'duration': '185'},
      {'number': '፺፫', 'description': 'አምላከ ፍድየት እግዚአብሔር።', 'duration': '190'},
      {'number': '፺፬', 'description': 'ንዑ ናእኵቶ ለእግዚአብሔር።', 'duration': '195'},
      {'number': '፺፭', 'description': 'ዘምሩ ለእግዚአብሔር ዝማሬ ሐዲስ።', 'duration': '200'},
      {'number': '፺፮', 'description': 'እግዚአብሔር ነግሠ ትትፌሣሕ ምድር።', 'duration': '185'},
      {'number': '፺፯', 'description': 'ዘምሩ ለእግዚአብሔር ዝ���ሬ ሐዲስ።', 'duration': '190'},
      {'number': '፺፰', 'description': 'እግዚአብሔር ነግሠ ይትጐሥዑ አሕዛብ።', 'duration': '195'},
      {'number': '፺፱', 'description': 'እግዚአብሔር ነግሠ ይትጐሥዑ አሕዛብ።', 'duration': '200'},
      {'number': '፻', 'description': 'እዜምር ለከ እግዚኦ ምሕረተከ ወፍትሐከ።', 'duration': '185'},
          // ... previous mezmurs ...
    {'number': '፻፩', 'description': 'እግዚኦ ስማዕ ጸሎትየ።', 'duration': '190'},
    {'number': '፻፪', 'description': 'ባርኪ ነፍስየ ለእግዚአብሔር።', 'duration': '195'},
    {'number': '፻፫', 'description': 'ባርኪ ነፍስየ ለእግዚአብሔር።', 'duration': '200'},
    {'number': '፻፬', 'description': 'አአትዎ ለእግዚአብሔር እስመ ሠናይ።', 'duration': '185'},
    {'number': '፻፭', 'description': 'አአትዎ ለእግዚአብሔር ወጸውዕዎ በስሙ።', 'duration': '190'},
    {'number': '፻፮', 'description': 'አአትዎ ለእግዚአብሔር እስመ ሠናይ።', 'duration': '195'},
    {'number': '፻፯', 'description': 'ጥቡዕ ልብየ አምላክ ጥቡዕ ልብየ።', 'duration': '200'},
    {'number': '፻፰', 'description': 'አምላክ ምስብሐትየ ኢትስታዕ።', 'duration': '185'},
    {'number': '፻፱', 'description': 'ይቤሎ እግዚአብሔር ለእግዚእየ።', 'duration': '190'},
    {'number': '፻፲', 'description': 'እአምን በኵሉ ልብየ እግዚኦ።', 'duration': '195'},
    {'number': '፻፲፩', 'description': 'ብፁዕ ብእሲ ዘይፈርሆ ለእግዚአብሔር።', 'duration': '200'},
    {'number': '፻፲፪', 'description': 'ስብሕዎ ደቂቅ ለእግዚአብሔር።', 'duration': '185'},
    {'number': '፻፲፫', 'description': 'በውጻኤ እስራኤል እምግብጽ።', 'duration': '190'},
    {'number': '፻፲፬', 'description': 'አፍቀርኩ እስመ ይሰምዕ እግዚአብሔር።', 'duration': '195'},
    {'number': '፻፲፭', 'description': 'አመንኩ በእንተዝ ነገርኩ።', 'duration': '200'},
    {'number': '፻፲፮', 'description': 'ሰብሕዎ ለእግዚአብሔር አሕዛብ ኵልክሙ።', 'duration': '185'},
    {'number': '፻፲፯', 'description': 'አአትዎ ለእግዚአብሔር እስመ ሠናይ።', 'duration': '190'},
    {'number': '፻፲፰', 'description': 'ብፁዓን እሙንቱ እለ ኢያበሱ በፍኖቶሙ።', 'duration': '195', 
      'subParts': [
        '፩', '፪', '፫', '፬', '፭', '፮', '፯', '፰', '፱', '፲',
        '፲፩', '፲፪', '፲፫', '፲፬', '፲፭', '፲፮', '፲፯', '፲፰', '፲፱', '፳',
        '፳፩', '፳፪'
      ]
    },
    {'number': '፻፲፱', 'description': 'ኀበ እግዚአብሔር በተሐዝነ ጸራሕኩ።', 'duration': '200'},
    {'number': '፻፳', 'description': 'አንሣእኩ አዕይንትየ ውስተ አድባር።', 'duration': '185'},
    {'number': '፻፳፩', 'description': 'ተፈሣሕኩ በእለ ይቤሉኒ።', 'duration': '190'},
    {'number': '፻፳፪', 'description': 'ኀቤከ አንሣእኩ አዕይንትየ።', 'duration': '195'},
    {'number': '፻፳፫', 'description': 'ሶበ አኮ እግዚአብሔር ምስሌነ።', 'duration': '200'},
    {'number': '፻፳፬', 'description': 'እለ ይትወልዎ ለእግዚአብሔር።', 'duration': '185'},
    {'number': '፻፳፭', 'description': 'በመልስ እግዚአብሔር ፄዋሆሙ ለጽዮን።', 'duration': '190'},
    {'number': '፻፳፮', 'description': 'እመ አኮ እግዚአብሔር ሐነጸ ቤተ።', 'duration': '195'},
    {'number': '፻፳፯', 'description': 'ብፁዓን ኵሎሙ እለ ይፈርህዎ ለእግዚአብሔር።', 'duration': '200'},
    {'number': '፻፳፰', 'description': 'ብዙኀ ጊዜያተ ተጋድሉኒ እምንእስየ።', 'duration': '185'},
    {'number': '፻፳፱', 'description': 'እምኀይቅ ጸራሕኩ ኀቤከ እግዚ።', 'duration': '190'},
    {'number': '፻፴', 'description': 'እግዚኦ ኢተለዐለ ልብየ።', 'duration': '195'},
    {'number': '፻፴፩', 'description': 'ተዘከሮ እግዚኦ ለዳዊት።', 'duration': '200'},
    {'number': '፻፴፪', 'description': 'ናሁ እፎ ሠናይ ወእፎ ያማስን።', 'duration': '185'},
    {'number': '፻፴፫', 'description': 'ናሁ ይእዜ ባርክዎ ለእግዚአብሔር።', 'duration': '190'},
    {'number': '፻፴፬', 'description': 'ስብሕዎ ለስመ እግዚአብሔር።', 'duration': '195'},
    {'number': '፻፴፭', 'description': 'አአትዎ ለእግዚአብሔር እስመ ሠናይ።', 'duration': '200'},
    {'number': '፻፴፮', 'description': 'ዲበ አፍላገ ባቢሎን።', 'duration': '185'},
    {'number': '፻፴፯', 'description': 'አአትዊከ እግዚኦ በኵሉ ልብየ።', 'duration': '190'},
    {'number': '፻፴፰', 'description': 'እግዚኦ ፈተንከኒ ወአእመርከኒ።', 'duration': '195'},
    {'number': '፻፴፱', 'description': 'አድኅነኒ እግዚኦ እምሰብእ እኩይ።', 'duration': '200'},
    {'number': '፻፵', 'description': 'እግዚኦ ጸራሕኩ ኀቤከ ስምዐኒ።', 'duration': '185'},
    {'number': '፻፵፩', 'description': 'እግዚኦ ስማዕ ጸሎትየ።', 'duration': '190'},
    {'number': '፻፵፪', 'description': 'ይትባረክ እግዚአብሔር አምላኪየ።', 'duration': '195'},
    {'number': '፻፵፫', 'description': 'አልዕሎ ለአምላኪየ ንጉሥየ።', 'duration': '200'},
    {'number': '፻፵፬', 'description': 'አልዕለከ አምላኪየ ንጉሥየ።', 'duration': '185'},
    {'number': '፻፵፭', 'description': 'ስብሒ ነፍስየ ለእግዚአብሔር።', 'duration': '190'},
    {'number': '፻፵፮', 'description': 'ሰብሕዎ ለእግዚአብሔር እስመ ሠናይ መዝሙር።', 'duration': '195'},
    {'number': '፻፵፯', 'description': 'ሰብሕዎ ለእግዚአብሔር እምሰማያት።', 'duration': '200'},
    {'number': '፻፵፰', 'description': 'ዘምሩ ለእግዚአብሔር ዝማሬ ሐዲሰ።', 'duration': '185'},
    {'number': '፻፵፱', 'description': 'ሰብሕዎ ለእግዚአብሔር በቅዱሳኒሁ።', 'duration': '190'},
    {'number': '፻፶', 'description': 'ኵሉ መንፈስ ያስብሖ ለእግዚአብሔር።', 'duration': '195'},
    {'number': '፻፶፩', 'description': 'ንእስ ወደቂቅ እምአኀውየ።', 'duration': '190'},
    {'number': '፻፶፪', 'description': 'እግዚኦ ስማዕ ጸሎትየ።', 'duration': '195'},
    {'number': '፻፶፫', 'description': 'አምላኪየ ወመድኃንየ።', 'duration': '200'},
    {'number': '፻፶፬', 'description': 'ባርኪ ነፍስየ ለእግዚአብሔር።', 'duration': '185'},
    {'number': '፻፶፭', 'description': 'እሴብሕ ስመከ እግዚኦ።', 'duration': '190'},
    {'number': '፻፶፮', 'description': 'ተፈሣሕኩ በእለ ይቤሉኒ።', 'duration': '195'},
    {'number': '፻፶፯', 'description': 'አንሣእኩ አዕይንትየ ውስተ አድባር።', 'duration': '200'},
    {'number': '፻፶፰', 'description': 'እግዚኦ ጸውዕኩከ ስምዐኒ።', 'duration': '185'},
    {'number': '፻፶፱', 'description': 'ይትፌሥሑ ጻድቃን በክብር።', 'duration': '190'},
    {'number': '፻፷', 'description': 'ዘምሩ ለእግዚአብሔር ዝማሬ ሐዲስ።', 'duration': '195'},
    {'number': '፻፷፩', 'description': 'ስብሕዎ ለእግዚአብሔር በቅዱሳኒሁ።', 'duration': '200'},
    {'number': '፻፷፪', 'description': 'ኵሉ መንፈስ ያስብሖ ለእግዚአብሔር።', 'duration': '185'},
    {'number': '፻፷፫', 'description': 'እሴብሐከ እግዚኦ በኵሉ ልብየ።', 'duration': '190'},
    {'number': '፻፷፬', 'description': 'አእኵቶ ለእግዚአብሔር በኵሉ ጊዜ።', 'duration': '195'},
    {'number': '፻፷፭', 'description': 'ይባርክ ነፍስየ ለእግዚአብሔር።', 'duration': '200'},
    {'number': '፻፷፮', 'description': 'ስብት ለእግዚአብሔር በሰማያት።', 'duration': '185'},
    {'number': '፻፷፯', 'description': 'እግዚኦ አድኅነኒ እስመ ጽድቅከ።', 'duration': '190'},
    {'number': '፻፷፰', 'description': 'ተሣሃለኒ እግዚኦ በከመ ምሕረትከ።', 'duration': '195'},
    {'number': '፻፷፱', 'description': 'አምላኪየ አምላኪየ ናሁ ጸራሕኩ።', 'duration': '200'},
    {'number': '፻፸', 'description': 'እግዚኦ በኃይልከ ይትፌሣሕ ንጉሥ።', 'duration': '185'},
    // ... rest of the code remains the same
    ];

    return mezmurData.asMap().entries.map((mezmure) {
      final index = mezmure.key + 1;
      final data = mezmure.value;
      
      return Audiobook(
        title: 'መዝሙር ${data['number']}',
        author: baseProperties['author']!,
        coverUrl: baseProperties['coverUrl']!,
        audioUrl: 'assets/audios/$index.mp3',
        documentUrl: 'assets/pdfs/mezmure-${data['number']}.pdf',
        description: data['description'],
        duration: int.parse(data['duration']!),
        category: baseProperties['category'],
        publishedDate: DateTime(2024, 3, 15),
        number: data['number']!,
        subParts: data['subParts'] as List<String>? ?? [],
      );
    }).toList();
  }
}

