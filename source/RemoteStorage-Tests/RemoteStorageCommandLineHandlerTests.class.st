Class {
	#name : #RemoteStorageCommandLineHandlerTests,
	#superclass : #TestCase,
	#category : #'RemoteStorage-Tests-API'
}

{ #category : #'as yet unclassified' }
RemoteStorageCommandLineHandlerTests >> implementedEndpoints [
	^ ResourceRESTfulControllerSpecification allSubclasses
		select:
			[ :class | class package name beginsWith: (self class package name copyUpTo: $-) ]
		thenCollect: [ :spec | spec new endpoint ]
]

{ #category : #'as yet unclassified' }
RemoteStorageCommandLineHandlerTests >> testAccessing [
	| handler |
	handler := RemoteStorageCommandLineHandler
		commandLine:
			(CommandLineArguments
				withArguments:
					{RemoteStorageCommandLineHandler commandName.
					'--api-server-url=/'.
					'--port=6789'}).
	self
		assert: RemoteStorageCommandLineHandler commandName equals: 'start';
		assert: RemoteStorageCommandLineHandler description
			equals: 'Start Remote Storage API';
		assert: handler logPrefix equals: 'remote-storage';
		assert: (handler configuration at: #port) equals: 6666;
		assert: (handler configuration at: #'api-server-url') equals: '/'
]

{ #category : #'as yet unclassified' }
RemoteStorageCommandLineHandlerTests >> testControllers [
	| controllers endpoints |
	controllers := RemoteStorageCommandLineHandler new controllers.
	endpoints := controllers
		collect: [ :controller | controller specification endpoint ].
	self implementedEndpoints
		do: [ :endpoint | 
			self
				assert: (endpoints includes: endpoint)
				description:
					('<1s> is imlpemented but not included on the installed controllers'
						expandMacrosWith: endpoint) ]
]

{ #category : #'as yet unclassified' }
RemoteStorageCommandLineHandlerTests >> testRootSystem [
	| rootSystem |
	rootSystem := RemoteStorageCommandLineHandler new rootSystem.
	self
		deny:
			(rootSystem systemsImplementing: #FileManagementSystemInterface)
				isEmpty
]
