Extension { #name : #CreateEmptyRDBMSApplication }

{ #category : #'*Persistent-API-Skeleton-SQLite' }
CreateEmptyRDBMSApplication class >> saganConfigurationParametersForSQLite [

	^ Array with: ( OptionalConfigurationParameter
			    named: 'Database File Name'
			    describedBy: 'SQLite Database file name'
			    inside: self sectionsForSaganConfiguration
			    defaultingTo: 'default.db' )
]
