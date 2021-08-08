import 'package:flutter/material.dart';

var items = [
  "Andhra Pradesh",
  "Arunachal Pradesh",
  "Assam",
  "Bihar",
  "Chhattisgarh",
  "Goa",
  "Gujarat",
  "Haryana",
  "Himachal Pradesh",
  "Jammu and Kashmir",
  "Jharkhand",
  "Karnataka",
  "Kerala",
  "Madhya Pradesh",
  "Maharashtra",
  "Manipur",
  "Meghalaya",
  "Mizoram",
  "Nagaland",
  "Odisha",
  "Punjab",
  "Rajasthan",
  "Sikkim",
  "Tamil Nadu",
  "Telangana",
  "Tripura",
  "Uttarakhand",
  "Uttar Pradesh",
  "West Bengal",
  "Andaman and Nicobar Islands",
  "Chandigarh",
  "Dadra and Nagar Haveli",
  "Daman and Diu",
  "Delhi",
  "Lakshadweep",
  "Puducherry"
];
var statesItems = [
  DropdownMenuItem(
    child: Text("${items[0]}"),
    value: "${items[0].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[1]}"),
    value: "${items[1].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[2]}"),
    value: "${items[2].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[3]}"),
    value: "${items[3].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[4]}"),
    value: "${items[4].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[5]}"),
    value: "${items[5].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[6]}"),
    value: "${items[6].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[7]}"),
    value: "${items[7].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[8]}"),
    value: "${items[8].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[9]}"),
    value: "${items[9].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[10]}"),
    value: "${items[10].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[11]}"),
    value: "${items[11].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[12]}"),
    value: "${items[12].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[13]}"),
    value: "${items[13].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[14]}"),
    value: "${items[14].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[15]}"),
    value: "${items[15].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[16]}"),
    value: "${items[16].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[17]}"),
    value: "${items[17].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[18]}"),
    value: "${items[18].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[19]}"),
    value: "${items[19].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[20]}"),
    value: "${items[20].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[21]}"),
    value: "${items[21].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[22]}"),
    value: "${items[22].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[23]}"),
    value: "${items[23].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[24]}"),
    value: "${items[24].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[25]}"),
    value: "${items[25].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[26]}"),
    value: "${items[26].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[27]}"),
    value: "${items[27].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[28]}"),
    value: "${items[28].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[29]}"),
    value: "${items[29].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[30]}"),
    value: "${items[30].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[31]}"),
    value: "${items[31].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[32]}"),
    value: "${items[32].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[33]}"),
    value: "${items[33].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[34]}"),
    value: "${items[34].toLowerCase()}",
  ),
  DropdownMenuItem(
    child: Text("${items[35]}"),
    value: "${items[35].toLowerCase()}",
  ),
];
// var statesItems2 = [
//   DropdownMenuItem(
//     child: Text("${items[0].toLowerCase()}"),
//     value: "${items[0].toLowerCase()}",
//   ),
//   DropdownMenuItem(
//     child: Text("Arunachal Pradesh"),
//     value: "Arunachal Pradesh",
//   ),
//   DropdownMenuItem(
//     child: Text("Assam"),
//     value: "Assam",
//   ),
//   DropdownMenuItem(
//     child: Text("Bihar"),
//     value: "Bihar",
//   ),
//   DropdownMenuItem(
//     child: Text("Chhattisgarh"),
//     value: "Chhattisgarh",
//   ),
//   DropdownMenuItem(
//     child: Text("Goa"),
//     value: "Goa",
//   ),
//   DropdownMenuItem(
//     child: Text("Gujarat"),
//     value: "Gujarat",
//   ),
//   DropdownMenuItem(
//     child: Text("Haryana"),
//     value: "Haryana",
//   ),
//   DropdownMenuItem(
//     child: Text("Himachal Pradesh"),
//     value: "Himachal Pradesh",
//   ),
//   DropdownMenuItem(
//     child: Text("Jammu and Kashmir"),
//     value: "Jammu and Kashmir",
//   ),
//   DropdownMenuItem(
//     child: Text("Jharkhand"),
//     value: "Jharkhand",
//   ),
//   DropdownMenuItem(
//     child: Text("Karnataka"),
//     value: "Karnataka",
//   ),
//   DropdownMenuItem(
//     child: Text("Kerala"),
//     value: "Kerala",
//   ),
//   DropdownMenuItem(
//     child: Text("Madhya Pradesh"),
//     value: "Madhya Pradesh",
//   ),
//   DropdownMenuItem(
//     child: Text("Maharashtra"),
//     value: "Maharashtra",
//   ),
//   DropdownMenuItem(
//     child: Text("Manipur"),
//     value: "Manipur",
//   ),
//   DropdownMenuItem(
//     child: Text("Meghalaya"),
//     value: "Meghalaya",
//   ),
//   DropdownMenuItem(
//     child: Text("Mizoram"),
//     value: "Mizoram",
//   ),
//   DropdownMenuItem(
//     child: Text("Nagaland"),
//     value: "Nagaland",
//   ),
//   DropdownMenuItem(
//     child: Text("Odisha"),
//     value: "Odisha",
//   ),
//   DropdownMenuItem(
//     child: Text("Punjab"),
//     value: "Punjab",
//   ),
//   DropdownMenuItem(
//     child: Text("Rajasthan"),
//     value: "Rajasthan",
//   ),
//   DropdownMenuItem(
//     child: Text("Sikkim"),
//     value: "Sikkim",
//   ),
//   DropdownMenuItem(
//     child: Text("Tamil Nadu"),
//     value: "Tamil Nadu",
//   ),
//   DropdownMenuItem(
//     child: Text("Telangana"),
//     value: "Telangana",
//   ),
//   DropdownMenuItem(
//     child: Text("Tripura"),
//     value: "Tripura",
//   ),
//   DropdownMenuItem(
//     child: Text("Uttarakhand"),
//     value: "Uttarakhand",
//   ),
//   DropdownMenuItem(
//     child: Text("Uttar Pradesh"),
//     value: "Uttar Pradesh",
//   ),
//   DropdownMenuItem(
//     child: Text("West Bengal"),
//     value: "West Bengal",
//   ),
//   DropdownMenuItem(
//     child: Text("Andaman and Nicobar Islands"),
//     value: "Andaman and Nicobar Islands",
//   ),
//   DropdownMenuItem(
//     child: Text("Chandigarh"),
//     value: "Chandigarh",
//   ),
//   DropdownMenuItem(
//     child: Text("Dadra and Nagar Haveli"),
//     value: "Dadra and Nagar Haveli",
//   ),
//   DropdownMenuItem(
//     child: Text("Daman and Diu"),
//     value: "Daman and Diu",
//   ),
//   DropdownMenuItem(
//     child: Text("Delhi"),
//     value: "Delhi",
//   ),
//   DropdownMenuItem(
//     child: Text("Lakshadweep"),
//     value: "Lakshadweep",
//   ),
//   DropdownMenuItem(
//     child: Text("Puducherry"),
//     value: "Puducherry",
//   ),
// ];
