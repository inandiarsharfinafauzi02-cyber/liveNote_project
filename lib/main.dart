import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart'; // File hasil generate

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi koneksi ke Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Live Notes',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

// CLASS HOMEPAGE
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Referensi Koleksi Firestore
  final CollectionReference _notes =
      FirebaseFirestore.instance.collection('notes');

  // Controller form
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Notes Fire")),

      // STREAMBUILDER: Bagian terpenting untuk Real-time
      body: StreamBuilder(
        stream: _notes.orderBy('timestamp', descending: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // Kondisi 1: Masih Loading
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // Kondisi 2: Data Kosong
          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Belum ada catatan."));
          }

          // Kondisi 3: Ada Data -> Tampilkan ListView
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot document =
                  snapshot.data!.docs[index];

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    document['title'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(document['content']),

                  // SOAL: Ketika ListTile (onTap) ditekan, buka form untuk EDIT
                  onTap: () => _showForm(context, document),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Fungsi Hapus
                      _notes.doc(document.id).delete();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  // FORM INPUT NOTE
  void _showForm(BuildContext context, [DocumentSnapshot? doc]) { // 
      // SOAL: Form harus terisi data LAMA ketika edit
      if (doc != null) {
        _titleController.text = doc['title'];
        _contentController.text = doc['content'];
      } else {
        _titleController.clear();
        _contentController.clear();
      }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Isi Catatan'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
             onPressed: () async {
                final title = _titleController.text;
                final content = _contentController.text;

                if (doc == null) {
                  // Tambah data
                  await _notes.add({
                    "title": title,
                    "content": content,
                    "timestamp": FieldValue.serverTimestamp(),
                  }); 
                } else {
                  // // SOAL: Update data ke Firebase dengan .update()
                  await _notes.doc(doc.id).update({
                    "title": title,
                    "content": content,
                    "timestamp": FieldValue.serverTimestamp(),
                  });
                }

                // Bersihkan Input & Tutup Modal
                _titleController.clear();
                _contentController.clear();
                Navigator.of(context).pop();
              },

              child: const Text("Simpan Catatan"),
            ),
          ],
        ),
      ),
    );
  }
}