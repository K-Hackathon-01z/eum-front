import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../services/user/government_service.dart';
import '../../../../models/government/benefit_info.dart';

class GovernmentHelpScreen extends StatelessWidget {
  const GovernmentHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GovernmentService governmentService = GovernmentService();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '정부 지원 혜택',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: -1.2),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey[500], height: 1.0),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 24, 20, 8),
            child: Text(
              '나에게 맞는 정부 지원 정책을 한눈에 확인하세요!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<BenefitInfo>>(
              future: governmentService.fetchRecommendedBenefits('1'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('데이터를 불러올 수 없습니다'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('추천 정부 혜택이 없습니다'));
                }
                final policies = snapshot.data!;
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: policies.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, idx) {
                    final policy = policies[idx];
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        title: Text(policy.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text('분류: ${policy.category}', style: const TextStyle(fontSize: 14)),
                            const SizedBox(height: 4),
                            Text('대상연령: ${policy.targetAge}세', style: const TextStyle(fontSize: 14)),
                            const SizedBox(height: 8),
                            Text(policy.description, style: const TextStyle(fontSize: 15, color: Colors.black87)),
                          ],
                        ),
                        trailing: const Icon(Icons.chevron_right, color: Colors.black38),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                              title: Text(policy.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(policy.description),
                                  const SizedBox(height: 12),
                                  Text('분류: ${policy.category}'),
                                  Text('대상연령: ${policy.targetAge}세'),
                                  const SizedBox(height: 12),
                                  GestureDetector(
                                    onTap: () async {
                                      final url = policy.url;
                                      if (await canLaunchUrl(Uri.parse(url))) {
                                        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                                      }
                                    },
                                    child: Text(
                                      policy.url,
                                      style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('닫기')),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
