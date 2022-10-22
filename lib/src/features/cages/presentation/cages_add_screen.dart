import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gliders/src/features/auth/presentation/auth_controller.dart';
import 'package:gliders/src/features/cages/domain/cages/cages.dart';
import 'package:gliders/src/features/cages/domain/gliders/gliders.dart';
import 'package:gliders/src/features/home/presentation/botnavbar_screen.dart';
import 'package:gliders/src/features/home/presentation/cages_controller.dart';
import 'package:gliders/src/shared/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as image_reduce;

class CagesAddScreen extends ConsumerStatefulWidget {
  final bool isEdit;
  final Cages? cages;
  const CagesAddScreen({Key? key, required this.isEdit, this.cages}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CagesAddScreenState();
}

class _CagesAddScreenState extends ConsumerState<CagesAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _genderController = TextEditingController();
  final _notesController = TextEditingController();
  final _imageController = TextEditingController();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final List<Gliders> listGliders = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      _titleController.text = widget.cages!.title.toString();
      _categoryController.text = widget.cages!.category.toString();
      _genderController.text = widget.cages!.category.toString();
      _notesController.text = widget.cages!.notes.toString();
      _imageController.text = widget.cages!.images.toString();
      listGliders.addAll(widget.cages!.gliders!.map((e) => Gliders.fromJson(e)).toList());
    }

    _categoryController.text = 'koloni';
    _genderController.text = 'jantan';
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _categoryController.dispose();
    _notesController.dispose();
    _imageController.dispose();
    _nameController.dispose();
    _ageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(authControllerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            'assets/images/x-icon.png',
            width: 12.w,
            height: 12.h,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: false,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset(
                      'assets/images/x-icon.png',
                      width: 12.w,
                      height: 12.h,
                    ),
                  ),
                ),
                Text(
                  widget.isEdit ? 'Edit Cages' : 'Add Cages',
                  style: btmsheet,
                ),
              ],
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (widget.isEdit) {
                    await ref.read(cagesControllerProvider.notifier).update(
                          Cages(
                            id: widget.cages!.id,
                            title: _titleController.text,
                            category: _categoryController.text,
                            notes: _notesController.text,
                            images: _imageController.text,
                            gliders: listGliders.map((e) => e.toJson()).toList(),
                          ),
                          name: users.name.toString(),
                          photo: users.photo.toString(),
                        );
                  } else {
                    await ref.read(cagesControllerProvider.notifier).add(
                          title: _titleController.text,
                          category: _categoryController.text,
                          gliders: listGliders.map((e) => e.toJson()).toList(),
                          images: _imageController.text == ''
                              ? 'https://firebasestorage.googleapis.com/v0/b/gliders-a4543.appspot.com/o/cages%2Fno-image.png?alt=media&token=3627aa16-08c2-42dc-b278-186137a60f87'
                              : _imageController.text,
                          notes: _notesController.text,
                          name: users.name.toString(),
                          photo: users.photo.toString(),
                        );
                  }

                  if (mounted) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BotNavBarScreen(),
                        ));
                  }
                }
              },
              child: Text(
                'Save',
                style: txtBtnBlue,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'cages',
                      style: textTitleBookmarkGliders,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'title *',
                          style: textTitleBookmark,
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter title';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _titleController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.r),
                              borderSide: BorderSide(width: 1, color: graySecond),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                            hintText: 'kandang 1',
                            hintStyle: tagHint,
                          ),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'category *',
                          style: textTitleBookmark,
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        DropdownButtonFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter category';
                              }
                              return null;
                            },
                            items: const [
                              DropdownMenuItem(
                                value: 'koloni',
                                child: Text('koloni'),
                              ),
                              DropdownMenuItem(
                                value: 'solo',
                                child: Text('solo'),
                              ),
                              DropdownMenuItem(
                                value: 'ip',
                                child: Text('ip'),
                              ),
                            ],
                            value: _categoryController.text,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.r),
                                borderSide: BorderSide(width: 1, color: graySecond),
                              ),
                              contentPadding: const EdgeInsets.all(12),
                              hintStyle: tagHint,
                            ),
                            onChanged: (value) {
                              _categoryController.text = value.toString();
                            }),
                        SizedBox(
                          height: 18.h,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'notes',
                          style: textTitleBookmark,
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _notesController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.r),
                              borderSide: BorderSide(width: 1, color: graySecond),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                            hintText: 'lorem ipsum',
                            hintStyle: tagHint,
                          ),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'image',
                          style: textTitleBookmark,
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        GestureDetector(
                          onTap: () async {
                            //show dialog to choose pick from image or camera
                            await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Choose Image',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    )),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          Navigator.pop(context);
                                          final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                          if (pickedFile != null) {
                                            final tempDir = await getTemporaryDirectory();
                                            final path = tempDir.path;
                                            image_reduce.Image image =
                                                image_reduce.decodeImage(File(pickedFile.path).readAsBytesSync())!;
                                            image_reduce.copyResize(image, width: 500);
                                            final compressedImage = File('$path/img_$image.jpg')
                                              ..writeAsBytesSync(image_reduce.encodeJpg(image, quality: 85));

                                            final value = await ref
                                                .read(cagesControllerProvider.notifier)
                                                .uploadImages(compressedImage.path);
                                            setState(() {
                                              _imageController.text = value;
                                              _isLoading = false;
                                            });
                                          } else {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          }
                                        },
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              const WidgetSpan(
                                                child: Icon(
                                                  Icons.image,
                                                ),
                                              ),
                                              TextSpan(
                                                  text: '  From Gallery',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          Navigator.pop(context);
                                          final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
                                          if (pickedFile != null) {
                                            final tempDir = await getTemporaryDirectory();
                                            final path = tempDir.path;
                                            image_reduce.Image image =
                                                image_reduce.decodeImage(File(pickedFile.path).readAsBytesSync())!;
                                            image_reduce.copyResize(image, width: 500);
                                            final compressedImage = File('$path/img_$image.jpg')
                                              ..writeAsBytesSync(image_reduce.encodeJpg(image, quality: 85));

                                            final value = await ref
                                                .read(cagesControllerProvider.notifier)
                                                .uploadImages(compressedImage.path);
                                            setState(() {
                                              _imageController.text = value;
                                              _isLoading = false;
                                            });
                                          } else {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          }
                                        },
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              const WidgetSpan(
                                                child: Icon(
                                                  Icons.camera_alt,
                                                ),
                                              ),
                                              TextSpan(
                                                  text: '  From Camera',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: _isLoading
                              ? Container(
                                  height: 200.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.r),
                                    border: Border.all(color: graySecond),
                                  ),
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : _imageController.text == ''
                                  ? Container(
                                      height: 200.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6.r),
                                        border: Border.all(color: graySecond),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 200.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            _imageController.text,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                        ),
                        // FutureBuilder(

                        //   future: _imageController.text == ''
                        //       ? Future.value('https://picsum.photos/500/300?random=1')
                        //       : Future.value(_imageController.text),
                        //   builder: (context, snapshot) {
                        //     if (snapshot.hasData) {
                        //       return GestureDetector(
                        //         onTap: () async {
                        //           final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                        //           if (pickedFile != null) {
                        //             final image = File(pickedFile.path);
                        //             final fileName = basename(image.path);
                        //             final destination = 'images/$fileName';
                        //             final storage = FirebaseStorage.instance;
                        //             final task = storage.ref(destination).putFile(image);
                        //             final snapshot = await task.whenComplete(() {});
                        //             final url = await snapshot.ref.getDownloadURL();
                        //             setState(() {
                        //               _imageController.text = url;
                        //             });
                        //           }
                        //         },
                        //         child: Container(
                        //           height: 200.h,
                        //           width: double.infinity,
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(6.r),
                        //             image: DecorationImage(
                        //               image: NetworkImage(snapshot.data.toString()),
                        //               fit: BoxFit.cover,
                        //             ),
                        //           ),
                        //         ),
                        //       );
                        //     } else {
                        //       return const Center(
                        //         child: CircularProgressIndicator(),
                        //       );
                        //     }
                        //   },
                        // ),

                        // TextFormField(
                        //   autovalidateMode: AutovalidateMode.onUserInteraction,
                        //   controller: _imageController,
                        //   decoration: InputDecoration(
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(6.r),
                        //       borderSide: BorderSide(width: 1, color: graySecond),
                        //     ),
                        //     contentPadding: const EdgeInsets.all(12),
                        //     hintText: 'https://',
                        //     hintStyle: tagHint,
                        //     suffixIcon: IconButton(
                        //       onPressed: () async {
                        //         // upload image to firebase storage
                        //         // final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                        //         // if (pickedFile != null) {
                        //         //   final file = File(pickedFile.path);
                        //         //   final fileName = basename(file.path);
                        //         //   final destination = 'images/$fileName';
                        //         //   final ref = FirebaseStorage.instance.ref(destination);
                        //         //   await ref.putFile(file);
                        //         //   final url = await ref.getDownloadURL();
                        //         //   _imageController.text = url;
                        //         // }
                        //       },
                        //       icon: const Icon(Icons.image),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 18.h,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'gliders',
                      style: textTitleBookmarkGliders,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'name',
                          style: textTitleBookmark,
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.r),
                              borderSide: BorderSide(width: 1, color: graySecond),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                            hintText: 'gray',
                            hintStyle: tagHint,
                          ),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'gender',
                          style: textTitleBookmark,
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        DropdownButtonFormField(
                            items: const [
                              DropdownMenuItem(
                                value: 'jantan',
                                child: Text('jantan'),
                              ),
                              DropdownMenuItem(
                                value: 'betina',
                                child: Text('betina'),
                              ),
                            ],
                            value: _genderController.text,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.r),
                                borderSide: BorderSide(width: 1, color: graySecond),
                              ),
                              contentPadding: const EdgeInsets.all(12),
                              hintStyle: tagHint,
                            ),
                            onChanged: (value) {
                              _genderController.text = value.toString();
                            }),
                        SizedBox(
                          height: 18.h,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'age',
                          style: textTitleBookmark,
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _ageController,
                          onFieldSubmitted: (value) async {
                            if (_ageController.text.isNotEmpty && _nameController.text.isNotEmpty) {
                              final gliders = Gliders(
                                name: _nameController.text,
                                age: int.tryParse(_ageController.text),
                                gender: _genderController.text,
                              );

                              setState(() {
                                listGliders.add(gliders);
                              });

                              _nameController.clear();
                              _ageController.clear();
                              _genderController.text = 'jantan';
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please fill the form'),
                                ),
                              );
                            }
                          },
                          decoration: InputDecoration(
                            //suffix icon with text months
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'months',
                                style: textTitleBookmark.copyWith(color: Colors.grey),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.r),
                              borderSide: BorderSide(width: 1, color: graySecond),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                            hintText: '5',
                            hintStyle: tagHint,
                          ),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                      ],
                    ),
                    Visibility(
                      visible: listGliders.isNotEmpty,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'list of gliders',
                            style: textTitleBookmarkGliders,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: listGliders.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CheckboxListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    listGliders[index].name.toString(),
                                    style: articleTagCheck,
                                  ),
                                  subtitle: Text(
                                    '${listGliders[index].age} months',
                                    style: articleTagCheck,
                                  ),
                                  secondary: Text(listGliders[index].gender.toString()),
                                  value: listGliders.contains(listGliders[index]),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (listGliders.contains(listGliders[index])) {
                                        listGliders.remove(listGliders[index]); // unselect
                                      } else {
                                        listGliders.add(listGliders[index]); // select
                                      }
                                    });
                                  },
                                  controlAffinity: ListTileControlAffinity.leading,
                                );
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gliders/src/features/auth/presentation/auth_controller.dart';
// import 'package:gliders/src/features/cages/domain/cages/cages.dart';
// import 'package:gliders/src/features/home/presentation/botnavbar_screen.dart';
// import 'package:gliders/src/features/home/presentation/cages_controller.dart';
// import 'package:gliders/src/shared/theme.dart';

