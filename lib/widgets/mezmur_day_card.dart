import 'package:flutter/material.dart';
import '../models/audiobook.dart';

class MezmurDayCard extends StatelessWidget {
  final String dayName;
  final String range;
  final List<Audiobook> mezmurs;
  final VoidCallback onTap;

  const MezmurDayCard({
    super.key,
    required this.dayName,
    required this.range,
    required this.mezmurs,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.7),
                Theme.of(context).primaryColor.withOpacity(0.3),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Background Pattern
              Positioned(
                right: -20,
                bottom: -20,
                child: Icon(
                  Icons.music_note,
                  size: 100,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    // Day Icon and Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Day Name
                          Text(
                            dayName,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Mezmur Range
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'መዝሙር $range',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Number of Mezmurs
                          Row(
                            children: [
                              Icon(
                                Icons.queue_music,
                                size: 20,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${mezmurs.length} መዝሙሮች',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Arrow Icon
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 