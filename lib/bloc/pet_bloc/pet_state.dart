part of 'pet_bloc.dart';

class PetState extends Equatable {
  const PetState();

  @override
  List<Object> get props => [];
}

class PetUninitialized extends PetState {}

class PetLoading extends PetState {}

class PetLoaded extends PetState {
  final List<Pet> pets;

  PetLoaded({required this.pets});
}

class PetEventFailed extends PetState {
  final String errorMessage;

  PetEventFailed({required this.errorMessage});
}

class PetAdopted extends PetState {
  final Pet pet;

  PetAdopted({required this.pet});
}

class AdoptedPetLoaded extends PetState {
  final List<Pet> adoptedPet;

  AdoptedPetLoaded({required this.adoptedPet});

  @override
  List<Object> get props => [adoptedPet];
}
