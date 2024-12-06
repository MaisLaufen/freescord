import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RepositoriesList extends StatelessWidget {
  const RepositoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color(0xff333333),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Ссылки на репозитории проектов:',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          RepositoryLinkItem(
            index: 1,
            title: 'zapret',
            url: 'https://github.com/bol-van/zapret/',
            author: 'by bol-van',
          ),
          SizedBox(height: 3),
          RepositoryLinkItem(
            index: 2,
            title: 'zapret-discord-youtube',
            url: 'https://github.com/Flowseal/zapret-discord-youtube',
            author: 'by Flowseal',
          ),
          SizedBox(height: 3),
          RepositoryLinkItem(
            index: 3,
            title: 'WinDivert',
            url: 'https://github.com/basil00/WinDivert',
            author: 'by basil00',
          ),
          RepositoryLinkItem(
            index: 4,
            title: 'Freescord',
            url: 'https://github.com/MaisLaufen/freescord',
            author: 'by MaisLaufen',
          )
        ],
      ),
    );
  }
}

class RepositoryLinkItem extends StatelessWidget {
  final int index;
  final String title;
  final String url;
  final String author;

  const RepositoryLinkItem(
      {super.key,
      required this.index,
      required this.title,
      required this.url,
      required this.author});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _launchURL(url),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            '$index.',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            title,
            style: const TextStyle(
              color: Color.fromARGB(255, 61, 106, 255),
              decoration: TextDecoration.underline,
              decorationColor: Color.fromARGB(255, 61, 106, 255),
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            author,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ]));
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
