import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption/bloc/pet_bloc/pet_bloc.dart';
import 'package:pet_adoption/model/pet_model.dart';
import 'package:pet_adoption/screens/history_screen.dart';
import 'package:pet_adoption/screens/pet_details.dart';
import 'package:pet_adoption/widget/pet_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _petNameController = TextEditingController();

  List<Pet>? pets;
  List<Pet> get searchedList {
    List<Pet> availableList = [];
    if (pets != null && pets!.isNotEmpty) {
      availableList.addAll(pets!.where((element) => element.name!
          .toLowerCase()
          .contains(_petNameController.text.toLowerCase())));
      return availableList;
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    _petNameController.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PetBloc>().add(LoadPet());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            BlocListener<PetBloc, PetState>(
              listener: (context, state) {
                if (state is PetLoaded) {
                  setState(() {
                    pets = state.pets;
                  });
                }
              },
              child: SliverToBoxAdapter(child: Container()),
            ),
            SliverAppBar(
              floating: true,
              title: Text(
                "Pet Adoption",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              actions: [
                PopupMenuButton(
                  onSelected: (val) {
                    if (val == "history") {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HistoryScreen()));
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: "history",
                      child: Text("History"),
                    ),
                  ],
                )
              ],
            ),
            SliverToBoxAdapter(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: _petNameController,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "search"),
                ),
              ),
            ),
            if (pets != null && pets!.isNotEmpty) ...[
              if (_petNameController.text.isNotEmpty) ...[
                if (searchedList.isEmpty) ...[
                  const SliverToBoxAdapter(
                    child: Text("Cannot find the search result"),
                  )
                ] else ...[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: searchedList.length,
                      (context, index) {
                        Pet pet = searchedList[index];
                        return PetCard(pet: pet);
                      },
                    ),
                  ),
                ]
              ] else ...[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: pets!.length,
                    (context, index) {
                      Pet pet = pets![index];
                      return PetCard(pet: pet);
                    },
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
