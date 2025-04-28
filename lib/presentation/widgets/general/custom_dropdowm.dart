import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
 final String value;
 final List<String> items;
 final Function(String?) onChanged;
 final String labelText;
 final IconData? prefixIcon;
 final Color? dropdownColor;
 final Color textColor;
 final Color borderColor;
 final Color focusedBorderColor;

 const CustomDropdown({
   required this.value,
   required this.items,
   required this.onChanged,
   required this.labelText,
   this.prefixIcon,
   this.dropdownColor = const Color(0xFF3A86FF),
   this.textColor = Colors.white,
   this.borderColor = Colors.white30,
   this.focusedBorderColor = Colors.white,
 });

 @override
 Widget build(BuildContext context) {
   return DropdownButtonFormField<String>(
     value: value,
     decoration: InputDecoration(
       labelText: labelText,
       prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: textColor.withOpacity(0.7)) : null,
       labelStyle: TextStyle(color: textColor.withOpacity(0.7)),
       enabledBorder: OutlineInputBorder(
         borderSide: BorderSide(color: borderColor),
         borderRadius: BorderRadius.circular(12),
       ),
       focusedBorder: OutlineInputBorder(
         borderSide: BorderSide(color: focusedBorderColor),
         borderRadius: BorderRadius.circular(12),
       ),
     ),
     dropdownColor: dropdownColor,
     style: TextStyle(color: textColor),
     items: items.map((item) => DropdownMenuItem(
       value: item,
       child: Text(item),
     )).toList(),
     onChanged: onChanged,
   );
 }
}