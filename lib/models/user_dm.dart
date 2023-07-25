class UserDm {
  static const String collectionName="users";
  static UserDm?currentUser;
  String id;
  String userName;
  String email;

  UserDm( this .email,  this.userName,  this.id);
}

