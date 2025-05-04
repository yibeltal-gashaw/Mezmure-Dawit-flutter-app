import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/audiobook.dart';
import 'daily_mezmurs_screen.dart';
import '../constants/daily_mezmur_ranges.dart';
import '../constants/ethiopic_numbers.dart';
import '../widgets/mezmur_day_card.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Audiobook> audiobooks = Audiobook.sampleAudiobooks;
  final _scrollController = ScrollController();
  bool isAppBarVisible = true;

  // Helper method to get mezmurs for a specific range
  List<Audiobook> _getMezmursForRange(int start, int end) {
    try {
      return audiobooks.where((book) {
        // Convert Ethiopian number to Arabic number using our constants
        final arabicNumeral = EthiopicNumbers.ethiopicToArabic[book.number];
        if (arabicNumeral == null) return false;
        
        final number = int.parse(arabicNumeral);
        return number >= start && number <= end;
      }).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error in _getMezmursForRange: $e');
      }
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    const dailyMezmurs = DailyMezmurRanges.dailyMezmurs;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:AppBar(
        title: const Text('መዝሙረ ዳዊት'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(.5),
              ],
            ),
          ),
        ),
        scrolledUnderElevation: 0,
      ) ,
      drawer: AppDrawer(audiobooks: audiobooks),
      body: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.only(top: kToolbarHeight + 25, bottom: 16),
        itemCount: dailyMezmurs.length,
        itemBuilder: (context, index) {
          final day = dailyMezmurs[index];
          
          // Special handling for Sunday
          if (day['day'] == 'እሑድ') {
            return MezmurDayCard(
              dayName: day['day'] as String,
              range: '152-171',  // Updated range for Sunday
              mezmurs: _getMezmursForRange(152, 171),  // Get all Sunday mezmurs
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DailyMezmursScreen(
                      dayName: day['day'] as String,
                      mezmurs: _getMezmursForRange(152, 171),
                    ),
                  ),
                );
              },
            );
          }
          
          // Regular handling for other days
          final mezmursForDay = _getMezmursForRange(
            day['start'] as int,
            day['end'] as int,
          );
          
          return MezmurDayCard(
            dayName: day['day'] as String,
            range: day['range'] as String,
            mezmurs: mezmursForDay,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DailyMezmursScreen(
                    dayName: day['day'] as String,
                    mezmurs: mezmursForDay,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}


