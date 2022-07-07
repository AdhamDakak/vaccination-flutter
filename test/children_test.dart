import 'package:flutter_test/flutter_test.dart';
import 'package:vaccination/children.dart';
void main(){
  test('name validation should return true', (){

    //Act
    bool namevalidation=Children().createState().NameValidation();
    //Assert
    expect(namevalidation,true );
  });
  test('E-mail validation should return true', (){

    //Act
    bool Emailvalidation=Children().createState().EmailValidation();
    //Assert
    expect(Emailvalidation,true );
  });
  test('National Id validation should return true', (){

    //Act
    bool nationalIdvalidation=Children().createState().NationalIdValidation();
    //Assert
    expect(nationalIdvalidation,true);
  });

}