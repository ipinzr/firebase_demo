import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Makanan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _textFieldController,
              decoration: InputDecoration(
                labelText: 'Data to Add',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _addDataToFirestore(_textFieldController.text);
              },
              child: Text('Add Data'),
            ),
            SizedBox(height: 20),
            Text(
              'Firestore Data:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('makanan').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final data = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final document = data[index].data() as Map<String, dynamic>;
                        final documentId = data[index].id;
                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            title: Text(document['field1']),
                            subtitle: Text(document['field2']),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    _updateDataInFirestore(documentId, document['field1'], document['isAvailable']);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    _deleteDataFromFirestore(documentId);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Text('No data available');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addDataToFirestore(String data) async {
    try {
      await _firestore.collection('makanan').add({
        'field1': data,
        'field2': 'food',
        'isAvailable': true, // Initialize as available
      });
      _textFieldController.clear();
    } catch (e) {
      print('Error adding data: $e');
    }
  }

  Future<void> _updateDataInFirestore(String documentId, String currentField1, bool? isAvailable) async {
  final TextEditingController _updateField1Controller = TextEditingController(text: currentField1);

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Update Data'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _updateField1Controller,
              decoration: InputDecoration(labelText: 'New Field1 Value'),
            ),
            Text('Is Available: ${isAvailable ?? false}'), // Display the current availability status
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final updatedField1 = _updateField1Controller.text;
              await _firestore.collection('makanan').doc(documentId).update({
                'field1': updatedField1,
                'isAvailable': !(isAvailable ?? false), // Toggle the availability status in Firestore
              });
              Navigator.of(context).pop();
            },
            child: Text('Update'),
          ),
        ],
      );
    },
  );
}



  Future<void> _deleteDataFromFirestore(String documentId) async {
    await _firestore.collection('makanan').doc(documentId).delete();
  }
}
