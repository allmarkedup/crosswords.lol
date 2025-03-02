## [Crosswords.lol](https://crosswords.lol) 

A little crossword app side project, powered by Guardian crossword data.

### About

I love [Guardian quick crosswords](https://www.theguardian.com/crosswords/series/quick). Who doesn't?! 😍

But the crossword UI on the Guardian website kinda sucks on mobile devices. Too fiddly and scrolly on a phone, too _website-y_ on an iPad.

So I built [crosswords.lol](https://crosswords.lol) as a little side project. It's a crossword app with a mobile-friendly UI, powered by data scraped from the Guardian website.

### How does it work?

Each [crossword page on the Guardian website](https://www.theguardian.com/crosswords/quick/17104) contains the JSON-encoded crossword data as the attribute value of an HTML tag in the source code. Pretty handy.

So once a day this app requests the latest crossword page in a background job, scrapes the data out of the response, parses it and stores it in the database.

On the frontend, each crossword is rendered using SVG using the scraped data to determine the cell positions and what entry they belong to. The rest of the UI is built with plain vanilla HTML, CSS and a sprinkling of AlpineJS for interactivity.

### Disclaimer

I don't want the scary Guardian lawyers to sue me for `$billions` 🤑. So you probably shouldn't acually use this. Or at least if you do then maybe go to [theguardian.com](https://www.theguardian.com) afterwards and click on a few of their ads or subscribe to the newspaper or _whatever_.

They really do have the best crossword setters and I really don't want their entire online puzzle empire to collapse because I felt the need to scratch my itch for a better mobile UI... 😜




