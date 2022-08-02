Class {
	#name : #SinglePostgreSQLDatabaseProviderModuleFactory,
	#superclass : #SingleDatabaseRepositoryProviderModuleFactory,
	#category : #'Persistent-API-Skeleton-PostgreSQL'
}

{ #category : #'instance creation' }
SinglePostgreSQLDatabaseProviderModuleFactory >> databaseLogin [

	| login |

	DatabaseAccessor classForThisPlatform DefaultDriver: P3DatabaseDriver.
	login := Login new
		         database: PostgreSQLPlatform new;
		         host: databaseConfiguration pgHostname;
		         port: databaseConfiguration pgPort;
		         username: databaseConfiguration pgUsername;
		         password: databaseConfiguration pgPassword;
		         databaseName: databaseConfiguration pgDatabaseName;
		         setSSL;
		         yourself.
	^ login
]
