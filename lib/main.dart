import 'package:cv_builder/api/cv_generate_api.dart';
import 'package:flutter/material.dart';

main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String? name, summary, knowledgeInFlutter, skills, projects, personalDetails;
  TextEditingController name = TextEditingController();
  TextEditingController summary = TextEditingController();
  TextEditingController knowledgeInFlutter = TextEditingController();
  TextEditingController skills = TextEditingController();
  TextEditingController projects = TextEditingController();
  TextEditingController personalDetails = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    name.dispose();
    summary.dispose();
    knowledgeInFlutter.dispose();
    skills.dispose();
    projects.dispose();
    personalDetails.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Builder'),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: width * 0.055, vertical: 24),
          child: Form(
            key: formKey,
            child: ListView(
              addAutomaticKeepAlives: true,
              children: [
                TextFormField(
                  controller: name,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'cannot be empty';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: 'Name',
                      labelText: "Name",
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: summary,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'cannot be empty';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                      hintText: 'Summary ',
                      labelText: "Summary ",
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'cannot be empty';
                    } else {
                      return null;
                    }
                  },
                  controller: knowledgeInFlutter,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                      hintText: 'knowledge In Flutter',
                      labelText: "knowledge In Flutter",
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'cannot be empty';
                    } else {
                      return null;
                    }
                  },
                  controller: skills,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                      hintText: 'Skills',
                      labelText: "Skills",
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'cannot be empty';
                    } else {
                      return null;
                    }
                  },
                  controller: projects,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                      hintText: 'Projects',
                      labelText: "Projects",
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'cannot be empty';
                    } else {
                      return null;
                    }
                  },
                  controller: personalDetails,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                      hintText: 'Personal Details',
                      labelText: "Personal Details",
                      border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            final file = await CvGenrateApi.generate(
              name: name.text,
              summary: summary.text,
              knowledgeInFlutter: knowledgeInFlutter.text,
              skills: skills.text,
              projects: projects.text,
              personalDetails: personalDetails.text,
            );
            CvGenrateApi.openFile(file);
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
