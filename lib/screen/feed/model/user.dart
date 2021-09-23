class User {
  int id;
  String userName;
  String storyImage;
  String userImage;


  User({required this.id,required this.userName,required this.storyImage,required this.userImage});
}
class Post
{
 int userid;
 int id;
 String title;
 Post({required this.userid,required this.id,required this.title});
}