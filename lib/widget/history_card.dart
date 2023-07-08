import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/model/pet_model.dart';
import 'package:pet_adoption/util/date_format.dart';
import 'package:pet_adoption/widget/title_card.dart';

class PetHistoryCard extends StatelessWidget {
  final Pet pet;
  const PetHistoryCard({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: pet.image!.url!,
            height: 100,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleCard(
                title: "Name:\n",
                value: pet.name!,
                titleStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.normal),
                valueStyle: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 10),
              TitleCard(
                title: "Adopted Time:\n",
                value: DateUtil.dateTimeYearFormat(
                    DateTime.parse(pet.adoptedDate!)),
                titleStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.normal),
                valueStyle: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
            ],
          )
        ],
      ),
    );
  }
}
