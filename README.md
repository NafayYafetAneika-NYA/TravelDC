# TravelDC

Original App Design Project - README Template
===

# Travel DC

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

Travel DC aims to revolutionize the way tourists explore Washington DC with challenges, activities and a social feed.


### Demo video

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/h9yMK3JlT9U/0.jpg)](https://www.youtube.com/watch?v=h9yMK3JlT9U)

### App Evaluation

[Evaluation of your app across the following attributes]
- **Category:** Social
- **Mobile:** Yes
- **Story:**  Exploring DC doesn't have to be boring and lonely.
- **Market:** Tourists in Washington, DC
- **Habit:** Occasional
- **Scope:** Narrow

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* View a list of Challenges to do
* Select a challenge and see other peoples' photos doing that challenge
* Users can accept challenges and then post pictures of them completing the challenge
* Score system to encourage people to complete challenges

**Optional Nice-to-have Stories**

* Register an account
* Follow people and comment on their posts
* Leaderboard for people with highest scores

### 2. Screen Archetypes

- [ ] **Challenges List Screen**
* View a list of Challenges to do
- [ ] **Challenge Detail Screen**
* See a map with the location of the challenge, a short summary, a button which says "Accept Challenge".
* If you scroll down, you see other peoples' photos doing that challenge.
- [ ] **Challenge Accepted Screen**
* See a map with the location of the challenge, a short summary and a button to upload/take your photo.
- [ ] **Leaderboard Screen**
* See a list of players with the highest score in your area.


### 3. Navigation

**Tab Navigation** (Tab to Screen)


- [ ] Challenges List
- [ ] Leaderboard


**Flow Navigation** (Screen to Screen)

- [ ] **Challenges List**
  * Leads to **Challenge Detail Screen**
- [ ] **Challenge Detail Screen**
  * Leads to **Challenge Accepted Screen**


## Wireframes

[Add picture of your hand sketched wireframes in this section]

![IMG_4472-min (1) (1) (1)](https://hackmd.io/_uploads/SJr0gD3gA.jpg)



### [BONUS] Digital Wireframes & Mockups

![Screenshot 2024-04-16 at 4.35.54 PM](https://hackmd.io/_uploads/rydTWPngA.jpg)



### [BONUS] Interactive Prototype

<div>
    <a href="https://www.loom.com/share/0ac1bfd1289341a19f297c6cdec3ae5a">
      <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/0ac1bfd1289341a19f297c6cdec3ae5a-with-play.gif">
    </a>
  </div>


 ### [BONUS] Xcode UI
<div>
    <a href="https://www.loom.com/share/a998632af8854a978d0a8736bf43ac6e">
      <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/a998632af8854a978d0a8736bf43ac6e-full-1713755750907.jpg">
    </a>
  </div>


## Schema 


### Models

User

| Property | Type   | Description                                  |
|----------|--------|----------------------------------------------|
| username | String | unique id for the user post (default field)   |
| password | String | user's password for login authentication      |


Post

| Property | Type   | Description                                  |
|----------|--------|----------------------------------------------|
| Imagefile | ParseFile | Image in the post   |
| user | User | User which is posting the image     |
| caption | String | Caption for the image     |

Challenge

| Property | Type   | Description                                  |
|----------|--------|----------------------------------------------|
| ChallengeImage | ParseFile | Image in the background of the challenge   |
| category | String | category of the challenge     |
| nameOfChallenge | String | Challenge Name     |
| descOfChallenge | String | Challenge description     |


### Networking

- [List of network requests by screen] NOT DECIDED YET
- [Example: `[GET] /users` - to retrieve user data] NOT DECIDED YET
- ...
- [Add list of network requests by screen ] NOT DECIDED YET
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
