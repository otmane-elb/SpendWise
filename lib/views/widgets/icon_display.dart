// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const Map<String, IconData> iconMap = {
  'house': FontAwesomeIcons.house,
  'utensils': FontAwesomeIcons.utensils,
  'cartShopping': FontAwesomeIcons.cartShopping,
  'gasPump': FontAwesomeIcons.gasPump,
  'lightbulb': FontAwesomeIcons.lightbulb,
  'water': FontAwesomeIcons.water,
  'mobileScreenButton': FontAwesomeIcons.mobileScreenButton,
  'creditCard': FontAwesomeIcons.creditCard,
  'internetExplorer': FontAwesomeIcons.internetExplorer,
  'car': FontAwesomeIcons.car,
  'dollarSign': FontAwesomeIcons.dollarSign,
  'moneyBill': FontAwesomeIcons.moneyBill,
  'school': FontAwesomeIcons.school,
  'tv': FontAwesomeIcons.tv,
  'wifi': FontAwesomeIcons.wifi,
  'bell': FontAwesomeIcons.bell,
  'appleWhole': FontAwesomeIcons.appleWhole,
  'book': FontAwesomeIcons.book,
  'mugSaucer': FontAwesomeIcons.mugSaucer,
  'bus': FontAwesomeIcons.bus,
  'heart': FontAwesomeIcons.heart,
  'shirt': FontAwesomeIcons.shirt,
  'hospital': FontAwesomeIcons.hospital,
  'medkit': FontAwesomeIcons.medkit,
  'pharmacy': FontAwesomeIcons.prescriptionBottleAlt,
  'gym': FontAwesomeIcons.dumbbell,
  'movie': FontAwesomeIcons.film,
  'gift': FontAwesomeIcons.gift,
  'taxi': FontAwesomeIcons.taxi,
  'plane': FontAwesomeIcons.plane,
  'hotel': FontAwesomeIcons.hotel,
  'cocktail': FontAwesomeIcons.cocktail,
  'coffee': FontAwesomeIcons.coffee,
  'music': FontAwesomeIcons.music,
  'baby': FontAwesomeIcons.baby,
  'pet': FontAwesomeIcons.paw,
  'bicycle': FontAwesomeIcons.bicycle,
  'tools': FontAwesomeIcons.toolbox,
  'laptop': FontAwesomeIcons.laptop,
  'shoppingBag': FontAwesomeIcons.shoppingBag,
  'tshirt': FontAwesomeIcons.tshirt,
  'hamburger': FontAwesomeIcons.hamburger,
  'pizza': FontAwesomeIcons.pizzaSlice,
  'couch': FontAwesomeIcons.couch,
  'wineGlass': FontAwesomeIcons.wineGlass,
  'beer': FontAwesomeIcons.beer,
};

IconData? getIconDataFromString(String? iconString) {
  return iconMap[iconString];
}

String? getStringFromIconData(IconData? iconData) {
  if (iconData == null) return null;
  return iconMap.entries
      .firstWhere((entry) => entry.value == iconData,
          orElse: () => const MapEntry('', Icons.error))
      .key;
}
