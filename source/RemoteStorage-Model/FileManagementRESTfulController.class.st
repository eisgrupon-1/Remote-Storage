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
FileManagementRESTfulController >> entityTagOf: resource encodedAs: mediaType within: aContext [
	^ ZnETag with: (MD5 hashMessage: resource printString) hex
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
	^ RESTfulControllerDoNotPaginateCollectionsPolicyTest for: self
]

{ #category : #'private - accessing' }
FileManagementRESTfulController >> provideResourceCreationPolicy [
	^ RESTfulControllerResourceCreationPolicy for: self
]

{ #category : #specification }
FileManagementRESTfulController >> specification [
	^ FileManagementRESTfulControllerSpecification new
]
