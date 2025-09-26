import 'package:flutter/material.dart';

class AddressSearchPopup extends StatelessWidget {
  final List<String> results;
  final void Function(String)? onSelect;

  const AddressSearchPopup({super.key, required this.results, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_on, size: 40, color: Color(0xFF9785BA)),
            const SizedBox(height: 12),
            const Text('주소 선택', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            results.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Text('검색 결과가 없습니다.', style: TextStyle(fontSize: 16, color: Color(0xFF868383))),
                  )
                : SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (context, idx) {
                        return Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          color: const Color(0xFFF5F2FA),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              onSelect?.call(results[idx]);
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
                                      results[idx],
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
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF9785BA),
                  side: const BorderSide(color: Color(0xFF9785BA)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('취소', style: TextStyle(fontSize: 16, color: Color(0xFF9785BA))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showAddressSearchPopup(BuildContext context, List<String> results, void Function(String) onSelect) async {
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => AddressSearchPopup(results: results, onSelect: onSelect),
  );
}
