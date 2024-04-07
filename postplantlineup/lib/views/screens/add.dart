import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:postplantlineup/views/utils/colors.dart';
import '../../data/agents_data_service.dart';
import '../../data/map_data_service.dart';
import '../../models/agents_model.dart';
import '../../models/maps_model.dart';

class AddLineupPage extends StatefulWidget {
  const AddLineupPage({super.key});

  @override
  _AddLineupPageState createState() => _AddLineupPageState();
}

class _AddLineupPageState extends State<AddLineupPage> {
  final TextEditingController lineupNameController = TextEditingController();
  final TextEditingController lineupDescriptionController = TextEditingController();
  final TextEditingController lineupImageUrlController = TextEditingController();
  final TextEditingController siteNameController = TextEditingController();

  late List<Agent> agents;
  late List<MapModel> maps;
  String? selectedAgent;
  String? selectedMap;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final agentsService = AgentsDataService();
    final mapsService = MapsDataService();
    agents = await agentsService.getAgents();
    maps = await mapsService.getMaps();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Lineup',
          style: TextStyle(color: CustomColors.textColor),
        ),
        backgroundColor: CustomColors.primaryColor,
      ),
      backgroundColor: CustomColors.primaryColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAgentDropdown(),
            _buildMapDropdown(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            _buildTextFormField(
              controller: lineupNameController,
              labelText: 'Lineup Name',
              validatorMessage: 'Please enter lineup name',
            ),
            _buildTextFormField(
              controller: lineupDescriptionController,
              labelText: 'Lineup Description',
              validatorMessage: 'Please enter lineup description',
            ),
            _buildTextFormField(
              controller: lineupImageUrlController,
              labelText: 'Lineup Image URL',
              validatorMessage: 'Please enter lineup image URL',
            ),
            _buildTextFormField(
              controller: siteNameController,
              labelText: 'Site Name',
              validatorMessage: 'Please enter site name',
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAgentDropdown() {
    return DropdownButtonFormField<String>(
      dropdownColor: CustomColors.primaryColor,
      onChanged: (String? newValue) {
        setState(() {
          selectedAgent = newValue;
        });
      },
      items: agents.map((agent) {
        return DropdownMenuItem<String>(
          value: agent.name,
          child: Text(
            agent.name,
            style: const TextStyle(color: CustomColors.textColor),
          ),
        );
      }).toList(),
      decoration: const InputDecoration(
        labelText: 'Agent Name',
        labelStyle: TextStyle(color: CustomColors.accentColor),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: CustomColors.accentColor),
        ),
      ),
    );
  }

  Widget _buildMapDropdown() {
    return DropdownButtonFormField<String>(
      dropdownColor: CustomColors.primaryColor,
      onChanged: (String? newValue) {
        setState(() {
          selectedMap = newValue;
        });
      },
      items: maps.map((map) {
        return DropdownMenuItem<String>(
          value: map.mapName,
          child: Text(
            map.mapName,
            style: const TextStyle(color: CustomColors.textColor),
          ),
        );
      }).toList(),
      decoration: const InputDecoration(
        labelText: 'Map Name',
        labelStyle: TextStyle(color: CustomColors.accentColor),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: CustomColors.accentColor),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required String validatorMessage,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: CustomColors.accentColor),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: CustomColors.accentColor),
        ),
      ),
      style: const TextStyle(color: CustomColors.textColor),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorMessage;
        }
        return null;
      },
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          if (_validateInputs()) {
            _showConfirmationDialog();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomColors.accentColor,
        ),
        child: const Text(
          'Add Lineup',
          style: TextStyle(color: CustomColors.textColor),
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData(
            dialogBackgroundColor: CustomColors.accentColor,
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: CustomColors.textColor),
            ),
          ),
          child: AlertDialog(
            title: const Text(
              "Confirm Addition",
              style: TextStyle(color: CustomColors.textColor),
            ),
            content: const Text("Do you want to add this lineup?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "No",
                  style: TextStyle(color: CustomColors.textColor),
                ),
              ),
              TextButton(
                onPressed: () async {
                  _addLineupToFirestore();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Yes",
                  style: TextStyle(color: CustomColors.textColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _addLineupToFirestore() async {
    String lineupName = lineupNameController.text;
    String lineupDescription = lineupDescriptionController.text;
    String lineupImageUrl = lineupImageUrlController.text;
    String siteName = siteNameController.text;

    await FirebaseFirestore.instance
        .collection('lineups')
        .doc(selectedAgent)
        .collection(selectedMap!)
        .add({
      'lineupName': lineupName,
      'lineupDescription': lineupDescription,
      'lineupImageUrl': lineupImageUrl,
      'siteName': siteName,
    });

    // Clear text controllers
    lineupNameController.clear();
    lineupDescriptionController.clear();
    lineupImageUrlController.clear();
    siteNameController.clear();
  }

  bool _validateInputs() {
    if (selectedAgent == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an agent')),
      );
      return false;
    }
    if (selectedMap == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a map')),
      );
      return false;
    }
    if (lineupNameController.text.isEmpty ||
        lineupDescriptionController.text.isEmpty ||
        lineupImageUrlController.text.isEmpty ||
        siteNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return false;
    }
    return true;
  }
}