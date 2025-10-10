import 'package:flutter/material.dart';

class AddressSearchPopupV2 extends StatefulWidget {
  final void Function(String)? onSelect;
  final Future<List<String>> Function(String) onSearch;

  const AddressSearchPopupV2({super.key, this.onSelect, required this.onSearch});

  @override
  State<AddressSearchPopupV2> createState() => _AddressSearchPopupV2State();
}

class _AddressSearchPopupV2State extends State<AddressSearchPopupV2> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _results = [];
  bool _isSearching = false;
  String? _error = '검색어를 입력해주세요.';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    setState(() {
      _isSearching = true;
      _error = null;
    });
    final keyword = _searchController.text.trim();
    if (keyword.isEmpty) {
      setState(() {
        _results = [];
        _error = '검색어를 입력해주세요.';
        _isSearching = false;
      });
      return;
    }
    try {
      final results = await widget.onSearch(keyword);
      setState(() {
        _results = results;
        _error = null;
        _isSearching = false;
      });
    } catch (e) {
      setState(() {
        _results = [];
        _error = '검색 중 오류가 발생했습니다.';
        _isSearching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.location_on, size: 40, color: Color(0xFF9785BA)),
                  const SizedBox(height: 12),
                  const Text('주소 선택', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(labelText: '주소 검색어', border: OutlineInputBorder()),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                    onSubmitted: (_) => _search(),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9785BA),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: _isSearching ? null : _search,
                      child: _isSearching
                          ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Text('검색', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(_error!, style: const TextStyle(fontSize: 15, color: Color(0xFF868383))),
                    ),
                  if (!_isSearching && _results.isEmpty && _error == null)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Text('검색 결과가 없습니다.', style: TextStyle(fontSize: 16, color: Color(0xFF868383))),
                    ),
                  if (_results.isNotEmpty)
                    SizedBox(
                      height: 190,
                      child: Scrollbar(
                        thumbVisibility: true,
                        child: ListView.builder(
                          itemCount: _results.length,
                          itemBuilder: (context, idx) {
                            return Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 0,
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              color: const Color(0xFFF5F2FA),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  widget.onSelect?.call(_results[idx]);
                                  Navigator.of(context).pop();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.home, color: Color(0xFF9785BA), size: 20),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          _results[idx],
                                          style: const TextStyle(fontSize: 16, color: Color(0xFF3B2D5B)),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(Icons.close, size: 28, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showAddressSearchPopupV2(
  BuildContext context,
  Future<List<String>> Function(String) onSearch,
  void Function(String) onSelect,
) async {
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => AddressSearchPopupV2(onSearch: onSearch, onSelect: onSelect),
  );
}
