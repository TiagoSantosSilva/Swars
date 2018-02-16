### Disclaimer

This app is partially programmed with FRP, which consumed a large portion of time into learning it. This lead the project to be kind of rushed and deprive it of some cleaner code and unit tests.

Still, taking the first steps into FRP was a nice trade-off in my opinion.

### Swars 

The application has two main views: Star Wars People and About.

#### Star Wars People

This view displays a Collection View with the Star Wars characters being displayed in each cell. These contain the characters’ names, vehicle count and species.

![Star Wars People](https://github.com/TiagoSantosSilva/Swars/blob/master/Screenshots/StarWarsPeople.png)

#### Details

Tapping a cell will display the Details View.

![Details](https://github.com/TiagoSantosSilva/Swars/blob/master/Screenshots/Details.png)

This view displays the character’s name, home planet, skin colour, gender and vehicle list.

A google button is also displayed. Tapping it will open a Safari Google search on the character’s name.

##### About

The About view displays the developer’s name and birthdate.

Tapping the GitHub button will open a Safari page directed to the developer’s GitHub page.

##### Extra

If the connection to the Internet is lost, the user will be alerted with the following view.

![NoConnection](https://github.com/TiagoSantosSilva/Swars/blob/master/Screenshots/NoConnection.png)

This view will disappear once the connection is reobtained.
