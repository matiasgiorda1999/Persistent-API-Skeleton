Class {
	#name : #SQLiteCreateEmptyRDBMSApplicationTest,
	#superclass : #CreateEmptyRDBMSApplicationTest,
	#category : #'Persistent-API-Skeleton-Tests'
}

{ #category : #tests }
SQLiteCreateEmptyRDBMSApplicationTest >> testConfigurationParameters [

	| parameters |

	parameters := CreateEmptyRDBMSApplication saganConfigurationParametersForSQLite.

	self withTheOnlyOneIn: parameters do: [ :parameter | 
		self
			assert: parameter name equals: 'Database File Name';
			assert: parameter summary equals: 'SQLite Database file name. Defaults to default.db';
			assert: parameter commandLineArgumentName equals: 'sagan.database-file-name';
			assert: parameter environmentVariableName equals: 'SAGAN__DATABASE_FILE_NAME'
		]
]
