"
A SingleSQLiteDatabaseProviderModuleFactoryTest is a test class for testing the behavior of SingleSQLiteDatabaseProviderModuleFactory
"
Class {
	#name : #SingleSQLiteDatabaseProviderModuleFactoryTest,
	#superclass : #PersistentAPIConfigurationTest,
	#category : #'Persistent-API-Skeleton-Tests'
}

{ #category : #tests }
SingleSQLiteDatabaseProviderModuleFactoryTest >> testDatabaseLogin [

	| factory configuration |

	configuration := ApplicationConfiguration
		                 forAll: CreateEmptyRDBMSApplication saganConfigurationParametersForSQLite
		                 providedBy:
		                 ( self commandLineProviderOver: #( '--sagan.database-file-name=/tmp/tmp.db' ) ).

	factory := SingleSQLiteDatabaseProviderModuleFactory configuredBy: configuration sagan.

	self
		assert: factory databaseLogin platform isSQLite3Platform;
		assert: factory databaseLogin databaseName equals: 'tmp.db';
		assert: factory databaseLogin host equals: '/tmp/';
		assert: factory databaseLogin password isEmpty
]

{ #category : #tests }
SingleSQLiteDatabaseProviderModuleFactoryTest >> testDefaultDatabaseLogin [

	| factory configuration |

	configuration := ApplicationConfiguration
		                 forAll: CreateEmptyRDBMSApplication saganConfigurationParametersForSQLite
		                 providedBy: NullConfigurationProvider new.

	factory := SingleSQLiteDatabaseProviderModuleFactory configuredBy: configuration sagan.

	self
		assert: factory databaseLogin platform isSQLite3Platform;
		assert: factory databaseLogin databaseName equals: 'default.db';
		assert: factory databaseLogin host notEmpty;
		assert: factory databaseLogin password isEmpty
]