// class CagesAddScreen extends ConsumerStatefulWidget {
//   final bool isEdit;
//   final Cages? cages;
//   const CagesAddScreen({Key? key, required this.isEdit, this.cages}) : super(key: key);

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _CagesAddScreenState();
// }

// class _CagesAddScreenState extends ConsumerState<CagesAddScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _titleController = TextEditingController();
//   final _categoryController = TextEditingController();
//   final _notesController = TextEditingController();
//   final _imageController = TextEditingController();
//   final _glidersController = TextEditingController();
//   final List<String> listGliders = [];

//   @override
//   void initState() {
//     super.initState();
//     if (widget.isEdit) {
//       _titleController.text = widget.cages!.title.toString();
//       _categoryController.text = widget.cages!.category.toString();
//       _notesController.text = widget.cages!.notes.toString();
//       _imageController.text = widget.cages!.images.toString();
//       listGliders.addAll(widget.cages!.gliders!.toList());
//     } else {
//       _categoryController.text = 'koloni';
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _titleController.dispose();
//     _categoryController.dispose();
//     _notesController.dispose();
//     _imageController.dispose();
//     _glidersController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final users = ref.watch(authControllerProvider);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 1,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Image.asset(
//             'assets/images/x-icon.png',
//             width: 12.w,
//             height: 12.h,
//           ),
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Visibility(
//                   visible: false,
//                   child: IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Image.asset(
//                       'assets/images/x-icon.png',
//                       width: 12.w,
//                       height: 12.h,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   widget.isEdit ? 'Edit Cages' : 'Add Cages',
//                   style: btmsheet,
//                 ),
//               ],
//             ),
//             TextButton(
//               onPressed: () async {
//                 if (_formKey.currentState!.validate()) {
//                   if (widget.isEdit) {
//                     await ref.read(cagesControllerProvider.notifier).update(
//                           Cages(
//                             id: widget.cages!.id,
//                             title: _titleController.text,
//                             category: _categoryController.text,
//                             notes: _notesController.text,
//                             images: _imageController.text,
//                             gliders: listGliders,
//                           ),
//                           name: users.name.toString(),
//                           photo: users.photo.toString(),
//                         );
//                   } else {
//                     await ref.read(cagesControllerProvider.notifier).add(
//                           title: _titleController.text,
//                           category: _categoryController.text,
//                           gliders: listGliders,
//                           images:
//                               _imageController.text == '' ? 'https://picsum.photos/500/300?random=1' : _imageController.text,
//                           notes: _notesController.text,
//                           name: users.name.toString(),
//                           photo: users.photo.toString(),
//                         );
//                   }

//                   if (mounted) {
//                     Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const BotNavBarScreen(),
//                         ));
//                   }
//                 }
//               },
//               child: Text(
//                 'Save',
//                 style: txtBtnBlue,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'title *',
//                       style: textTitleBookmark,
//                     ),
//                     SizedBox(
//                       height: 6.h,
//                     ),
//                     TextFormField(
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter title';
//                         }
//                         return null;
//                       },
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       controller: _titleController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(6.r),
//                           borderSide: BorderSide(width: 1, color: graySecond),
//                         ),
//                         contentPadding: const EdgeInsets.all(12),
//                         hintText: 'kandang 1',
//                         hintStyle: tagHint,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 18.h,
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'category *',
//                       style: textTitleBookmark,
//                     ),
//                     SizedBox(
//                       height: 6.h,
//                     ),
//                     DropdownButtonFormField(
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter category';
//                           }
//                           return null;
//                         },
//                         items: const [
//                           DropdownMenuItem(
//                             value: 'koloni',
//                             child: Text('koloni'),
//                           ),
//                           DropdownMenuItem(
//                             value: 'solo',
//                             child: Text('solo'),
//                           ),
//                           DropdownMenuItem(
//                             value: 'ip',
//                             child: Text('ip'),
//                           ),
//                         ],
//                         value: _categoryController.text,
//                         autovalidateMode: AutovalidateMode.onUserInteraction,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(6.r),
//                             borderSide: BorderSide(width: 1, color: graySecond),
//                           ),
//                           contentPadding: const EdgeInsets.all(12),
//                           hintStyle: tagHint,
//                         ),
//                         onChanged: (value) {
//                           _categoryController.text = value.toString();
//                         }),
//                     SizedBox(
//                       height: 18.h,
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'notes',
//                       style: textTitleBookmark,
//                     ),
//                     SizedBox(
//                       height: 6.h,
//                     ),
//                     TextFormField(
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       controller: _notesController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(6.r),
//                           borderSide: BorderSide(width: 1, color: graySecond),
//                         ),
//                         contentPadding: const EdgeInsets.all(12),
//                         hintText: 'lorem ipsum',
//                         hintStyle: tagHint,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 18.h,
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'image',
//                       style: textTitleBookmark,
//                     ),
//                     SizedBox(
//                       height: 6.h,
//                     ),
//                     TextFormField(
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       controller: _imageController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(6.r),
//                           borderSide: BorderSide(width: 1, color: graySecond),
//                         ),
//                         contentPadding: const EdgeInsets.all(12),
//                         hintText: 'https://',
//                         hintStyle: tagHint,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 18.h,
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'gliders *',
//                       style: textTitleBookmark,
//                     ),
//                     SizedBox(
//                       height: 6.h,
//                     ),
//                     TextFormField(
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       controller: _glidersController,
//                       onFieldSubmitted: (value) async {
//                         setState(() {
//                           listGliders.add(value);
//                         });
//                         _glidersController.clear();
//                       },
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(6.r),
//                           borderSide: BorderSide(width: 1, color: graySecond),
//                         ),
//                         contentPadding: const EdgeInsets.all(12),
//                         hintText: 'gray',
//                         hintStyle: tagHint,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 18.h,
//                     ),
//                     ListView.builder(
//                         physics: const NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         itemCount: listGliders.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return CheckboxListTile(
//                             contentPadding: EdgeInsets.zero,
//                             title: Text(
//                               listGliders[index],
//                               style: articleTagCheck,
//                             ),
//                             value: listGliders.contains(listGliders[index]),
//                             onChanged: (bool? value) {
//                               setState(() {
//                                 if (listGliders.contains(listGliders[index])) {
//                                   listGliders.remove(listGliders[index]); // unselect
//                                 } else {
//                                   listGliders.add(listGliders[index]); // select
//                                 }
//                               });
//                             },
//                             controlAffinity: ListTileControlAffinity.leading,
//                           );
//                         }),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }