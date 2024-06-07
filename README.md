# GithubLookup
An iOS app that gets github follower data and profile info.
100% Programmatic UI.
Custom reusable UI components.
Custom error handling.
Parent and child UI components using inheritence.
Displaying followers in UICollectionView and UICollectionViewDiffableDataSrouce for faster filtering/search updates and animation.

## Features

##  User can get followers for a github user.
![saaa](https://github.com/jjcode22/GHLookup/assets/108716229/3bfa0942-b085-45e9-a822-603342f2e46d)


## Fast searching and filtering using UICollectionViewDiffableDataSource
Follower images are cached locally using NSCache to avoid making repeated network calls.
![uuu](https://github.com/jjcode22/GHLookup/assets/108716229/45fa2eb1-2d87-488e-a403-8ff6528691f2)

## User can get general github information for a github user.
![uuuu](https://github.com/jjcode22/GHLookup/assets/108716229/cd67912c-bd43-44d2-85db-90ce23b2753d)


## User can favourite/save a user. Favourite user data is persisted using UserDefaults
![uuuuuu](https://github.com/jjcode22/GHLookup/assets/108716229/463f6c9d-f2ec-48fe-a7a1-d0596ccc77ae)


Favorited user data is PERSISTEED locally using UserDefaults.
Accessibility for older iOS devices i.e iPhone SE and 8 is implemented using conditional rendering.


