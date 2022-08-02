Class {
	#name : #SingleSQLiteDatabaseProviderModuleFactory,
	#superclass : #SingleDatabaseRepositoryProviderModuleFactory,
	#category : #'Persistent-API-Skeleton-SQLite'
}

{ #category : #private }
SingleSQLiteDatabaseProviderModuleFactory >> databaseBaseName [

	^self databaseFileName asFileReference asAbsolute basename
]

{ #category : #private }
SingleSQLiteDatabaseProviderModuleFactory >> databaseFileName [

	^databaseConfiguration databaseFileName
]

{ #category : #private }
SingleSQLiteDatabaseProviderModuleFactory >> databaseLogin [

	DatabaseAccessor classForThisPlatform DefaultDriver: SQLite3Driver.
	^ Login new
		database: UDBCSQLite3Platform new;
		host: self databasePathName;
		databaseName: self databaseBaseName;
		password: '';
		yourself
]

{ #category : #private }
SingleSQLiteDatabaseProviderModuleFactory >> databasePathName [

	^ self databaseFileName asFileReference asAbsolute parent pathString
	  , FileSystem disk delimiter asString
]
