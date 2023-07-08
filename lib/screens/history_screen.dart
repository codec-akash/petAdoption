import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption/bloc/pet_bloc/pet_bloc.dart';
import 'package:pet_adoption/model/pet_model.dart';
import 'package:pet_adoption/widget/history_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Pet> adoptedPet = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PetBloc>().add(LoadAdoptedPet());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adoption History"),
      ),
      body: CustomScrollView(
        slivers: [
          BlocListener<PetBloc, PetState>(
            listener: (context, state) {
              if (state is AdoptedPetLoaded) {
                adoptedPet.clear();
                adoptedPet.addAll(state.adoptedPet);
                setState(() {
                  isLoading = false;
                });
              }
            },
            child: SliverToBoxAdapter(child: Container()),
          ),
          if (isLoading == true) ...[
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ] else ...[
            if (adoptedPet.isNotEmpty) ...[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: adoptedPet.length,
                  (context, index) {
                    Pet pet = adoptedPet[index];
                    return PetHistoryCard(pet: pet);
                  },
                ),
              ),
            ] else ...[
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/image/cute_dog.png",
                      height: 280,
                    ),
                    Text(
                      "No Adoptions yet !!",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              )
            ],
          ],
        ],
      ),
    );
  }
}
