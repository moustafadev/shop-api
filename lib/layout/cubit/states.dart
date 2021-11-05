abstract class ShopStates {}

class InitialStats extends ShopStates{}


class ChangePageBoarding extends ShopStates {}




class ChangeBottomScreen extends ShopStates {}

class ShopLoadingHomeStates extends ShopStates {}

class ShopSuccessHomeStates extends ShopStates {}

class ShopErrorHomeStates extends ShopStates {}


// User profile states
class ShopLoadingUserStates extends ShopStates {}

class ShopSuccessUserStates extends ShopStates {}

class ShopErrorUserStates extends ShopStates {}

//Update Profile States
class ShopLoadingUpdateProfileStates extends ShopStates {}

class ShopSuccessUpdateProfileStates extends ShopStates {}

class ShopErrorUpdateProfileStates extends ShopStates {}


//Search States
class ShopSearchSuccessStates extends ShopStates {}

class ShopSearchLoadingStates extends ShopStates {}

class ShopSearchErrorStates extends ShopStates {}


//Categories States
class ShopSuccessCategoriesStates extends ShopStates {}

class ShopErrorCategoriesStates extends ShopStates {}

//Favorites States
class ShopSuccessFavoritesStates extends ShopStates {}

class ShopErrorFavoritesStates extends ShopStates {}

// change favorite bottom
class ShopChaneFavoritesLoadingStates extends ShopStates {}

class ShopChaneFavoritesSuccessStates extends ShopStates {}

class ShopFavoritesSuccessStates extends ShopStates {}

class ShopChaneFavoritesErrorStates extends ShopStates {}