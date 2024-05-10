// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:notify_ju/Controller/postController.dart';
// import 'package:notify_ju/Models/postModel.dart';
// import 'package:notify_ju/Repository/authentication_repository.dart';
// import 'package:notify_ju/Widgets/bottomNavBar.dart';
// import 'package:notify_ju/Widgets/drawer.dart';
// import 'package:notify_ju/Widgets/image_input.dart';
// import 'package:random_string/random_string.dart';

// class VotingPage extends StatefulWidget {
//   @override
//   _VotingPageState createState() => _VotingPageState();
// }

// final controller = Get.put(PostController());
// final _authRepo = Get.put(AuthenticationRepository());

// class _VotingPageState extends State<VotingPage> {
//   List<Post> posts = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: DrawerWidget(),
//       appBar: AppBar(
//         title: Text('Voting'),
//         backgroundColor: const Color.fromARGB(255, 195, 235, 197),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: posts.length,
//         itemBuilder: (context, index) {
//           return PostWidget(
//             post: posts[index],
//             onLike: () {
//               setState(() {
//                 if (!posts[index].liked) {
//                   posts[index].likes++;
//                   posts[index].liked = true;
//                   if (posts[index].disliked) {
//                     posts[index].dislikes--;
//                     posts[index].disliked = false;
//                   }
//                 }
//               });
//             },
//             onDislike: () {
//               setState(() {
//                 if (!posts[index].disliked) {
//                   posts[index].dislikes++;
//                   posts[index].disliked = true;
//                   if (posts[index].liked) {
//                     posts[index].likes--;
//                     posts[index].liked = false;
//                   }
//                 }
//               });
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _addPost(context);
//         },
//         child: Icon(Icons.add),
//       ),
//       bottomNavigationBar: BottomNavigationBarWidget(),
//     );
//   }

//   void _addPost(BuildContext context) async {
//     final newPost = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => AddPostPage()),
//     );
//     if (newPost != null) {
//       setState(() {
//         posts.insert(0, newPost);
//       });
//     }
//   }
// }

// class Post {
//   String content;
//   int likes = 0;
//   int dislikes = 0;
//   bool liked = false;
//   bool disliked = false;

//   Post({this.content = ""});
// }

// class AddPostPage extends StatefulWidget {
//   @override
//   _AddPostPageState createState() => _AddPostPageState();
// }

// class _AddPostPageState extends State<AddPostPage> {
//   final TextEditingController _textEditingController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Post'),
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 195, 235, 197),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               keyboardType: TextInputType.multiline,
//               maxLines: 5,
//               enabled: true,
//               controller: _textEditingController,
//               decoration: const InputDecoration(
//                 hintText: 'what problem do you have?',
//                 filled: true,
//               ),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               keyboardType: TextInputType.datetime,
//               enabled: false,
//               decoration: const InputDecoration(
//                 labelText: 'Post Date and Time ',
//                 filled: true,
//               ),
//               controller: TextEditingController(
//                 text: DateFormat('dd-MM-yyyy    h:mm').format(DateTime.now()),
//               ),
//             ),
//             const ImageInput(),
//             ElevatedButton(
//               onPressed: () {
//                 Get.back();
//                 final post = postModel(
//                   post_id: randomAlphaNumeric(20),
//                   description: _textEditingController.text,
//                   time: DateTime.now(),
//                   // incident_location: GeoPoint(_selectedLocation.latitude,
//                   //     _selectedLocation.longitude),
//                   email: _authRepo.firebaseUser.value?.email ?? " ",
//                 );
//               },
//               child: Text('Post'),
//             ),
//             const SizedBox(width: 10),
//             ElevatedButton(
//               onPressed: () {
//                 Get.back();
//               },
//               child: const Text('Cancel'),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBarWidget(),
//     );
//   }

//   @override
//   void dispose() {
//     _textEditingController.dispose();
//     super.dispose();
//   }
// }

// class PostWidget extends StatefulWidget {
//   final Post post;
//   final VoidCallback onLike;
//   final VoidCallback onDislike;

//   const PostWidget({
//     required this.post,
//     required this.onLike,
//     required this.onDislike,
//   });

//   @override
//   State<PostWidget> createState() => _PostWidgetState();
// }

// class _PostWidgetState extends State<PostWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Padding(
//             padding: EdgeInsets.all(8),
//             child: Text(widget.post.content),
//           ),
//           Padding(
//             padding: EdgeInsets.all(8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Likes: ${widget.post.likes}'),
//                 Text('Dislikes: ${widget.post.dislikes}'),
//               ],
//             ),
//           ),
//           ButtonBar(
//             children: [
//               IconButton(
//                 onPressed: widget.post.liked ? null : widget.onLike,
//                 icon: Icon(Icons.thumb_up),
//                 color: widget.post.liked ? Colors.green : null,
//               ),
//               IconButton(
//                 onPressed: widget.post.disliked ? null : widget.onDislike,
//                 icon: Icon(Icons.thumb_down),
//                 color: widget.post.disliked ? Colors.red : null,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
