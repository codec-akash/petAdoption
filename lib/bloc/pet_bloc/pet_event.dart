part of 'pet_bloc.dart';

class PetEvent {
  const PetEvent();
}

class LoadPet extends PetEvent {}

class AdoptPet extends PetEvent {
  final int id;
  AdoptPet({required this.id});
}

class LoadAdoptedPet extends PetEvent {}
