import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pet_adoption/model/pet_model.dart';
import 'package:pet_adoption/repo/pet_repo.dart';
import 'package:equatable/equatable.dart';

part 'pet_state.dart';
part 'pet_event.dart';

class PetBloc extends Bloc<PetEvent, PetState> {
  PetRepo bankRepo = PetRepo();
  List<Pet> pets = [];
  List<Pet> adoptedPets = [];
  String hiveBoxName = "adoptedBox";
  String hiveListName = "adoptedList";
  PetBloc() : super(PetUninitialized()) {
    on<LoadPet>((event, emit) async {
      emit(PetLoading());
      await Future.delayed(const Duration(milliseconds: 700));
      try {
        pets = await bankRepo.getPet();
        try {
          await getDataFromHive();
          if (adoptedPets != null && adoptedPets.isNotEmpty) {
            updatePetsFromHive();
          }
          emit(PetLoaded(pets: pets));
        } catch (e) {
          emit(PetEventFailed(errorMessage: e.toString()));
        }
      } catch (e) {
        PetEventFailed(errorMessage: "Failed to load");
      }
    });
    on<AdoptPet>((event, emit) async {
      emit(PetLoading());
      Pet pet = pets[pets.indexWhere((element) => element.id == event.id)];
      pet.isAdopted = true;
      pet.adoptedDate = DateTime.now().toIso8601String();
      adoptedPets.add(pet);

      try {
        await updateHive();
        emit(PetAdopted(pet: pet));
      } catch (e) {
        emit(PetEventFailed(errorMessage: e.toString()));
      }
    });
    on<LoadAdoptedPet>((event, emit) async {
      emit(PetLoading());
      await Future.delayed(const Duration(milliseconds: 700));
      emit(AdoptedPetLoaded(adoptedPet: adoptedPets));
    });
  }

  Future<Box> openHiveBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      Hive.init((await getApplicationDocumentsDirectory()).path);
    }

    return await Hive.openBox(boxName);
  }

  Future<void> getDataFromHive() async {
    var box = await openHiveBox(hiveBoxName);

    if (box.containsKey(hiveListName)) {
      var json = box.get(hiveListName);
      adoptedPets = (json as List).map((e) => Pet.fromJson(e)).toList();
    }
    box.close();
  }

  Future<void> updateHive() async {
    var box = await openHiveBox(hiveBoxName);
    var json = adoptedPets.map((e) => e.toJson()).toList();
    box.put(hiveListName, json);
    box.close();
  }

  void updatePetsFromHive() {
    for (var element in adoptedPets) {
      int index = pets.indexWhere((pet) => pet.id == element.id);
      if (index != -1) {
        pets[index] = element;
      }
    }
  }
}
