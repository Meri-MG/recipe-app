# Recipe App

> The Recipe app keeps track of all the users' recipes, ingredients, and inventory. It will allow the user to save ingredients, keep track of what they have, create recipes, and generate a shopping list based on what they have and what they are missing from a recipe. Also, since sharing recipes is an important part of cooking the app should allow the user to make them public so anyone can access them.

> The project is following data model below: 
> ![diagram](https://github.com/microverseinc/curriculum-rails/blob/main/recipe-app/images/recipe_app_erd.png)

## Built With

- Ruby
- Ruby on Rails
- PostgreSQL

## Getting Started

- [Install Ruby](https://www.ruby-lang.org/en/documentation/installation/) on your local machine 
- [Install Ruby on Rails](https://guides.rubyonrails.org/v5.1/getting_started.html)
- Clone [this repository](https://github.com/Meri-MG/recipe-app)
  ```
  git clone git@github.com:Meri-MG/recipe-app.git
  ```
- To get started, In the root directory run:
  ```
  gem install bundler
  ```
  Then run:
  ```
  bundle install
  ```
  To start the server run: 

  ```
  rails s
  ```
  Open the browser with `localhost:3000`

  
## After installing bundle

Please run the following commands `rails db:create` `rails db:migrate` `rails s`

## Tests
```cmd
bundle exec rspec
```
Or
```mdx
rspec spec

### To track linter errors locally follow these steps:  

Track linter errors run:
```
rubocop
```

## Authors

  :woman: **Meri Gogichashvili**

- [GitHub](https://github.com/Meri-MG)
- [LinkedIn](https://www.linkedin.com/in/meri-gogichashvili/)

  :man: **Amadu Kamara (Amkam)**

- [GitHub](https://github.com/AmaduKamara)
- [LinkedIn](https://www.linkedin.com/in/amadu-kamara-3b60a25b)
- [Twitter](https://twitter.com/DevAmkam)
- [Facebook](https://www.facebook.com/amadus.kamara.7)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/Meri-MG/recipe-app/issues).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Thanks to my morning session partners, coding partners and teammates.

## 📝 License

This project is [MIT](./MIT.md) licensed.