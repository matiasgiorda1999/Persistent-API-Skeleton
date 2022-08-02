Class {
	#name : #PostgreSQLCreateEmptyRDBMSApplicationTest,
	#superclass : #CreateEmptyRDBMSApplicationTest,
	#category : #'Persistent-API-Skeleton-Tests'
}

{ #category : #tests }
PostgreSQLCreateEmptyRDBMSApplicationTest >> testConfigurationParameters [

	| parameters parameter |

	parameters := CreateEmptyRDBMSApplication saganConfigurationParametersForPostgreSQL.

	self assert: parameters size equals: 5.

	parameter := parameters first.

	self
		assert: parameter name equals: 'PG Hostname';
		assert: parameter summary equals: 'Name of PostgreSQL''s host to connect';
		assert: parameter commandLineArgumentName equals: 'sagan.pg-hostname';
		assert: parameter environmentVariableName equals: 'SAGAN__PG_HOSTNAME'.

	parameter := parameters second.

	self
		assert: parameter name equals: 'PG Port';
		assert: parameter summary
		equals: 'Port number to connect to at the server host. Defaults to 5432';
		assert: parameter commandLineArgumentName equals: 'sagan.pg-port';
		assert: parameter environmentVariableName equals: 'SAGAN__PG_PORT'.

	parameter := parameters third.

	self
		assert: parameter name equals: 'PG Username';
		assert: parameter summary equals: 'PostgreSQL user name to connect as';
		assert: parameter commandLineArgumentName equals: 'sagan.pg-username';
		assert: parameter environmentVariableName equals: 'SAGAN__PG_USERNAME'.

	parameter := parameters fourth.

	self
		assert: parameter name equals: 'PG Password';
		assert: parameter summary
		equals: 'Password to be used if the server demands password authentication';
		assert: parameter commandLineArgumentName equals: 'sagan.pg-password';
		assert: parameter environmentVariableName equals: 'SAGAN__PG_PASSWORD'.

	parameter := parameters last.

	self
		assert: parameter name equals: 'PG Database Name';
		assert: parameter summary equals: 'The database name';
		assert: parameter commandLineArgumentName equals: 'sagan.pg-database-name';
		assert: parameter environmentVariableName equals: 'SAGAN__PG_DATABASE_NAME'
]
