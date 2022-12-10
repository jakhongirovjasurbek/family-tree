class Person {
  final String firstName;
  final String lastName;
  final int age;
  final bool isMale;
  final String bio;
  const Person({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.isMale,
    required this.bio,
  });

  @override
  String toString() {
    return 'First name: $firstName, Last name: $lastName, Age: $age, Gender: ${isMale ? 'Male' : 'Female'}, Bio: $bio';
  }

  Person copyWith({
    String? firstName,
    String? lastName,
    int? age,
    bool? isMale,
    String? bio,
  }) {
    return Person(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      isMale: isMale ?? this.isMale,
      bio: bio ?? this.bio,
    );
  }

  @override
  bool operator ==(covariant Person other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.age == age &&
        other.isMale == isMale &&
        other.bio == bio;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        age.hashCode ^
        isMale.hashCode ^
        bio.hashCode;
  }
}
