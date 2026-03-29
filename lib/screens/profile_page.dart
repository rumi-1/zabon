import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../data/dari_units.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    final appState = context.read<AppState>();
    _nameController.text = appState.profileName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
    if (!_isEditing) {
      // Save changes
      final appState = context.read<AppState>();
      appState.updateProfileName(_nameController.text);
    }
  }

  void _selectProfilePicture() {
    // For now, show a simple dialog with predefined options
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Profile Picture'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              spacing: 8,
              children: List.generate(6, (index) {
                return GestureDetector(
                  onTap: () {
                    final appState = context.read<AppState>();
                    appState.updateProfilePicture('avatar_${index + 1}');
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.primaries[index % Colors.primaries.length],
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  String _getCurrentUnitName(AppState appState) {
    final unit = dariUnits.firstWhere(
      (unit) => unit.id == appState.currentUnitId,
      orElse: () => dariUnits.first,
    );
    return unit.name;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            actions: [
              IconButton(
                icon: Icon(_isEditing ? Icons.check : Icons.edit),
                onPressed: _toggleEditing,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Picture
                GestureDetector(
                  onTap: _isEditing ? _selectProfilePicture : null,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: appState.profilePicturePath != null
                            ? Colors.primaries[int.tryParse(appState.profilePicturePath!.split('_').last) ?? 0 % Colors.primaries.length]
                            : Colors.blue,
                        child: appState.profilePicturePath != null
                            ? Text(
                                appState.profilePicturePath!.split('_').last,
                                style: const TextStyle(color: Colors.white, fontSize: 30),
                              )
                            : Text(
                                appState.profileName.isNotEmpty ? appState.profileName[0].toUpperCase() : 'L',
                                style: const TextStyle(color: Colors.white, fontSize: 30),
                              ),
                      ),
                      if (_isEditing)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Name
                if (_isEditing)
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    textAlign: TextAlign.center,
                  )
                else
                  Text(
                    appState.profileName,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                const SizedBox(height: 32),

                // Stats
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildStatRow('Overall XP', '${appState.xp} XP'),
                        const Divider(),
                        _buildStatRow('Current Unit', _getCurrentUnitName(appState)),
                        const Divider(),
                        _buildStatRow(
                          'Start Date',
                          appState.startDate != null
                              ? '${appState.startDate!.month}/${appState.startDate!.day}/${appState.startDate!.year}'
                              : 'Not set',
                        ),
                        if (appState.startDate != null) ...[
                          const Divider(),
                          _buildStatRow(
                            'Days Learning',
                            '${DateTime.now().difference(appState.startDate!).inDays} days',
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Set Start Date Button
                if (_isEditing)
                  ElevatedButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: appState.startDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        appState.setStartDate(pickedDate);
                      }
                    },
                    child: const Text('Set Start Date'),
                  ),

                // Unit Selection (for demo purposes)
                if (_isEditing)
                  DropdownButton<int>(
                    value: appState.currentUnitId,
                    onChanged: (value) {
                      if (value != null) {
                        appState.setCurrentUnit(value);
                      }
                    },
                    items: dariUnits.map((unit) {
                      return DropdownMenuItem(
                        value: unit.id,
                        child: Text(unit.name),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        Text(value, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
