import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption/model/pet_model.dart';
import 'package:pet_adoption/repo/pet_repo.dart';
import 'package:equatable/equatable.dart';

part 'pet_state.dart';
part 'pet_event.dart';

class PetBloc extends Bloc<PetEvent, PetState> {
  PetRepo bankRepo = PetRepo();
  List<Pet> pets = [];
  PetBloc() : super(PetUninitialized()) {
    on<LoadPet>((event, emit) async {
      emit(PetLoading());
      await Future.delayed(const Duration(milliseconds: 700));
      try {
        pets = await bankRepo.getPet();
        emit(PetLoaded(pets: pets));
      } catch (e) {
        PetEventFailed(errorMessage: "Failed to load");
      }
    });
    on<AdoptPet>((event, emit) async {
      emit(PetLoading());
      Pet pet = pets[pets.indexWhere((element) => element.id == event.id)];
      pet.isAdopted = true;
      pet.adoptedDate = DateTime.now();
      emit(PetAdopted(pet: pet));
    });
  }
}
