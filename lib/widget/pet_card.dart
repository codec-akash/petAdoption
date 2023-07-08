import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption/bloc/pet_bloc/pet_bloc.dart';
import 'package:pet_adoption/model/pet_model.dart';
import 'package:pet_adoption/screens/pet_details.dart';

class PetCard extends StatefulWidget {
  final Pet pet;
  const PetCard({super.key, required this.pet});

  @override
  State<PetCard> createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  late Pet pet;

  @override
  void initState() {
    pet = widget.pet;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PetBloc, PetState>(
      listener: (BuildContext context, state) {
        if (state is PetAdopted) {
          if (state.pet.id == pet.id) {
            setState(() {
              pet = state.pet;
            });
          }
        }
      },
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PetDetailsScreen(pet: widget.pet)));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: ColorFiltered(
            colorFilter: widget.pet.isAdopted
                ? const ColorFilter.mode(Colors.white, BlendMode.saturation)
                : const ColorFilter.mode(
                    Colors.transparent, BlendMode.saturation),
            child: Stack(
              children: [
                Column(
                  children: [
                    Hero(
                      tag: widget.pet.id!,
                      child:
                          CachedNetworkImage(imageUrl: widget.pet.image!.url!),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      color: Colors.blueGrey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            widget.pet.name!,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (widget.pet.breedGroup != null) ...[
                            const SizedBox(height: 5),
                            Text(
                              "breed: ${widget.pet.breedGroup!}",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                if (pet.isAdopted)
                  Positioned(
                    top: 10,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.horizontal(left: Radius.circular(15)),
                        color: Colors.black,
                      ),
                      child: Text("Adopted"),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
