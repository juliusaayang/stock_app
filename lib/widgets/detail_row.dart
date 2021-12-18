import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailRow extends StatelessWidget {
  DetailRow({required this.attributes, required this.results});
  final String attributes;
  final String results;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              attributes,
              style: GoogleFonts.raleway(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              results,
              style: GoogleFonts.raleway(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Divider(
          color: Colors.grey[600],
          thickness: 1,
        ),
      ],
    );
  }
}
