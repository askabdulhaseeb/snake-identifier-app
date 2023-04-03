enum UserRole {
  user('user', 'User'),
  admin('admin', 'Admin'),
  superAdmin('super_admin', 'Super Admin');

  const UserRole(this.json, this.title);

  final String json;
  final String title;
}

class UserRoleConvertor {
  UserRole toEnum(String type) {
    if (type == UserRole.superAdmin.json) {
      return UserRole.superAdmin;
    } else if (type == UserRole.admin.json) {
      return UserRole.admin;
    } else {
      return UserRole.user;
    }
  }
}
