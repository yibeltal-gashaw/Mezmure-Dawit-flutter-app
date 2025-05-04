import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('ቅንብሮች'),
          ),
          body: ListView(
            children: [
              // የቋንቋ ምርጫ
              ListTile(
                title: const Text('ቋንቋ'),
                trailing: DropdownButton<String>(
                  value: settings.currentLanguage,
                  items: const [
                    DropdownMenuItem(value: 'am', child: Text('አማርኛ')),
                    DropdownMenuItem(value: 'en', child: Text('English')),
                  ],
                  onChanged: (value) => settings.setLanguage(value!),
                ),
              ),

              ListTile(
                title: const Text('የጽሑፍ መጠን'),
                subtitle: Slider(
                  value: settings.fontSize,
                  min: 12.0,
                  max: 24.0,
                  divisions: 12,
                  label: settings.fontSize.toString(),
                  onChanged: (value) => settings.setFontSize(value),
                ),
              ),

              
              SwitchListTile(
                title: const Text('የጨለማ ሁነታ'),
                value: settings.isDarkMode,
                onChanged: (value) => settings.setDarkMode(value),
              ),

              
              SwitchListTile(
                title: const Text('የበይነመረብ ውጭ ሁነታ'),
                subtitle: const Text('መዝሙሮችን ለበይነመረብ ውጭ አጠቃቀም አስቀምጥ'),
                value: settings.isOfflineMode,
                onChanged: (value) => settings.setOfflineMode(value),
              ),
            ],
          ),
        );
      },
    );
  }
} 