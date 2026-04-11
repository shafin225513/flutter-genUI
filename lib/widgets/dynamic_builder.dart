import 'package:flutter/material.dart';

Widget buildWidget(Map<String, dynamic> config, {Function(String)? onAction}) {
  final String type = config["type"] ?? "text";
  
  // Helper to extract styles safely
  final Map<String, dynamic> style = config["style"] ?? {};

  switch (type) {
    case "container":
      return Container(
        padding: EdgeInsets.all((config["padding"] ?? 10).toDouble()),
        margin: EdgeInsets.all((config["margin"] ?? 0).toDouble()),
        decoration: BoxDecoration(
          color: _parseColor(config["color"]),
          borderRadius: BorderRadius.circular((config["borderRadius"] ?? 0).toDouble()),
        ),
        child: config["child"] != null && config["child"] is Map<String, dynamic>
            ? buildWidget(config["child"], onAction: onAction)
            : null,
      );

    case "text":
      return Text(
        config["value"] ?? "Default Text",
        style: TextStyle(
          color: _parseColor(style["color"]),
          fontSize: (style["fontSize"] ?? 14).toDouble(),
          fontWeight: style["fontWeight"] == "bold" ? FontWeight.bold : FontWeight.normal,
        ),
      );

      case "textField":
        return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
        decoration: InputDecoration(
        labelText: config["label"] ?? "Enter text",
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    ),
  );

    case "button":
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _parseColor(config["color"]),
          foregroundColor: config["color"] != null ? Colors.white : null,
        ),
        onPressed: () {
          if (config["action"] != null && onAction != null) {
            onAction(config["action"]); // Handle clicks dynamically!
          }
        },
        child: Text(config["text"] ?? "Button"),
      );

    case "column":
    case "row":
      final List rawChildren = config["children"] ?? [];
      final List<Widget> children = rawChildren.map((child) {
        if (child is Map<String, dynamic>) {
          return buildWidget(child, onAction: onAction);
        }
        return const SizedBox();
      }).toList();

      return type == "column"
          ? Column(
              crossAxisAlignment: _parseCrossAxis(config["crossAlign"]),
              mainAxisAlignment: _parseMainAxis(config["mainAlign"]),
              children: children,
            )
          : Row(
              mainAxisAlignment: _parseMainAxis(config["mainAlign"]),
              children: children,
            );

    case "image":
      return ClipRRect(
        borderRadius: BorderRadius.circular((config["borderRadius"] ?? 0).toDouble()),
        child: Image.network(
          config["url"] ?? "https://via.placeholder.com/150",
          height: (config["height"] ?? 150).toDouble(),
          width: (config["width"] ?? double.infinity).toDouble(),
          fit: BoxFit.cover,
        ),
      );

    default:
      return Text("Unsupported: $type", style: const TextStyle(color: Colors.red));
  }
}

// --- HELPER PARSERS ---

Color? _parseColor(String? colorStr) {
  if (colorStr == null) return null;
  if (colorStr.startsWith('#')) {
    return Color(int.parse(colorStr.replaceFirst('#', '0xff')));
  }
  switch (colorStr.toLowerCase()) {
    case 'blue': return Colors.blue;
    case 'red': return Colors.red;
    case 'green': return Colors.green;
    case 'orange': return Colors.orange;
    case 'white': return Colors.white;
    case 'black': return Colors.black;
    default: return Colors.grey;
  }
}

MainAxisAlignment _parseMainAxis(String? align) {
  switch (align) {
    case 'center': return MainAxisAlignment.center;
    case 'spaceBetween': return MainAxisAlignment.spaceBetween;
    case 'end': return MainAxisAlignment.end;
    default: return MainAxisAlignment.start;
  }
}

CrossAxisAlignment _parseCrossAxis(String? align) {
  switch (align) {
    case 'center': return CrossAxisAlignment.center;
    case 'stretch': return CrossAxisAlignment.stretch;
    default: return CrossAxisAlignment.start;
  }
}