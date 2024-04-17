# **Cash Register**

This is a simple cash register program that allows users to add/remove products to a cart, apply discounts based on pricing rules, and calculate the total price of the cart.

## **Usage**
To use the program, follow these steps:

1. Ensure you have Ruby installed on your system
2. Clone this repository to your local machine
3. Navigate to the project directory
4. Run bundle install to install dependencies
5. Run the program using `ruby src/app.rb`

## **Dependancies**
The Cash Register Program relies on the following components:

Ruby: The program is written in Ruby and requires Ruby to be installed on your system.
RSpec Gem (for testing): Used for writing and executing automated tests.

## **Features**
- Add products to the cart.
- Apply discounts based on pricing rules (e.g., Buy One Get One Free, Bulk Discounts).
- Remove products from the cart.
- Calculate the total price of the cart.

## **Project Structure**
```
Cash Register
│
├── src/                        # Directory containing source code
│   ├── app.rb                  # Main entry point of the application
│   ├── register.rb             # Manages the cart and performs calculations
│   ├── userInterface.rb        # Handles user interactions and input/output
│   └── product.rb              # Represents individual products and their attributes
│
├── data/                       # Directory containing JSON data files
│   ├── pricing_rules.json      # Data file for storing pricing rules and discounts
│   ├── products.json           # Data file for storing product information
│   └── test_data.json          # Data file for storing the
│
├── spec/                       # Directory containing RSpec test files
│   ├── register_spec.rb        # RSpec tests for the Register class
│   ├── userInterface_spec.rb   # RSpec tests for the UserInterface class
│   └── product_spec.rb         # RSpec tests for the Product class
│
└── Gemfile                     # File specifying Ruby gem dependencies
```


# **Original Task**

## **Problem to Solve**

You are the developer in charge of building a cash register.
This app will be able to add products to a cart and compute the total price.

## Objective

Build an application responding to these needs.

By application, we mean:
- It can be a CLI application to run in command line
- It is usable while remaining as simple as possible
- It is simple
- It is readable
- It is maintainable
- It is easily extendable

## Technical requirements

- Use any of those languages you are comfortable (Ruby, Python, Go, .Net Core)
- Covered by tests
- Following TDD methodology

## Description

### Assumptions

**Products Registered**
| Product Code | Name | Price |
|--|--|--|
| GR1 |  Green Tea | 3.11€ |
| SR1 |  Strawberries | 5.00 € |
| CF1 |  Coffee | 11.23 € |

**Special conditions**

- The CEO is a big fan of buy-one-get-one-free offers and green tea.
He wants us to add a  rule to do this.

- The COO, though, likes low prices and wants people buying strawberries to get a price  discount for bulk purchases.
If you buy 3 or more strawberries, the price should drop to 4.50€.

- The VP of Engineering is a coffee addict.
If you buy 3 or more coffees, the price of all coffees should drop to 2/3 of the original price.

Our check-out can scan items in any order, and because the CEO and COO change their minds  often, it needs to be flexible regarding our pricing rules.

**Test data**
| Basket | Total price expected |
|--|--|
| GR1,GR1 |  3.11€ |
| SR1,SR1,GR1,SR1 |  16.61€ |
| GR1,CF1,SR1,CF1,CF1 |  30.57€ |

**Deliverable**

The codebase in a shared folder we can access or a public git repository

**Things we are going to look into or ask about**

- Best practices
- Commit history
- Code structure and flow
- Facility To make some changes to the code
- A proper readme with good explanation


## **Author**

Made with ❤️, 🍵 and 🥵 by [Rokas Stasiulis](https://github.com/rokastas)
