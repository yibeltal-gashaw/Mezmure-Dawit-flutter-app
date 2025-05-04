import 'package:flutter/material.dart';
import 'package:mezmure_dawit/constants/ethiopic_numbers.dart';
import '../models/audiobook.dart';
import 'audiobook_detail_screen.dart';

class DailyMezmursScreen extends StatelessWidget {
  final String dayName;
  final List<Audiobook> mezmurs;

  const DailyMezmursScreen({
    super.key,
    required this.dayName,
    required this.mezmurs,
  });
//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('የ$dayName መዝሙሮች'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(0),
              ],
            ),
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: Container(
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
        child: dayName == 'እሑድ' ? 
        Column(
          children: [
            Card(
              margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 16),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/mezmure dawit.jpg',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: const Text(
                  'የሰሎሞን መዝሙሮች',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    const Text('መዝሙር 152-156'),
                    const SizedBox(height: 4),
                    Text(
                      '5 መዝሙሮች',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  final solomonMezmurs = mezmurs.where((m) {
                    final number = int.tryParse(EthiopicNumbers.ethiopicToArabic[m.number] ?? '0') ?? 0;
                    return number >= 152 && number <= 156;
                  }).toList();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DailyMezmursScreen(
                        dayName: 'የሰሎሞን',
                        mezmurs: solomonMezmurs,
                      ),
                    ),
                  );
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.all(16),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/mezmure dawit.jpg',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: const Text(
                  'የነቢያት መዝሙሮች',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    const Text('መዝሙር 157-171'),
                    const SizedBox(height: 4),
                    Text(
                      '15 መዝሙሮች',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  final prophetMezmurs = mezmurs.where((m) {
                    final number = int.tryParse(EthiopicNumbers.ethiopicToArabic[m.number] ?? '0') ?? 0;
                    return number >= 157 && number <= 171;
                  }).toList();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DailyMezmursScreen(
                        dayName: 'የነቢያት',
                        mezmurs: prophetMezmurs,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ) : 
        ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: mezmurs.length,
          itemBuilder: (context, index) {
            final mezmur = mezmurs[index];
            if (dayName == 'ረቡዕ' && mezmur.title.contains('118')) {
              return ExpansionTile(
                title: Text(
                  mezmur.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  for (int i = 1; i <= 32; i++)
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 32),
                      title: Text('ክፍል $i (${(i-1)*8 + 1}-${i*8})'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AudiobookDetailScreen(
                              audiobook: mezmur,
                              title: '${mezmur.title} - ክፍል $i',
                              startVerse: (i-1)*8 + 1,
                              endVerse: i*8,
                            ),
                          ),
                        );
                      },
                    ),
                ],
              );
            }
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    mezmur.coverUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  mezmur.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(mezmur.description ?? ''),
                    const SizedBox(height: 4),
                    Text(
                      'ርዝመት: ${(mezmur.duration! / 60).floor()}:${(mezmur.duration! % 60).toString().padLeft(2, '0')}',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AudiobookDetailScreen(
                        audiobook: mezmur,
                        title: mezmur.title,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
} 