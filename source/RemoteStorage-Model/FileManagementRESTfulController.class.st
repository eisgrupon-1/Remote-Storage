Class {
	#name : #FileManagementRESTfulController,
	#superclass : #ResourceRESTfulController,
	#instVars : [
		'fileManagementSystem'
	],
	#category : #'RemoteStorage-Model-API'
}

{ #category : #'as yet unclassified' }
FileManagementRESTfulController class >> within: aFileManagementSystem [
	^ self new initializeWithin: aFileManagementSystem
]

{ #category : #'private - accessing' }
FileManagementRESTfulController >> createFileBasedOn: anHttpRequest within: aContext [
	^ self
		withCreatedResourceDo: [ :file | 
			self fileManagementSystem createFile: file.
			file ]
		decodedUsing: self specification fileMappingKey
		basedOn: anHttpRequest
		within: aContext
]

{ #category : #'private - accessing' }
FileManagementRESTfulController >> deleteFileBasedOn: anHttpRequest within: aContext [
	| uuid |
	uuid := anHttpRequest at: #identifier.
	self fileManagementSystem
		fileIdentifiedBy: uuid
		ifFound: [ :file | self fileManagementSystem deleteFileNamed: file name ]
		ifNone: [ ^ ObjectNotFound signal ].
	^ ZnResponse noContent
]

{ #category : #'private - accessing' }
FileManagementRESTfulController >> entityTagOf: resource encodedAs: mediaType within: aContext [
	^ ZnETag with: (MD5 hashMessage: resource printString) hex
]

{ #category : #'private - accessing' }
FileManagementRESTfulController >> fileManagementSystem [
	^ fileManagementSystem
]

{ #category : #'private - accessing' }
FileManagementRESTfulController >> getFilesBasedOn: aTeaRequest within: aContext [
	^ self
		get: [ self fileManagementSystem getAllFiles ]
		asCollectionEncodedUsing: self specification filesMappingKey
		basedOn: aTeaRequest
		within: aContext
]

{ #category : #initialization }
FileManagementRESTfulController >> initializeWithin: aFileManagementSystem [
	fileManagementSystem := aFileManagementSystem
]

{ #category : #'private - accessing' }
FileManagementRESTfulController >> locationOf: resource within: aContext [
	| baseUrl |
	baseUrl := (baseUrlOptional withContentDo: #yourself ifUnused: [ '' ])
		asZnUrl.
	^ baseUrl / self specification endpoint
		/ resource uuid printString asZnUrl
]

{ #category : #'private - accessing' }
FileManagementRESTfulController >> provideHypermediaPolicy [
	^ HypermediaDrivenRESTfulControllerPolicy for: self
]

{ #category : #'private - accessing' }
FileManagementRESTfulController >> providePaginationPolicy [
	^ RESTfulControllerDoNotPaginateCollectionsPolicy for: self
]

{ #category : #'private - accessing' }
FileManagementRESTfulController >> provideResourceCreationPolicy [
	^ RESTfulControllerDoNotRespondCreatedEntityPolicy for: self
]

{ #category : #specification }
FileManagementRESTfulController >> specification [
	^ FileManagementRESTfulControllerSpecification new
]
