import 'package:flutter/material.dart';

Widget buildWidget(Map<String, dynamic> config) {
  final String type = config["type"] ?? "text";

  switch (type) {
    case "text":
      return Text(config["value"] ?? "Default Text");

    case "textField":
      return TextField(
        decoration: InputDecoration(
          labelText: config["label"] ?? "Enter text",
        ),
      );

    case "button":
      return ElevatedButton(
        onPressed: () {},
        child: Text(config["text"] ?? "Button"),
      );

    case "column":
      final List rawChildren = config["children"] ?? [];
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rawChildren.map((child) {
          if (child is Map<String, dynamic>) {
            return buildWidget(child);
          }
          return const SizedBox();
        }).toList(),
      );

    case "row":
      final List rawChildren = config["children"] ?? [];
      return Row(
        children: rawChildren.map((child) {
          if (child is Map<String, dynamic>) {
            return buildWidget(child);
          }
          return const SizedBox();
        }).toList(),
      );

    case "container":
      return Container(
        padding: const EdgeInsets.all(10),
        child: config["child"] != null &&
                config["child"] is Map<String, dynamic>
            ? buildWidget(config["child"])
            : const SizedBox(),
      );

    default:
      return Text("Unsupported: $type");
  }
}