# Boardgame Group Database

This project represents a **Boardgame Group** database for managing members, guests, events, venues, sponsors, and games. It includes several tables with foreign key relationships to support different entities within a boardgame group and the various operations related to them, such as event management, guest attendance, and game ownership.

The schema is designed to manage information about members, events, games, venues, sponsors, and much more. Below is a description of the schema and key SQL queries used in this project.

## Database Schema Overview

The database contains the following tables:

- **Members**: Stores information about members of the boardgame group, including personal details, contact information, and a relationship to a supervisor.
- **Guest**: Stores information about guests associated with members.
- **Venue**: Information about the venues where events are hosted.
- **Sponsor**: Information about sponsors for events.
- **Event**: Stores details about the events, including the date, type, and associated sponsors and venues.
- **Game**: Details about the games available within the group, including attributes like cost, complexity, and player count.
- **BoardGame**: Details about specific board games, including subgenres.
- **CCG**: Details about collectible card games, including their brands.
- **RPG**: Details about role-playing games, including systems.
- **NumberOfAttendees**: Tracks attendance of members and guests at specific events.
- **Available**: Stores information about which games are available at specific events.

### Key Features

- **Member Management**: You can add, update, and delete members along with their personal details and supervisor information.
- **Guest Management**: Allows members to bring guests, and guests are linked to members.
- **Game Collection**: Supports storing different types of games, including Boardgames, CCGs, and RPGs.
- **Event Management**: Manage events and associate them with sponsors, venues, and games.
- **Attendance Tracking**: Tracks which members and guests attended which events.
- **Game Availability**: Determine which games are available at specific events.

## Getting Started

To set up the database on your local machine, follow these steps:

1. **Install MySQL**: Ensure you have MySQL installed. If you don't, follow the installation guide from [MySQL's official website](https://dev.mysql.com/downloads/installer/).
2. **Create the Database**: Run the provided SQL script to create the necessary tables and relationships.
3. **Populate Data**: After creating the database schema, you can populate the tables with sample data (provided in the script).

## Acknowledgements
MySQL: Used for managing the database and executing queries.
Glitch: For hosting web applications (if applicable).
Bulma: Used for styling (if applicable in the front-end).

## License
This project is licensed under the MIT License - see the LICENSE file for details.

