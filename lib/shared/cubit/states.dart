abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class NewsBusinessLoadingState extends NewsStates {}

class NewsSetDesktopState extends NewsStates {}

class NewsSelectBusinessSuccessState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  final String Error;

  NewsGetBusinessErrorState(this.Error);
}

class NewsSportsLoadingState extends NewsStates {}

class NewsGetSportsSuccessState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates {
  final String Error;

  NewsGetSportsErrorState(this.Error);
}

class NewsScienceLoadingState extends NewsStates {}

class NewsGetSienceSuccessState extends NewsStates {}

class NewsGetScienceErrorState extends NewsStates {
  final String Error;

  NewsGetScienceErrorState(this.Error);
}

class AppChangeModeState extends NewsStates {}

class NewssearchLoadingState extends NewsStates {}

class NewsGetsearchSuccessState extends NewsStates {}

class NewsGetsearchErrorState extends NewsStates {
  final String Error;

  NewsGetsearchErrorState(this.Error);
}
