Extension { #name : #CreateEmptyRDBMSApplication }

{ #category : #'*Persistent-API-Skeleton-PostgreSQL' }
CreateEmptyRDBMSApplication class >> saganConfigurationParametersForPostgreSQL [

	^ OrderedCollection new
		  add: ( MandatoryConfigurationParameter
				    named: 'PG Hostname'
				    describedBy: 'Name of PostgreSQL''s host to connect'
				    inside: self sectionsForSaganConfiguration );
		  add: ( OptionalConfigurationParameter
				    named: 'PG Port'
				    describedBy: 'Port number to connect to at the server host'
				    inside: self sectionsForSaganConfiguration
				    defaultingTo: 5432 );
		  add: ( MandatoryConfigurationParameter
				    named: 'PG Username'
				    describedBy: 'PostgreSQL user name to connect as'
				    inside: self sectionsForSaganConfiguration );
		  add: ( MandatoryConfigurationParameter
				    named: 'PG Password'
				    describedBy: 'Password to be used if the server demands password authentication'
				    inside: self sectionsForSaganConfiguration ) asSensitive;
		  add: ( MandatoryConfigurationParameter
				    named: 'PG Database Name'
				    describedBy: 'The database name'
				    inside: self sectionsForSaganConfiguration );
		  asArray
]
