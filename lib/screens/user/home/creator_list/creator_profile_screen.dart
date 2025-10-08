import 'package:flutter/material.dart';
import '../../../../widgets/user/appbar.dart';
import '../../../../widgets/user/creator_list.dart';
import 'package:provider/provider.dart';
import '../../../../providers/creator_provider.dart';

class CreatorProfileScreen extends StatefulWidget {
  final String subCategory;
  const CreatorProfileScreen({super.key, required this.subCategory});

  @override
  State<CreatorProfileScreen> createState() => _CreatorProfileScreenState();
}

class _CreatorProfileScreenState extends State<CreatorProfileScreen> {
  bool _fetched = false;

  @override
  void initState() {
    super.initState();
    // 최초 1회만 fetchAllCreators 호출
    Future.microtask(() {
      if (!_fetched) {
        Provider.of<CreatorProvider>(context, listen: false).fetchAllCreators();
        _fetched = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final creatorProvider = Provider.of<CreatorProvider>(context);
    final filteredCreators = creatorProvider.creators
        .where((c) => c.subCategory.trim() == widget.subCategory.trim())
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: CustomAppBar(
        title: '${widget.subCategory} 장인',
        showBack: true,
        showHome: true,
        showSearch: true,
        onSearch: () {
          showDialog(
            context: context,
            barrierColor: Colors.black.withOpacity(0.2),
            builder: (context) {
              return Align(
                alignment: Alignment.topCenter,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.black54),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: TextField(
                            autofocus: true,
                            decoration: InputDecoration(hintText: '검색어를 입력하세요', border: InputBorder.none),
                          ),
                        ),
                        IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.of(context).pop()),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        children: filteredCreators.isEmpty
            ? [const Center(child: Text('해당 분야의 장인 정보가 없습니다', style: TextStyle(fontSize: 16)))]
            : filteredCreators
                  .map(
                    (c) => CreatorList(title: c.name, skill: widget.subCategory, works: c.mainWorks, bio: c.biography),
                  )
                  .toList(),
      ),
    );
  }
}
