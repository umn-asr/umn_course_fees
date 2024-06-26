# UMN Course Fee Service

Provides data about course fees by campus.

## URLs

- Staging: [https://course-fees-staging.umn.edu](https://course-fees-staging.umn.edu)
- Production: [https://course-fees.umn.edu](https://course-fees.umn.edu)

## Routes

Data returned follows the [JSON API](http://jsonapi.org/) specification.

| URL | Description |
| --- | --- |
| `/campuses` | All campuses |
| `/campuses/:campus_id` | A single campus |
| `/campuses/:campus_id/terms` | All terms with course fee data for a campus |
| `/terms/:term_id/courses` | All courses with fees offered by Campus during a Term |

### Side-loading

Side-loading follows the [JSON API guidelines](http://jsonapi.org/format/#fetching-includes). For example:

- `campuses/UMNCR?include=terms`
Side loads all terms for a campus as part of the Campus route

- `campuses/UMNCR?include=terms.courses`
Side loads all terms and courses for a campus as part of the Campus route. This can be exceptionally slow.

## Development

This application uses GitHub's [scripts to rule them all](https://github.com/github/scripts-to-rule-them-all) approach.

### Getting Started

- Clone the repo
- `cd` into the repo
- `./script/setup`

### Running a Server

- `./script/server`

### Testing

- `./script/test`

### Updating local setup, including database views

- `./script/update`

## Deployment

Run `script/deploy <environment>`. E.g., `script/deploy staging`.

## Design

There's very little to this application on the Rails side of things. It uses [JSON API Resources](https://github.com/cerebris/jsonapi-resources) to handle the views and controllers. Models contain no business logic beyond defining associations.

All of the logic around what data to show is built into the views. Definitions of the views are in [lib/data_views](lib/data_views).

## Owners

Who is responsible for the web application after initial development?
 * [See this spreadsheet](https://docs.google.com/spreadsheets/d/1JOCG2MZnzsQ_ja8B-pEBqARSXyvoR0TwDb_APO3cdL4/edit?usp=sharing).
