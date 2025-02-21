import 'package:flutter/material.dart';

class CreateBlogScreen extends StatefulWidget {
  const CreateBlogScreen({super.key});

  @override
  _CreateBlogScreenState createState() => _CreateBlogScreenState();
}

class _CreateBlogScreenState extends State<CreateBlogScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void submitBlog() {
    if (_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
      Navigator.pop(context, {
        'title': _titleController.text,
        'description': _descriptionController.text
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Blog')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Blog Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Blog Description'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitBlog,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
