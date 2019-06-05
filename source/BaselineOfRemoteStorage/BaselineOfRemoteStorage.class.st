Class {
	#name : #BaselineOfRemoteStorage,
	#superclass : #BaselineOf,
	#category : #BaselineOfRemoteStorage
}

{ #category : #baselines }
BaselineOfRemoteStorage >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self
				setUpDependencies: spec;
				baselineOfRemoteStorage: spec.
			spec
				group: 'CI' with: 'Tests';
				group: 'Development' with: #('Tests') ]
]

{ #category : #baselines }
BaselineOfRemoteStorage >> baselineOfRemoteStorage: spec [
	spec
		package: 'RemoteStorage-Model'
			with: [ spec
				requires: #('Chalten' 'Kepler-Core' 'Stargate-Core' 'ApplicationStarter') ];
		group: 'Deployment' with: 'RemoteStorage-Model'.
	spec
		package: 'RemoteStorage-Tests'
			with: [ spec
				requires: #('RemoteStorage-Model' 'Kepler-SUnit' 'Stargate-SUnit') ];
		group: 'Tests' with: 'RemoteStorage-Tests'
]

{ #category : #baselines }
BaselineOfRemoteStorage >> setUpDependencies: spec [
	spec
		baseline: 'ApplicationStarter'
		with: [ spec repository: 'github://ba-st/ApplicationStarter:v1/source' ].
	spec
		baseline: 'Kepler'
			with: [ spec repository: 'github://ba-st/Kepler:v4/source' ];
		project: 'Kepler-Core'
			copyFrom: 'Kepler'
			with: [ spec loads: 'Core' ];
		project: 'Kepler-SUnit'
			copyFrom: 'Kepler'
			with: [ spec loads: 'Dependent-SUnit-Extensions' ].
	spec
		baseline: 'Stargate'
			with:
				[ spec repository: 'github://ba-st/Stargate:release-candidate/source' ];
		project: 'Stargate-Core'
			copyFrom: 'Stargate'
			with: [ spec loads: 'Deployment' ];
		project: 'Stargate-SUnit'
			copyFrom: 'Stargate'
			with: [ spec loads: 'Stargate-Model-Tests' ].
	spec
		baseline: 'Chalten'
		with: [ spec
				repository: 'github://ba-st/Chalten:v8/source';
				loads: #('Chalten-Gregorian-Calendar') ]
]
