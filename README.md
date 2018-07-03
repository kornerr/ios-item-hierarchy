
# Overview

This is a sample iOS application to represent three levels of item hierarchy:

* sections
    * first level items
    * CoverFlow/Carousel-like display
* categories
    * second level items
    * central (selected) item is enlarged
* products
    * third level items
    * accessed by swiping the sections and categories away

# Preview

This is what the app looks like:

![Preview][preview]

# Images

Images represent [Mass Effect races][me-races].

Image loading is simulated.

# Issues

This is only an unpolished prototype with several issues/limitations:

* sections and categories are not paginated
* vertical pan gesture to collapse/expand products conflicts with products' scrolling
    * one has to collapse/expand by panning outside products
* there is no unlimited scrolling through products

[preview]: preview.gif
[me-races]: http://masseffect.wikia.com/wiki/Races
