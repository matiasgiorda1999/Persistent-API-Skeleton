"
A PersistentAPIConfigurationTest is a test class for testing the behavior of PersistentAPIConfiguration
"
Class {
	#name : #PersistentAPIConfigurationTest,
	#superclass : #TestCase,
	#category : #'Persistent-API-Skeleton-Tests'
}

{ #category : #testing }
PersistentAPIConfigurationTest class >> isAbstract [

	^ self name = #PersistentAPIConfigurationTest
]

{ #category : #private }
PersistentAPIConfigurationTest >> commandLineProviderOver: arguments [

	^ ConfigurationFromCommandLineProvider over: ( CommandLineArguments withArguments: arguments )
]
