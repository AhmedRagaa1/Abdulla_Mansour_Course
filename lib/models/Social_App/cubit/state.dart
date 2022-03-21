abstract class SocialStates {}

class SocialIinitialState extends SocialStates {}

class SocialGetUserSuccessStates extends SocialStates {}

class SocialGetUserErrorStates extends SocialStates
{
  final String error;

  SocialGetUserErrorStates(this.error);

}

class SocialGetUserLoadingState extends SocialStates {}



class SocialChangeBottomNavStates extends SocialStates {}

class SocialNewPostStates extends SocialStates {}




class SocialProfileImagePickerSuccessState extends SocialStates {}

class SocialProfileImagePickerErrorState extends SocialStates {}

class SocialCoverImagePickerSuccessState extends SocialStates {}

class SocialCoverImagePickerErrorState extends SocialStates {}

class SocialUpdateProfileImagePickerSuccessState extends SocialStates {}

class SocialUpdateProfileImagePickerErrorState extends SocialStates {}

class SocialUpdateCoverImagePickerSuccessState extends SocialStates {}

class SocialUpdateCoverImagePickerErrorState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

class SocialUserUpdateLoadingState extends SocialStates {}



//Create Post

class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialPostImagePickerSuccessState extends SocialStates {}

class SocialPostImagePickerErrorState extends SocialStates {}

class SocialRemoveImageState extends SocialStates {}



class SocialGetPostSuccessStates extends SocialStates {}

class SocialGetPostErrorStates extends SocialStates
{
  final String error;

  SocialGetPostErrorStates(this.error);

}

class SocialGetPostLoadingState extends SocialStates {}


class SocialLikePostSuccessStates extends SocialStates {}

class SocialLikePostErrorStates extends SocialStates
{
  final String error;

  SocialLikePostErrorStates(this.error);

}


class SocialGetAllUserSuccessStates extends SocialStates {}

class SocialGetAllUserErrorStates extends SocialStates
{
  final String error;

  SocialGetAllUserErrorStates(this.error);

}

class SocialGetAllUserLoadingState extends SocialStates {}



//chat

class SocialSendMessageSuccessStates extends SocialStates {}

class SocialSendMessageErrorStates extends SocialStates
{
  final String error;

  SocialSendMessageErrorStates(this.error);

}


class SocialGetMessageSuccessStates extends SocialStates {}

class SocialGetMessageErrorStates extends SocialStates
{
  final String error;

  SocialGetMessageErrorStates(this.error);

}





