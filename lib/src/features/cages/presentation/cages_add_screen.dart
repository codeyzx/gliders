import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gliders/src/features/home/domain/cages/cages.dart';
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
  final _notesController = TextEditingController();
  final _imageController = TextEditingController();
  final _glidersController = TextEditingController();
  final List<String> listGliders = [];

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      _titleController.text = widget.cages!.title.toString();
      _categoryController.text = widget.cages!.category.toString();
      _notesController.text = widget.cages!.notes.toString();
      _imageController.text = widget.cages!.images.toString();
      listGliders.addAll(widget.cages!.gliders!.toList());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _categoryController.dispose();
    _notesController.dispose();
    _imageController.dispose();
    _glidersController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (widget.isEdit) {
                    ref.read(cagesControllerProvider.notifier).update(
                          Cages(
                            id: widget.cages!.id,
                            title: _titleController.text,
                            category: _categoryController.text,
                            notes: _notesController.text,
                            images: _imageController.text,
                            gliders: listGliders,
                          ),
                        );
                  } else {
                    ref.read(cagesControllerProvider.notifier).add(
                          title: _titleController.text,
                          category: _categoryController.text,
                          gliders: listGliders,
                          images:
                              _imageController.text == '' ? 'https://picsum.photos/500/300?random=1' : _imageController.text,
                          notes: _notesController.text,
                        );
                  }

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BotNavBarScreen(),
                      ));
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
                      'title',
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
                      'category',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter category';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _categoryController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: graySecond),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: 'koloni',
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'gliders',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _glidersController,
                      onFieldSubmitted: (value) async {
                        setState(() {
                          listGliders.add(value);
                        });
                        _glidersController.clear();
                      },
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
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: listGliders.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              listGliders[index],
                              style: articleTagCheck,
                            ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
