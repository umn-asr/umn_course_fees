# UMN Course Fee Service

Provides data about course fees by campus.

### Routes

Data returned follows the [JSON API](http://jsonapi.org/) specification.

| URL | Description |
| --- | --- |
| `/campuses` | All campuses |
| `/campuses/:campus_id` | A single campus |
| `/campuses/:campus_id/terms` | All terms with course fee data for a campus |
| `/terms/:term_id/subjects` | All subjects offered by Campus during a Term |
| `/subjects/:subject_id/courses` | All courses with fees in that Subject for that Campus and Term |

#### Side-loading

Side-loading follows the [JSON API guidelines](http://jsonapi.org/format/#fetching-includes). For example:

- `campuses/UMNCR?include=terms`
Side loads all terms for a campus as part of the Campus route

- `campuses/UMNCR?include=terms.subjects`
Side loads all terms and subjects for a campus as part of the Campus route

- `campuses/UMNCR?include=terms.subjects.courses`
Side loads all terms and subjects and courses with fees for a campus as part of the Campus route. This can be exceptionally slow.

### Development

This application uses GitHub's [scripts to rule them all](https://github.com/github/scripts-to-rule-them-all) approach.

#### Getting Started

- Clone the repo
- `cd` into the repo
- `./script/setup`

#### Running a Server

- `./script/server`

#### Testing

- `./script/test`

#### Updating local setup, including database views

- `./script/update`

### Design

There's very little to this application on the Rails side of things. It uses [JSON API Resources](https://github.com/cerebris/jsonapi-resources) to handle the views and controllers. Models contain no business logic beyond defining associations.

All of the logic around what data to show is built into the views. Definitions of the views are in [lib/data_views](lib/data_views).
