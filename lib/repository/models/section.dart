// type Section struct {
// 	BigID
// 	Name      string     `gorm:"size:32;not null" json:"name"`
// 	ClassID   uint       `gorm:"foreignKey;not null" json:"classID"`
// 	Class     *Class     `json:"class,omitempty"`
// 	Students  []User     `gorm:"many2many:students" json:"students,omitempty"`
// 	Teachers  []User     `gorm:"many2many:teachers" json:"teachers,omitempty"`
// 	Materials []Material `gorm:"polymorphic:Materialable" json:"materials,omitempty"`
// 	Timestamps
// }

import 'package:classroom_mobile/repository/models/model.dart';

class Section extends Model {
  String name;

  Section({required this.name});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
