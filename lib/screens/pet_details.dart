import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption/bloc/pet_bloc/pet_bloc.dart';
import 'package:pet_adoption/model/pet_model.dart';
import 'package:pet_adoption/widget/back_button.dart';

class PetDetailsScreen extends StatefulWidget {
  final Pet pet;
  const PetDetailsScreen({super.key, required this.pet});

  @override
  State<PetDetailsScreen> createState() => _PetDetailsScreenState();
}

class _PetDetailsScreenState extends State<PetDetailsScreen> {
  bool isAdopted = false;
  late ConfettiController _confettiController;

  Widget bottomButtom(
      {required String text,
      required Function() onclick,
      required Color color}) {
    return GestureDetector(
      onTap: () async {
        if (isAdopted == true) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Already Adopted !!"),
            backgroundColor: Colors.blueGrey,
          ));
          return;
        }
        await onclick();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        curve: Curves.bounceInOut,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: color,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget titlevalue(String title, String value) {
    return RichText(
        text: TextSpan(
      text: title,
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(fontWeight: FontWeight.bold),
      children: [
        TextSpan(
          text: value,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.normal, fontSize: 20),
        )
      ],
    ));
  }

  Widget successBottomSheet() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "You Adopted ${widget.pet.name}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              color: Colors.transparent,
              child: Text(
                "Yay !!",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Colors.green[300]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> adoptme() async {
    var res = await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Adopting ${widget.pet.name}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Divider(),
              Text(
                "are you sure you want to adopt cute little ${widget.pet.name}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Text(
                          "Yesss",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: Colors.blueGrey),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    width: 1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Text(
                          "Not yet",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: Colors.red[300]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    if (res == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    isAdopted = widget.pet.isAdopted;
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NavigatorBack(
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: 0,
            emissionFrequency: 0.6,
            minimumSize: const Size(10, 10),
            maximumSize: const Size(50, 50),
            numberOfParticles: 1,
            gravity: 0.1,
            child: CustomScrollView(
              slivers: [
                BlocListener<PetBloc, PetState>(
                  listener: (context, state) {
                    if (state is PetAdopted) {
                      setState(() {
                        isAdopted = true;
                      });
                      _confettiController.play();
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15))),
                        builder: (context) => successBottomSheet(),
                      );
                    }
                  },
                  child: SliverToBoxAdapter(child: Container()),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Hero(
                        tag: widget.pet.id!,
                        child: CachedNetworkImage(
                            imageUrl: widget.pet.image!.url!),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 20),
                            titlevalue("name : ", " ${widget.pet.name!} Kgs"),
                            const SizedBox(height: 10),
                            titlevalue("weight : ",
                                " ${widget.pet.weight!.metric!} Kgs"),
                            const SizedBox(height: 10),
                            titlevalue("height : ",
                                " ${widget.pet.height!.metric!} m"),
                            if (widget.pet.breedGroup != null) ...[
                              const SizedBox(height: 10),
                              titlevalue(
                                  "breed : ", " ${widget.pet.breedGroup!} m"),
                            ],
                            const SizedBox(height: 10),
                            titlevalue(
                                "life span : ", " ${widget.pet.lifeSpan!}"),
                            const SizedBox(height: 10),
                            titlevalue("temperament : ",
                                " ${widget.pet.temperament!}"),
                            const SizedBox(height: 10),
                            if (widget.pet.origin != null ||
                                widget.pet.origin!.isNotEmpty) ...[
                              titlevalue("origin : ", " ${widget.pet.origin!}"),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              Expanded(
                child: bottomButtom(
                  text: "Adopt Me",
                  color: isAdopted
                      ? Colors.grey[400]!
                      : Theme.of(context).primaryColor,
                  onclick: () async {
                    var res = await adoptme();
                    if (res == true) {
                      context.read<PetBloc>().add(AdoptPet(id: widget.pet.id!));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
