import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../models/audiobook.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

class AudiobookDetailScreen extends StatefulWidget {
  final Audiobook audiobook;
  final String title;
  final int? startVerse;
  final int? endVerse;

  const AudiobookDetailScreen({
    super.key, 
    required this.audiobook, 
    required this.title,
    this.startVerse,
    this.endVerse,
  });

  @override
  State<AudiobookDetailScreen> createState() => _AudiobookDetailScreenState();
}

class _AudiobookDetailScreenState extends State<AudiobookDetailScreen> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  double _currentPosition = 0;
  double _duration = 0;
  String? _localPdfPath;
  String errorMessage = '';
  int _currentPart = 1;
  final int _totalParts = 22;  // Specifically for Mezmur 118
  

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudioPlayer();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final arabicNumber = _convertFromEthiopicNumeral(widget.audiobook.number);
      final fileName = 'mezmure_$arabicNumber.pdf';
      final file = File('${dir.path}/$fileName');
      
      if (kDebugMode) {
        print('Loading PDF: assets/pdfs/$fileName');
        print('Saving to: ${file.path}');
      }
      
      if (!await file.exists()) {
        try {
          final data = await rootBundle.load('assets/pdfs/$fileName');
          await file.writeAsBytes(data.buffer.asUint8List(), flush: true);
          if (kDebugMode) {
            print('PDF file written successfully');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Error loading asset: $e');
          }
          throw Exception('Failed to load PDF asset: $e');
        }
      }
      
      setState(() {
        _localPdfPath = file.path;
        errorMessage = '';
      });
    } catch (e) {
      if (kDebugMode) {
        print('PDF loading error: $e');
      }
      setState(() => errorMessage = 'PDF loading error: $e');
    }
  }

  String _convertFromEthiopicNumeral(String ethiopicNumber) {
    final Map<String, String> ethiopicToArabic = {
      '፩': '1', '፪': '2', '፫': '3', '፬': '4', '፭': '5',
      '፮': '6', '፯': '7', '፰': '8', '፱': '9', '፲': '10',
      '፲፩': '11', '፲፪': '12', '፲፫': '13', '፲፬': '14', '፲፭': '15',
      '፲፮': '16', '፲፯': '17', '፲፰': '18', '፲፱': '19', '፳': '20',
      '፻፲፰': '118'
    };
    
    return ethiopicToArabic[ethiopicNumber] ?? '1';
  }

  void _initAudioPlayer() async {
    try {
      if (widget.audiobook.audioUrl.isEmpty) {
        throw Exception('Audio URL is empty');
      }
      
      // Construct the audio path for Mezmur 118 parts
      final audioUrl = widget.audiobook.number == '፻፲፰'
          ? 'assets/audios/118.$_currentPart.mp3'
          : widget.audiobook.audioUrl;
      
      if (kDebugMode) {
        print('Attempting to load audio from: $audioUrl');
      }
      
      // Use asset:/// prefix for asset files
      final fullUrl = audioUrl.startsWith('assets/') 
          ? 'asset:///$audioUrl'
          : audioUrl;
          
      await _audioPlayer.setUrl(fullUrl).catchError((error) {
        throw Exception('Failed to set audio URL: $error');
      });
      
      // Listen to player state changes
      _audioPlayer.playerStateStream.listen((playerState) {
        setState(() {
          _isPlaying = playerState.playing;
        });
      });

      _audioPlayer.durationStream.listen((duration) {
        if (duration != null) {
          setState(() => _duration = duration.inSeconds.toDouble());
        }
      });

      _audioPlayer.positionStream.listen((position) {
        setState(() => _currentPosition = position.inSeconds.toDouble());
      });
    } catch (e) {
      setState(() => errorMessage = 'Failed to load audio: $e');
      if (kDebugMode) print('Error initializing audio player: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.play();
      }
    } catch (e) {
      if (kDebugMode) print('Error toggling play/pause: $e');
    }
  }

  Widget _buildPdfView() {
    if (_localPdfPath == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      child: PDFView(
        filePath: _localPdfPath!,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: false,
        pageFling: false,
        pageSnap: false,
        fitPolicy: FitPolicy.WIDTH,
        onError: (error) {
          if (kDebugMode) {
            print('PDF View Error: $error');
          }
          setState(() => errorMessage = error.toString());
        },
        onPageError: (page, error) {
          if (kDebugMode) {
            print('Error on page $page: $error');
          }
          setState(() => errorMessage = 'Error on page $page: $error');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(child: _buildPdfView()),
              _buildSlider(),
              _buildPlaybackControls(),
            ],
          ),
        ),
      ),
    );
  }

  void _showPartsBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'የመዝሙር 118 ክፍሎች',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Flexible(
              child: GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: _totalParts,
                itemBuilder: (context, index) {
                  final partNumber = index + 1;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _currentPart = partNumber;
                        _initAudioPlayer();
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _currentPart == partNumber
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          partNumber.toString(),
                          style: TextStyle(
                            color: _currentPart == partNumber
                                ? Colors.white
                                : Theme.of(context).textTheme.bodyLarge?.color,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          Column(
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (widget.audiobook.number == '፻፲፰') // Show only for Mezmur 118
                GestureDetector(
                  onTap: _showPartsBottomSheet,
                  child: Row(
                    children: [
                      Text(
                        'ክፍል $_currentPart/22',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const Icon(Icons.arrow_drop_down, size: 20),
                    ],
                  ),
                ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
    );
  
  }

  Widget _buildSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child:Text(
                  _formatDuration(_currentPosition),
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
                
                Expanded(
                  flex: 10,
                  child: Slider(
                  value: _currentPosition,
                  min: 0.0,
                  max: _duration,
                  onChanged: (value) {
                  setState(() => _currentPosition = value);
                  _audioPlayer.seek(Duration(seconds: value.round()));
                 },)),
                Expanded(
                  flex: 1,
                  child: Text(
                  _formatDuration(_duration),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),)
              ],
            ),
    );
  }

  Widget _buildPlaybackControls() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.skip_previous),
            onPressed: _skipToPreviousPart,
          ),
          IconButton(
            icon: const Icon(Icons.replay_10),
            onPressed: () => _seek(-15),
          ),
          FloatingActionButton(
            onPressed: _togglePlayPause,
            child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
          ),
          IconButton(
            icon: const Icon(Icons.forward_10),
            onPressed: () => _seek(15),
          ),
          IconButton(
            icon: const Icon(Icons.skip_next),
            onPressed: _skipToNextPart,
          ),
        ],
      ),
    );
  }

  String _formatDuration(double seconds) {
    final duration = Duration(seconds: seconds.round());
    final minutes = duration.inMinutes;
    final remainingSeconds = duration.inSeconds - minutes * 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _seek(int seconds) {
    final newPosition = _currentPosition + seconds;
    _audioPlayer.seek(Duration(seconds: newPosition.round()));
  }

  void _skipToPreviousPart() {
    if (_currentPart > 1) {
      setState(() {
        _currentPart--;
        // Load the audio for the new part
        _initAudioPlayer();
      });
    }
  }

  void _skipToNextPart() {
    if (_currentPart < _totalParts) {
      setState(() {
        _currentPart++;
        // Load the audio for the new part
        _initAudioPlayer();
      });
    }
  }
}

