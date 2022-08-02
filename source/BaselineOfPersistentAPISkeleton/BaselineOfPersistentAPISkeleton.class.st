Class {
	#name : #BaselineOfPersistentAPISkeleton,
	#superclass : #BaselineOf,
	#category : #BaselineOfPersistentAPISkeleton
}

{ #category : #baselines }
BaselineOfPersistentAPISkeleton >> baseline: spec [

	<baseline>
	spec
		for: #pharo
		do: [ self
				setUpDependencies: spec;
				setUpPackages: spec.
			spec
				group: 'Deployment' with: #('SQLite3 Persistence' 'PostgreSQL Persistence');
				group: 'CI' with: 'Tests';
				group: 'Dependent-SUnit-Extensions' with: #('Stargate-SUnit' 'Kepler-SUnit');
				group: 'Tools' with: 'Stargate-Tools';
				group: 'Development' with: #('Tests' 'Tools')
			]
]

{ #category : #accessing }
BaselineOfPersistentAPISkeleton >> projectClass [

	^ MetacelloCypressBaselineProject
]

{ #category : #baselines }
BaselineOfPersistentAPISkeleton >> setUpDependencies: spec [

	spec
		baseline: 'Stargate' with: [ spec repository: 'github://ba-st/Stargate:v8' ];
		project: 'Stargate-Deployment' copyFrom: 'Stargate' with: [ spec loads: 'Deployment' ];
		project: 'Stargate-SUnit' copyFrom: 'Stargate' with: [ spec loads: 'Dependent-SUnit-Extensions' ];
		project: 'Stargate-Tools' copyFrom: 'Stargate' with: [ spec loads: 'Tools' ].

	spec
		baseline: 'StargateConsul' with: [ spec repository: 'github://ba-st/Stargate-Consul:v4' ];
		project: 'Stargate-Consul-Deployment'
		copyFrom: 'StargateConsul'
		with: [ spec loads: 'Deployment' ].

	spec
		baseline: 'Sagan' with: [ spec repository: 'github://ba-st/Sagan:v6' ];
		project: 'Sagan-SQLite' copyFrom: 'Sagan' with: [ spec loads: 'SQLite' ];
		project: 'Sagan-PostgreSQL' copyFrom: 'Sagan' with: [ spec loads: 'PostgreSQL' ].

	spec
		baseline: 'Launchpad' with: [ spec repository: 'github://ba-st/Launchpad:v4' ];
		project: 'Launchpad-Deployment' copyFrom: 'Launchpad' with: [ spec loads: 'Deployment' ].

	spec
		baseline: 'Kepler' with: [ spec repository: 'github://ba-st/Kepler:v5' ];
		project: 'Kepler-Core' copyFrom: 'Kepler' with: [ spec loads: 'Core' ];
		project: 'Kepler-SUnit' copyFrom: 'Kepler' with: [ spec loads: 'Dependent-SUnit-Extensions' ]
]

{ #category : #baselines }
BaselineOfPersistentAPISkeleton >> setUpPackages: spec [

	spec
		package: 'API-Skeleton'
			with: [ spec
				requires: #('Stargate-Deployment' 'Kepler-Core' 'Launchpad-Deployment' 'Stargate-Consul-Deployment')
			];
		group: 'Core' with: 'API-Skeleton';
		group: 'Deployment' with: 'API-Skeleton'.

	spec package: 'Persistent-API-Skeleton' with: [ spec requires: 'API-Skeleton' ].

	spec
		package: 'Persistent-API-Skeleton-SQLite'
			with: [ spec requires: #('Persistent-API-Skeleton' 'Sagan-SQLite') ];
		group: 'SQLite3 Persistence' with: 'Persistent-API-Skeleton-SQLite'.

	spec
		package: 'Persistent-API-Skeleton-PostgreSQL'
			with: [ spec requires: #('Persistent-API-Skeleton' 'Sagan-PostgreSQL') ];
		group: 'PostgreSQL Persistence' with: 'Persistent-API-Skeleton-PostgreSQL'.

	spec
		package: 'API-Skeleton-Tests' with: [ spec requires: #('API-Skeleton' 'Stargate-SUnit') ];
		group: 'Tests' with: 'API-Skeleton-Tests'.

	spec
		package: 'Persistent-API-Skeleton-Tests'
			with: [ spec
				requires: #('Persistent-API-Skeleton-SQLite' 'Persistent-API-Skeleton-PostgreSQL' 'Stargate-SUnit')
			];
		group: 'Tests' with: 'Persistent-API-Skeleton-Tests'
]
