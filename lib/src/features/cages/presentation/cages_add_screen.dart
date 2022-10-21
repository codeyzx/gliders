import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gliders/src/features/auth/presentation/auth_controller.dart';
import 'package:gliders/src/features/cages/domain/cages/cages.dart';
import 'package:gliders/src/features/cages/domain/gliders/gliders.dart';
import 'package:gliders/src/features/home/presentation/botnavbar_screen.dart';
import 'package:gliders/src/features/home/presentation/cages_controller.dart';
import 'package:gliders/src/shared/theme.dart';

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
                          images:
                              _imageController.text == '' ? 'https://picsum.photos/500/300?random=1' : _imageController.text,
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
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _imageController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.r),
                              borderSide: BorderSide(width: 1, color: graySecond),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                            hintText: 'https://',
                            hintStyle: tagHint,
                          ),
                        ),
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