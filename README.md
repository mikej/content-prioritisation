# content-prioritisation

Over the years I've amassed collections of unread ebooks collections on various sites including:

 * My Kindle library
 * [The Pragmatic Bookshelf](https://pragprog.com)
 * [Gumroad](https://gumroad.com)
 * [O'Reilly Member's Library](https://members.oreilly.com/)
 
 This repo contains some scripts to streamline the process of compiling a list of what's in each collection so that I can
 then put these lists into a Google Sheet and manually sort them into:
 
 * Reference books
 * To read - add these to my reading list so they can be prioritised
 * No longer relevant - stuff that's out of date or no longer of interest

## Usage guide

### Kindle library

 1. Go to _Manage Your Content And Devices_
 2. Click on _Books_
 3. Update filters to view Books Purchases, Sort by: Acquired: Oldest to Newest
 4. Navigate to the page that contentains the first book to be included in the CSV 
 5. Use Developer Tools to copy the table of books e.g. `<table class="ListLayout-module_table__1QeQ4">`, paste into a file and save e.g. `books.html`
 6. run `$ ./kindle.rb books.html` to output list of books and authors in CSV format
 7. repeat steps 3 - 4 for each additional page in the list of books

### Gumroad

 1. Go to your library on Gumroad and sort by purchase date: https://app.gumroad.com/library?sort=purchase_date
 2. Save a copy of the page e.g. `gumroad.html`
 3. run `$ ./gumroad.rb books.html` to output list of products and creators in CSV format

### Audible

 1. Go to _Library_ on Audible
 2. Change _Show items per page_ to the maximum value in order to reduce number of pages needed
 3. Save a copy of the page e.g. `audible.html`
 4. run `$ ./audible.rb audible.html` to output list of audiobooks and authors in CSV format
 5. repeat steps 3 - 4 for each additional page if there is more than one page in the library
