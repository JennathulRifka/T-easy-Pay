import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class newsManage extends StatelessWidget {
  const newsManage({Key? key}) : super(key: key);

  Future<void> _showNewsDialog(BuildContext context,
      {DocumentSnapshot? doc}) async {
    final TextEditingController titleController =
        TextEditingController(text: doc?['title'] ?? '');
    final TextEditingController imagePathController =
        TextEditingController(text: doc?['imagePath'] ?? '');
    final TextEditingController contentController =
        TextEditingController(text: doc?['content'] ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(doc == null ? 'Add News' : 'Edit News'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: imagePathController,
                decoration: const InputDecoration(labelText: 'Image Path'),
              ),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: 'Content'),
                maxLines: 5,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow.shade700),
            child: Text(doc == null ? 'Add' : 'Update',
                style: const TextStyle(color: Colors.black)),
            onPressed: () async {
              final String title = titleController.text.trim();
              final String content = contentController.text.trim();
              if (title.isEmpty || content.isEmpty) return;

              if (doc == null) {
                await FirebaseFirestore.instance.collection('news').add({
                  'title': title,
                  'imagePath': imagePathController.text.trim(),
                  'content': content,
                  'timestamp': FieldValue.serverTimestamp(),
                });
              } else {
                await FirebaseFirestore.instance
                    .collection('news')
                    .doc(doc.id)
                    .update({
                  'title': title,
                  'content': content,
                });
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _deleteNews(String id) async {
    await FirebaseFirestore.instance.collection('news').doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage News',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.yellow.shade700,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.go ('/adminHome');
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 249, 250, 242),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('news')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading news"));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (doc['imagePath'] != null &&
                          doc['imagePath'].toString().isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            doc['imagePath'],
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(height: 10),
                      Text(
                        doc['title'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        doc['content'],
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.green),
                            onPressed: () => _showNewsDialog(context, doc: doc),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteNews(doc.id),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow[700],
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () => _showNewsDialog(context),
      ),
    );
  }
}
