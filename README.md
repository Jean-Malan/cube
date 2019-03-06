# Cube is a social media app that allows users to connect through friend requests and interact using Bits.

Bits is the main feature of the application which works like a tweet for twitter.

The user journey will be as follows:

1. Sign up with email and password
2. Complete profile details. For the sake of the project, the software will generate a user a Radom colour which forms as the profile picture colour. 
3. Once details have been submitted, a user is logged into their profile and they now have access to the bits and friends tabs. 
4. Initially, the bits tabs will be blank, this will be filled with bits
5. The friends tab is split into three tabs, namely: All friends, Pending Friends and Friend Requests
    1. All friends displays all current friends
    2. Pending Friends displays requests that the user has made
    3. Friend Requests display all requests a user has received - to accept it, they will click the ‘accept request’ button
6. In the top right of the screen, there is a search bar where users can search through all users on the platform. Clicking on this will send the user to that profile. 
7. Of a top right of the profile, the user will see a button ‘Add Friend’, this will send them a request. Immediately after this button changes to Pending and the user is moved to the Pending tab of their own page. 
8. Underneath the users name, there is an icon that allows them to edit their page


# Technical Details:

## Technologies: 

Ruby version:  2.6.0p0
Rails version: Rails 5.2.2
Npm version: 6.8.0


### Installing ruby:
Mac: 
- ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
- brew install rbenv ruby-build
- rbenv install 2.6.0
- rbenv global 2.6.0
- ruby -v
- 

### Installing Rails (Mac)
- gem install rails -v 5.2.2
- rbenv rehash

### Install Sqlite3
- brew install sqlite3

### Node
- nvm install node

## Running the application:
Start server: rails s

## Structure

The application is a monolith application that is split between Ruby on Rails and Vuejs. Vuejs handles most of the front end with the exception of the login screens. 

Through div tags in the view, the app/javascript.packs/application.js file renders the relevant component. The components, due to small amount, are stored in the app/javascript/components directory .

In the backend, the application consists of three scaffolds, Profiles, Users and Bits which are all inherently associated. 

## Design

Due to time constraints, the majority of the styling is done with inline styling. Although this is not a normality through my development process, it was able to help ensure the project was accurate and on time. The general colours, with the exception of the automatically generated profile icon are from the Bitcube website. 
