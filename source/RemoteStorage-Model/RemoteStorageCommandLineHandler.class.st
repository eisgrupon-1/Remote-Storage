Class {
	#name : #RemoteStorageCommandLineHandler,
	#superclass : #ApplicationStarterCommandLineHandler,
	#instVars : [
		'rootSystem'
	],
	#category : #'RemoteStorage-Model-API'
}

{ #category : #accessing }
RemoteStorageCommandLineHandler class >> commandName [
	^ 'start'
]

{ #category : #accessing }
RemoteStorageCommandLineHandler class >> description [
	^ 'Start Remote Storage API'
]

{ #category : #activation }
RemoteStorageCommandLineHandler >> basicActivate [
	<ignoreForCoverage>
	self
		startServedOn: (self configuration at: #'api-server-url')
		listeningOn: (self configuration at: #port)
]

{ #category : #'private - accessing' }
RemoteStorageCommandLineHandler >> configurationDefinition [
	^ OrderedCollection new
		add: (MandatoryArgument named: #'api-server-url');
		add:
			(OptionalArgument
				named: #port
				defaultingTo: 6789
				convertingWith: #asNumber);
		yourself
]

{ #category : #'private - accessing' }
RemoteStorageCommandLineHandler >> controllers [
	rootSystem := self rootSystem.
	^ OrderedCollection new
		add:
			(FileManagementRESTfulController
				within: rootSystem >> #FileManagementSystemInterface);
		asArray
]

{ #category : #'private - accessing' }
RemoteStorageCommandLineHandler >> logPrefix [
	^ 'remote-storage'
]

{ #category : #'private - accessing' }
RemoteStorageCommandLineHandler >> rootSystem [
	^ CompositeSystem new
		register: FileManagementSystem new;
		yourself
]

{ #category : #'private - accessing' }
RemoteStorageCommandLineHandler >> startServedOn: anUrl listeningOn: aPort [
	<ignoreForCoverage>
	| server |
	server := HTTPBasedRESTfulAPI
		configuredBy:
			{(#port -> aPort).
			(#serverUrl -> anUrl)}
		installing: self controllers.
	server
		install;
		start.
	self uploadServer start
]

{ #category : #'private - accessing' }
RemoteStorageCommandLineHandler >> uploadServer [
	^ FileUploadController
		within: rootSystem >> #FileManagementSystemInterface
]
