import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mezmure_dawit/constants/ethiopic_numbers.dart';
import '../screens/daily_mezmurs_screen.dart';
import '../models/audiobook.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class AppDrawer extends StatelessWidget {
  final List<Audiobook> audiobooks;
  
  const AppDrawer({
    super.key,
    required this.audiobooks,
  });

  // Helper method to get mezmurs for a specific range
  List<Audiobook> _getMezmursForRange(int start, int end) {
    try {
      return audiobooks.where((book) {
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
    return Drawer(
      backgroundColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.8),
              const Color.fromARGB(255, 255, 255, 255),
              Theme.of(context).primaryColor.withOpacity(0.3),
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.8),
                    const Color.fromARGB(255, 255, 255, 255),
                    Theme.of(context).primaryColor.withOpacity(0.3),
                  ],
                ),
              ),
              height: 200.0,
              child: Image.asset(
                'assets/images/mezmure dawit.jpg',
                height: 100,
                fit: BoxFit.fill,
              ),
            ),
            const Divider(),
            _buildDayTile(context, 'ሰኞ', 1, 30),
            _buildDayTile(context, 'ማክሰኞ', 31, 60),
            _buildDayTile(context, 'ረቡዕ', 61, 80),
            _buildDayTile(context, 'ሐሙስ', 81, 110),
            _buildDayTile(context, 'አርብ', 111, 130),
            _buildDayTile(context, 'ቅዳሜ', 131, 151),
            _buildDayTile(context, 'እሑድ', 152, 171),
            // Contact Info
            const Divider(),
            const ListTile(
              leading: Icon(Icons.phone),
              title: Text('ስልክ'),
              subtitle: Text('+251 907 515 011'),
            ),
            const Divider(),
            // Social Media Links
            _buildSocialMediaTile(context, 'Email', 'https://www.yibeltalgashaw320@gmail.com', Icons.email),
            _buildSocialMediaTile(context, 'Facebook', 'https://www.linkedin.com/in/yibeltal-gashaw21', Icons.facebook),
            _buildSocialMediaTile(context, 'Telegram', 'https://t.me/dartdevop', Icons.telegram),  
          ],
        ),
      ),
    );
  }

  Widget _buildDayTile(BuildContext context, String day, int start, int end) {
    return GestureDetector(
      onTap: () {
        final mezmurs = _getMezmursForRange(start, end);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DailyMezmursScreen(
              dayName: day,
              mezmurs: mezmurs,
            ),
          ),
        );
      },
      child: ListTile(
        leading: const Icon(Icons.calendar_today),
        title: Text('የ$day መዝሙሮች'),
      ),
    );
  }

  Widget _buildSocialMediaTile(BuildContext context, String platform, String url, IconData icon) {

    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await launcher.canLaunchUrl(uri)) {
          await launcher.launchUrl(uri);
        }
      },
      child: ListTile(
        leading: Icon(icon),
        title: Text(platform),
      ),
    );
  }
} 