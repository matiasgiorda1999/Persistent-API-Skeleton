# Baseline Groups

Persistent API Skeleton includes the following groups in its Baseline that can
be used as loading targets:

- `Core` will load the minimal packages needed in a deployed application
- `SQLite3 Persistence` will load support for APIs persisting on SQLite 3
- `PostgreSQL Persistence` will load support for APIs persisting on PostgreSQL
- `Deployment` in this case is `Core` + `PostgreSQL Persistence` + `SQLite3 Persistence`
- `Tests` will load the test cases
- `Tools` will load tooling extensions
- `Dependent-SUnit-Extensions` will load extensions to SUnit
- `CI` is the group loaded in the continuous integration setup, in this
  particular case it is the same as `Tests`
- `Development` will load all the needed packages to develop and contribute to
   the project
