# TelstraPOC

Architecture implemented in MVVM
URL Session class is used for the API call
JSON content received from the API is parsed with Decodable using swift's JSONDecoder class.
The Table View displays the image along with a title and a description in each of its cells, as the view is scrolled down (Image is downloaded asynchronously and displayed using the main thread)
Added activity indicator on the navigation bar as UI is not supposed to be blocked while loading data
