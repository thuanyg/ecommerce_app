import 'package:ecommerce_app/core/config/constant.dart';
import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  static String routeName = "/FaqPage";
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('FAQs'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return FAQItemWidget(faq: faqs[index]);
        },
      ),
    );
  }
}

class FAQItemWidget extends StatefulWidget {
  final FAQItem faq;

  const FAQItemWidget({Key? key, required this.faq}) : super(key: key);

  @override
  _FAQItemWidgetState createState() => _FAQItemWidgetState();
}

class _FAQItemWidgetState extends State<FAQItemWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      child: ExpansionTile(
        title: Text(
          widget.faq.question,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        onExpansionChanged: (bool expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        trailing: Icon(
          _isExpanded ? Icons.expand_less : Icons.expand_more,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.faq.answer,
              style: const TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
