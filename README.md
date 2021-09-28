# Fetch Rewards - iOS Coding Challenge

Please write a native iOS app in Swift using UIKit (no SwiftUI, please) that allows users to browse recipes sorted alphabetically by category using the following API:
https://www.themealdb.com/api.php

There are 3 primary endpoints that your app should utilize:

1. https://www.themealdb.com/api/json/v1/1/categories.php for fetching the list of categories.
2. https://www.themealdb.com/api/json/v1/1/filter.php?c=CATEGORY for fetching the list of meals in a category.
3. https://www.themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID for fetching the meal details by its ID.

Categories and meals should be displayed alphabetically with meals sorted into their respective categories. How exactly you choose to layout the UI in order to display this information is up to you.

When a user selects a meal, they should be taken to a detail view that includes:

- Meal name
- Instructions
- Ingredients/measurements

We’re looking for developers, not designers, so don’t get too hung up on how the app looks. Instead, focus on how you can leverage system-provided UI elements to display data in a way that’s intuitive and user-friendly.

Please read the following guidelines carefully before starting the coding challenge:

- Be sure to filter out any null or empty values from the API before displaying them. We encourage you to test out the API first to find where these null or empty values can appear. The API is poorly designed in many respects, and we’re using this as an opportunity to see how you convert imperfectly formatted data into workable models. 
- Loading indicators and error handling are not required, but your submitted code should take both into consideration as future additions necessary for a production ready app. 
- Unit tests are encouraged but not required.
- Third-party libraries are not allowed.
- The app should compile using the latest version of Xcode.

Take as much time as you need to complete this challenge. While your solution does not need fully production ready, you are being evaluated, so please put your best foot forward.