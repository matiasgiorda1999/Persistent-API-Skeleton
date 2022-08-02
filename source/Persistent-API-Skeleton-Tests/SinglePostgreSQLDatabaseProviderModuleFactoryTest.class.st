Class {
	#name : #SinglePostgreSQLDatabaseProviderModuleFactoryTest,
	#superclass : #PersistentAPIConfigurationTest,
	#category : #'Persistent-API-Skeleton-Tests'
}

{ #category : #tests }
SinglePostgreSQLDatabaseProviderModuleFactoryTest >> testDatabaseLogin [

	| login configuration |

	configuration := ApplicationConfiguration
		                 forAll:
		                 CreateEmptyRDBMSApplication saganConfigurationParametersForPostgreSQL
		                 providedBy: ( self commandLineProviderOver:
				                   #( '--sagan.pg-hostname=localhost' '--sagan.pg-username=postgres'
				                      '--sagan.pg-password=secret' '--sagan.pg-database-name=test' ) ).

	login := ( SinglePostgreSQLDatabaseProviderModuleFactory configuredBy: configuration sagan )
		         databaseLogin.

	self
		assert: login platform isPostgreSQLPlatform;
		assert: login host equals: 'localhost';
		assert: login port equals: 5432;
		assert: login username equals: 'postgres';
		assert: login password equals: 'secret';
		assert: login databaseName equals: 'test'
]
