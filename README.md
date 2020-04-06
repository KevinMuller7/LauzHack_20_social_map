# Project: Relationship and risk tracking
[DevPost project](https://devpost.com/software/proposal-relationship-and-risk-tracking)

Project members (the project has forked):

- Giorgio Anastopoulos: Implementing a web-base app based on javascript that will work for AWS. Looking for front-end developer.

- Kevin Müller: Working on a prototype on Matlab, which is given in this git

## Introduction

This application allows to create a social map or net in order to give a better idea of the progress of the coronavirus, and it has been build for large-scale usage. This application can be combined with other idea for information gathering in order to provide a major application to fight the coronavirus. 

The main idea is that each user enters a set of information about him/her and who he/she had an social interaction with. Hence, a social map is obtained and we can see in real time how the coronavirus progress in this social map.

There are three objectives:
1° Give useful data, which is not currently obtained, that allows to monitor better the spread of the coronavirus. Hence, better measure against the coronavirus can be done.
2° The user know which person it is more risky to have a close social interaction with. Therefore, it provides a better risk assessment at the level of the user.
3° It gives who is in quarantine, allowing the user to offer his/her support (like buying foods or calling him/her). Some people that may have the virus still go to a food store because they are not asking for support.

## The matlab code

The matlab code provided here is a mock up of an app, which is robust and should be able to handle a Swiss-scale scenario. For the moment, in the database, the user has an health state (healthy, sick, critical condition), a location (postal code) and a list of relative/friend. For each relative/friend, he/she can see his/her health state and if he/she knows someone who got the coronavirus (or who knows someone who got the coronavirus, a social distance of 3). Additional information about the user and his/her friends/relatives can be included if necessary.

The mock-up works in the following way. An user pressing a certain button is replaced by a call of the function, which has the format:

db_cv = user_"action"(db_cv, "user name", input parameter);

where db_cv is the database. The output seen by an user is given by:

user_info = output_user_data(db_cv, "user_name") ;

where user_info is a structure containing everything it sees on the GUI. If you want more type of output, do not hesitate to contact me.

At the beginning, call:

db_cv = memory_allocate_new_table(init_size) ;

where init_size is the initial size of the database. It will initialize the database.

Every function has its description at the beginning of the '.m' file. There is the function "test_script_1" that creates a simple scenario (it is a list of action done by users). There is also a bigger social map given in "data_scenario.json" written by Giorgio. Do not hesitate to create new scenario and sharing them.

When writing a scenario, please use the user id instead of the user name when calling a "user_..." function. Searching the user name in the database is not optimized.

Finally, do not hesitate to ask for new functionalities. I would happy to provide them.

## About the futur

This code is the core of the program. From there, multiple type of work can be done:

- Testing: the code provided here should be robust but we never know.

- Creating scenario: it can be for testing code or just to play with the code and get a feeling about what is missing or not well implemented

- Designing a GUI: If it becomes an app, it is necessary. Also important in order to advertise this work and gain momentum. If you are interested to do in javascript, Giorgio is also interested.

- Analyzing the data: It is a good social map generator, so it gives you a good platform to see how you can interpret the data.

- Adding feature: This mock-up app is minimal in terms of data gathering (but already powerful), but it is straight forward to add new feature

- Translating the code in another language: Obviously, Maltab is not a language to implement an app, but it is easier to create an app based on a working prototype than from scratch. I will help you as much as I can in this process.

## Contact

For any idea, suggestion, feedback, etc..., please contact me (language: English or French)

By email:
kevin.muller@epfl .ch

Or on Slack
